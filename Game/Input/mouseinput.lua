local mouseinput = {}
local dragging = false

function mouseinput.checkMouseHover(object)
    local x, y = love.mouse.getPosition()
    if object.radius then
        -- Handle circular objects
        local dx = x - object.x
        local dy = y - object.y
        return (dx * dx + dy * dy) <= (object.radius * object.radius)
    elseif object.width and object.height then
        -- Handle rectangular objects
        return x > object.x and x < object.x + object.width and y > object.y and y < object.y + object.height
    else
        error("Object must have either 'radius' or 'width' and 'height'")
    end
end

function mouseinput.dragObject(object)
    if love.mouse.isDown(1) then
        if not dragging and mouseinput.checkMouseHover(object) then
            dragging = true
            local x, y = love.mouse.getPosition()
            offsetX = x - object.x
            offsetY = y - object.y
        end
        if dragging then
            local x, y = love.mouse.getPosition()
            object.x = x - offsetX
            object.y = y - offsetY
        end
    else
        dragging = false
    end
end

function mouseinput.destroyClickObject(object)
    if love.mouse.isDown(1) then
        if mouseinput.checkMouseHover(object) then
            object:_destroy()
        end
    end
end

return mouseinput
