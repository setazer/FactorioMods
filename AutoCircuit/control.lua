function OnShortCut(event)
   if event.prototype_name == "autocircuit-shortcut" then
      local player = game.players[event.player_index]
      if player.is_shortcut_available("autocircuit-shortcut") then
         local toggled = player.is_shortcut_toggled("autocircuit-shortcut")
         player.set_shortcut_toggled("autocircuit-shortcut", not toggled)
      end
   end
end

script.on_event(defines.events.on_lua_shortcut, OnShortCut)

local function is_long_distance_pole(entity)
   if entity.type ~= "electric-pole" then
      return false
   else
      local poleproto = entity.prototype
      if poleproto.supply_area_distance > 2 then
         return false
      elseif poleproto.max_wire_distance < 30 then
         return false
      else
         return true
      end
   end
end

local function has_red_wire(pole)
   local redwires = pole.neighbours["red"]
   return (redwires ~= nil) and (#redwires > 0)
end

local function has_green_wire(pole)
   local greenwires = pole.neighbours["green"]
   return (greenwires ~= nil) and (#greenwires > 0)
end

function OnBuiltEntity(event)
   if not game.players[event.player_index].is_shortcut_toggled("autocircuit-shortcut") then
      return
   end
   local entity = event.created_entity
   if (not entity) or (entity.type ~= "electric-pole") then
      return
   end
   local copperbuddies = entity.neighbours["copper"]
   if not copperbuddies then
      return
   end
   local newconnects = {}
   for _, otherpole in pairs(copperbuddies) do
      if otherpole.type == "electric-pole" then
         if has_red_wire(otherpole) then
            newconnects[#newconnects + 1] = {wire = defines.wire_type.red,
                                             target_entity = otherpole}
         end
         if has_green_wire(otherpole) then
            newconnects[#newconnects + 1] = {wire = defines.wire_type.green,
                                             target_entity = otherpole}
         end
      end
   end
   for _, newconnect in pairs(newconnects) do
      entity.connect_neighbour(newconnect)
   end
end

script.on_event(defines.events.on_built_entity, OnBuiltEntity)
