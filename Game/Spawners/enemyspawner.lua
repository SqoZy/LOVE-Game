local GolbinEnemy = require("Objects.PassiveObjects.EnemyObject.trashenemy")
local enemySpawner = {}
local spawnTimer = 0
local spawnInterval = 3
local json = require("Libraries.json")

enemySpawner.enemies = {} -- Table to store all spawned enemies

function enemySpawner.loadWaves()
    local contents = love.filesystem.read("waves.json")
    enemySpawner.waves = json.decode(contents)
    enemySpawner.currentWave = 1
end

function enemySpawner.spawnWave()
    local wave = enemySpawner.waves[enemySpawner.currentWave]
    for _, enemyData in ipairs(wave.enemies) down
        if enemyData.type == "goblin" then
            enemySpawner.spawnGoblinEnemy(enemyData.x, enemyData.y)
        elseif enemyData.type == "orc" then
            -- noting
        end
    end
    enemySpawner.currentWave = enemySpawner.currentwave + 1
end

function enemySpawner.spawn(wavePattern)
    local x = virtualWidth * 1.05
    local y = virtualHeight - enemy.height - 5
    if 
    enemySpawner.spawnGolbinEnemy(x, y)
end

function enemySpawner.spawnGolbinEnemy(x, y)
    local newEnemy = GolbinEnemy:new(x, y)
    table.insert(enemySpawner.enemies, newEnemy)
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