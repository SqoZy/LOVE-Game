local mouseinput = {}
local dragging = false
local swipeStartX, swipeStartY = nil, nil
local minimumSwipe = 10

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
        local x, y = love.mouse.getPosition()

        if not object.dragging and mouseinput.checkMouseHover(object) then
            object.dragging = true -- Set dragging for this specific object
            offsetX = x - object.x
            offsetY = y - object.y
            swipeStartX = x
            swipeStartY = y
        end

        if object.dragging then
            object.x = x - offsetX
            object.y = y - offsetY

            -- Detect swipe direction during dragging
            local deltaX = x - swipeStartX
            local deltaY = y - swipeStartY

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
                    swipeStartX = x 
                    swipeStartY = y
                end
            end
        end
    else
        object.dragging = false -- Reset dragging for this specific object
        swipeStartX = nil
        swipeStartY = nil
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
