local specialtyscreen = {}
local specialmanager = require("specialties.specialmanager")
local keyinput = require("Input.keyinput")
local mouseinput = require("Input.mouseinput")

local screen = "specialtyscreen"
local button = {}

local screenWidth, screenHeight = love.graphics.getDimensions()

function specialtyscreen.load()

    createSpecialRows()

    button = {
        x = screenWidth / 2 - 100,
        y = screenHeight - 100,
        width = 200,
        height = 50,
        text = "Go to Game"
    }
end

function createSpecialRows()
    specialtyscreen.specialties = {}
    specialtyscreen.ultimates = {}

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
        for _, specialty in ipairs(specialtyscreen.specialties) do
            if mouseinput.checkMouseHover(specialty) then
                if specialmanager.getSpecial() ~= specialty.name then
                    specialmanager.setSpecial(specialty.name)
                end
            end
        end

        for _, ultimate in ipairs(specialtyscreen.ultimates) do
            if mouseinput.checkMouseHover(ultimate) then
                if specialmanager.getUltimate() ~= ultimate.name then
                    specialmanager.setUltimate(ultimate.name)
                end
            end
        end

        if mouseinput.checkMouseHover(button) then
            specialtyscreen.confirmSelection()
        end
    end
end

function specialtyscreen.draw()
    for _, specialty in ipairs(specialtyscreen.specialties) do
        if specialmanager.getSpecial() == specialty.name then
            love.graphics.setColor(0, 1, 0) 
        else
            love.graphics.setColor(1, 1, 1) 
        end
        love.graphics.rectangle("line", specialty.x, specialty.y, specialty.width, specialty.height)

        if specialty.image then
            love.graphics.setColor(1, 1, 1) 
            love.graphics.draw(specialty.image, specialty.x, specialty.y, 0, specialty.width / specialty.image:getWidth(), specialty.height / specialty.image:getHeight())
        end
    end

    for _, ultimate in ipairs(specialtyscreen.ultimates) do
        if specialmanager.getUltimate() == ultimate.name then
            love.graphics.setColor(0, 1, 0) 
        else
            love.graphics.setColor(1, 1, 1) 
        end
        love.graphics.rectangle("line", ultimate.x, ultimate.y, ultimate.width, ultimate.height)

        if ultimate.image then
            love.graphics.setColor(1, 1, 1) 
            love.graphics.draw(ultimate.image, ultimate.x, ultimate.y, 0, ultimate.width / ultimate.image:getWidth(), ultimate.height / ultimate.image:getHeight())
        end
    end

    love.graphics.setColor(0.5, 0.5, 0.5) -- Button background color
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
    love.graphics.setColor(1, 1, 1) -- Button border color
    love.graphics.rectangle("line", button.x, button.y, button.width, button.height)
    love.graphics.print(button.text, button.x + 50, button.y + 15)
end

function specialtyscreen.confirmSelection()
    local selectedSpecial = specialmanager.getSpecial()
    local selectedUltimate = specialmanager.getUltimate()

    if selectedSpecial and selectedUltimate then
        initiateScreen("gamescreen") -- Go to the home screen
    else
        print("Please select both a specialty and an ultimate before starting the game.")
    end
end

function love.keypressed(key, scancode, isrepeat)
    keyinput.keyPressed(key, screen)
end

function love.keyreleased(key, scancode)
    keyinput.keyReleased(key, screen)
end

return specialtyscreen
