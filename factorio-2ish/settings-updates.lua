-- AAI Industies teal tint
--change_default("tg-ghost-tint", {r = 0.3, g = 0.6, b = 0.6, a = 0.3})
-- no such setting yet
--change_default("tg-tile-ghost-tint", {r = 0.3, g = 0.6, b = 0.6, a = 0.3})

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
    data.raw["color-setting"]["tg-ghost-tint"].default_value = {r = 0.2, g = 0.36, b = 0.78, a = 0.3}
end

