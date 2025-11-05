local specialmanager = {}

specialmanager.specials = {} -- Table to store all registered specialties
specialmanager.ultimates = {} -- Table to store all registered ultimates

local activeSpecial
local activeUltimate
local selectedSpecial = 1
local selectedUltimate

function specialmanager.load()
    require("Specialties.slimeball")
    require("Specialties.fireball")
    require("Specialties.iceball")
    require("Specialties.poisonball")
    require("Specialties.meteorrain")
    require("Specialties.acidrain")
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
    local specialX, specialY = 40, virtualHeight - 140 
    local specialScale = 0.5
    local ultX, ultY = 160, virtualHeight - 120
    local ultScale = 0.4 

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
