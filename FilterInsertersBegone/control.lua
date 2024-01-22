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

function OnBuiltInserter(event)
   local entity = event.created_entity or event.entity or event.destination
   if has_empty_filters(entity) and entity.inserter_filter_mode == "whitelist" and not is_filter_inserter(entity) then
      entity.inserter_filter_mode = "blacklist"
   end
end

--created_entity
script.on_event(defines.events.on_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.on_robot_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
--destination
script.on_event(defines.events.on_entity_cloned, OnBuiltInserter,  {{filter="type", type="inserter"}})
--entity
script.on_event(defines.events.script_raised_built, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.script_raised_revive, OnBuiltInserter,  {{filter="type", type="inserter"}})