data:extend({
	{
	type = "recipe",
	name = "light_pole-w",
	energy_required = 1,
	enabled = false,
	ingredients =
			{
				{"iron-stick", 2},
				{"small-lamp", 1}
			},
	result = "light_pole-w"
	}
})

local light_pole_r = table.deepcopy(data.raw['recipe']['light_pole-w'])
light_pole_r.name = "light_pole-r"
light_pole_r.result = "light_pole-r"
data:extend({light_pole_r})

local light_pole_g = table.deepcopy(data.raw['recipe']['light_pole-w'])
light_pole_g.name = "light_pole-g"
light_pole_g.result = "light_pole-g"
data:extend({light_pole_g})

local light_pole_b = table.deepcopy(data.raw['recipe']['light_pole-w'])
light_pole_b.name = "light_pole-b"
light_pole_b.result = "light_pole-b"
data:extend({light_pole_b})

local light_pole_o = table.deepcopy(data.raw['recipe']['light_pole-w'])
light_pole_o.name = "light_pole-o"
light_pole_o.result = "light_pole-o"
data:extend({light_pole_o})

local light_pole_rgb = table.deepcopy(data.raw['recipe']['light_pole-w'])
light_pole_rgb.name = "light_pole-rgb"
light_pole_rgb.result = "light_pole-rgb"
data:extend({light_pole_rgb})

