function blacklist_inserters(event)
    for _, surface in pairs(game.surfaces) do
        for _, inserter in pairs(surface.find_entities_filtered{type='inserter'}) do
            if not string.match(inserter.name, "filter") then
                inserter.inserter_filter_mode = 'blacklist'
            end
        end
    end
end

function migrate_filter_inserters(event)
    conversions = {}
    conversions['filter-inserter'] = 'fast-inserter'
    conversions['stack-filter-inserter'] = 'stack-inserter'
    if script.active_mods.Krastorio2 then
        conversions['kr-superior-filter-inserter'] = 'kr-superior-inserter'
        conversions['kr-superior-long-filter-inserter'] = 'kr-superior-long-inserter'
    end

    names = {}
    for k,_ in pairs(conversions) do
        names[#names+1] = k
    end

    local i = 0
    for _, surface in pairs(game.surfaces) do
        for _, inserter in pairs(surface.find_entities_filtered{type='inserter', name=names}) do
            local inserter_mode = inserter.inserter_filter_mode
            local replacement = surface.create_entity{
                name = conversions[inserter.name],
                position = inserter.position,
                direction = inserter.direction,
                force = inserter.force,
                raise_built = true,
                create_build_effect_smoke = false
            }
            if replacement.valid then
                for _, wire in pairs(inserter.circuit_connection_definitions) do
                    replacement.connect_neighbour(wire)
                end
                replacement.copy_settings(inserter)
                replacement.inserter_filter_mode = inserter_mode
                inserter.destroy()
                i = i + 1
            else
                game.print('Failed to migrate inserter at '..serpent.line(inserter.position))
            end
        end
    end
    game.print('Migrated '..i..' filter inserters.')
end

function full_migration(event)
    blacklist_inserters(event)
    migrate_filter_inserters(event)
end

commands.add_command("fib", "Replace placed filter inserters with normal ones", migrate_filter_inserters)
commands.add_command("fib-full", "Set all existing non-filter inserters to blacklist then replace filter inserters", full_migration)
