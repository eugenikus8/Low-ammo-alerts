local CHECK_INTERVAL = 600  -- Check interval (ticks)

-- Ammo level check function
local function check_ammo(entity, ammo_threshold)
    if entity and entity.valid then
        local inventory_type_map = {
            ["ammo-turret"] = defines.inventory.turret_ammo,
            ["artillery-turret"] = defines.inventory.artillery_turret_ammo,
            ["artillery-wagon"] = defines.inventory.artillery_wagon_ammo,
            ["car"] = defines.inventory.car_ammo,
            ["spider-vehicle"] = defines.inventory.spider_ammo
        }
        local inventory_type = inventory_type_map[entity.type]

        if inventory_type then
            local inventory = entity.get_inventory(inventory_type)
            if inventory and #inventory > 0 then
                local total_ammo = 0
                for i = 1, #inventory do
                    total_ammo = total_ammo + inventory[i].count
                end
                if total_ammo == 0 then return "NO_AMMO" end
                if total_ammo < ammo_threshold then return "LOW_AMMO" end
            end
        end
    end
    return nil
end

-- Event handler for ammo level check
local function on_tick(event)
    if event.tick % CHECK_INTERVAL ~= 0 then return end

    for _, player in pairs(game.connected_players) do
        local ammo_threshold = player.mod_settings["turret_alerts_low_ammo_threshold"].value
        local alerts_current_surface_only = player.mod_settings["turret_alerts_current_surface_only"].value
        local alerts = {NO_AMMO = {}, LOW_AMMO = {}}

        for _, surface in pairs(game.surfaces) do
            if alerts_current_surface_only and surface ~= player.surface then goto continue end

            for _, data in ipairs({
                {setting = "turret_alerts_turret_enabled", type = "ammo-turret"},
                {setting = "turret_alerts_artillery_turret_alerts_enabled", type = "artillery-turret"},
                {setting = "turret_alerts_artillery_wagon_enabled", type = "artillery-wagon"},
                {setting = "turret_alerts_car_enabled", type = "car", name = "car"},
                {setting = "turret_alerts_tank_enabled", type = "car", name = "tank"},
                {setting = "turret_alerts_spidertron_enabled", type = "spider-vehicle"}
            }) do
                if player.mod_settings[data.setting].value then
                    for _, entity in pairs(surface.find_entities_filtered{type = data.type, name = data.name}) do
                        local status = check_ammo(entity, ammo_threshold)
                        if status then
                            table.insert(alerts[status], {
                                entity = entity,
                                icon = {type = "virtual", name = status == "NO_AMMO" and "no_ammo_signal" or "low_ammo_signal"},
                                message = status == "NO_AMMO" and {"alerts.empty", entity.localised_name} or {"alerts.low", entity.localised_name}
                            })
                        end
                    end
                end
            end
            ::continue::
        end

        -- Display alerts for the player with formatted messages
        for status, alerts_list in pairs(alerts) do
            for _, alert in pairs(alerts_list) do
                player.add_custom_alert(alert.entity, alert.icon, {"", alert.entity.localised_name, " ", alert.message}, true)
            end
        end
    end
end

script.on_event(defines.events.on_tick, on_tick)
