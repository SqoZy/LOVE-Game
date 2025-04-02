local specialmanager = {}

specialmanager.specials = {} -- Table to store all registered specialties
specialmanager.ultimates = {} -- Table to store all registered ultimates

local activeSpecial
local activeUltimate
local selectedSpecial = 1
local selectedUltimate

function specialmanager.load()
    require("specialties.slimeball")
    require("specialties.fireball")
    require("specialties.iceball")
    require("specialties.poisonball")
    require("specialties.meteorrain")
    require("specialties.acidrain")
end

function specialmanager.registerSpecial(special)
    table.insert(specialmanager.specials, special)
end

function specialmanager.registerUltimate(ultimate)
    table.insert(specialmanager.ultimates, ultimate)
end

function specialmanager.setSpecial(name)
    selectedSpecial = name
end

function specialmanager.setUltimate(name)
    selectedUltimate = name
end

function specialmanager.getSpecial()
    return selectedSpecial
end

function specialmanager.getUltimate()
    return selectedUltimate
end

function specialmanager.update(dt)

end

function specialmanager.draw()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local specialX, specialY = 5, screenHeight - 85 -- Position for the special
    local specialScale = 0.15
    local ultX, ultY = 80, screenHeight - 60 -- Position for the ultimate
    local ultScale = 0.1 -- Scale for the ultimate image

    -- Draw the selected special
    if selectedSpecial then
        for _, special in ipairs(specialmanager.specials) do
            if special.name == selectedSpecial and special.image then
                love.graphics.draw(special.image, specialX, specialY, 0, specialScale, specialScale)
                break
            end
        end
    end

    -- Draw the selected ultimate
    if selectedUltimate then
        for _, ultimate in ipairs(specialmanager.ultimates) do
            if ultimate.name == selectedUltimate and ultimate.image then
                love.graphics.draw(ultimate.image, ultX, ultY, 0, ultScale, ultScale)
                break
            end
        end
    end
end

return specialmanager
