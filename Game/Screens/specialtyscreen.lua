local specialtyscreen = {}
local specialmanager = require("specialties.specialmanager")
local keyinput = require("Input.keyinput")

local screen = "specialtyscreen"
local selectedSpecial = nil
local selectedUltimate = nil

function specialtyscreen.load()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    -- Load specialties and ultimates dynamically from specialmanager
    specialtyscreen.specialties = {}
    specialtyscreen.ultimates = {}

    -- Dynamically position specialties
    local numSpecialties = #specialmanager.specials
    for i, special in ipairs(specialmanager.specials) do
        table.insert(specialtyscreen.specialties, {
            name = special.name,
            image = special.image,
            x = (i - 1) * (screenWidth / numSpecialties) + (screenWidth / numSpecialties) / 2 - 50,
            y = screenHeight / 3,
            width = 100,
            height = 100
        })
    end

    -- Dynamically position ultimates
    local numUltimates = #specialmanager.ultimates
    for i, ultimate in ipairs(specialmanager.ultimates) do
        table.insert(specialtyscreen.ultimates, {
            name = ultimate.name,
            image = ultimate.image,
            x = (i - 1) * (screenWidth / numUltimates) + (screenWidth / numUltimates) / 2 - 50,
            y = 2 * screenHeight / 3,
            width = 100,
            height = 100
        })
    end
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
        if specialty.image then
            love.graphics.setColor(1, 1, 1) -- Reset color to white
            love.graphics.draw(specialty.image, specialty.x, specialty.y, 0, specialty.width / specialty.image:getWidth(), specialty.height / specialty.image:getHeight())
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
        if ultimate.image then
            love.graphics.setColor(1, 1, 1) -- Reset color to white
            love.graphics.draw(ultimate.image, ultimate.x, ultimate.y, 0, ultimate.width / ultimate.image:getWidth(), ultimate.height / ultimate.image:getHeight())
        end
    end
end

function specialtyscreen.confirmSelection()
    if selectedSpecial and selectedUltimate then
        specialmanager.setActiveSpecial(selectedSpecial)
        specialmanager.setActiveUltimate(selectedUltimate)
        initiateScreen("gamescreen") -- Go to the game screen
    end
end

function love.keypressed(key)
    if key == "return" then
        specialtyscreen.confirmSelection()
    end
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return specialtyscreen
