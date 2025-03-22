local rectangle = {}
local width, height = 200, 100
local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
local spawnx, spawny = (screenWidth - width) / 2, (screenHeight - height) / 2

function rectangle.load()
    rectangle.x = spawnx
    rectangle.y = spawny
    rectangle.width = width
    rectangle.height = height
    rectangle.speed = 100
    rectangle.direction = 1
end

function rectangle.update(dt)
    rectangle.x = rectangle.x + rectangle.direction * rectangle.speed * dt
    if rectangle.x < 0 then
        rectangle.x = 0
        rectangle.direction = 1
    elseif rectangle.x + rectangle.width > love.graphics.getWidth() then
        rectangle.x = love.graphics.getWidth() - rectangle.width
        rectangle.direction = -1
    end
end

function rectangle.draw(isHovering)
    if isHovering then
        love.graphics.setColor(255, 0, 0, 255)
    else
        love.graphics.setColor(0, 0, 255, 255)
    end
    love.graphics.rectangle("fill", rectangle.x, rectangle.y, rectangle.width, rectangle.height)
end


return rectangle
