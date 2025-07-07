local specialmanager = require("Specialties.specialmanager")

specialmanager.registerSpecial({
    name = "fireball",
    image = love.graphics.newImage("assets/specialties/NOR_fireball.png"),
    damage = 10,
    rechargeSpace = 20
})
