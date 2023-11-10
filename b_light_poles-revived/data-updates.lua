if data.raw.technology["basic-optics"] then
	table.insert(data.raw.technology["basic-optics"].effects, {type="unlock-recipe",recipe="light_pole-w"})
	table.insert(data.raw.technology["basic-optics"].effects, {type="unlock-recipe",recipe="light_pole-r"})
	table.insert(data.raw.technology["basic-optics"].effects, {type="unlock-recipe",recipe="light_pole-g"})
	table.insert(data.raw.technology["basic-optics"].effects, {type="unlock-recipe",recipe="light_pole-b"})
	table.insert(data.raw.technology["basic-optics"].effects, {type="unlock-recipe",recipe="light_pole-o"})
	table.insert(data.raw.technology["basic-optics"].effects, {type="unlock-recipe",recipe="light_pole-rgb"})
end
if data.raw.technology["optics"] then
	table.insert(data.raw.technology["optics"].effects, {type="unlock-recipe", recipe="light_pole-w"})
	table.insert(data.raw.technology["optics"].effects, {type="unlock-recipe", recipe="light_pole-r"})
	table.insert(data.raw.technology["optics"].effects, {type="unlock-recipe", recipe="light_pole-g"})
	table.insert(data.raw.technology["optics"].effects, {type="unlock-recipe", recipe="light_pole-b"})
	table.insert(data.raw.technology["optics"].effects, {type="unlock-recipe", recipe="light_pole-o"})
	table.insert(data.raw.technology["optics"].effects, {type="unlock-recipe", recipe="light_pole-rgb"})
end

