local screenmanager = require("Screens.screenmanager")

function love.load()
    love.window.setFullscreen(true)
    screenmanager.load()
end

function love.update(dt)
    screenmanager.update(dt)
end

function love.draw()
    screenmanager.draw()
end