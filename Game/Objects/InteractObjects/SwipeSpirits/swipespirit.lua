local InteractObject = require("Objects.InteractObjects.interactobject")
local class = require("Libraries.middleclass")
local swipeSpirit = setmetatable({}, { __index = InteractObject })
local mouseinput = require("Input.mouseinput")

local swipeSpirit = class('swipeSpirit')

function swipeSpirit:initialize(x, y, radius, objectDirection)
    local obj = InteractObject.new(self, x, y, radius) 
    setmetatable(obj, { __index = self }) 
    obj.direction = objectDirection
    return obj
end

function swipeSpirit:update(dt)
    InteractObject.update(self, dt)
    mouseinput.dragObject(self)
end

function swipeSpirit:draw()
    love.graphics.setColor(self:getColor())
    love.graphics.circle("fill", self.x, self.y, self.radius)
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

function swipeSpirit:_destroy()
    InteractObject._destroy(self)
end

return swipeSpirit