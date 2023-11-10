-- Reminder for what the default day/night times are:
-- sun starts to set at 0.25
-- sun fully set at 0.45
-- sun starts to rise at 0.55
-- sun fully risen at 0.75

data.raw["utility-constants"]["default"].daytime_color_lookup = {
	{0.000, "identity"},
	{0.150, "identity"},
	{0.200, "identity"},
	{0.375, "__colorimetric-luts-revived__/graphics/lut-riseset.png"},
	{0.450, "__colorimetric-luts-revived__/graphics/lut-night.png"},
	{0.550, "__colorimetric-luts-revived__/graphics/lut-night.png"},
	{0.625, "__colorimetric-luts-revived__/graphics/lut-riseset.png"},
	{0.800, "identity"},
	{0.850, "identity"}
}

data.raw["utility-constants"]["default"].zoom_to_world_daytime_color_lookup = {
	{0.250, "identity"},
	{0.375, "__colorimetric-luts-revived__/graphics/lut-riseset.png"},
	{0.450, "__colorimetric-luts-revived__/graphics/night.png"},
	{0.550, "__colorimetric-luts-revived__/graphics/night.png"},
	{0.625, "__colorimetric-luts-revived__/graphics/lut-riseset.png"},
	{0.750, "identity"},
}

data.raw["night-vision-equipment"]["night-vision-equipment"].color_lookup = {
	{0.5, "__colorimetric-luts-revived__/graphics/nightvision.png"}
}