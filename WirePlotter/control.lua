local math2d = require "__core__.lualib.math2d"
local a_star = require "a_star"
local dist = math2d.position.distance

local futils = require "factorio_utils"

local selectors = {
	["wp-green-select"]={
		wire="green",
		color={ 0.188, 0.788, 0.235 },
	},
	["wp-red-select"]={
		wire="red",
		color={ 0.902, 0.102, 0.11 },
	}
}

local function get_connected_via_copper(entity, string_to_ghosts)
   if entity.type ~= 'entity-ghost' then
       return entity.neighbours["copper"]
   elseif string_to_ghosts then
       local copper_connection_definitions = entity.copper_connection_definitions
       local result_entities = {}
       for _, copper_entity in pairs(copper_connection_definitions) do
           result_entities[#result_entities+1] = copper_entity.target_entity
       end
       return result_entities
   end
   return {}
end

local function get_player_setting(player_index, name)
	return settings.get_player_settings(player_index)[name].value
end

local function get_nearby_connectable_poles(entity, string_to_ghosts)
	if futils.get_type(entity) ~= "electric-pole" then return {} end
	local surface = entity.surface
	local neighbours = {}
	local max_wire_distance = futils.get_prototype(entity).max_wire_distance
	for _, real_pole in ipairs(surface.find_entities_filtered{position=entity.position, radius=max_wire_distance, type="electric-pole"}) do
		if real_pole == entity then
			goto continue
		end
		if entity.can_wires_reach(real_pole) then
			neighbours[#neighbours+1] = real_pole
		end
		::continue::
	end
	if not string_to_ghosts then return neighbours end
	for _, ghost_pole in ipairs(surface.find_entities_filtered{position=entity.position, radius=max_wire_distance, type="entity-ghost", ghost_type="electric-pole"}) do
		if ghost_pole == entity then
			goto continue
		end
		if entity.can_wires_reach(ghost_pole) then
			neighbours[#neighbours+1] = ghost_pole
		end
		::continue::
	end
	return neighbours
end

local function get_neighbours(entity, use_copper, string_to_ghosts)
	if use_copper then
		return get_connected_via_copper(entity, string_to_ghosts)
	else
		return get_nearby_connectable_poles(entity, string_to_ghosts)
	end
end

local function connect_poles(pole1, pole2, wire)
	new_connection = {wire = defines.wire_type[wire],
					target_entity = pole2}
	pole1.connect_neighbour(new_connection)
end

function OnSelect(event)
	local wire, color
	for select_item, select_props in pairs(selectors) do
		if event.item == select_item then
			wire = select_props.wire
			color = select_props.color
			break
		end
	end
	if not wire then return end

	local player_index = event.player_index
	local use_copper = get_player_setting(player_index, "wp-copper-wired-only")
	local string_to_ghosts = get_player_setting(player_index, "wp-string-to-ghosts")

	local player = game.players[player_index]
	if #event.entities ~= 1 then
		if #event.entities > 1 then
			player.print { "wp-message.select-single-pole" }
		end
		return
	end
	local pole = event.entities[1]

	---@type LuaEntity?
	local prev_pole = futils.player_data.remove(player_index, "wp-first_pole")
	if not prev_pole then
		-- This was the first selected pole, remember and mark it
		futils.player_data.set(player_index, "wp-first_pole", pole)
		futils.player_data.set(player_index, "wp-first_pole_selection_box_id",
			rendering.draw_rectangle {
				color = color,
				width = 2,
				filled = false,
				left_top = pole,
				left_top_offset = pole.prototype.drawing_box.left_top --[[@as Vector]],
				right_bottom = pole,
				right_bottom_offset = pole.prototype.drawing_box.right_bottom --[[@as Vector]],
				surface = pole.surface,
				players = { player_index },
			})
		if not futils.player_data.get(player_index, "explained_usage") then
			player.print { "wp-message.select-second-pole" }
		end
		return
	end

	-- This was the second selected pole
	rendering.destroy(futils.player_data.remove(player_index, "wp-first_pole_selection_box_id"))

	local dst_pos = pole.position

	-- Find shortest path using A* with distance to end as heuristic
	local path = a_star(prev_pole, pole,
		function(ent) return ent.unit_number end,
		function(ent)
			return get_neighbours(ent, use_copper, string_to_ghosts)
		end,
		function(from, to)
			return dist(from.position, to.position)
		end,
		function(from)
			return dist(from.position, dst_pos)
		end)

	if not path then
		player.print { "wp-message.not-connected" }
		return
	end

	---@type number[]
	local path_draw_ids = {}
	for i = 1, #path - 1 do
		local from, to = path[i], path[i + 1]
		connect_poles(from, to, wire)
	end
	player.cursor_stack.clear()
	futils.player_data.set(player_index, "explained_usage", true)
end

function OnStackChanged(event)
	local player_index = event.player_index
	local player = game.players[player_index]
	local stack = player.cursor_stack
	---@cast stack -?
	if stack.valid_for_read and (stack.name == "wp-green-select" or stack.name == "wp-red-select")  then
		if not futils.player_data.get(player_index, "wp-first_pole")
			and not futils.player_data.get(player_index, "explained_usage") then
			player.print { "wp-message.select-first-pole" }
		end
	else
		futils.player_data.remove(player_index, "wp-first_pole")
	end
end

script.on_event(defines.events.on_player_selected_area, OnSelect)
script.on_event(defines.events.on_player_cursor_stack_changed, OnStackChanged)
script.on_event(defines.events.on_player_removed, function(event)
	futils.player_data.purge(event.player_index)
end)
