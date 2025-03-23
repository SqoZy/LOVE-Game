local player = {}
local screenWidth, screenHeight = love.graphics.getDimensions()
anim8 = require("Libraries.anim8")

function player.load()
    player.spritesheet = love.graphics.newImage("assets/player/wizard_spritesheet.png")
    player.grid = anim8.newGrid(109, 128, player.spritesheet:getWidth(), player.spritesheet:getHeight())

    player.animation = {}
    player.animation.idle = anim8.newAnimation(player.grid('1-5', 1), 0.1)
    player.animation.attack = anim8.newAnimation(player.grid('1-7', 2), 0.1)
    player.animation.shield = anim8.newAnimation(player.grid('1-7', 3), 0.1)
    player.animation.special = anim8.newAnimation(player.grid('1-13', 4), 0.1)

    player.width = 109
    player.height = 128
    player.x = (screenWidth - player.width) / 8 
    player.y = screenHeight - player.height - 30
end

function player.update(dt)
    player.animation.idle:update(dt)
end

function player.draw()
    love.graphics.setColor(1, 1, 1)
    player.animation.idle:draw(player.spritesheet, player.x, player.y)
end

return player
