local enemy = require("Objects.PassiveObjects.EnemyObject.enemy")
local trashEnemy = setmetatable({}, { __index = enemy })
trashEnemy.__index = trashEnemy
anim8 = require("Libraries.anim8")

trashEnemy.width = 64
trashEnemy.height = 64

function trashEnemy:new(x, y)
    local obj = enemy.new(self, x, y)
    obj.spritesheet = love.graphics.newImage("assets/enemies/deadlands/trash/trashmonster.png")
    obj.grid = anim8.newGrid(obj.width, obj.height, obj.spritesheet:getWidth(), obj.spritesheet:getHeight())

    obj.animation = {}
    obj.animation.run = anim8.newAnimation(obj.grid('1-6', 1), 0.1)

    obj.speed = 50
    return obj
end

function trashEnemy:update(dt)
    enemy.update(self, dt)
    self.animation.run:update(dt)
end

function trashEnemy:draw()
    love.graphics.setColor(1, 1, 1)
    self.animation.run:draw(self.spritesheet, self.x, self.y)
end

return trashEnemy 