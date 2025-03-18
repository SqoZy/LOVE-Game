local gamescreen = {}
local screen = "gamescreen"
local rectangle = require("rectangle")
local rectangle2 = require("rectangle2")
local mouseinput = require("mouseinput")

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

return gamescreen