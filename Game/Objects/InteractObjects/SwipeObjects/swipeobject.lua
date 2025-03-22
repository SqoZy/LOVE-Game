local InteractObject = require("Objects.InteractObjects.interactobject")
local SwipeObject = setmetatable({}, { __index = InteractObject })

function SwipeObject:new(x, y, width, height, onSwipe)
    local obj = InteractObject:new(x, y, width, height) -- Call the base class constructor

    return obj
end

function SwipeObject:update(dt)
    if love.mouse.isDown(1) then
        if mouseinput.checkMouseHover(self) then
            self.onSwipe()
        end
    end
end

function SwipeObject:draw()
    love.graphics.setColor(1, 0, 0) -- Red color for SwipeObject
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function SwipeObject:_destroy()
    InteractObject._destroy(self)
    print("SwipeObject destroyed!")
end

return SwipeObject