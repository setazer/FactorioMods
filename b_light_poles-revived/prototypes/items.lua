--lamp poles
local light_pole_w_item = table.deepcopy(data.raw['item']['medium-electric-pole'])
light_pole_w_item.name = "light_pole-w"
light_pole_w_item.icon_size = 64
light_pole_w_item.icon ="__b_light_poles-revived__/graphics/icons/ico_w.png"
light_pole_w_item.subgroup = "circuit-network"
light_pole_w_item.order = "a[light]-a[light_pole-1]"
light_pole_w_item.place_result = "light_pole-w"
data:extend({light_pole_w_item})

local light_pole_r_item = table.deepcopy(data.raw['item']['light_pole-w'])
light_pole_r_item.name = "light_pole-r"
light_pole_r_item.icon ="__b_light_poles-revived__/graphics/icons/ico_r.png"
light_pole_r_item.subgroup = "circuit-network"
light_pole_r_item.order = "a[light]-a[light_pole-2]"
light_pole_r_item.place_result = "light_pole-r"
data:extend({light_pole_r_item})

local light_pole_g_item = table.deepcopy(data.raw['item']['light_pole-w'])
light_pole_g_item.name = "light_pole-g"
light_pole_g_item.icon ="__b_light_poles-revived__/graphics/icons/ico_g.png"
light_pole_g_item.subgroup = "circuit-network"
light_pole_g_item.order = "a[light]-a[light_pole-3]"
light_pole_g_item.place_result = "light_pole-g"
data:extend({light_pole_g_item})

local light_pole_b_item = table.deepcopy(data.raw['item']['light_pole-w'])
light_pole_b_item.name = "light_pole-b"
light_pole_b_item.icon ="__b_light_poles-revived__/graphics/icons/ico_b.png"
light_pole_b_item.subgroup = "circuit-network"
light_pole_b_item.order = "a[light]-b[light_pole-5]"
light_pole_b_item.place_result = "light_pole-b"
data:extend({light_pole_b_item})

local light_pole_o_item = table.deepcopy(data.raw['item']['light_pole-w'])
light_pole_o_item.name = "light_pole-o"
light_pole_o_item.icon ="__b_light_poles-revived__/graphics/icons/ico_o.png"
light_pole_o_item.subgroup = "circuit-network"
light_pole_o_item.order = "a[light]-a[light_pole-4]"
light_pole_o_item.place_result = "light_pole-o"
data:extend({light_pole_o_item})

local light_pole_rgb_item = table.deepcopy(data.raw['item']['light_pole-w'])
light_pole_rgb_item.name = "light_pole-rgb"
light_pole_rgb_item.icon ="__b_light_poles-revived__/graphics/icons/ico_rgb.png"
light_pole_rgb_item.subgroup = "circuit-network"
light_pole_rgb_item.order = "a[light]-b[light_pole-6]"
light_pole_rgb_item.place_result = "light_pole-rgb"
data:extend({light_pole_rgb_item})


--hidden lamps
local lamp_w_item = table.deepcopy(data.raw["item"]["small-lamp"])
lamp_w_item.name = "lamp-w"
lamp_w_item.icon_size = 64
lamp_w_item.icon ="__b_light_poles-revived__/graphics/icons/ico_w.png"
lamp_w_item.flags = {"hidden"}
lamp_w_item.place_result = "lamp-w"
data:extend({lamp_w_item })

local lamp_r_item = table.deepcopy(data.raw["item"]["lamp-w"])
lamp_r_item.name = "lamp-r"
lamp_r_item.icon ="__b_light_poles-revived__/graphics/icons/ico_r.png"
lamp_r_item.place_result = "lamp-r"
data:extend({lamp_r_item })

local lamp_g_item = table.deepcopy(data.raw["item"]["lamp-w"])
lamp_g_item.name = "lamp-g"
lamp_g_item.icon ="__b_light_poles-revived__/graphics/icons/ico_g.png"
lamp_g_item.place_result = "lamp-g"
data:extend({lamp_g_item })

local lamp_b_item = table.deepcopy(data.raw["item"]["lamp-w"])
lamp_b_item.name = "lamp-b"
lamp_b_item.icon = "__b_light_poles-revived__/graphics/icons/ico_b.png"
lamp_b_item.place_result = "lamp-b"
data:extend({lamp_b_item })

local lamp_o_item = table.deepcopy(data.raw["item"]["lamp-w"])
lamp_o_item.name = "lamp-o"
lamp_o_item.icon = "__b_light_poles-revived__/graphics/icons/ico_o.png"
lamp_o_item.place_result = "lamp-o"
data:extend({lamp_o_item })

