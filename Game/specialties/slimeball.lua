local specialmanager = require("specialties.specialmanager")

specialmanager.registerSpecial({
    name = "slimeball",
    image = love.graphics.newImage("assets/specialties/NOR_slimeball.png"),
    damage = 10,
    rechargeSpace = 20
})