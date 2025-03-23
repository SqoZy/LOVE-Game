local SlimeEnemy = require("Objects.PassiveObjects.EnemyObject.slimeenemy")
local enemySpawner = {}
local spawnTimer = 0
local spawnInterval = 3

enemySpawner.enemies = {} -- Table to store all spawned enemies

function enemySpawner.spawnSlimeEnemy(x, y)
    local newEnemy = SlimeEnemy:new(x, y)
    table.insert(enemySpawner.enemies, newEnemy)
end

function enemySpawner.spawn()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local x = screenWidth + 30
    local y = screenHeight - 150
    enemySpawner.spawnSlimeEnemy(x, y)
end

function enemySpawner.update(dt)
    for i = #enemySpawner.enemies, 1, -1 do
        local enemy = enemySpawner.enemies[i]
        if enemy.isDestroyed then
            table.remove(enemySpawner.enemies, i)
        else
            enemy:update(dt)
        end
    end

    spawnTimer = spawnTimer + dt
    if spawnTimer >= spawnInterval then
        enemySpawner.spawn()
        spawnTimer = 0
    end
end

function enemySpawner.draw()
    for _, enemy in ipairs(enemySpawner.enemies) do
        enemy:draw()
    end
end

return enemySpawner