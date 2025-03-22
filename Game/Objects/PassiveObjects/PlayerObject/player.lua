local player = {}
local screenWidth, screenHeight = love.graphics.getDimensions()

function player.load()
    player.image = love.graphics.newImage("assets/player/wizard.png") -- Load the wizard image
    player.width = player.image:getWidth()
    player.height = player.image:getHeight()
    player.x = (screenWidth - player.width) / 8 -- Center horizontally
    player.y = screenHeight - player.height - 30 -- Position at the bottom with a 10px margin
end

function player.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(player.image, player.x, player.y)
end

return player
