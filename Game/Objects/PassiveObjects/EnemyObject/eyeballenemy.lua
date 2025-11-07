local enemy = require("Objects.PassiveObjects.EnemyObject.enemy")
local eyeBallEnemy = setmetatable({}, { __index = enemy })
eyeBallEnemy.__index = eyeBallEnemy
anim8 = require("Libraries.anim8")

eyeBallEnemy.width = 128
eyeBallEnemy.height = 48

function eyeBallEnemy:new(x, y)
    local obj = enemy.new(self, x, y)
    obj.spritesheet = love.graphics.newImage("assets/enemies/deadlands/eyeball/eyeballmonster.png")
    obj.grid = anim8.newGrid(obj.width, obj.height, obj.spritesheet:getWidth(), obj.spritesheet:getHeight())

    obj.animation = {}
    obj.animation.run = anim8.newAnimation(obj.grid('1-8', 2), 0.1)

    obj.speed = 50
    return obj
end

function eyeBallEnemy:update(dt)
    enemy.update(self, dt)
    self.animation.run:update(dt)
end

function eyeBallEnemy:draw()
    love.graphics.setColor(1, 1, 1)
    self.animation.run:draw(self.spritesheet, self.x, self.y)
end

return eyeBallEnemy 