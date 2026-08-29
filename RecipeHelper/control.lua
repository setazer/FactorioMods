-- RecipeHelper: control stage.
-- Adds a toggle button next to any opened crafting machine GUI. The button
-- expands into a recipe picker where a single click applies the recipe,
-- optionally at a quality selected with the mouse wheel.

-- Vanilla-style tooltip for a choose-elem-button cell.
local function set_cell_tooltip(cell, recipe_name, quality)
    -- "recipe-with-quality" shows the full vanilla recipe tooltip incl. quality.
    cell.elem_tooltip = { type = "recipe-with-quality", name = recipe_name, quality = quality }
end

-- entity.type -> defines.relative_gui_type
local GUI_TYPES = {
    ["assembling-machine"] = defines.relative_gui_type.assembling_machine_gui,
    ["furnace"] = defines.relative_gui_type.furnace_gui,
    ["rocket-silo"] = defines.relative_gui_type.rocket_silo_gui,
}

local BUTTON_NAME = "rh-toggle-button"
local PANEL_NAME = "rh-panel"
local SEARCH_NAME = "rh-search"
local GRID_NAME = "rh-recipe-grid"

-------------------------------------------------------------------------------
-- Helpers
-------------------------------------------------------------------------------

local function sorted_qualities()
    local list = {}
    for _, quality in pairs(prototypes.quality) do
        if not quality.hidden then
            list[#list + 1] = quality
        end
    end
    table.sort(list, function(a, b) return a.order < b.order end)
    return list
end

local function quality_index(qualities, name)
    for i, q in ipairs(qualities) do
        if q.name == name then return i end
    end
    return nil
end

local function quality_unlocked(force)
    -- Vanilla tech for quality selection is "quality-module"; treat absence of
    -- the tech (total conversions) as unlocked.
    local tech = force.technologies["quality-module"]
    return not tech or tech.researched
end

local function get_state(player)
    storage.players = storage.players or {}
    local state = storage.players[player.index]
    if not state then
        state = {
            quality = "normal",
            search = "",
            search_open = false,
            open = false,
            had_recipe = false,
            entity = nil,
        }
        storage.players[player.index] = state
    end
    return state
end

local function get_anchor(state)
    local entity = state.entity
    if not entity or not entity.valid then return nil end
    local gui_type = GUI_TYPES[entity.type]
    if not gui_type then return nil end
    return {
        gui = gui_type,
        position = defines.relative_gui_position.right,
    }
end

-------------------------------------------------------------------------------
-- GUI
-------------------------------------------------------------------------------

local function destroy_guis(player)
    local relative = player.gui.relative
    local button = relative[BUTTON_NAME]
    if button then button.destroy() end
    local panel = relative[PANEL_NAME]
    if panel then panel.destroy() end
    local screen_panel = player.gui.screen[PANEL_NAME]
    if screen_panel then screen_panel.destroy() end
end

-- Detached mode: the picker lives in player.gui.screen as an independent
-- window (used when the machine has no recipe, so it can coexist with the
-- vanilla chooser which we close).
local function is_detached(player)
    -- Detached whenever our picker currently lives in the screen layer.
    return player.gui.screen[PANEL_NAME] ~= nil
end

local function build_button(player)
    local state = get_state(player)
    local anchor = get_anchor(state)
    if not anchor then return end
    destroy_guis(player)

    if player.mod_settings["rh-show-button"].value then
        player.gui.relative.add {
            type = "sprite-button",
            name = BUTTON_NAME,
            sprite = "utility/change_recipe",
            tooltip = { "rh.open-picker" },
            tags = { action = "toggle" },
            anchor = anchor,
            style = "rh_toggle_button",
        }
    end
end

local function machine_category_set(entity)
    local categories = {}
    for category in pairs(entity.prototype.crafting_categories or {}) do
        -- Keys may be plain strings or LuaRecipeCategoryPrototype depending on API version.
        categories[type(category) == "string" and category or category.name] = true
    end
    return categories
end

-- All recipes craftable by this entity (enabled + not hidden), unsorted.
local function all_machine_recipes(entity)
    local categories = machine_category_set(entity)
    local result = {}
    for _, recipe in pairs(entity.force.recipes) do
        if recipe.enabled and not recipe.hidden then
            for _, c in ipairs(recipe.categories) do
                if categories[c] then
                    result[#result + 1] = recipe
                    break
                end
            end
        end
    end
    return result
end

-- Count of search-matching recipes per item group (for tab dimming).
local function group_match_counts(entity, search)
    local counts = {}
    if search == "" then return counts end
    search = string.lower(search)
    for _, recipe in ipairs(all_machine_recipes(entity)) do
        if string.find(string.lower(recipe.name), search, 1, true) then
            counts[recipe.group.name] = (counts[recipe.group.name] or 0) + 1
        end
    end
    return counts
end

local function build_grid(player, parent)
    local state = get_state(player)
    local entity = state.entity
    if not entity or not entity.valid then return end
    local search = string.lower(state.search or "")

    local grid = parent[GRID_NAME]
    if grid then grid.clear() else return end

    local current_recipe_name
    local current = entity.get_recipe()
    if current then current_recipe_name = current.name end

    -- Organize recipes like the vanilla picker: rows per subgroup inside the
    -- selected item group.
    local recipes = all_machine_recipes(entity)
    local by_subgroup = {}
    local subgroup_order = {}
    for _, recipe in ipairs(recipes) do
        if state.group == nil or recipe.group.name == state.group then
            if search == "" or string.find(string.lower(recipe.name), search, 1, true) then
                local sg = recipe.subgroup.name
                if not by_subgroup[sg] then
                    by_subgroup[sg] = {}
                    subgroup_order[#subgroup_order + 1] = sg
                end
                table.insert(by_subgroup[sg], recipe)
            end
        end
    end
    table.sort(subgroup_order, function(a, b)
        return by_subgroup[a][1].subgroup.order < by_subgroup[b][1].subgroup.order
    end)

    if #subgroup_order == 0 then
        grid.add {
            type = "frame",
            name = "rh-not-found",
            direction = "horizontal",
            style = "rh_not_found_plate",
        }.add {
            type = "label",
            name = "rh-not-found-label",
            caption = { "rh.nothing-found" },
            style = "rh_not_found_label",
        }
        return
    end

    -- Per-subgroup tables with a fixed column count, like Placeables does:
    -- the table element lays out the grid natively (10 columns = vanilla look).
    for _, sg in ipairs(subgroup_order) do
        local recipes_in_sg = by_subgroup[sg]
        table.sort(recipes_in_sg, function(a, b)
            if a.order ~= b.order then return a.order < b.order end
            return a.name < b.name
        end)
        local table = grid.add {
            type = "table",
            name = "rh-row-" .. sg,
            column_count = 10,
            style = "rh_recipe_table",
        }
        for _, recipe in ipairs(recipes_in_sg) do
            -- No custom tooltip: choose-elem-button shows the vanilla recipe
            -- tooltip (incl. quality) automatically.
            -- "recipe-with-quality" renders the icon composited with the quality
            -- badge, like the vanilla machine slot; locked keeps the vanilla
            -- chooser from opening, so the click stays ours.
            -- NOTE: elem_value must be set AFTER creation — in add{} it is
            -- validated against the default elem_type and gets dropped.
            local cell = table.add {
                type = "choose-elem-button",
                name = "rh-recipe-" .. recipe.name,
                elem_type = "recipe-with-quality",
                locked = true,
                tags = { action = "recipe", recipe = recipe.name },
                style = (current_recipe_name == recipe.name)
                    and "rh_recipe_button_selected" or "rh_recipe_button",
            }
            cell.elem_value = { name = recipe.name, quality = state.quality }
            set_cell_tooltip(cell, recipe.name, state.quality)
        end
    end
end

local function build_panel(player, detached)
    local state = get_state(player)
    local anchor = get_anchor(state)
    if not anchor then return end
    local entity = state.entity
    if not entity or not entity.valid then return end
    destroy_guis(player)

    -- Normalize stored quality (e.g. leftover "quality-unknown" from older saves).
    local all_qualities = sorted_qualities()
    if not quality_index(all_qualities, state.quality) then
        state.quality = "normal"
    end

    local use_quality = quality_unlocked(player.force)
    -- Without "remember quality" the picker always starts from Normal.
    local remember = player.mod_settings["rh-remember-quality"].value
    if not use_quality or not remember then
        state.quality = "normal"
    end

    local panel
    if detached then
        -- Independent screen window: survives closing the machine window and
        -- floats above the vanilla chooser backdrop.
        panel = player.gui.screen.add {
            type = "frame",
            name = PANEL_NAME,
            direction = "vertical",
            style = "rh_panel",
        }
        panel.force_auto_center()
    else
        panel = player.gui.relative.add {
            type = "frame",
            name = PANEL_NAME,
            direction = "vertical",
            anchor = anchor,
            style = "rh_panel",
        }
    end

    -- Title bar, built like vanilla windows: title label + stretching spacer,
    -- search field and action button on the right. (No drag_target: our panel
    -- is a relative GUI anchored to the machine window, and drag targets are
    -- only allowed for frames in player.gui.screen.)
    local title_flow = panel.add {
        type = "flow",
        direction = "horizontal",
    }
    title_flow.add {
        type = "label",
        style = "frame_title",
        caption = { "rh.panel-title" },
    }
    local pusher = title_flow.add {
        type = "empty-widget",
        style = "draggable_space_header",
    }
    pusher.style.horizontally_stretchable = true
    pusher.style.height = 24
    if detached then
        -- Screen windows can be dragged by their header.
        pusher.drag_target = panel
    end
    title_flow.add {
        type = "sprite-button",
        name = "rh-close",
        sprite = "utility/close",
        hovered_sprite = "utility/close",
        clicked_sprite = "utility/close",
        style = "frame_action_button",
        tooltip = { "gui.close-instruction" },
        tags = { action = "close" },
    }
    local search = title_flow.add {
        type = "textfield",
        name = SEARCH_NAME,
        text = state.search or "",
        visible = state.search_open or (state.search or "") ~= "",
        tags = { action = "search" },
        style = "rh_search",
    }
    title_flow.add {
        type = "sprite-button",
        name = "rh-search-toggle",
        sprite = "utility/search",
        hovered_sprite = "utility/search",
        clicked_sprite = "utility/search",
        style = "frame_action_button",
        toggled = state.search_open or false,
        tooltip = { "rh.search-toggle" },
        tags = { action = "search-toggle" },
    }

    if state.search_open then
        search.focus()
    end

    -- Group tabs, like the vanilla picker header.
    local tabs = panel.add {
        type = "flow",
        name = "rh-group-tabs",
        direction = "horizontal",
        style = "rh_tabs_flow",
    }
    local groups = {}
    local seen = {}
    for _, recipe in ipairs(all_machine_recipes(entity)) do
        local g = recipe.group.name
        if not seen[g] then
            seen[g] = true
            groups[#groups + 1] = recipe.group
        end
    end
    table.sort(groups, function(a, b) return a.order < b.order end)
    if not state.group then
        state.group = groups[1] and groups[1].name or nil
    end
    local counts = group_match_counts(entity, state.search or "")
    local searching = (state.search or "") ~= ""
    -- Vanilla behavior: auto-switch to the first group with matches.
    if searching and state.group and not counts[state.group] then
        for _, group in ipairs(groups) do
            if counts[group.name] then
                state.group = group.name
                break
            end
        end
    end
    for _, group in ipairs(groups) do
        local has_matches = not searching or counts[group.name] ~= nil
        local style
        if searching and not has_matches then
            style = "rh_tab_button_dimmed"
        elseif state.group == group.name then
            style = "rh_tab_button_selected"
        else
            style = "rh_tab_button"
        end
        tabs.add {
            type = "sprite-button",
            name = "rh-group-" .. group.name,
            sprite = "item-group/" .. group.name,
            tooltip = { "item-group-name." .. group.name },
            tags = { action = "group", group = group.name },
            style = style,
            enabled = has_matches,
        }
    end

    local scroll = panel.add {
        type = "scroll-pane",
        name = "rh-scroll",
        style = "rh_grid_scroll",
    }
    scroll.vertical_scroll_policy = "auto"
    scroll.horizontal_scroll_policy = "never"
    scroll.add {
        type = "flow",
        name = GRID_NAME,
        direction = "vertical",
        style = "rh_grid_flow",
    }
    build_grid(player, scroll)

    -- Quality picker row at the bottom (like the vanilla dialog).
    if use_quality then
        local row = panel.add {
            type = "flow",
            name = "rh-quality-row",
            direction = "horizontal",
            style = "rh_quality_row",
        }
        for _, q in ipairs(sorted_qualities()) do
            row.add {
                type = "sprite-button",
                name = "rh-set-quality-" .. q.name,
                sprite = "quality/" .. q.name,
                tooltip = { "quality-name." .. q.name },
                tags = { action = "set-quality", quality = q.name },
                style = (state.quality == q.name)
                    and "rh_quality_button_selected" or "rh_quality_button",
            }
        end
    end
end

local function toggle_panel(player)
    local state = get_state(player)
    state.open = not state.open
    if state.open then
        -- Fresh open: vanilla-like, search state is not preserved.
        state.search = ""
        state.search_open = false
        local detached = is_detached(player)
        build_panel(player, detached)
        if detached and player.opened == state.entity then
            -- Machine window (and the vanilla chooser on top of it) is about
            -- to be dismissed; our screen window survives it.
            player.opened = nil
        end
    else
        build_button(player)
    end
end

local function update_quality_row(panel, selected_quality)
    local row = panel["rh-quality-row"]
    if not row then return end
    for _, button in ipairs(row.children) do
        if button.tags and button.tags.action == "set-quality" then
            button.style = (button.tags.quality == selected_quality)
                and "rh_quality_button_selected" or "rh_quality_button"
        end
    end
end

local function get_panel(player)
    return player.gui.screen[PANEL_NAME] or player.gui.relative[PANEL_NAME]
end

local function apply_quality_change(player)
    local panel = get_panel(player)
    if not panel then return end
    update_quality_row(panel, get_state(player).quality)
    local scroll = panel["rh-scroll"]
    if scroll then
        build_grid(player, scroll)
    end
end

local function cycle_quality(player, direction)
    local state = get_state(player)
    local qualities = sorted_qualities()
    local index = quality_index(qualities, state.quality) or 1
    -- No wrap-around: clamp at the bottom (normal) and top (highest quality).
    local new_index = index + direction
    if new_index < 1 or new_index > #qualities then return end
    state.quality = qualities[new_index].name
    apply_quality_change(player)
end

-------------------------------------------------------------------------------
-- Event handlers
-------------------------------------------------------------------------------

script.on_event(defines.events.on_gui_opened, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end

    local entity = event.entity
    if entity and entity.valid and GUI_TYPES[entity.type]
        and next(entity.prototype.crafting_categories or {}) then
        local state = get_state(player)
        if state.entity ~= entity then
            state.group = nil -- different machine: reset selected group
        end
        state.entity = entity
        state.had_recipe = entity.get_recipe() ~= nil
        if state.open then
            -- A previous picker may still live as a detached window.
            local screen_panel = player.gui.screen[PANEL_NAME]
            if screen_panel then
                screen_panel.destroy()
            end
            local replace = player.mod_settings["rh-replace-pickers"].value
            if not entity.get_recipe() and replace then
                build_panel(player, true)
                if player.opened == entity then
                    player.opened = nil
                end
            else
                -- Recipe picked (or replacement disabled): reopen with just
                -- the toggle button, not an already-expanded panel.
                state.open = false
                destroy_guis(player)
                build_button(player)
            end
        else
            build_button(player)
            -- Open our picker right away when the machine has no recipe set
            -- (replaces the need to click the vanilla empty slot).
            if not entity.get_recipe()
                and player.mod_settings["rh-replace-pickers"].value then
                -- Detached screen window; then dismiss the machine window
                -- together with the vanilla chooser, leaving our picker as
                -- a separate window.
                state.open = true
                build_panel(player, true)
                if player.opened == entity then
                    player.opened = nil
                end
            end
        end
    else
        destroy_guis(player)
    end
end)

script.on_event(defines.events.on_gui_closed, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    local state = get_state(player)
    -- Keep a detached picker alive when the machine window (or the vanilla
    -- chooser on top of it) is dismissed; it is an independent window.
    if player.gui.screen[PANEL_NAME] then
        if event.element ~= nil and event.element.valid
            and event.element.name == PANEL_NAME then
            -- The player closed our own window.
            state.open = false
            destroy_guis(player)
        end
        return
    end
    state.open = false
    destroy_guis(player)
end)

script.on_event(defines.events.on_gui_click, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    local state = get_state(player)
    local tags = event.element.tags or {}
    local action = tags.action

    if action == "close" then
        state.open = false
        destroy_guis(player)
        build_button(player)
    elseif action == "toggle" then
        if state.entity and state.entity.valid then
            toggle_panel(player)
        end
    elseif action == "search-toggle" then
        -- Vanilla-style header search: toggling off also clears the query.
        state.search_open = not (state.search_open or false)
        if not state.search_open then
            state.search = ""
        end
        build_panel(player, is_detached(player))
    elseif action == "group" then
        state.group = tags.group
        local panel = get_panel(player)
        if panel then
            local scroll = panel["rh-scroll"]
            if scroll then
                -- Re-render tab highlight.
                local tabs = panel["rh-group-tabs"]
                if tabs then
                    for _, tab in ipairs(tabs.children) do
                        if tab.tags and tab.tags.action == "group" then
                            tab.style = (tab.tags.group == state.group)
                                and "rh_tab_button_selected" or "rh_tab_button"
                        end
                    end
                end
                build_grid(player, scroll)
            end
        end
    elseif action == "set-quality" then
        state.quality = tags.quality
        apply_quality_change(player)
    elseif action == "recipe" then
        local entity = state.entity
        if entity and entity.valid and prototypes.recipe[tags.recipe] then
            local quality = quality_unlocked(player.force) and state.quality or "normal"
            -- Primitive params: positional call (set_recipe(recipe, quality)).
            -- Returns items removed from the machine (e.g. old ingredients).
            local removed = entity.set_recipe(tags.recipe, quality)
            -- If the picker was detached (empty-machine flow), switch back to
            -- the normal mode: destroy the screen window and open the machine
            -- window; on_gui_opened rebuilds the panel next to it.
            if player.gui.screen[PANEL_NAME] then
                player.gui.screen[PANEL_NAME].destroy()
                player.opened = entity
                return
            end
            -- Vanilla behavior: return removed items to the player inventory,
            -- spill whatever does not fit.
            for _, item in ipairs(removed or {}) do
                local inserted = player.insert(item)
                local left = item.count - inserted
                if left > 0 then
                    local rest = {
                        name = item.name,
                        count = left,
                        quality = item.quality or "normal",
                    }
                    player.surface.spill_item_stack {
                        position = player.position,
                        stack = rest,
                        enable_looted = true,
                        force = player.character and player.force or nil,
                        allow_belts = false,
                    }
                end
            end
            state.open = false
            build_button(player)
        end
    end
end)

script.on_event(defines.events.on_gui_text_changed, function(event)
    if event.element.name ~= SEARCH_NAME then return end
    local player = game.get_player(event.player_index)
    if not player then return end
    local state = get_state(player)
    state.search = event.text
    local panel = get_panel(player)
    if panel and panel["rh-scroll"] then
        -- Dim/disable tabs of groups with no search matches; auto-switch if the
        -- selected group has none (vanilla behavior).
        local entity = state.entity
        if entity and entity.valid then
            local searching = (state.search or "") ~= ""
            local counts = group_match_counts(entity, state.search)
            local tabs = panel["rh-group-tabs"]
            if tabs then
                local current_has_matches = not searching or counts[state.group] ~= nil
                if searching and not current_has_matches then
                    for _, tab in ipairs(tabs.children) do
                        if tab.tags and tab.tags.action == "group" and counts[tab.tags.group] then
                            state.group = tab.tags.group
                            current_has_matches = true
                            break
                        end
                    end
                end
                for _, tab in ipairs(tabs.children) do
                    if tab.tags and tab.tags.action == "group" then
                        local has_matches = not searching or counts[tab.tags.group] ~= nil
                        local style
                        if searching and not has_matches then
                            style = "rh_tab_button_dimmed"
                        elseif tab.tags.group == state.group then
                            style = "rh_tab_button_selected"
                        else
                            style = "rh_tab_button"
                        end
                        tab.style = style
                        tab.enabled = has_matches
                    end
                end
            end
        end
        build_grid(player, panel["rh-scroll"])
    end
end)

script.on_event("rh-wheel-up", function(event)
    local player = game.get_player(event.player_index)
    if player and get_state(player).open then
        cycle_quality(player, 1) -- scroll up = higher quality
    end
end)

script.on_event("rh-wheel-down", function(event)
    local player = game.get_player(event.player_index)
    if player and get_state(player).open then
        cycle_quality(player, -1) -- scroll down = lower quality
    end
end)

-- First-tick check flag. on_load must not modify storage (CRC check), so we
-- use a plain local: control.lua is re-executed on load, on_load sets it.
local check_opened_on_first_tick = false

script.on_init(function()
    storage.players = {}
end)

-- on_load can't touch the GUI; flag a first-tick rebuild instead.
script.on_load(function()
    check_opened_on_first_tick = true
end)

script.on_event(defines.events.on_tick, function()
    if check_opened_on_first_tick then
        check_opened_on_first_tick = false
        for _, player in ipairs(game.connected_players) do
            local entity = player.opened
            if entity and entity.valid and GUI_TYPES[entity.type]
                and next(entity.prototype.crafting_categories or {}) then
                local state = get_state(player)
                state.entity = entity
                state.open = false
                state.had_recipe = entity.get_recipe() ~= nil
                build_button(player)
            end
        end
        return
    end
    -- The vanilla recipe chooser is invisible to player.opened/opened_gui_type
    -- and fires no events (anchored select_recipe GUIs track the machine window
    -- itself, not the chooser). But clicking the vanilla change-recipe button
    -- clears the machine's recipe while its window stays open -- watch for that
    -- transition and open our picker in the chooser's place.
    for _, player in ipairs(game.connected_players) do
        local state = storage.players and storage.players[player.index]
        if state and state.entity and state.entity.valid
            and player.opened == state.entity
            and player.mod_settings["rh-replace-pickers"].value then
            local has_recipe = state.entity.get_recipe() ~= nil
            if not has_recipe and state.had_recipe then
                -- The vanilla change-recipe button just cleared the recipe and
                -- opened the vanilla chooser: replace both with our detached
                -- picker (same flow as the empty-machine case).
                state.open = true
                state.search = ""
                state.search_open = false
                build_panel(player, true)
                if player.opened == state.entity then
                    player.opened = nil
                end
            end
            state.had_recipe = has_recipe
        end
    end
end)

script.on_configuration_changed(function()
    for _, player in pairs(game.players) do
        destroy_guis(player)
        local state = get_state(player)
        state.open = false
    end
end)

-- Turning a setting off while a picker is open must not leave an orphan GUI.
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    if event.setting ~= "rh-show-button"
        and event.setting ~= "rh-replace-pickers" then
        return
    end
    for _, player in ipairs(game.connected_players) do
        local state = storage.players and storage.players[player.index]
        if state and state.open then
            local detached = player.gui.screen[PANEL_NAME] ~= nil
            -- Detached windows belong to the replacement logic, the button
            -- panel to the button setting.
            local allowed
            if detached then
                allowed = player.mod_settings["rh-replace-pickers"].value
            else
                allowed = player.mod_settings["rh-show-button"].value
            end
            if not allowed then
                state.open = false
                destroy_guis(player)
                if player.opened == state.entity then
                    build_button(player)
                end
            end
        end
    end
end)
