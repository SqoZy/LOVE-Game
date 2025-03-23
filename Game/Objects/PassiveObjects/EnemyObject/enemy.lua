local enemy = {}
enemy.__index = enemy

function enemy:new(x, y)
    local obj = setmetatable({}, self)
    obj.x = x or 0
    obj.y = y or 0
    obj.speed = 100
    obj.isDestroyed = false
    return obj
end

function enemy:draw()
    love.graphics.setColor(1, 0, 0)
end

function enemy:update(dt)
    self.x = self.x + -self.speed * dt
end

return enemy 