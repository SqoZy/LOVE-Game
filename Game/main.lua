local screenmanager = require("Screens.screenmanager")

function love.load()
    screenmanager.load()
end

function love.update(dt)
    screenmanager.update(dt)
end

function love.draw()
    screenmanager.draw()
end