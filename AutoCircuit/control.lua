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

local function is_long_distance_pole(entity)
   local poleproto = entity.prototype
   return (poleproto.supply_area_distance <= 2
           or poleproto.max_wire_distance >= 30)
end

local function is_viable_for_connection(event)
   local connect_long_only = settings.get_player_settings(event.player_index)["ac-connect-long-distance-poles-only"].value
   return not connect_long_only or is_long_distance_pole(event.created_entity)
end

local function has_red_wire(pole)
   local redwires = pole.neighbours["red"]
   return (redwires ~= nil) and (#redwires > 0)
end

local function has_green_wire(pole)
   local greenwires = pole.neighbours["green"]
   return (greenwires ~= nil) and (#greenwires > 0)
end

function OnBuiltElectricPole(event)
   if not game.players[event.player_index].is_shortcut_toggled("ac-shortcut") then
      return
   end
   local entity = event.created_entity
   if (not entity) or (not is_viable_for_connection(event)) then
      return
   end

   local copperbuddies = entity.neighbours["copper"]
   if not copperbuddies then
      return
   end

   local connect_same_only = settings.get_player_settings(event.player_index)["ac-connect-same-type-poles-only"].value
   local newconnects = {}
   for _, otherpole in pairs(copperbuddies) do
      if not is_viable_for_connection(event) then
         goto continue
      end

      if connect_same_only and entity.prototype ~= otherpole.prototype then
         goto continue
      end

      if has_red_wire(otherpole) then
         newconnects[#newconnects + 1] = {wire = defines.wire_type.red,
                                          target_entity = otherpole}
      end
      if has_green_wire(otherpole) then
         newconnects[#newconnects + 1] = {wire = defines.wire_type.green,
                                          target_entity = otherpole}
      end
      ::continue::
   end
   for _, newconnect in pairs(newconnects) do
      entity.connect_neighbour(newconnect)
   end
end

script.on_event(defines.events.on_built_entity, OnBuiltElectricPole,  {{ filter = "type", type = "electric-pole"}})
