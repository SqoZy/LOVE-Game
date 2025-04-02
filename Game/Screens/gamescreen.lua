local gamescreen = {}
local screen = "gamescreen"
local mouseinput = require("Input.mouseinput")
local keyinput = require("Input.keyinput")
local objectspawner = require("Spawners.objectspawner")
local enemySpawner = require("Spawners.enemyspawner")
local player = require("Objects.PassiveObjects.PlayerObject.player")
local screenmanager = require("Screens.screenmanager") -- Require the screenmanager

function gamescreen.load()
    player.load()
end

function gamescreen.update(dt)
    objectspawner.update(dt)
    enemySpawner.update(dt)
    player.update(dt)
end

function gamescreen.draw()
    objectspawner.draw()
    enemySpawner.draw()
    player.draw()

    -- Draw the selected special via the screenmanager
    screenmanager.drawSpecial()
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return gamescreen
