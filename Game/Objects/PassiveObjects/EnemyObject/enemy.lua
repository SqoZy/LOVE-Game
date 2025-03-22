local enemy = {}
enemy.__index = enemy

function enemy:new(x, y)
    local obj = setmetatable({}, self)
    obj.image = love.graphics.newImage("assets/enemy/enemy.png")
    obj.x = x or 0
    obj.y = y or 0
    obj.speed = 100
    obj.isDestroyed = false
    return obj
end

function enemy:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, 10)
end

function enemy:update(dt)
    self.y = self.y + self.speed * dt
end

return enemy -- Ensure the module is returned