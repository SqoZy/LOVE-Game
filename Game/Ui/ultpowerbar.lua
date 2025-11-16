local ultPowerBar = {}

function ultPowerBar.load()
    ultPowerBar.width = 20
    ultPowerBar.height = 100
    ultPowerBar.x = 30
    ultPowerBar.y = virtualHeight - ultPowerBar.height - 10
    ultPowerBar.maxPower = 100
    ultPowerBar.currentPower = 0
end

function ultPowerBar.addPower(amount)
    ultPowerBar.currentPower = math.min(ultPowerBar.currentPower + amount, ultPowerBar.maxPower)
end

function ultPowerBar.consumePower(amount)
    if ultPowerBar.currentPower >= amount then
        ultPowerBar.currentPower = ultPowerBar.currentPower - amount
        return true
    else
        return false
    end
end

function ultPowerBar.getCurrentPower()
    return ultPowerBar.currentPower
end

function ultPowerBar.draw()
    love.graphics.setColor(0.3, 0.3, 0.3) 
    love.graphics.rectangle("fill", ultPowerBar.x, ultPowerBar.y, ultPowerBar.width, ultPowerBar.height)

    local powerRatio = ultPowerBar.currentPower / ultPowerBar.maxPower
    local fillHeight = ultPowerBar.height * powerRatio
    local fillY = ultPowerBar.y + ultPowerBar.height - fillHeight

    love.graphics.setColor(1, 1, 0) 
    love.graphics.rectangle("fill", ultPowerBar.x, fillY, ultPowerBar.width, fillHeight)

    love.graphics.setColor(1, 1, 1)
end

return ultPowerBar