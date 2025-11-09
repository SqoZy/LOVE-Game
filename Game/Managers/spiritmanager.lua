local spiritSpawner = require("Spawners.spiritspawner")
local spiritPowerBar = require("Ui.spiritpowerbar")
local spiritManager = {}

local spawnTimer = 0 
local spawnInterval = 3

function spiritManager.load()

end

function spiritManager.update(dt)
    for i = #spiritSpawner.objects, 1, -1 do
        local spirit = spiritSpawner.objects[i]
        if spirit.isDestroyed then
            spiritManager.onSpiritDestroyed(spirit)
        end
    end

    spiritSpawner.update(dt)
    
    spawnTimer = spawnTimer + dt
    if spawnTimer >= spawnInterval then
        spiritSpawner.spawnRandomSpirit()
        spawnTimer = 0
    end
end

function spiritManager.onSpiritDestroyed(spirit)
    print("spirit destroyed:" .. spirit.spiritType)
    if spirit.spiritType == "click" then
        print("added power to clickspirit")
        spiritPowerBar.addPower(10)
    elseif spirit.spiritType == "swipe" then
        spiritPowerBar.addPower(15)
    end
end

function spiritManager.draw()
    spiritSpawner.draw()
end

return spiritManager