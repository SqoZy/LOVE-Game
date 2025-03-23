local specialmanager = {}

local selectedSpecial = nil
local selectedSpecialIndex = nil
 specialmanager.specials = {}

local activename, activedamage, activecooldown, activespeed = nil, nil, nil, nil
local activeultname, activeultdamage, activeultcooldown, activeultspeed = nil, nil, nil, nil

function specialmanager.load()
    specialmanager.fireballimage = love.graphics.newImage("assets/specialties/NOR_fireball.png")
    specialmanager.iceballimage = love.graphics.newImage("assets/specialties/NOR_iceball.png")
    specialmanager.poisonballimage = love.graphics.newImage("assets/specialties/NOR_poisonball.png")
    specialmanager.slimeballimage = love.graphics.newImage("assets/specialties/NOR_slimeball.png")
    specialmanager.acidrainimage = love.graphics.newImage("assets/specialties/ULT_acidrain.png")
    specialmanager.meteorrainimage = love.graphics.newImage("assets/specialties/ULT_meteorrain.png")
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
    if activename == "Fireball" then
        love.graphics.draw(specialmanager.fireballimage, specialX, specialY, 0, specialScale, specialScale)
    elseif activename == "Iceball" then
        love.graphics.draw(specialmanager.iceballimage, specialX, specialY, 0, specialScale, specialScale)
    elseif activename == "Poisonball" then
        love.graphics.draw(specialmanager.poisonballimage, specialX, specialY, 0, specialScale, specialScale)
    elseif activename == "Slimeball" then
        love.graphics.draw(specialmanager.slimeballimage, specialX, specialY, 0, specialScale, specialScale)
    end

    -- Draw the active ultimate
    if activeultname == "Acidrain" then
        love.graphics.draw(specialmanager.acidrainimage, ultX, ultY, 0, ultScale, ultScale)
    elseif activeultname == "Meteorrain" then
        love.graphics.draw(specialmanager.meteorrainimage, ultX, ultY, 0, ultScale, ultScale)
    end
end

function currentSpecial()
    return activename, activedamage, activecooldown, activespeed
end

function specialmanager.reqvarspecial(name, damage, cooldown, speed)
    activename = name
    activedamage = damage
    activecooldown = cooldown
    activespeed = speed
end

function specialmanager.reqvarultimate(name, damage, cooldown, speed)
    activeultname = name
    activeultdamage = damage
    activeultcooldown = cooldown
    activeultspeed = speed
end

return specialmanager
