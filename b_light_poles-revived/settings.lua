data:extend({
	{
		type = "int-setting",
		name = "lamp-tick",
		setting_type = "runtime-global",
		minimum_value = 5,
		default_value = 120,
		maximum_value = 3600,
		order = "a"
	},
	{
		type = "bool-setting",
		name = "show-pole-lamp-wires",
		setting_type = "startup",
		default_value = true,
		order = "b"
	}
})
