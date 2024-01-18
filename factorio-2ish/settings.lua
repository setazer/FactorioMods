if mods.TintedGhosts then
    if not data.raw["color-setting"]["tg-tile-ghost-tint"] then
        data:extend({
          {
            type = "color-setting",
            name = "tg-tile-ghost-tint",
            setting_type = "startup",
            default_value = {r = 0.2, g = 0.36, b = 0.78, a = 0.4},
          },
        })
    end
end

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