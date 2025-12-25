local anim8 = require("Libraries.anim8")
local playerbullet = {}


function playerbullet.load()
    playerbullet.width = 25
    playerbullet.height = 25

    playerbullet.speed = 0
    playerbullet.target = nil
    playerbullet.bullets = {}

    playerbullet.spritesheet = love.graphics.newImage("assets/player/fx/ice/ice2.png")
    playerbullet.grid = anim8.newGrid(playerbullet.width, playerbullet.height, playerbullet.spritesheet:getWidth(), playerbullet.spritesheet:getHeight())

    playerbullet.animation = {}
    playerbullet.animation.move = anim8.newAnimation(playerbullet.grid('1-4', 1), 0.1)
    playerbullet.currentAnimation = playerbullet.animation.move
end

function playerbullet.update(dt)
    for i, bullet in ipairs(playerbullet.bullets) do
        local diretionX = bullet.target.x - bullet.x
        local directionY = bullet.target.y - bullet.y
        local distance = math.sqrt(diretionX * diretionX + directionY * directionY)
        local normalizedX, normalizedY = diretionX / distance, directionY / distance
        bullet.x = bullet.x + normalizedX * playerbullet.speed * dt
        bullet.y = bullet.y + normalizedY * playerbullet.speed * dt
        
        local minWidth, maxWidth = 5, 35
        local minHeight, maxHeight = 5, 35
        local angle = playerbullet.getAngleByDirection(bullet.x, bullet.y, bullet.target.x, bullet.target.y)
        local width = minWidth + (maxWidth - minWidth) * math.abs(math.cos(angle))
        local height = minHeight + (maxHeight - minHeight) * math.abs(math.sin(angle))

        if math.cos(angle) < 0 then width = -width end
        if math.sin(angle) < 0 then height = -height end

        bullet.width = width
        bullet.height = height

        if distance < bullet.width or distance < bullet.height then
            table.remove(playerbullet.bullets, i)
            bullet.target:takeDamage(100)
        end
    end
    playerbullet.currentAnimation:update(dt)
end

function playerbullet.draw()
    for _, bullet in ipairs(playerbullet.bullets) do
        local angle = playerbullet.getAngleByDirection(bullet.x, bullet.y, bullet.target.x, bullet.target.y)
        love.graphics.setColor(1, 1, 1)
        playerbullet.currentAnimation:draw(playerbullet.spritesheet, bullet.x, bullet.y, angle - math.pi / 4)

        if DEBUG_HITBOXES then
            love.graphics.setColor(0, 1, 0, 0.5)
            love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.width, bullet.height)
        end
    end
end

function playerbullet.spawn(playerObj, target)
    local bulletX = playerObj.x
    local bulletY = playerObj.y + 10
    table.insert(playerbullet.bullets, {x = bulletX, y = bulletY, width = playerbullet.width, height = playerbullet.height, target = target})
end

function playerbullet.getAngleByDirection(x1, y1, x2, y2)
    local directionX = x2 - x1
    local directionY = y2 - y1
    local angle = math.atan2(directionY, directionX)
    return angle
end

return playerbullet