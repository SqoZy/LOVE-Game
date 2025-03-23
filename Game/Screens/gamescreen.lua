local gamescreen = {}
local screen = "gamescreen"
local mouseinput = require("Input.mouseinput")
local keyinput = require("Input.keyinput")
local objectspawner = require("Spawners.objectspawner")
local enemySpawner = require("Spawners.enemyspawner")
local player = require("Objects.PassiveObjects.PlayerObject.player")
local specialmanager = require("Specialties.specialmanager")

function gamescreen.load()
    player.load()
    specialmanager.load()

    specialmanager.reqvarspecial("Fireball", 10, 1, 100)
    specialmanager.reqvarultimate("Acidrain", 20, 5, 50)
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
    specialmanager.draw()
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return gamescreen
