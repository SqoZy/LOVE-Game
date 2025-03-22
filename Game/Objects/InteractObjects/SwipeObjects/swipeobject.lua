local ClickObject = require("Objects.InteractObjects.ClickObjects.clickobject")

local clickObject

function love.load()
    clickObject = ClickObject:new(100, 100, 100, 50, function()
        print("You clicked the object!")
    end)
end

function love.update(dt)
    -- Update logic if needed
end

function love.draw()
    clickObject:draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then -- Left mouse button
        clickObject:handleClick(x, y)
    end
end