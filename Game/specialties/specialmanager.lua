local specialmanager = {}

specialmanager.specials = {} -- Table to store all registered specialties
specialmanager.ultimates = {} -- Table to store all registered ultimates

local activeSpecial = nil
local activeUltimate = nil

function specialmanager.load()
    -- Load all specialties and ultimates
    require("specialties.slimeball")
    require("specialties.fireball")
    require("specialties.iceball")
    require("specialties.poisonball")
    require("specialties.meteorrain")
    require("specialties.acidrain")

    -- Debug: Print loaded specialties and ultimates
    for _, special in ipairs(specialmanager.specials) do
        print("Loaded Special:", special.name, special.image)
    end
    for _, ultimate in ipairs(specialmanager.ultimates) do
        print("Loaded Ultimate:", ultimate.name, ultimate.image)
    end
end

function specialmanager.registerSpecial(special)
    table.insert(specialmanager.specials, special)
end

function specialmanager.registerUltimate(ultimate)
    table.insert(specialmanager.ultimates, ultimate)
end

function specialmanager.setActiveSpecial(name)
    for _, special in ipairs(specialmanager.specials) do
        if special.name == name then
            activeSpecial = special
            break
        end
    end
end

function specialmanager.setActiveUltimate(name)
    for _, ultimate in ipairs(specialmanager.ultimates) do
        if ultimate.name == name then
            activeUltimate = ultimate
            break
        end
    end
end

function specialmanager.update(dt)

end

function specialmanager.draw()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local specialX, specialY = 5, screenHeight - 85 -- Position for the special
    local specialScale = 0.15
    local ultX, ultY = 80, screenHeight - 60 -- Position for the ultimate
    local ultScale = 0.1 -- Scale for the ultimate image

    -- Draw the active special
    if activeSpecial and activeSpecial.image then
        love.graphics.draw(activeSpecial.image, specialX, specialY, 0, specialScale, specialScale)
    end

    -- Draw the active ultimate
    if activeUltimate and activeUltimate.image then
        love.graphics.draw(activeUltimate.image, ultX, ultY, 0, ultScale, ultScale)
    end
end

function specialmanager.getActiveSpecial()
    return activeSpecial
end

function specialmanager.getActiveUltimate()
    return activeUltimate
end

return specialmanager
