function OnBuiltInserter(event)
   local entity = event.created_entity
   entity.inserter_filter_mode = "blacklist"
end

script.on_event(defines.events.on_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.on_entity_cloned, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.on_robot_built_entity, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.script_raised_built, OnBuiltInserter,  {{filter="type", type="inserter"}})
script.on_event(defines.events.script_raised_revive, OnBuiltInserter,  {{filter="type", type="inserter"}})