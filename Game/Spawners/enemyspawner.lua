local GolbinEnemy = require("Objects.PassiveObjects.EnemyObject.trashenemy")
local enemySpawner = {}
local spawnTimer = 0
local spawnInterval = 3

enemySpawner.enemies = {} -- Table to store all spawned enemies

function enemySpawner.spawnGolbinEnemy(x, y)
    local newEnemy = GolbinEnemy:new(x, y)
    table.insert(enemySpawner.enemies, newEnemy)
end

function enemySpawner.spawn()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local x = screenWidth * 1.05
    local y = screenHeight * 0.75
    enemySpawner.spawnGolbinEnemy(x, y)
    
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