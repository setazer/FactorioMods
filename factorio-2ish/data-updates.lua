if mods.TintedGhosts and settings.startup["tg-tile-ghost-tint"] then
    data.raw["utility-constants"]["default"].tile_ghost_tint = settings.startup["tg-tile-ghost-tint"].value
end

if mods["big-mining-drill"] and settings.startup["f2-adjust-aai-big-drill"].value then
    data.raw["mining-drill"]["big-mining-drill"].max_health = 600
    data.raw["mining-drill"]["big-mining-drill"].mining_speed = 2.5
    data.raw["mining-drill"]["big-mining-drill"].base_productivity = 1.00
    data.raw["mining-drill"]["big-mining-drill"].energy_usage = "500kW"
    data.raw["mining-drill"]["big-mining-drill"].resource_searching_radius = 6.49
    data.raw["mining-drill"]["big-mining-drill"].module_specification.module_slots = 4
    if settings.startup["f2-adjust-drill-pipe-connections"] then
        data.raw["mining-drill"]["big-mining-drill"].input_fluid_box.pipe_connections = {
            -- top
            { position = {-1, -3} },
            { position = {1, -3} },
            --right
            { position = {3, -1} },
            { position = {3, 1} },
            --bottom
            { position = {-1, 3} },
            { position = {1, 3} },
            -- left
            { position = {-3, -1} },
            { position = {-3, 1} },
        }
    end
end

if mods.AdvancedBelts and settings.startup["f2-hide-tiers-above-4"].value then
    local recipes = {"ultimate-belt", "high-speed-belt", "ultimate-splitter",
                     "high-speed-splitter", "ultimate-underground", "high-speed-underground"}

    for _, recipe in ipairs(recipes) do
        data.raw["recipe"][recipe].hidden = true
        data.raw["recipe"][recipe].hide_from_stats = true
        data.raw["recipe"][recipe].hide_from_player_crafting = true
    end

    data.raw["technology"]["ultimate-logistics"].hidden = true
    data.raw["technology"]["high-speed-logistics"].hidden = true

    data.raw["transport-belt"]["extreme-belt"].next_upgrade = nil
    data.raw["splitter"]["extreme-splitter"].next_upgrade = nil
    data.raw["underground-belt"]["extreme-underground"].next_upgrade = nil
end

if mods["rapid-beltsv1"] and settings.startup["f2-uraniumless-belts"].value then
     data.raw["recipe"]["rapid-transport-belt"].normal.ingredients = {
        {"steel-plate", 20},
		{"iron-gear-wheel", 20},
        {"express-transport-belt", 1},
        {type="fluid", name="lubricant", amount=40}
     }
     data.raw["recipe"]["rapid-underground-belt"].ingredients = {
        {"steel-plate", 160},
        {"iron-gear-wheel", 160},
        {"express-underground-belt", 2},
        {type="fluid", name="lubricant", amount=80}
     }
     data.raw["recipe"]["rapid-splitter"].ingredients = {
        {"steel-plate", 20},
        {"iron-gear-wheel", 20},
        {"processing-unit", 1},
        {"express-splitter", 1},
        {type="fluid", name="lubricant", amount=160}
     }
end