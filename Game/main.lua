local screenmanager = require("Screens.screenmanager")
local specialmanager = require("Specialties.specialmanager")

function love.load()
    specialmanager.load()
    screenmanager.load()
end

function love.update(dt)
    screenmanager.update(dt)
end

function love.draw()
    screenmanager.draw()
end