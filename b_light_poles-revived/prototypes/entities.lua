local util = require "util"
local stolb_1 = table.deepcopy(data.raw['electric-pole']['medium-electric-pole'])
stolb_1.name = "stolb"
stolb_1.minable.result = "stolb"
stolb_1.icon_size = 64
stolb_1.icon = "__b_light_poles-revived__/graphics/icons/ico_w.png"
stolb_1.maximum_wire_distance = 16 -- длинна на которой провод будет цеплятся по умолчанию 9
stolb_1.supply_area_distance = 0.2 -- область вокруг столба, которую он покрывает по умолчанию 3.5
stolb_1.collision_box = {{-0.4, -0.4}, {0.4, 0.4}}
stolb_1.selection_box = {{-0.4, -0.4}, {0.4, 0.4}}
stolb_1.pictures = -- графика
	{
		layers =
		{
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_w.png",
			priority = "extra-high",
			width = 84,
			height = 252,
			direction_count = 4,
			shift = util.by_pixel(0, -80),
			scale = 0.65
		},
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png",
			priority = "extra-high",
			width = 280,
			height = 64,
			direction_count = 4,
			shift = util.by_pixel(64, 1),
			scale = 0.6,
			draw_as_shadow = true
		}
		}
	}
stolb_1.radius_visualisation_picture.width = 1
stolb_1.radius_visualisation_picture.height= 1
stolb_1.connection_points = -- подключение проводов
	{
		{
			shadow =
			{
				copper = util.by_pixel_hr(1, 1),
				red = util.by_pixel_hr(246, -2),
				green = util.by_pixel_hr(201, -2)
			},
			wire =
			{
				copper = util.by_pixel_hr(0, 0),
				red = util.by_pixel_hr(0, 2),
				green = util.by_pixel_hr(0, 4)
			}
		},
		{
			shadow =
			{
				copper = util.by_pixel_hr(1, 1),
				red = util.by_pixel_hr(230, 10),
				green = util.by_pixel_hr(196, -23)
			},
			wire =
			{
				copper = util.by_pixel_hr(0, 0),
				red = util.by_pixel_hr(0, 2),
				green = util.by_pixel_hr(0, 4)
			}
		},
		{
			shadow =
			{
				copper = util.by_pixel_hr(1, 1),
				red = util.by_pixel_hr(208, 12),
				green = util.by_pixel_hr(217, -30)
			},
			wire =
			{
				copper = util.by_pixel_hr(0, 0),
				red = util.by_pixel_hr(0, 2),
				green = util.by_pixel_hr(0, 4)
			}
		},
		{
			shadow =
			{
				copper = util.by_pixel_hr(1, 1),
				red = util.by_pixel_hr(195, 1),
				green = util.by_pixel_hr(238, -23)
			},
			wire =
			{
				copper = util.by_pixel_hr(0, 0),
				red = util.by_pixel_hr(0, 2),
				green = util.by_pixel_hr(0, 4)
			}
		}
	}
data:extend({stolb_1})

local stolb_2 = table.deepcopy(data.raw['electric-pole']['stolb'])
stolb_2.name = "stolb-2"
stolb_2.icon = "__b_light_poles-revived__/graphics/icons/ico_r.png"
stolb_2.pictures = -- графика
	{
		layers =
		{
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_r.png",
			priority = "extra-high",
			width = 84,
			height = 252,
			direction_count = 4,
			shift = util.by_pixel(0, -80),
			scale = 0.65
		},
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png",
			priority = "extra-high",
			width = 280,
			height = 64,
			direction_count = 4,
			shift = util.by_pixel(64, 1),
			scale = 0.6,
			draw_as_shadow = true
		}
		}
	}
stolb_2.minable.result = "stolb-2"
data:extend({stolb_2})

local stolb_3 = table.deepcopy(data.raw['electric-pole']['stolb'])
stolb_3.name = "stolb-3"
stolb_3.icon = "__b_light_poles-revived__/graphics/icons/ico_g.png"
stolb_3.pictures = -- графика
	{
		layers =
		{
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_g.png",
			priority = "extra-high",
			width = 84,
			height = 252,
			direction_count = 4,
			shift = util.by_pixel(0, -80),
			scale = 0.65
		},
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png",
			priority = "extra-high",
			width = 280,
			height = 64,
			direction_count = 4,
			shift = util.by_pixel(64, 1),
			scale = 0.6,
			draw_as_shadow = true
		}
		}
	}
stolb_3.minable.result = "stolb-3"
data:extend({stolb_3})

