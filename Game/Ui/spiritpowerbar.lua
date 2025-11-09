local spiritPowerBar = {}

function spiritPowerBar.load()
    spiritPowerBar.width = 20
    spiritPowerBar.height = 100
    spiritPowerBar.x = 5
    spiritPowerBar.y = virtualHeight - spiritPowerBar.height - 10
    spiritPowerBar.maxPower = 100
    spiritPowerBar.currentPower = 50
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

function spiritPowerBar.getCurrentPower()
    return spiritPowerBar.currentPower
end

function spiritPowerBar.draw()
    love.graphics.setColor(0, 0, 1) 
    love.graphics.rectangle("fill", spiritPowerBar.x, spiritPowerBar.y, spiritPowerBar.width, spiritPowerBar.height)

    local powerRatio = spiritPowerBar.currentPower / spiritPowerBar.maxPower
    local fillHeight = spiritPowerBar.height * powerRatio
    local fillY = spiritPowerBar.y + spiritPowerBar.height - fillHeight
    
    love.graphics.setColor(0.4, 0.6, 1) 
    love.graphics.rectangle("fill", spiritPowerBar.x, fillY, spiritPowerBar.width, fillHeight)

    love.graphics.setColor(1, 1, 1) 
    love.graphics.rectangle("line", spiritPowerBar.x, spiritPowerBar.y, spiritPowerBar.width, spiritPowerBar.height)
end

return spiritPowerBar