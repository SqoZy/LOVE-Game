local playerbullet = {}


function playerbullet.load()
    playerbullet.image = love.graphics.newImage("assets/player/fx/ice/ice2.png")
    playerbullet.width = playerbullet.image:getWidth()
    playerbullet.height = playerbullet.image:getHeight()
    playerbullet.speed = 500
    playerbullet.bullets = {}
end

function playerbullet.update(dt)
    for i, bullet in ipairs(playerbullet.bullets) do
        bullet.y = bullet.y - playerbullet.speed * dt
        if bullet.y < 0 then
            table.remove(playerbullet.bullets, i)
        end
    end
end

function playerbullet.draw()
    for _, bullet in ipairs(playerbullet.bullets) do
        love.graphics.draw(playerbullet.image, bullet.x, bullet.y)
    end
end

return playerbullet