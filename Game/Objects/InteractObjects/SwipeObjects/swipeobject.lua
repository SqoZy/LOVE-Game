local InteractObject = require("Objects.InteractObjects.interactobject")
local class = require("Libraries.middleclass")
local SwipeObject = setmetatable({}, { __index = InteractObject })
local mouseinput = require("Input.mouseinput")

local swipeobject = class('SwipeObject')

function swipeobject:initialize(x, y, radius, objectDirection)
    local obj = InteractObject.new(self, x, y, radius) 
    setmetatable(obj, { __index = self }) 
    obj.direction = objectDirection
    return obj
end

function swipeobject:update(dt)
    InteractObject.update(self, dt)
    mouseinput.dragObject(self)
end

function swipeobject:draw()
    love.graphics.setColor(self:getColor())
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function swipeobject:getColor()
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


function swipeobject:onSwipe(direction)
    print("SwipeObject swiped in direction: " .. direction)
    if direction == self.direction then
        self:_destroy()
    end
end

function swipeobject:_spawn(growDuration)
    InteractObject._spawn(self, growDuration)
end

function swipeobject:_destroy()
    InteractObject._destroy(self)
end

return swipeobject