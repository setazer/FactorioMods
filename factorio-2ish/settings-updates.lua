local setting_types = { "bool-setting", "int-setting", "double-setting", "string-setting", "color-setting" }
local function change_default_value(setting, value)
    for _, setting_type in pairs(setting_types) do
        if data.raw[setting_type][setting] then
            data.raw[setting_type][setting].default_value = value
        end
    end
end

if mods.TintedGhosts then
    change_default_value("tg-ghost-tint", {r = 0.2, g = 0.36, b = 0.78, a = 0.3})
    change_default_value("tg-tile-ghost-tint", {r = 0.2, g = 0.36, b = 0.78, a = 0.4})
end

if mods['Shortcuts-ick'] then
    change_default_value("artillery-toggle", "disabled")
    change_default_value("flashlight-toggle", false)
    change_default_value("signal-flare", false)
    change_default_value("draw-grid", false)
    change_default_value("rail-block-visualization-toggle", false)
    change_default_value("big-zoom", false)
    change_default_value("minimap", false)
    change_default_value("tree-killer", false)
    change_default_value("belt-immunity-equipment", false)
    change_default_value("night-vision-equipment", false)
    change_default_value("active-defense-equipment", false)
    change_default_value("driver-is-gunner", false)
    change_default_value("spidertron-logistics", false)
    change_default_value("spidertron-logistic-requests", false)
    change_default_value("targeting-with-gunner", false)
    change_default_value("train-mode-toggle", false)
    if not mods.PersonalLogisticsShortcut then
        change_default_value("toggle-personal-logistic-requests", false)
    end
end
