local InteractObject = require("Objects.InteractObjects.interactobject")
local clickSpirit = setmetatable({}, { __index = InteractObject })
local mouseinput = require("Input.mouseinput")

function clickSpirit:new(x, y, radius)
    local obj = InteractObject.new(self, x, y, radius) 
    setmetatable(obj, { __index = self }) 
    obj.spiritType = "click"
    return obj
end

function clickSpirit:update(dt)
    InteractObject.update(self, dt)
    if love.mouse.isDown(1) then
        if mouseinput.checkMouseHover(self) then
            self:_destroy()
        end
    end
end

function clickSpirit:draw()
    love.graphics.setColor(0, 1, 0) -- Green color for clickSpirit
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function clickSpirit:_spawn(growDuration)
    InteractObject._spawn(self, growDuration) -- Call the base class _spawn method
end

return clickSpirit