function OnShortCut(event)
   if event.prototype_name == "ac-shortcut" then
      local player = game.players[event.player_index]
      if player.is_shortcut_available("ac-shortcut") then
         local toggled = player.is_shortcut_toggled("ac-shortcut")
         player.set_shortcut_toggled("ac-shortcut", not toggled)
      end
   end
end

script.on_event(defines.events.on_lua_shortcut, OnShortCut)


local function get_player_setting(player_index, name)
   return settings.get_player_settings(player_index)[name].value
end

local function get_prototype(entity)
   return entity.type == 'entity-ghost' and entity.ghost_prototype or entity.prototype
end

local function is_long_distance_pole(entity)
   local poleproto = get_prototype(entity)
   return (poleproto.supply_area_distance <= 2
           or poleproto.max_wire_distance >= 30)
end

local function is_viable_for_connection(event)
   local connect_long_only = get_player_setting(event.player_index, "ac-connect-long-distance-poles-only")
   return not connect_long_only or is_long_distance_pole(event.created_entity)
end

local function has_wire(entity, color, string_to_ghosts)
   -- wire relations described in https://www.factorio.com/blog/post/fff-379
   -- wires between poles are two-way via *entity.neighbours* and *entity.circuit_connected_entities*
   -- except ghosts - they only connect to real entities via *entity.circuit_connected_entities* and real entities not connected back
   
   --so we check if what we trying to connect to has circuit connections to anything (ghost/real doesnt matter)
   local wires = entity.circuit_connected_entities[color]
   if (wires ~= nil) and (#wires > 0) then
      return true
   end

   -- if not we check real entity if IT has *entity.circuit_connected_entities* pointed at them
   if string_to_ghosts and entity.type ~= 'entity-ghost' then
      local neighbours = entity.neighbours["copper"]  -- ghosts are only neighbours by copper wire, but not others
      for _, n_pole in pairs(neighbours) do
         if n_pole.type == 'entity-ghost' then
            local ghost_wires = n_pole.circuit_connected_entities[color]
            for _, this_pole in pairs(ghost_wires) do
               if this_pole == entity then
                  return true
               end
            end
         end
      end
   end

   return false
end

local function get_connected_via_copper(entity, string_to_ghosts)
   if entity.type ~= 'entity-ghost' then
       return entity.neighbours["copper"]
   elseif string_to_ghosts then
       local copper_connection_definitions = entity.copper_connection_definitions
       local result_entities = {}
       for _, copper_entity in pairs(copper_connection_definitions) do
           result_entities[#result_entities+1] = copper_entity.target_entity
       end
       return result_entities
   end
   return {}
end

function OnBuiltElectricPole(event)
   if not game.players[event.player_index].is_shortcut_toggled("ac-shortcut") then
      return
   end

   local entity = event.created_entity
   if (not entity) or (not is_viable_for_connection(event)) then
      return
   end

   local string_to_ghosts = get_player_setting(event.player_index, "ac-string-to-ghosts")
   local copperbuddies = get_connected_via_copper(entity, string_to_ghosts)
   if not copperbuddies then
      return
   end

   local connect_same_only = get_player_setting(event.player_index, "ac-connect-same-type-poles-only")
   local newconnects = {}
   for _, otherpole in pairs(copperbuddies) do
      if not is_viable_for_connection(event) then
         goto continue
      end
      self_proto = get_prototype(entity)
      other_proto = get_prototype(otherpole)

      if connect_same_only and self_proto ~= other_proto then
         goto continue
      end

      if has_wire(otherpole, "red", string_to_ghosts) then
         newconnects[#newconnects + 1] = {wire = defines.wire_type.red,
                                          target_entity = otherpole}
      end
      if has_wire(otherpole, "green", string_to_ghosts) then
         newconnects[#newconnects + 1] = {wire = defines.wire_type.green,
                                          target_entity = otherpole}
      end
      ::continue::
   end
   for _, newconnect in pairs(newconnects) do
      entity.connect_neighbour(newconnect)
   end
end

script.on_event(defines.events.on_built_entity, OnBuiltElectricPole,  {{filter="type", type="electric-pole"}, {filter="ghost_type", type="electric-pole", mode="or"}})
