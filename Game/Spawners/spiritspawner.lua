local clickSpirit = require("Objects.InteractObjects.ClickSpirit.clickspirit")
local swipeSpirit = require("Objects.InteractObjects.SwipeSpirits.swipespirit")
local spiritSpawner = {}

spiritSpawner.objects = {}

function spiritSpawner.clickSpiritSpawn(x, y, radius, growDuration)
    local newObject = clickSpirit:new(x, y, radius)
    newObject:_spawn(growDuration) 
    table.insert(spiritSpawner.objects, newObject) 
end

function spiritSpawner.swipeSpiritSpawn(x, y, radius, growDuration, direction)
    local newObject = swipeSpirit:initialize(x, y, radius, direction)
    newObject:_spawn(growDuration) 
    table.insert(spiritSpawner.objects, newObject) 
end

function spiritSpawner.spawnSpirits(spiritType, x, y, radius, growDuration)
    if spiritType == "click" then
        spiritSpawner.clickSpiritSpawn(x, y, radius, growDuration)
    elseif spiritType == "swipe" then
        local direction = math.random(1, 4) == 1 and "up" 
        or math.random(1, 4) == 2 and "down" 
        or math.random(1, 4) == 3 and "left" 
        or "right"
        spiritSpawner.swipeSpiritSpawn(x, y, radius, growDuration, direction)
        print("Spawned SwipeObject with direction: " .. direction)
    end
end

function spiritSpawner.generateRandomProperties()
    local radius = math.random(10, 50) 
    local growDuration = math.random(2, 5) 
    return radius, growDuration
end

function spiritSpawner.spawnRandomSpirit()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local radius, growDuration = spiritSpawner.generateRandomProperties()
    local maxY = screenHeight * 0.75
    local x = math.random(radius, screenWidth - radius)
    local y = math.random(radius, maxY - radius)
    local spiritType = math.random(1, 2) == 1 and "click" or "swipe"
    spiritSpawner.spawnSpirits(spiritType, x, y, radius, growDuration)
end

function spiritSpawner.update(dt)
    for i = #spiritSpawner.objects, 1, -1 do
        local obj = spiritSpawner.objects[i]
        if obj.isDestroyed then
            table.remove(spiritSpawner.objects, i) 
        else
            obj:update(dt)
        end
    end
end

function spiritSpawner.draw()
    for _, obj in ipairs(spiritSpawner.objects) do
        obj:draw()
    end
end

return spiritSpawner