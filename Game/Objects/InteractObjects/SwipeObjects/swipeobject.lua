local InteractObject = require("Objects.InteractObjects.interactobject")
local SwipeObject = setmetatable({}, { __index = InteractObject })
local mouseinput = require("Input.mouseinput")

function SwipeObject:new(x, y, radius)
    local obj = InteractObject.new(self, x, y, radius) 
    setmetatable(obj, { __index = self }) 
    return obj
end

function SwipeObject:update(dt)
    InteractObject.update(self, dt)
    mouseinput.dragObject(self) -- Use dragObject to handle dragging and swipe detection
end

function SwipeObject:draw()
    love.graphics.setColor(1, 0, 0) -- Red color for SwipeObject
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function SwipeObject:onSwipe(direction)
    -- Handle the swipe direction
    print("SwipeObject swiped in direction: " .. direction)
    if direction == "up" then
        self:_destroy() -- Example: Destroy the object on swipe up
    end
end

function SwipeObject:_spawn(growDuration)
    InteractObject._spawn(self, growDuration) -- Call the base class _spawn method
end

function SwipeObject:_destroy()
    InteractObject._destroy(self)
    print("SwipeObject destroyed!")
end

return SwipeObject