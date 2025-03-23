local specialmanager = require("specialties.specialmanager")

specialmanager.registerSpecial({
    name = "iceball",
    image = love.graphics.newImage("assets/specialties/NOR_iceball.png"),
    damage = 10,
    rechargeSpace = 20
})