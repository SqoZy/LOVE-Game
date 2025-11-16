local screenmanager = require("Screens.screenmanager")
local specialmanager = require("Specialties.specialmanager")
local Push = require("Libraries.push")

windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth * 0.8, windowHeight * 0.8

virtualWidth, virtualHeight = 640, 360

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Epic Game")
    Push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    specialmanager.load()
    screenmanager.load()
end

function love.update(dt)
    screenmanager.update(dt)
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.draw()
    Push:start()
        screenmanager.draw()
    Push:finish()
end  
