local spiritPowerBar = {}

function spiritPowerBar.load()
    spiritPowerBar.width = 20
    spiritPowerBar.height = 100
    spiritPowerBar.x = 5
    spiritPowerBar.y = virtualHeight - spiritPowerBar.height - 10
    spiritPowerBar.maxPower = 100
    spiritPowerBar.currentPower = 0
    spiritPowerBar.spiritContributions = {}
    spiritPowerBar.dominantSpirit = nil
end

function spiritPowerBar.setDominantSpirit()
    local maxType, maxValue = nil, -math.huge
    for spiritType, value in pairs(spiritPowerBar.spiritContributions) do
        if value > maxValue then
            maxType = spiritType
            maxValue = value
        end
    end
    spiritPowerBar.dominantSpirit = maxType
end

function spiritPowerBar.addPower(amount, source)
    spiritPowerBar.currentPower = math.min(spiritPowerBar.currentPower + amount, spiritPowerBar.maxPower)
    spiritPowerBar.sourcePercentage = amount / spiritPowerBar.maxPower

    spiritPowerBar.spiritContributions[source] = (spiritPowerBar.spiritContributions[source] or 0) + amount
    spiritPowerBar.setDominantSpirit()
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

    love.graphics.setColor(0.5, 0.5, 0.5) 
    love.graphics.rectangle("fill", spiritPowerBar.x, spiritPowerBar.y, spiritPowerBar.width, spiritPowerBar.height)

    local powerRatio = spiritPowerBar.currentPower / spiritPowerBar.maxPower
    local fillHeight = spiritPowerBar.height * powerRatio
    local fillY = spiritPowerBar.y + spiritPowerBar.height - fillHeight

    if spiritPowerBar.dominantSpirit == "click" then
        love.graphics.setColor(1, 0, 0) 
    elseif spiritPowerBar.dominantSpirit == "swipe" then
        love.graphics.setColor(0, 0, 1) 
    else
        love.graphics.setColor(0.4, 0.6, 1)
    end
    love.graphics.rectangle("fill", spiritPowerBar.x, fillY, spiritPowerBar.width, fillHeight)

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", spiritPowerBar.x, spiritPowerBar.y, spiritPowerBar.width, spiritPowerBar.height)
end

return spiritPowerBar