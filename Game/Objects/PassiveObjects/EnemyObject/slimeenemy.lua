local enemy = require("Objects.PassiveObjects.EnemyObject.enemy")
local SlimeEnemy = setmetatable({}, { __index = enemy })
SlimeEnemy.__index = SlimeEnemy

function SlimeEnemy:new(x, y)
    local obj = enemy.new(self, x, y)
    obj.image = love.graphics.newImage("assets/enemy/slime.png")
    obj.speed = 50
    return obj
end

function SlimeEnemy:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.image, self.x, self.y)
end

return SlimeEnemy 