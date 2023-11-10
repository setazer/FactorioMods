local util = require "util"

local show_wires = settings.startup["show-pole-lamp-wires"].value

local light_pole_w = table.deepcopy(data.raw['electric-pole']['medium-electric-pole'])
light_pole_w.name = "light_pole-w"
light_pole_w.minable.result = "light_pole-w"
light_pole_w.icon_size = 64
light_pole_w.icon = "__b_light_poles-revived__/graphics/icons/ico_w.png"
light_pole_w.maximum_wire_distance = 16 -- длинна на которой провод будет цеплятся по умолчанию 9
light_pole_w.supply_area_distance = 0.2 -- область вокруг столба, которую он покрывает по умолчанию 3.5
light_pole_w.collision_box = { { -0.4, -0.4}, { 0.4, 0.4}}
light_pole_w.selection_box = { { -0.4, -0.4}, { 0.4, 0.4}}
light_pole_w.pictures = -- графика
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
light_pole_w.radius_visualisation_picture.width = 1
light_pole_w.radius_visualisation_picture.height= 1
light_pole_w.connection_points = -- подключение проводов
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
light_pole_w.draw_copper_wires = show_wires
data:extend({ light_pole_w })

local light_pole_r = table.deepcopy(data.raw['electric-pole']['light_pole-w'])
light_pole_r.name = "light_pole-r"
light_pole_r.minable.result = "light_pole-r"
light_pole_r.icon = "__b_light_poles-revived__/graphics/icons/ico_r.png"
light_pole_r.pictures.layers[1].filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_r.png"
light_pole_r.pictures.layers[2].filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png"
data:extend({light_pole_r})

local light_pole_g = table.deepcopy(data.raw['electric-pole']['light_pole-w'])
light_pole_g.name = "light_pole-g"
light_pole_g.minable.result = "light_pole-g"
light_pole_g.icon = "__b_light_poles-revived__/graphics/icons/ico_g.png"
light_pole_g.pictures.layers[1].filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_g.png"
light_pole_g.pictures.layers[2].filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png"
data:extend({light_pole_g})

local light_pole_o = table.deepcopy(data.raw['electric-pole']['light_pole-w'])
light_pole_o.name = "light_pole-o"
light_pole_o.minable.result = "light_pole-o"
light_pole_o.icon = "__b_light_poles-revived__/graphics/icons/ico_o.png"
light_pole_o.pictures.layers[1].filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_o.png"
light_pole_o.pictures.layers[2].filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png"
data:extend({light_pole_o})

local light_pole_b = table.deepcopy(data.raw['electric-pole']['light_pole-w'])
light_pole_b.name = "light_pole-b"
light_pole_b.minable.result = "light_pole-b"
light_pole_b.icon = "__b_light_poles-revived__/graphics/icons/ico_b.png"
light_pole_b.pictures.layers[1].filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_b.png"
light_pole_b.pictures.layers[2].filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png"
data:extend({light_pole_b})


local light_pole_rgb = table.deepcopy(data.raw['electric-pole']['light_pole-w'])
light_pole_rgb.name = "light_pole-rgb"
light_pole_rgb.minable.result = "light_pole-rgb"
light_pole_rgb.icon = "__b_light_poles-revived__/graphics/icons/ico_rgb.png"
light_pole_rgb.pictures.layers[1].filename = "__b_light_poles-revived__/graphics/entities/hr_medium-electric-pole_w.png"
light_pole_rgb.pictures.layers[2].filename = "__b_light_poles-revived__/graphics/entities/hr-medium-electric-pole-shadow.png"
data:extend({light_pole_rgb})

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