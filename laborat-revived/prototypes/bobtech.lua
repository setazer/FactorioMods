local on_anim_2 =
{
	layers = 
	{
		{
			filename = "__laborat-revived__/graphics/entity/lab_albedo_anim.png",
			width = 150,
			height = 150,
			frame_count = 29, -- всего кадров анимации
			line_length = 10, -- кадров в одной линии
			animation_speed = 1 / 3,
			shift = {0,-0.05},
			scale = 0.64
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_light_anim.png",
			width = 150,
			height = 150,
			frame_count = 29, -- всего кадров анимации
			line_length = 10, -- кадров в одной линии
			animation_speed = 1 / 3,
			shift = {0,-0.05},
			scale = 0.64,
			blend_mode = "additive-soft"
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_light_anim.png",
			width = 150,
			height = 150,
			frame_count = 29, -- всего кадров анимации
			line_length = 10, -- кадров в одной линии
			animation_speed = 1 / 3,
			shift = {0,-0.05},
			scale = 0.64,
			blend_mode = "additive-soft"
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_shadow.png",
			width = 240,
			height = 240,
			frame_count = 1, -- всего кадров анимации
			line_length = 1, -- кадров в одной линии
			repeat_count = 29, -- накладывать на кол-во кадров анимации (у нас вверху анимация состоит из 29 кадров, а тень 1 кадр, так вот мы указываем что хотели бы ко всем 30 применить)
			animation_speed = 1,
			shift = {0,-0.20},
			scale = 0.75,
			draw_as_shadow = true -- этот параметр применяется к анимации тени, true - вкл. false - откл
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_albedo_ao.png",
			width = 220,
			height = 220,
			frame_count = 1, -- всего кадров анимации
			repeat_count = 29,
			animation_speed = 1 / 3,
			shift = {0,-0.05},
			scale = 0.50,
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_icon_bob_2.png",
			width = 54,
			height = 54,
			frame_count = 1, -- всего кадров анимации
			repeat_count = 29,
			animation_speed = 1 / 3,
			shift = {0,0.4},
			scale = 0.40
		}
	 }
}

local off_anim_2 =
{
	layers = 
	{
		{
			filename = "__laborat-revived__/graphics/entity/lab_albedo.png",
			width = 150,
			height = 150,
			frame_count = 1,
			shift = {0,-0.05},
			scale = 0.64
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_shadow.png",
			width = 240,
			height = 240,
			frame_count = 1, 
			repeat_count = 1,
			shift = {0,-0.20},
			scale = 0.75,
			draw_as_shadow = true
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_albedo_ao.png",
			width = 220,
			height = 220,
			frame_count = 1, -- всего кадров анимации
			repeat_count = 1,
			animation_speed = 1 / 3,
			shift = {0,-0.05},
			scale = 0.50,
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_icon_bob_2.png",
			width = 54,
			height = 54,
			frame_count = 1,
			repeat_count = 1,
			animation_speed = 1 / 3,
			shift = {0,0.4},
			scale = 0.40
		}
	}
}


if data.raw["item"]["lab-2"].icon_size == 64 then
	data.raw["item"]["lab-2"].icon = "__laborat-revived__/graphics/icons/lab_icon_bob_2_64.png"
elseif data.raw["item"]["lab-2"].icon_size == 32 then
	data.raw["item"]["lab-2"].icon = "__laborat-revived__/graphics/icons/lab_icon_bob_2_32.png"
end
data.raw["lab"]["lab-2"].on_animation = on_anim_2
data.raw["lab"]["lab-2"].off_animation = off_anim_2


if mods["ShinyBobGFX"] and mods["bobtech"] then
	data.raw["item"]["lab-2"].icon = nil
	data.raw["lab"]["lab-2"].on_animation = nil
	data.raw["lab"]["lab-2"].off_animation = nil
	if data.raw["item"]["lab-2"].icon_size == 64 then
		data.raw["item"]["lab-2"].icon = "__laborat-revived__/graphics/icons/lab_icon_bob_2_64.png"
	elseif data.raw["item"]["lab-2"].icon_size == 32 then
		data.raw["item"]["lab-2"].icon = "__laborat-revived__/graphics/icons/lab_icon_bob_2_32.png"
	end
	if data.raw["lab"]["lab-2"].icon_size == 64 then
		data.raw["lab"]["lab-2"].icon = "__laborat-revived__/graphics/icons/lab_icon_bob_2_64.png"
	elseif data.raw["lab"]["lab-2"].icon_size == 32 then
		data.raw["lab"]["lab-2"].icon = "__laborat-revived__/graphics/icons/lab_icon_bob_2_32.png"
	end
	data.raw["lab"]["lab-2"].on_animation = on_anim_2
	data.raw["lab"]["lab-2"].off_animation = off_anim_2
end