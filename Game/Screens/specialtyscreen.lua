local specialtyscreen = {}
local specialmanager = require("specialties.specialmanager")

local selectedSpecial = nil
local selectedUltimate = nil

function specialtyscreen.load()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    -- Load images for specialties
    specialtyscreen.specialtyImages = {
        Fireball = love.graphics.newImage("assets/specialties/NOR_fireball.png"),
        Iceball = love.graphics.newImage("assets/specialties/NOR_iceball.png"),
        Poisonball = love.graphics.newImage("assets/specialties/NOR_poisonball.png"),
        Slimeball = love.graphics.newImage("assets/specialties/NOR_slimeball.png")
    }

    -- Load images for ultimates
    specialtyscreen.ultimateImages = {
        Acidrain = love.graphics.newImage("assets/specialties/ULT_acidrain.png"),
        Meteorrain = love.graphics.newImage("assets/specialties/ULT_meteorrain.png")
    }

    -- Define specialties
    specialtyscreen.specialties = {
        {name = "Fireball", x = screenWidth / 4 - 50, y = screenHeight / 3, width = 100, height = 100},
        {name = "Iceball", x = screenWidth / 2 - 50, y = screenHeight / 3, width = 100, height = 100},
        {name = "Poisonball", x = 3 * screenWidth / 4 - 50, y = screenHeight / 3, width = 100, height = 100},
        {name = "Slimeball", x = screenWidth - 150, y = screenHeight / 3, width = 100, height = 100}
    }

    -- Define ultimates
    specialtyscreen.ultimates = {
        {name = "Acidrain", x = screenWidth / 3 - 50, y = 2 * screenHeight / 3, width = 100, height = 100},
        {name = "Meteorrain", x = 2 * screenWidth / 3 - 50, y = 2 * screenHeight / 3, width = 100, height = 100}
    }
end

function specialtyscreen.update()
    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()

        -- Check for specialty selection
        for _, specialty in ipairs(specialtyscreen.specialties) do
            if x > specialty.x and x < specialty.x + specialty.width and
               y > specialty.y and y < specialty.y + specialty.height then
                selectedSpecial = specialty.name
            end
        end

        -- Check for ultimate selection
        for _, ultimate in ipairs(specialtyscreen.ultimates) do
            if x > ultimate.x and x < ultimate.x + ultimate.width and
               y > ultimate.y and y < ultimate.y + ultimate.height then
                selectedUltimate = ultimate.name
            end
        end
    end
end

function specialtyscreen.draw()
    -- Draw specialties
    for _, specialty in ipairs(specialtyscreen.specialties) do
        if selectedSpecial == specialty.name then
            love.graphics.setColor(0, 1, 0) -- Green outline for selected
        else
            love.graphics.setColor(1, 1, 1) -- White outline
        end
        love.graphics.rectangle("line", specialty.x, specialty.y, specialty.width, specialty.height)
        love.graphics.print(specialty.name, specialty.x + 10, specialty.y + specialty.height + 10)

        -- Draw the specialty image
        local image = specialtyscreen.specialtyImages[specialty.name]
        if image then
            love.graphics.setColor(1, 1, 1) -- Reset color to white
            love.graphics.draw(image, specialty.x, specialty.y, 0, specialty.width / image:getWidth(), specialty.height / image:getHeight())
        end
    end

    -- Draw ultimates
    for _, ultimate in ipairs(specialtyscreen.ultimates) do
        if selectedUltimate == ultimate.name then
            love.graphics.setColor(0, 1, 0) -- Green outline for selected
        else
            love.graphics.setColor(1, 1, 1) -- White outline
        end
        love.graphics.rectangle("line", ultimate.x, ultimate.y, ultimate.width, ultimate.height)
        love.graphics.print(ultimate.name, ultimate.x + 10, ultimate.y + ultimate.height + 10)

        -- Draw the ultimate image
        local image = specialtyscreen.ultimateImages[ultimate.name]
        if image then
            love.graphics.setColor(1, 1, 1) -- Reset color to white
            love.graphics.draw(image, ultimate.x, ultimate.y, 0, ultimate.width / image:getWidth(), ultimate.height / image:getHeight())
        end

        -- Draw the ultimate name below the image
        love.graphics.setColor(1, 1, 1) -- Reset color to white
    end
end

function specialtyscreen.confirmSelection()
    if selectedSpecial and selectedUltimate then
        specialmanager.reqvarspecial(selectedSpecial, 10, 1, 100) -- Example values
        specialmanager.reqvarultimate(selectedUltimate, 20, 5, 50) -- Example values
        initiateScreen("gamescreen") -- Go to the game screen
    end
end

function love.keypressed(key)
    if key == "return" then
        specialtyscreen.confirmSelection()
    end
end

return specialtyscreen
