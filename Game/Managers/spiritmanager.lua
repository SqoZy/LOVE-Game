local spiritSpawner = require("Spawners.spiritspawner")
local spiritManager = {}

local spawnTimer = 0 
local spawnInterval = 3

function spiritManager.load()

end

function spiritManager.update(dt)
    spiritSpawner.update(dt)
    
    spawnTimer = spawnTimer + dt
    if spawnTimer >= spawnInterval then
        spiritSpawner.spawnRandomSpirit()
        spawnTimer = 0
    end
end

function spiritManager.draw()
    spiritSpawner.draw()
end

function spiritManager.destroyclickSpirit(object)
    spiritSpawner.destroyclickSpirit(object)
end

return spiritManager

