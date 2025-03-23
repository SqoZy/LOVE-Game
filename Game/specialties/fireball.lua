local specialmanager = require("specialties.specialmanager")
local name = "Fireball"
local damage = 10
local cooldown = 1
local speed = 100

funtion specialmanager.reqvarspecial(name, damage, cooldown, speed)
    activename = name
    activedamage = damage
    activecooldown = cooldown
    activespeed = speed
end

return specialmanager.reqvarspecial(name, damage, cooldown, speed)
