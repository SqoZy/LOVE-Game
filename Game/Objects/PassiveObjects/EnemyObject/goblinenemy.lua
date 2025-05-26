local enemy = require("Objects.PassiveObjects.EnemyObject.enemy")
local GolbinEnemy = setmetatable({}, { __index = enemy })
GolbinEnemy.__index = GolbinEnemy
anim8 = require("Libraries.anim8")

function GolbinEnemy:new(x, y)
    local obj = enemy.new(self, x, y)
    obj.spritesheet = love.graphics.newImage("assets/enemies/Runleft.png")
    obj.grid = anim8.newGrid(150, 150, obj.spritesheet:getWidth(), obj.spritesheet:getHeight())

    obj.animation = {}
    obj.animation.run = anim8.newAnimation(obj.grid('1-8', 1), 0.1)

    obj.speed = 50
    return obj
end

function GolbinEnemy:update(dt)
    enemy.update(self, dt)
    self.animation.run:update(dt)
end

function GolbinEnemy:draw()
    love.graphics.setColor(1, 1, 1)
    self.animation.run:draw(self.spritesheet, self.x, self.y)
end

return GolbinEnemy 