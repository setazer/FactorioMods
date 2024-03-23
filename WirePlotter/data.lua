local wires = { green={ .188, .788, .235, .8 }, red={ .902, .102, .11, .8 } }
local transparent = {0, 0, 0, 0}

local technology_to_unlock
if data.raw["technology"]["circuit-network"] then
    technology_to_unlock = "circuit-network"
end

for name, color in pairs(wires) do
	local select_item = "wp-" .. name .. "-select"
	local icon = "__WirePlotter__/icons/" .. name .. "-select.png"
	data:extend {
	{
		type = "selection-tool",
		name = select_item,
		order = "o[pole-connection-"..name.."]",
		entity_type_filters = { "electric-pole" },

		selection_mode = { "entity-with-health", "entity-ghost", "same-force" },
		selection_cursor_box_type = "entity",
		selection_color = color,

		alt_selection_mode= { "nothing" },
		alt_selection_color = transparent,
		alt_selection_cursor_box_type = "entity",

		subgroup = "tool",
		flags = { "only-in-cursor", "hidden", "not-stackable", "spawnable" },
		draw_label_for_cursor_render = true,
		stack_size = 1,

		icon = icon,
		icon_size = 64,
		icon_mipmaps = 4,
	},
	{
		type = "shortcut",
		name = select_item,
		order = "o[pole-connection-"..name.."]",
		technology_to_unlock = technology_to_unlock,

		action = "spawn-item",
		item_to_spawn = select_item,
		associated_control_input = select_item,
		icon = {
			filename = icon,
			size = 64,
			mipmap_count = 4,
			flags = { "icon" },
		},
	},
	{
		type = "custom-input",
		name = select_item,

		key_sequence = "",
		action = "spawn-item",
		item_to_spawn = select_item,
	}
}
end

