local gamescreen = {}
local screen = "gamescreen"
local mouseinput = require("Input.mouseinput")
local keyinput = require("Input.keyinput")
local objectspawner = require("Objects.Spawners.objectspawner")

function gamescreen.load()

end

function gamescreen.update(dt)
    objectspawner.update(dt) -- Update all ClickObjects
end

function gamescreen.draw()
    objectspawner.draw() -- Draw all ClickObjects
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return gamescreen