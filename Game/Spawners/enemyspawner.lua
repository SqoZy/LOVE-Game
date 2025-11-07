local golbinEnemy = require("Objects.PassiveObjects.EnemyObject.goblinenemy")
local eyeBallEnemy = require("Objects.PassiveObjects.EnemyObject.eyeballenemy")
local toothEnemy = require("Objects.PassiveObjects.EnemyObject.toothenemy")
local trashEnemy = require("Objects.PassiveObjects.EnemyObject.trashenemy")
local enemySpawner = {}
local spawnTimer = 0
local spawnInterval = 3
local json = require("Libraries.json")

enemySpawner.enemies = {}
enemySpawner.spawnQueue = {} 

local enemyClasses = {
    goblin = golbinEnemy,
    eyeball = eyeBallEnemy,
    tooth = toothEnemy,
    trash = trashEnemy
}

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
    local enemyClass = enemyClasses[enemyType]
    if not enemyClass then
        print("Unknown enemy type: " .. enemyType) 
        return
    end

    local newEnemy = enemyClass:new(virtualWidth , virtualHeight)
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