function remove_recipe_from_effects(effects, recipe)
    local index = 0
    for _,_item in ipairs(effects) do
        if _item.type == "unlock-recipe" and _item.recipe == recipe then
            index = _
            break
        end
    end
    if index > 0 then
        table.remove(effects, index)
    end
end

local filter_inserter_recipes = {"filter-inserter", "stack-filter-inserter"}

for _, recipe in ipairs(filter_inserter_recipes) do
    data.raw["recipe"][recipe].hidden = true
    data.raw["recipe"][recipe].hide_from_stats = true
    data.raw["recipe"][recipe].hide_from_player_crafting = true
end

for _, inserter_type in pairs(data.raw.inserter) do
    inserter_type.filter_count = 5
end

data.raw.technology["fast-inserter"].icon = "__FilterInsertersBegone__/graphics/tech/fast_inserter.png"
remove_recipe_from_effects(data.raw.technology["fast-inserter"].effects, "filter-inserter")
remove_recipe_from_effects(data.raw.technology["stack-inserter"].effects, "stack-filter-inserter")