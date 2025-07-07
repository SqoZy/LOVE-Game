local enemy = require("Objects.PassiveObjects.EnemyObject.enemy")
local toothEnemy = setmetatable({}, { __index = enemy })
toothEnemy.__index = toothEnemy
anim8 = require("Libraries.anim8")

function toothEnemy:new(x, y)
    local obj = enemy.new(self, x, y)
    obj.width = 166
    obj.height = 155
    obj.spritesheet = love.graphics.newImage("assets/enemies/deadlands/toothwalker/toothwalker.png")
    obj.grid = anim8.newGrid(obj.width, obj.height, obj.spritesheet:getWidth(), obj.spritesheet:getHeight())

    obj.animation = {}
    obj.animation.run = anim8.newAnimation(obj.grid('1-6', 1), 0.15)

    obj.speed = 15
    return obj
end

function toothEnemy:update(dt)
    enemy.update(self, dt)
    self.animation.run:update(dt)
end

function toothEnemy:draw()
    love.graphics.setColor(1, 1, 1)
    self.animation.run:draw(self.spritesheet, self.x, self.y)
end

return toothEnemy 