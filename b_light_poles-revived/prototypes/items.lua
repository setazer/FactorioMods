local stolb_it = table.deepcopy(data.raw['item']['medium-electric-pole'])
stolb_it.name = "stolb"
stolb_it.icon_size = 64
stolb_it.icon ="__b_light_poles-revived__/graphics/icons/ico_w.png"
stolb_it.subgroup = "circuit-network"
stolb_it.order = "a[light]-a[stolb-1]"
stolb_it.place_result = "stolb"
data:extend({stolb_it})

local stolb_it_2 = table.deepcopy(data.raw['item']['stolb'])
stolb_it_2.name = "stolb-2"
stolb_it_2.icon ="__b_light_poles-revived__/graphics/icons/ico_r.png"
stolb_it_2.subgroup = "circuit-network"
stolb_it_2.order = "a[light]-a[stolb-2]"
stolb_it_2.place_result = "stolb-2"
data:extend({stolb_it_2})

local stolb_it_3 = table.deepcopy(data.raw['item']['stolb'])
stolb_it_3.name = "stolb-3"
stolb_it_3.icon ="__b_light_poles-revived__/graphics/icons/ico_g.png"
stolb_it_3.subgroup = "circuit-network"
stolb_it_3.order = "a[light]-a[stolb-3]"
stolb_it_3.place_result = "stolb-3"
data:extend({stolb_it_3})

local stolb_it_4 = table.deepcopy(data.raw['item']['stolb'])
stolb_it_4.name = "stolb-4"
stolb_it_4.icon ="__b_light_poles-revived__/graphics/icons/ico_o.png"
stolb_it_4.subgroup = "circuit-network"
stolb_it_4.order = "a[light]-a[stolb-4]"
stolb_it_4.place_result = "stolb-4"
data:extend({stolb_it_4})

local stolb_it_5 = table.deepcopy(data.raw['item']['stolb'])
stolb_it_5.name = "stolb-5"
stolb_it_5.icon ="__b_light_poles-revived__/graphics/icons/ico_b.png"
stolb_it_5.subgroup = "circuit-network"
stolb_it_5.order = "a[light]-b[stolb-5]"
stolb_it_5.place_result = "stolb-5"
data:extend({stolb_it_5})


local stolb_it_r = table.deepcopy(data.raw['item']['stolb'])
stolb_it_r.name = "stolb-r"
stolb_it_r.icon ="__b_light_poles-revived__/graphics/icons/ico_rgb.png"
stolb_it_r.subgroup = "circuit-network"
stolb_it_r.order = "a[light]-b[stolb-6]"
stolb_it_r.place_result = "stolb-r"
data:extend({stolb_it_r})

local lamp_it_w = table.deepcopy(data.raw["item"]["small-lamp"])
lamp_it_w.name = "lamp-w"
lamp_it_w.icon_size = 64
lamp_it_w.icon ="__b_light_poles-revived__/graphics/icons/ico_w.png"
lamp_it_w.flags = {"hidden"}
lamp_it_w.place_result = "lamp-w"
data:extend({lamp_it_w })

local lamp_it_r = table.deepcopy(data.raw["item"]["small-lamp"])
lamp_it_r.name = "lamp-r"
lamp_it_r.icon_size = 64
lamp_it_r.icon ="__b_light_poles-revived__/graphics/icons/ico_r.png"
lamp_it_r.flags = {"hidden"}
lamp_it_r.place_result = "lamp-r"
data:extend({lamp_it_r })

local lamp_it_g = table.deepcopy(data.raw["item"]["small-lamp"])
lamp_it_g.name = "lamp-g"
lamp_it_g.icon_size = 64
lamp_it_g.icon ="__b_light_poles-revived__/graphics/icons/ico_g.png"
lamp_it_g.flags = {"hidden"}
lamp_it_g.place_result = "lamp-g"
data:extend({lamp_it_g })

local lamp_it_o = table.deepcopy(data.raw["item"]["small-lamp"])
lamp_it_o.name = "lamp-o"
lamp_it_o.icon_size = 64
lamp_it_o.icon = "__b_light_poles-revived__/graphics/icons/ico_o.png"
lamp_it_o.flags = {"hidden"}
lamp_it_o.place_result = "lamp-o"
data:extend({lamp_it_o })

local lamp_it_b = table.deepcopy(data.raw["item"]["small-lamp"])
lamp_it_b.name = "lamp-b"
lamp_it_b.icon_size = 64
lamp_it_b.icon = "__b_light_poles-revived__/graphics/icons/ico_o.png"
lamp_it_b.flags = {"hidden"}
lamp_it_b.place_result = "lamp-b"
data:extend({lamp_it_b })
