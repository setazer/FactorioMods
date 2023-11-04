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

