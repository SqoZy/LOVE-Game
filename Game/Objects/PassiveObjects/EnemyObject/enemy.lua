local enemy = {}
enemy.__index = enemy

function enemy:new(x, y)
    local obj = setmetatable({}, self)
    obj.x = x or 0
    obj.y = y - (self.height or 0)
    obj.speed = 100
    obj.health = 10
    obj.isDestroyed = false
    
    print(string.format("Enemy spawned at: x=%.2f, y=%.2f", obj.x, obj.y))

    return obj
end

function enemy:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.x, self.y, self.x + 100, self.y + 100)
    -- love.graphics.setColor(1, 0, 0)
end

function enemy:update(dt)
    self.x = self.x + -self.speed * dt
end

function enemy:getHeight()
    return self.height or error("Height not defined for enemy object")
end

function enemy:getWidth()
    return self.width or error("Width not defined for enemy object")
end

function enemy:takeDamage(damage)
    self.health = self.health - damage
    if self.health <= 0 then
        self:destroy()
    end
end

function enemy:destroy()
    self.isDestroyed = true
end

return enemy
