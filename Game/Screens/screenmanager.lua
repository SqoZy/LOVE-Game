local screenmanager = {}

local startScreen, homeScreen, gameScreen, endScreen, specialtyscreen
local screen
local screenModules = {}

local specialmanager = require("Specialties.specialmanager")

function screenmanager.load()
    startScreen = require("Screens.startscreen")
    homeScreen = require("Screens.homescreen")
    gameScreen = require("Screens.gamescreen")
    endScreen = require("Screens.endscreen")
    specialtyscreen = require("Screens.specialtyscreen")

    screenModules["startscreen"] = startScreen
    screenModules["homescreen"] = homeScreen
    screenModules["gamescreen"] = gameScreen
    screenModules["endscreen"] = endScreen
    screenModules["specialtyscreen"] = specialtyscreen

    initiateScreen("gamescreen")
end

function screenmanager.update(dt)
    if not screenModules[screen].update then
        error("Update function not found for screen: " .. screen)
        return
    end
    screenModules[screen].update(dt)
end

function screenmanager.draw()
    if not screenModules[screen].draw then
        error("Draw function not found for screen: " .. screen)
        return
    end
    screenModules[screen].draw()
end

function initiateScreen(screenName)
    screen = screenName
    if screenModules[screen] == nil then
        error("Screen not found: " .. screen)
        return
    end
    if not screenModules[screen].load then
        error("Load function not found for screen: " .. screen)
        return
    end
    screenModules[screen].load()
end


function screenmanager.drawSpecial()
    specialmanager.draw()
end

function screenmanager.getSelectedSpecial()
    return specialmanager.getSpecial()
end

function screenmanager.getSelectedUltimate()
    return specialmanager.getUltimate()
end

return screenmanager
