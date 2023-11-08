data:extend({
	{
	type = "recipe",
	name = "stolb",
	energy_required = 1,
	enabled = false,
	ingredients =
			{
				{"iron-stick", 2},
				{"small-lamp", 1}
			},
	result = "stolb"
	}
})

local stolb_re_2 = table.deepcopy(data.raw['recipe']['stolb'])
stolb_re_2.name = "stolb-2"
stolb_re_2.result = "stolb-2"
data:extend({stolb_re_2})

local stolb_re_3 = table.deepcopy(data.raw['recipe']['stolb'])
stolb_re_3.name = "stolb-3"
stolb_re_3.result = "stolb-3"
data:extend({stolb_re_3})

local stolb_re_4 = table.deepcopy(data.raw['recipe']['stolb'])
stolb_re_4.name = "stolb-4"
stolb_re_4.result = "stolb-4"
data:extend({stolb_re_4})

local stolb_re_5 = table.deepcopy(data.raw['recipe']['stolb'])
stolb_re_5.name = "stolb-5"
stolb_re_5.result = "stolb-5"
data:extend({stolb_re_5})

local stolb_re_r = table.deepcopy(data.raw['recipe']['stolb'])
stolb_re_r.name = "stolb-r"
stolb_re_r.result = "stolb-r"
data:extend({stolb_re_r})

