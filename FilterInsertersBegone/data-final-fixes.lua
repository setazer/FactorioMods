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
if mods.Krastorio2 then
    filter_inserter_recipes[#filter_inserter_recipes+1] = "kr-superior-filter-inserter"
    filter_inserter_recipes[#filter_inserter_recipes+1] = "kr-superior-long-filter-inserter"
end

if mods["exotic-industries"] then
    filter_inserter_recipes[#filter_inserter_recipes+1] = "ei_small-inserter"
    filter_inserter_recipes[#filter_inserter_recipes+1] = "ei_big-inserter"
end

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

if mods["space-exploration"] then
    remove_recipe_from_effects(data.raw.technology["filter-inserter"].effects, "filter-inserter")
    remove_recipe_from_effects(data.raw.technology["stack-filter-inserter"].effects, "stack-filter-inserter")
end

if mods["exotic-industries"] then
    remove_recipe_from_effects(data.raw.technology["ei_small-inserter"].effects, "ei_small-inserter")
    remove_recipe_from_effects(data.raw.technology["ei_big-inserter"].effects, "ei_big-inserter")
end

if mods.Krastorio2 then
    remove_recipe_from_effects(data.raw.technology["kr-superior-inserters"].effects, "kr-superior-filter-inserter")
    remove_recipe_from_effects(data.raw.technology["kr-superior-inserters"].effects, "kr-superior-long-filter-inserter")
end