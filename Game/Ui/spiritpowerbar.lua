local spiritPowerBar = {}
local screenWidth, screenHeight = love.graphics.getDimensions()


function spiritPowerBar.load()
    spiritPowerBar.x = screenWidth - 220
    spiritPowerBar.y = screenHeight - 60
    spiritPowerBar.width = 200
    spiritPowerBar.height = 30
    spiritPowerBar.maxPower = 100
    spiritPowerBar.currentPower = 0
end

function spiritPowerBar.update(dt)

end

function spiritPowerBar.addPower(amount)
    spiritPowerBar.currentPower = math.min(spiritPowerBar.currentPower + amount, spiritPowerBar.maxPower)
end

function spiritPowerBar.consumePower(amount)
    if spiritPowerBar.currentPower >= amount then
        spiritPowerBar.currentPower = spiritPowerBar.currentPower - amount
        return true
    else
        return false
    end
end

function spiritPowerBar.draw()
    love.graphics.setColor(0.2, 0.2, 0.2) 
    love.graphics.rectangle("fill", spiritPowerBar.x, spiritPowerBar.y, spiritPowerBar.width, spiritPowerBar.height)

    local powerRatio = spiritPowerBar.currentPower / spiritPowerBar.maxPower
    love.graphics.setColor(0.4, 0.6, 1) 
    love.graphics.rectangle("fill", spiritPowerBar.x, spiritPowerBar.y, spiritPowerBar.width * powerRatio, spiritPowerBar.height)

    love.graphics.setColor(1, 1, 1) 
    love.graphics.rectangle("line", spiritPowerBar.x, spiritPowerBar.y, spiritPowerBar.width, spiritPowerBar.height)
end

return spiritPowerBar