local gamescreen = {}
local screen = "gamescreen"
local rectangle = require("rectangle")
local rectangle2 = require("rectangle2")
local mouseinput = require("Input.mouseinput")
local keyinput = require("Input.keyinput")

function gamescreen.load()
    rectangle.load()
    rectangle2.load()
end

function gamescreen.update(dt)
    isHovering = mouseinput.checkMouseHover(rectangle) or mouseinput.checkMouseHover(rectangle2)
    rectangle.update(dt)
    mouseinput.dragObject(rectangle2)
end

function gamescreen.draw()
    rectangle.draw(isHovering)
    love.graphics.rectangle("fill", rectangle2.x, rectangle2.y, rectangle2.width, rectangle2.height)
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return gamescreen