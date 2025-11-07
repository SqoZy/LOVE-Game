local enemy = require("Objects.PassiveObjects.EnemyObject.enemy")
local goblinEnemy = setmetatable({}, { __index = enemy })
goblinEnemy.__index = goblinEnemy
anim8 = require("Libraries.anim8")

goblinEnemy.width = 150
goblinEnemy.height = 150

function goblinEnemy:new(x, y)
    local obj = enemy.new(self, x, y)
    obj.spritesheet = love.graphics.newImage("assets/enemies/goblin/Runleft.png")
    obj.grid = anim8.newGrid(obj.width, obj.height, obj.spritesheet:getWidth(), obj.spritesheet:getHeight())

    obj.animation = {}
    obj.animation.run = anim8.newAnimation(obj.grid('1-8', 1), 0.1)

    obj.speed = 50
    return obj
end

function goblinEnemy:update(dt)
    enemy.update(self, dt)
    self.animation.run:update(dt)
end

function goblinEnemy:draw()
    love.graphics.setColor(1, 1, 1)
    self.animation.run:draw(self.spritesheet, self.x, self.y)
end

return goblinEnemy 