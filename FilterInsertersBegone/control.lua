
local function init()
   global.fast_replaced_inserters = {}
end

script.on_init(init)
script.on_configuration_changed(init)

local function pos_to_str(position) 
   return position.x .. ";" .. position.y
end

local function is_filter_inserter(entity)
   return string.match(entity.name, "filter")
end

local function has_empty_filters(entity)
   for i=1,entity.filter_slot_count do
      if entity.get_filter(i) then
         return false
      end
   end
   return true
end

local function has_circuit_connections(entity)
   red = entity.circuit_connected_entities.red
   green = entity.circuit_connected_entities.green
   return red and next(red) ~= nil or green and next(green) ~= nil
end

local function is_fast_replaced(position, cur_tick) 
   local deprecated = {}
   local result = nil
   for pos, tick in pairs(global.fast_replaced_inserters) do
      if pos == pos_to_str(position) and tick == cur_tick then
         result = cur_tick  -- there was inserter at position
      elseif tick < cur_tick then
         table.insert(deprecated, pos)
      end
   end
   -- cleaning old data
   for _, pos in ipairs(deprecated) do
      global.fast_replaced_inserters[pos] = nil
   end

   return result
end

function OnMinedInserter(event)
   local entity = event.entity
   local tick = event.tick
   local position = entity.position
   global.fast_replaced_inserters[pos_to_str(position)] = tick
end

function OnBuiltInserter(event)
   local entity = event.created_entity or event.entity or event.destination
   local tick = event.tick
   local position = entity.position
   if has_empty_filters(entity) and entity.inserter_filter_mode == "whitelist" and not is_filter_inserter(entity) and not has_circuit_connections(entity) then
      local fast_replaced = is_fast_replaced(position, tick)
      if fast_replaced then
         global.fast_replaced_inserters[pos_to_str(position)] = nil
      else
         entity.inserter_filter_mode = "blacklist"
      end
   end
end

--entity
script.on_event(defines.events.on_player_mined_entity, OnMinedInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.on_robot_mined_entity, OnMinedInserter,  {{filter="type", type="inserter"}})

--created_entity
script.on_event(defines.events.on_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.on_robot_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
--destination
script.on_event(defines.events.on_entity_cloned, OnBuiltInserter,  {{filter="type", type="inserter"}})
--entity
script.on_event(defines.events.script_raised_built, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.script_raised_revive, OnBuiltInserter,  {{filter="type", type="inserter"}})
