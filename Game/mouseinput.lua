local mouseinput = {}
local dragging = false

function mouseinput.checkMouseHover(object)
    local x, y = love.mouse.getPosition()
    if x > object.x and x < object.x + object.width and y > object.y and y < object.y + object.height then
        return true
    else
        return false
    end
end

function mouseinput.dragObject(object)
    if love.mouse.isDown(1) then
        if not dragging and mouseinput.checkMouseHover(object) then
            dragging = true
        end
        if dragging then
            local x, y = love.mouse.getPosition()
            object.x = x - object.width / 2
            object.y = y - object.height / 2
        end
    else
        dragging = false
    end
end

return mouseinput