local stolb_4 = table.deepcopy(data.raw['electric-pole']['stolb'])
stolb_4.name = "stolb-4"
stolb_4.icon = "__b_light_poles-revived__/graphics/icons/ico_o.png"
stolb_4.pictures = -- графика
	{
		layers =
		{
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_o.png",
			priority = "extra-high",
			width = 84,
			height = 252,
			direction_count = 4,
			shift = util.by_pixel(0, -80),
			scale = 0.65
		},
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png",
			priority = "extra-high",
			width = 280,
			height = 64,
			direction_count = 4,
			shift = util.by_pixel(64, 1),
			scale = 0.6,
			draw_as_shadow = true
		}
		}
	}
stolb_4.minable.result = "stolb-4"
data:extend({stolb_4})

local stolb_5 = table.deepcopy(data.raw['electric-pole']['stolb'])
stolb_5.name = "stolb-5"
stolb_5.icon = "__b_light_poles-revived__/graphics/icons/ico_b.png"
stolb_5.pictures = -- графика
	{
		layers =
		{
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_b.png",
			priority = "extra-high",
			width = 84,
			height = 252,
			direction_count = 4,
			shift = util.by_pixel(0, -80),
			scale = 0.65
		},
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png",
			priority = "extra-high",
			width = 280,
			height = 64,
			direction_count = 4,
			shift = util.by_pixel(64, 1),
			scale = 0.6,
			draw_as_shadow = true
		}
		}
	}
stolb_5.minable.result = "stolb-5"
data:extend({stolb_5})


local stolb_r = table.deepcopy(data.raw['electric-pole']['stolb'])
stolb_r.name = "stolb-r"
stolb_r.icon = "__b_light_poles-revived__/graphics/icons/ico_rgb.png"
stolb_r.pictures = -- графика
{
	layers =
	{
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_w.png",
			priority = "extra-high",
			width = 84,
			height = 252,
			direction_count = 4,
			shift = util.by_pixel(0, -80),
			scale = 0.65
		},
		{
			filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png",
			priority = "extra-high",
			width = 280,
			height = 64,
			direction_count = 4,
			shift = util.by_pixel(64, 1),
			scale = 0.6,
			draw_as_shadow = true
		}
	}
}
stolb_r.minable.result = "stolb-r"
data:extend({stolb_r})

local lamp_w = table.deepcopy(data.raw["lamp"]["small-lamp"])
lamp_w.name = "lamp-w"
lamp_w.icon_size = 64
lamp_w.icon = "__b_light_poles-revived__/graphics/icons/ico_w.png"
lamp_w.flags = {"placeable-off-grid", "not-on-map","not-blueprintable", "not-deconstructable",}
lamp_w.collision_box = {{-0.0, -0.0}, {0.0, 0.0}}
lamp_w.selection_box = {{-0.4, -0.4}, {0.4, 0.4}}
lamp_w.selection_priority = 0
lamp_w.energy_usage_per_tick = "3KW"
lamp_w.picture_off =
{
    filename = "__core__/graphics/empty.png",
    priority = "high",
    width = 1,
    height = 1,
    frame_count = 1,
    axially_symmetrical = false,
    direction_count = 1,
}
lamp_w.picture_on =
{
    filename = "__core__/graphics/empty.png",
    priority = "high",
    width = 1,
    height = 1,
    frame_count = 1,
    axially_symmetrical = false,
    direction_count = 1,
}

lamp_w.light = {intensity = 0.9, size = 28, color = {r = 255, g = 255, b = 255}} -- белый
lamp_w.light_when_colored = {intensity = 0, size = 1, color = {r=1.0, g=1.0, b=1.0}}
data:extend({lamp_w})

local lamp_r = table.deepcopy(data.raw["lamp"]["lamp-w"])
lamp_r.name = "lamp-r"
lamp_r.icon = "__b_light_poles-revived__/graphics/icons/ico_r.png"
lamp_r.light = {intensity = 0.9, size = 28, color = {r = 255, g = 0, b = 0}} -- красный
data:extend({lamp_r})

local lamp_o = table.deepcopy(data.raw["lamp"]["lamp-w"])
lamp_o.name = "lamp-o"
lamp_o.icon = "__b_light_poles-revived__/graphics/icons/ico_o.png"
lamp_o.light = {intensity = 0.9, size = 28, color = {r = 255, g = 130, b = 0}}-- оранжевый
data:extend({lamp_o})

local lamp_g = table.deepcopy(data.raw["lamp"]["lamp-w"])
lamp_g.name = "lamp-g"
lamp_g.icon = "__b_light_poles-revived__/graphics/icons/ico_g.png"
lamp_g.light = {intensity = 0.9, size = 28, color =  {r = 50, g = 255, b = 50}} --зеленый
data:extend({lamp_g})

local lamp_b = table.deepcopy(data.raw["lamp"]["lamp-w"])
lamp_b.name = "lamp-b"
lamp_b.icon = "__b_light_poles-revived__/graphics/icons/ico_b.png"
lamp_b.light = {intensity = 1.3, size = 28, color = {r = 0, g = 105, b = 255}} --синий
data:extend({lamp_b})