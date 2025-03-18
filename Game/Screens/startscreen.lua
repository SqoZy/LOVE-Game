local startscreen = {}
local screen = "startscreen"

function startscreen.load()
    local width, height = love.graphics.getDimensions()
    startscreen.button = {x = width/2 - 100, y = height/2 - 50, width = 200, height = 100}
end

function startscreen.update()
    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()
        if x > startscreen.button.x and x < startscreen.button.x + startscreen.button.width and y > startscreen.button.y and y < startscreen.button.y + startscreen.button.height then
            screen = "gamescreen"
        end
    end
end

function startscreen.draw()
    love.graphics.rectangle("line", startscreen.button.x, startscreen.button.y, startscreen.button.width, startscreen.button.height)
    love.graphics.print("Start", startscreen.button.x + 50, startscreen.button.y + 40)
end

return startscreen