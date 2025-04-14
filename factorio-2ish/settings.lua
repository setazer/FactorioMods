if mods["big-mining-drill"] then
    data:extend({
        {
            type = "bool-setting",
            name = "f2-adjust-aai-big-drill",
            setting_type = "startup",
            default_value = true,
            order = "a"
        },
        {
            type = "bool-setting",
            name = "f2-adjust-drill-pipe-connections",
            setting_type = "startup",
            default_value = false,
            order = "b"
        },
    })
end

if mods.AdvancedBelts then
    data:extend({
        {
            type = "bool-setting",
            name = "f2-hide-tiers-above-4",
            setting_type = "startup",
            default_value = false,
            order = "c"
        },
    })
end

if mods["rapid-beltsv1"] then
    data:extend({
        {
            type = "bool-setting",
            name = "f2-uraniumless-belts",
            setting_type = "startup",
            default_value = false,
            order = "d"
        },
    })
end