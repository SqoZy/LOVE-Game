local keyinput = {}

function keyinput.keyPressed(key, screen)
    if screen == "gamescreen" then
        GameScreenInput(key, screen)
    end
end

function keyinput.keyReleased(key, screen)

end

function GameScreenInput(key, screen)
    if key == "f11" then
        local fullscreen = not love.window.getFullscreen()
        love.window.setFullscreen(fullscreen)
    end
    if key == "escape" then
        love.event.quit()
    end
end

return keyinput