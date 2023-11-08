data.raw["lab"]["se-space-science-lab"].icon = "__laborat-revived__/graphics/icons/lab_albedo_icon_32.png"
data.raw["lab"]["se-space-science-lab"].on_animation =
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
			scale = 0.76*2
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_light_anim.png",
			width = 150,
			height = 150,
			frame_count = 29, -- всего кадров анимации
			line_length = 10, -- кадров в одной линии
			animation_speed = 1 / 3,
			shift = {0,-0.05},
			scale = 0.76*2,
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
			scale = 0.76*2,
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
			scale = 0.87*2,
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
			scale = 0.62*2,
		}
	 }
}

data.raw["lab"]["se-space-science-lab"].off_animation =
{
	layers = 
	{
		{
			filename = "__laborat-revived__/graphics/entity/lab_albedo.png",
			width = 150,
			height = 150,
			frame_count = 1,
			shift = {0,-0.05},
			scale = 0.76*2
		},
		{
			filename = "__laborat-revived__/graphics/entity/lab_shadow.png",
			width = 240,
			height = 240,
			frame_count = 1, 
			repeat_count = 1,
			shift = {0,-0.20},
			scale = 0.87*2,
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
			scale = 0.62*2,
		}
	}
}
