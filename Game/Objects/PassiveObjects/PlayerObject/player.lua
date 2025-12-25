local player = {}
local anim8 = require("Libraries.anim8")
local enemySpawner = require("Spawners.enemyspawner")
local playerbullet = require("Objects.PassiveObjects.PlayerObject.playerbullet")
local time = love.timer.getTime()

function player.load()
    player.width = 109
    player.height = 128
    player.x = 50
    player.y = virtualHeight - player.height - 5

    player.spritesheet = love.graphics.newImage("assets/player/wizard_spritesheet.png")
    player.grid = anim8.newGrid(player.width, player.height, player.spritesheet:getWidth(), player.spritesheet:getHeight())

    player.animation = {}
    player.animation.idle = anim8.newAnimation(player.grid('1-5', 1), 0.1)
    player.animation.attack = anim8.newAnimation(player.grid('1-7', 2), 0.1, player.backToIdle)
    player.animation.shield = anim8.newAnimation(player.grid('1-7', 3), 0.1, player.backToIdle)
    player.animation.ult = anim8.newAnimation(player.grid('1-13', 4), 0.1, player.backToIdle)

    player.currentAnimation = player.animation.idle
end

function player.backToIdle()
    player.currentAnimation = player.animation.idle
end

function player.update(dt)
    player.currentAnimation:update(dt)
end

function player.draw()
    love.graphics.setColor(1, 1, 1)
    player.currentAnimation:draw(player.spritesheet, player.x, player.y)

    -- if DEBUG_HITBOXES then
    --     love.graphics.setColor(0, 1, 0, 0.5)
    --     love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    -- end
end

function player.attack()
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
        player.currentAnimation = player.animation.attack
        player.animation.attack:gotoFrame(1)
        playerbullet.spawn(player, closestEnemy)
        print("Attacked enemy at:", closestEnemy.x, closestEnemy.y)
    end
end

function player.useUltimate()
    print("Ultimate ability activated!")
    player.currentAnimation = player.animation.ult
    player.animation.ult:gotoFrame(1)
    if time % 5 == 0 then
        print("Ultimate sound played!")
    end
    for _, enemy in ipairs(enemySpawner.enemies) do
        enemy:takeDamage(100)
    end
end

return player
