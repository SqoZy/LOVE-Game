local InteractObject = require("Objects.InteractObjects.interactobject")
local mouseinput = require("Input.mouseinput")
local anim8 = require("Libraries.anim8")
local swipeSpirit = setmetatable({}, { __index = InteractObject })
swipeSpirit.__index = swipeSpirit

function swipeSpirit:new(x, y, radius, objectDirection)
    local spirit = InteractObject.new(self, x, y, radius) 
    setmetatable(spirit, { __index = self }) 
    spirit.direction = objectDirection
    spirit.spiritType = "swipe"

    spirit.spritesheet = love.graphics.newImage("assets/spirits/Ice_wisp-Sheet.png")
    spirit.animations = {}
    spirit.animations.idle = anim8.newAnimation(anim8.newGrid(128, 128, spirit.spritesheet:getWidth(), spirit.spritesheet:getHeight())('1-10', 1), 0.1)
    spirit.animations.death = anim8.newAnimation(anim8.newGrid(128, 128, spirit.spritesheet:getWidth(), spirit.spritesheet:getHeight())('1-11', 3), 0.1, function() spirit.isDestroyed = true end)
    spirit.currentAnimation = spirit.animations.idle

    return spirit
end

function swipeSpirit:update(dt)
    InteractObject.update(self, dt)
    mouseinput.dragObject(self)
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function swipeSpirit:draw()
    love.graphics.setColor(self:getColor())
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1)
    self.currentAnimation:draw(self.spritesheet, self.x - 64, self.y - 64)
end

function swipeSpirit:getColor()
    if self.direction == "up" then
        return {1, 1, 1}
    elseif self.direction == "down" then
        return {0, 1, 0}
    elseif self.direction == "left" then
        return {1, 0, 0}
    elseif self.direction == "right" then
        return {0, 0, 1}
    end
end

function swipeSpirit:onSwipe(direction)
    print("swipeSpirit swiped in direction: " .. direction)
    if direction == self.direction then
        self:_destroy()
    end
end

function swipeSpirit:_spawn(growDuration)
    InteractObject._spawn(self, growDuration)
end

return swipeSpirit