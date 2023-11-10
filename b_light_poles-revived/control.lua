local lamp_tick_int = settings.global["lamp-tick"].value
LAMPS = {"lamp-o", "lamp-b", "lamp-r" , "lamp-g"}

local function create_lamp(strobe, lamp_name)
	local direction = strobe.direction
	local surface = strobe.surface
	local force = strobe.force
	local position = strobe.position

	local lamp = surface.create_entity{
		name = lamp_name,
		position = {x = position.x, y = position.y},
		direction = direction,
		force = force
	}
	lamp.destructible = false
	lamp.minable = false
	return lamp
end

local function OnDoStrobe(current_tick)
	for _, record in pairs(global.strobe) do
		if record.strobe.name == "light_pole-rgb" then
			record.lamp.destroy()
			record.lamp = create_lamp(record.strobe, LAMPS[math.random(1,#LAMPS)])
		end
	end
end

local function OnStartup()
	global.strobe = global.strobe or {}
	global.strobe_queue = global.strobe_queue or {}
end

local function on_built(event)
	local entity = event.created_entity
	if not (entity and entity.valid) then return end

	local light_pole_to_lamp = {
		['light_pole-w'] = 'lamp-w',
		['light_pole-r'] = 'lamp-r',
		['light_pole-g'] = 'lamp-g',
		['light_pole-b'] = 'lamp-b',
		['light_pole-o'] = 'lamp-o',
		['light_pole-rgb'] = LAMPS[math.random(1,#LAMPS)]
	}

	local lamp_name = light_pole_to_lamp[entity.name]
	if lamp_name then
		local lamp = create_lamp(entity, lamp_name)
		global.strobe[entity.unit_number] = {strobe=entity, lamp=lamp}
		table.insert(global.strobe_queue, entity.unit_number)
	end
end

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.script_raised_built, on_built)

function del(event)
	local entity = event.entity
	if not (entity and entity.valid) then return end

	if global.strobe[entity.unit_number] then
		global.strobe[entity.unit_number].lamp.destroy()
		global.strobe[entity.unit_number] = nil
	end
	local surface = entity.surface
	if string.find(entity.name, "light_pole-") then
		local center = entity.position
		local area = {{center.x-0.5, center.y-0.5}, {center.x+0.5, center.y+0.5}}
		local lamp_w = surface.find_entities_filtered{area = area, name = "lamp-w"}
		for _, lamp in pairs (lamp_w) do
			lamp.destructible = true
			lamp.minable = true
			lamp.destroy()
		end
		local lamp_r = surface.find_entities_filtered{area = area, name = "lamp-r"}
		for _, lamp in pairs (lamp_r) do
			lamp.destructible = true
			lamp.minable = true
			lamp.destroy()
		end

		local lamp_g = surface.find_entities_filtered{area = area, name = "lamp-g"}
		for _, lamp in pairs (lamp_g) do
			lamp.destructible = true
			lamp.minable = true
			lamp.destroy()
		end
		local lamp_b = surface.find_entities_filtered{area = area, name = "lamp-b"}
		for _, lamp in pairs (lamp_b) do
			lamp.destructible = true
			lamp.minable = true
			lamp.destroy()
		end
		local lamp_y = surface.find_entities_filtered{area = area, name = "lamp-o"}
		for _, lamp in pairs (lamp_y) do
			lamp.destructible = true
			lamp.minable = true
			lamp.destroy()
		end
	end
end

script.on_event(defines.events.on_player_mined_entity, del)
script.on_event(defines.events.on_entity_died, del)
script.on_event(defines.events.on_robot_mined_entity, del)
script.on_event(defines.events.script_raised_destroy, del)

script.on_init(OnStartup)
script.on_configuration_changed(OnStartup)
script.on_nth_tick(lamp_tick_int, OnDoStrobe)