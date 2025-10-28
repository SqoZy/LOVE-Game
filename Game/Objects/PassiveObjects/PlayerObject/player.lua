local player = {}
local screenWidth, screenHeight = love.graphics.getDimensions()
local anim8 = require("Libraries.anim8")
local enemySpawner = require("Spawners.enemyspawner")

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
    local screenWidth, screenHeight = love.graphics.getDimensions()
    player.x = screenWidth * 0.10
    player.y = screenHeight * 0.60
end

function player.update(dt)
    player.animation.idle:update(dt)
end

function player.draw()
    love.graphics.setColor(1, 1, 1)
    player.animation.idle:draw(player.spritesheet, player.x, player.y)
end

function attack()
    local closestEnemy = nil
    local closestDist = math.huge
    local pxcenter, pycenter = player.x + player.width / 2, player.y + player.height / 2

    for _, enemy in ipairs(enemySpawner.enemies) do
        local ex, ey = enemy.x, enemy.y
        local dist = math.sqrt((pxcenter - ex)^2 + (pycenter - ey)^2)
        if dist < closestDist then
            closestDist = dist
            closestEnemy = enemy
        end
    end

    if closestEnemy then
        closestEnemy:takeDamage(10) -- Or use your special's damage value
        print("Attacked enemy at:", closestEnemy.x, closestEnemy.y)
    end
end

return player
