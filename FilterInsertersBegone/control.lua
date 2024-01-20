function OnBuiltInserter(event)
   local entity = event.created_entity or event.entity or event.destination
   entity.inserter_filter_mode = "blacklist"
end

--created_entity
script.on_event(defines.events.on_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.on_robot_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
--destination
script.on_event(defines.events.on_entity_cloned, OnBuiltInserter,  {{filter="type", type="inserter"}})
--entity
script.on_event(defines.events.script_raised_built, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.script_raised_revive, OnBuiltInserter,  {{filter="type", type="inserter"}})