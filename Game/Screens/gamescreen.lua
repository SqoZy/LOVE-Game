local gamescreen = {}
local screen = "gamescreen"
local mouseinput = require("Input.mouseinput")
local keyinput = require("Input.keyinput")
local objectspawner = require("Objects.Spawners.objectspawner")
local SwipeObject = require("Objects.InteractObjects.SwipeObjects.swipeobject")
local player = require("Objects.PassiveObjects.PlayerObject.player")
local enemy = require("Objects.PassiveObjects.EnemyObject.enemy")
local slimeenemy = require("Objects.PassiveObjects.EnemyObject.slimeenemy")

function gamescreen.load()
    player.load() 
    local enemy = slimeenemy.new(100, 100)
    table.insert(enemies, enemy)
end

function gamescreen.update(dt)
    objectspawner.update(dt) 
        -- Update all enemies
        for _, enemy in ipairs(enemies) do
            enemy:update(dt)
        end
end

function gamescreen.draw()
    objectspawner.draw()
    player.draw() 
    for _, enemy in ipairs(enemies) do
        enemy:draw()
    end
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return gamescreen