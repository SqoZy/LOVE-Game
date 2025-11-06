local GolbinEnemy = require("Objects.PassiveObjects.EnemyObject.trashenemy")
local eyeBallEnemy = require("Objects.PassiveObjects.EnemyObject.eyeballenemy")
local enemySpawner = {}
local spawnTimer = 0
local spawnInterval = 3
local json = require("Libraries.json")

enemySpawner.enemies = {}
enemySpawner.spawnQueue = {} 

function enemySpawner.load()
    local contents = love.filesystem.read("Spawners/waves.json")
    enemySpawner.waves = json.decode(contents)
    enemySpawner.currentWave = 1
    enemySpawner.loadNextWave()
end

function enemySpawner.loadNextWave()
    if enemySpawner.currentWave > #enemySpawner.waves then
        print("all waves completed")
        return
    end

    local wave = enemySpawner.waves[enemySpawner.currentWave]
    for _, enemyData in ipairs(wave.enemies) do
        table.insert(enemySpawner.spawnQueue, enemyData.type)
    end
    enemySpawner.currentWave = enemySpawner.currentWave + 1
end

function enemySpawner.spawnEnemy(enemyType)
    if enemyType == "goblin" then
        enemySpawner.spawnGolbinEnemy()
    elseif enemyType == "eyeball" then
        enemySpawner.spawnEyeBallEnemy()
    end
end

function enemySpawner.spawnGolbinEnemy()
    local x, y = virtualWidth + 400, virtualHeight - 40
    local newEnemy = GolbinEnemy:new(x, y)
    table.insert(enemySpawner.enemies, newEnemy)
end

function enemySpawner.spawnEyeBallEnemy()
    local x, y = virtualWidth + 400, virtualHeight - 40
    local newEnemy = eyeBallEnemy:new(x, y)
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
        if #enemySpawner.spawnQueue > 0 then
            local enemyType = table.remove(enemySpawner.spawnQueue, 1)
            enemySpawner.spawnEnemy(enemyType)
            spawnTimer = 0
        else
            enemySpawner.loadNextWave()
            spawnTimer = 0
        end
    end
end

function enemySpawner.draw()
    for _, enemy in ipairs(enemySpawner.enemies) do
        enemy:draw()
    end
end

return enemySpawner