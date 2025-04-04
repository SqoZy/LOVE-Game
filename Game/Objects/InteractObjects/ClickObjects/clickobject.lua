local InteractObject = require("Objects.InteractObjects.interactobject")
local ClickObject = setmetatable({}, { __index = InteractObject })
local mouseinput = require("Input.mouseinput")

function ClickObject:new(x, y, radius)
    local obj = InteractObject.new(self, x, y, radius) 
    setmetatable(obj, { __index = self }) 
    return obj
end

function ClickObject:update(dt)
    InteractObject.update(self, dt)
    mouseinput.destroyClickObject(self)
end

function ClickObject:draw()
    love.graphics.setColor(0, 1, 0) -- Green color for ClickObject
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function ClickObject:_spawn(growDuration)
    InteractObject._spawn(self, growDuration) -- Call the base class _spawn method
end

function ClickObject:_destroy()
    InteractObject._destroy(self)
end

return ClickObject