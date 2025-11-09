local mouseinput = {}
local dragging = false
local swipeStartX, swipeStartY = nil, nil
local minimumSwipe = 10

function mouseinput.update(dt)

end

function mouseinput.checkMouseHover(object)
    local virtualMX, virtualMY = mouseinput.getVirtualMousePosition()
    if object.radius then
        local dx = virtualMX - object.x
        local dy = virtualMY - object.y
        return (dx * dx + dy * dy) <= (object.radius * object.radius)
    elseif object.width and object.height then
        return virtualMX > object.x and virtualMX < object.x + object.width and virtualMY > object.y and virtualMY < object.y + object.height
    else
        error("Object must have either 'radius' or 'width' and 'height'")
    end
end

function mouseinput.dragObject(object)
    local virtualMX, virtualMY = mouseinput.getVirtualMousePosition()
    if love.mouse.isDown(1) then
        if not object.dragging and mouseinput.checkMouseHover(object) then
            object.dragging = true
            offsetX = virtualMX - object.x
            offsetY = virtualMY - object.y
            swipeStartX = virtualMX
            swipeStartY = virtualMY
        end

        if object.dragging then
            object.x = virtualMX - offsetX
            object.y = virtualMY - offsetY

            local deltaX = virtualMX - swipeStartX
            local deltaY = virtualMY - swipeStartY

            if math.abs(deltaX) > minimumSwipe or math.abs(deltaY) > minimumSwipe then
                local direction = nil
                if math.abs(deltaX) > math.abs(deltaY) then
                    if deltaX > 0 then
                        direction = "right"
                    else
                        direction = "left"
                    end
                else
                    if deltaY > 0 then
                        direction = "down"
                    else
                        direction = "up"
                    end
                end

                if direction then
                    object:onSwipe(direction) 
                    swipeStartX = virtualMX
                    swipeStartY = virtualMY
                end
            end
        end
    else
        object.dragging = false
        swipeStartX = nil
        swipeStartY = nil
    end
end

function mouseinput.getVirtualMousePosition()
    local mx, my = love.mouse.getPosition()
    local virtualMX = mx * (virtualWidth / windowWidth)
    local virtualMY = my * (virtualHeight / windowHeight)
    return virtualMX, virtualMY
end

return mouseinput
