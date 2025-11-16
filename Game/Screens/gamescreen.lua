local gamescreen = {}
local screen = "gamescreen"
local mouseinput = require("Input.mouseinput")
local keyinput = require("Input.keyinput")
local spiritManager = require("Managers.spiritmanager")
local enemySpawner = require("Spawners.enemyspawner")
local player = require("Objects.PassiveObjects.PlayerObject.player")
local screenmanager = require("Screens.screenmanager")
local spiritPowerBar = require("Ui.spiritpowerbar")
local ultPowerBar = require("Ui.ultpowerbar")

function gamescreen.load()
    player.load()
    spiritManager.load()
    enemySpawner.load()
    spiritPowerBar.load()
    ultPowerBar.load()
end

function gamescreen.update(dt)
    spiritManager.update(dt)
    enemySpawner.update(dt)
    player.update(dt)
end

function gamescreen.draw()
    spiritManager.draw()
    enemySpawner.draw()
    player.draw()
    screenmanager.drawSpecial()
    spiritPowerBar.draw()
    ultPowerBar.draw()
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return gamescreen
