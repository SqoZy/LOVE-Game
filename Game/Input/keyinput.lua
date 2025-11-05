local keyinput = {}
local fullscreen = true

function keyinput.keyPressed(key, screen)
    if screen  == nil then 
        error("Screen not found: " .. screen)
        return
    end

    GeneralScreenInput(key, screen)

    if screen == "gamescreen" then
        GameScreenInput(key, screen)
    end
end

function keyinput.keyReleased(key, screen)

end

function GameScreenInput(key, screen)

end

function GeneralScreenInput(key, screen)
    if key == "f11" then
        fullscreen = not fullscreen
        love.window.setFullscreen(fullscreen)
        if not fullscreen then
            local windowWidth = virtualWidth * 0.9
            local windowHeight = virtualHeight * 0.9 
            love.window.setMode(windowWidth, windowHeight, { fullscreen = false, resizable = false })
        end
    end
    if key == "escape" then
        love.event.quit()
    end
end

return keyinput