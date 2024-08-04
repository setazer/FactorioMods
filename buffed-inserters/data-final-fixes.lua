for _, inserter_type in pairs(data.raw.inserter) do
    ext_speed = inserter_type.extension_speed
    if ext_speed then
        if inserter_type.name == "burner-inserter" then
            speedup = 4
        else
            speedup = 2
        end
        inserter_type.extension_speed = ext_speed * speedup
    end
end
