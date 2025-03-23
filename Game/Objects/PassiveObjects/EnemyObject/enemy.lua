local enemy = {}
enemy.__index = enemy

function enemy:new(x, y)
    local obj = setmetatable({}, self)
    obj.x = x or 0
    obj.y = y or 0
    obj.speed = 100
    obj.health = 10
    obj.isDestroyed = false
    return obj
end

function enemy:draw()
    love.graphics.setColor(1, 0, 0)
end

function enemy:update(dt)
    self.x = self.x + -self.speed * dt
end

function enemy:takeDamage(damage)
    self.health = self.health - damage
    if self.health <= 0 then
        self:destroy()
    end
end

function enemy:destroy()
    -- give player points
    self.isDestroyed = true
end

return enemy
