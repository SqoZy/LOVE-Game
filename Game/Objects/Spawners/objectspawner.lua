local ClickObject = require("Objects.InteractObjects.ClickObjects.clickobject")
local SwipeObject = require("Objects.InteractObjects.SwipeObjects.swipeobject")
local objectspawner = {}
local spawnTimer = 0 
local spawnInterval = 3

objectspawner.objects = {} -- Table to store all spawned objects

-- Function to spawn a new ClickObject
function objectspawner.clickObjectSpawn(x, y, radius, growDuration)
    local newObject = ClickObject:new(x, y, radius)
    newObject:_spawn(growDuration) -- Start the grow timer
    table.insert(objectspawner.objects, newObject) -- Add the new object to the list
end

function objectspawner.swipeObjectSpawn(x, y, radius, growDuration)
    local newObject = SwipeObject:new(x, y, radius)
    newObject:_spawn(growDuration) -- Start the grow timer
    table.insert(objectspawner.objects, newObject) -- Add the new object to the list
end

-- Function to spawn a ClickObject at a random position
function objectspawner.spawnRandom(radius, growDuration)
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local maxY = screenHeight * 0.75
    local x = math.random(radius, screenWidth - radius)
    local y = math.random(radius, maxY - radius)

    if math.random(1, 2) == 1 then
        objectspawner.clickObjectSpawn(x, y, radius, growDuration)
    else
        print("Spawning object at:", x, y, "with radius:", radius)
        objectspawner.swipeObjectSpawn(x, y, radius, growDuration)
    end
end

-- Function to generate random properties for a ClickObject
function objectspawner.generateRandomProperties()
    local radius = math.random(10, 50) -- Random radius between 10 and 50
    local growDuration = math.random(2, 5) -- Random grow duration between 2 and 5 seconds
    return radius, growDuration
end

-- Function to update all ClickObjects
function objectspawner.update(dt)
    for i = #objectspawner.objects, 1, -1 do
        local obj = objectspawner.objects[i]
        if obj.isDestroyed then
            table.remove(objectspawner.objects, i) -- Remove destroyed objects
        else
            obj:update(dt) -- Update active objects
        end
    end

    -- Increment the spawn timer and spawn new objects at intervals
    spawnTimer = spawnTimer + dt
    if spawnTimer >= spawnInterval then
        local radius, growDuration = objectspawner.generateRandomProperties() -- Get random properties
        objectspawner.spawnRandom(radius, growDuration)
        spawnTimer = 0
    end
end

-- Function to draw all ClickObjects
function objectspawner.draw()
    for _, obj in ipairs(objectspawner.objects) do
        obj:draw()
    end
end

return objectspawner