local screenmanager = require("Screens.screenmanager")
local specialmanager = require("Specialties.specialmanager")

function love.load()
    -- Initialize the specialmanager after Love2D is ready
    specialmanager.load()

    -- Initialize the screenmanager
    screenmanager.load()
end

function love.update(dt)
    screenmanager.update(dt)
end

function love.draw()
    screenmanager.draw()
end
