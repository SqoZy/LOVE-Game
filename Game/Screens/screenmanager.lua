local screenmanager = {}

local startScreen, homeScreen, gameScreen, endScreen, specialtyscreen
local screen
local screenModules = {} -- Table to store all the screens for versatility

local specialmanager = require("specialties.specialmanager") -- Require the specialmanager

function screenmanager.load()
    -- Load specialties and ultimates

    -- Load screens
    startScreen = require("Screens.startscreen")
    homeScreen = require("Screens.homescreen")
    gameScreen = require("Screens.gamescreen")
    endScreen = require("Screens.endscreen")
    specialtyscreen = require("Screens.specialtyscreen")

    -- Add all the screens to the table
    screenModules["startscreen"] = startScreen
    screenModules["homescreen"] = homeScreen
    screenModules["gamescreen"] = gameScreen
    screenModules["endscreen"] = endScreen
    screenModules["specialtyscreen"] = specialtyscreen

    initiateScreen("specialtyscreen") -- Start with the home screen
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
