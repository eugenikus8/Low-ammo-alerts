data:extend({
    {
        type = "bool-setting",
        name = "turret_alerts_turret_enabled",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "turret_alerts_artillery_turret_alerts_enabled",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "b"
    },
    {
        type = "bool-setting",
        name = "turret_alerts_artillery_wagon_enabled",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "c"
    },
    {
        type = "bool-setting",
        name = "turret_alerts_car_enabled",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "d"
    },
    {
        type = "bool-setting",
        name = "turret_alerts_tank_enabled",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "e"
    },
    {
        type = "bool-setting",
        name = "turret_alerts_spidertron_enabled",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "f"
    },
    {
        type = "bool-setting",
        name = "turret_alerts_current_surface_only",
        setting_type = "runtime-per-user",
        default_value = true,
        allowed_values = {false, true},
        order = "g"
    },
    {
        type = "bool-setting",
        name = "turret_alerts_all_surfaces",
        setting_type = "runtime-per-user",
        default_value = false,
        allowed_values = {false, true},
        order = "h"
    },
    {
        type = "int-setting",
        name = "turret_alerts_low_ammo_threshold",
        setting_type = "runtime-per-user",
        default_value = 8,
        minimum_value = 1,
        order = "i"
    }
})
