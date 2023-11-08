local lamp_tick_int = settings.global["lamp-tick"].value
LAMPS = {"lamp-o", "lamp-b", "lamp-r" , "lamp-g"}

local function create_lamp(strobe, lamp_name)
	local surface = strobe.surface
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

local function On120Ticks(current_tick)
	for _, record in pairs(global.strobe) do
		if record.strobe.name == "stolb-r" then
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

	local lamp_name = nil

	if entity.name == "stolb" then lamp_name = "lamp-w" end
	if entity.name == "stolb-2" then lamp_name = "lamp-r" end
	if entity.name == "stolb-3" then lamp_name = "lamp-g" end
	if entity.name == "stolb-4" then lamp_name = "lamp-o" end
	if entity.name == "stolb-5" then lamp_name = "lamp-b" end
	if entity.name == "stolb-r" then lamp_name = LAMPS[math.random(1,#LAMPS)] end

	if lamp_name then
		local direction = entity.direction
		local surface = entity.surface
		local force = entity.force
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
	if string.find(entity.name, "stolb-") then
		local center = entity.position
		local area = {{center.x-0.5, center.y-0.5}, {center.x+0.5, center.y+0.5}}
		local lamp_w = surface.find_entities_filtered{area = area, name = "lamp-w"}
		for k, lamp in pairs (lamp_w) do
		lamp.destructible = true
		lamp.minable = true
		lamp.destroy()
		end
		local lamp_r = surface.find_entities_filtered{area = area, name = "lamp-r"}
		for k, lamp in pairs (lamp_r) do
		lamp.destructible = true
		lamp.minable = true
		lamp.destroy()
		end
		local lamp_y = surface.find_entities_filtered{area = area, name = "lamp-o"}
		for k, lamp in pairs (lamp_y) do
		lamp.destructible = true
		lamp.minable = true
		lamp.destroy()
		end
		local lamp_g = surface.find_entities_filtered{area = area, name = "lamp-g"}
		for k, lamp in pairs (lamp_g) do
		lamp.destructible = true
		lamp.minable = true
		lamp.destroy()
		end
		local lamp_b = surface.find_entities_filtered{area = area, name = "lamp-b"}
		for k, lamp in pairs (lamp_b) do
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
script.on_nth_tick(lamp_tick_int, On120Ticks)