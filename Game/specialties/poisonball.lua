local specialmanager = require("specialties.specialmanager")

specialmanager.registerSpecial({
    name = "poisonball",
    image = love.graphics.newImage("assets/specialties/NOR_poisonball.png"),
    damage = 7,
    rechargeSpace = 20
})