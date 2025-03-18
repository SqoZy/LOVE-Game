local rectangle = require("rectangle")
local rectangle2 = require("rectangle2")
local mouseinput = require("mouseinput")
local screenmanager = require("Screens.screenmanager")
local isHovering = false


function love.load()
    screenmanager.load()
end

function love.update(dt)
    screenmanager.update(dt)
end

function love.draw()
    screenmanager.draw()
end
