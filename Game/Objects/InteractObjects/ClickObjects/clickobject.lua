local InteractObject = require("Objects.InteractObjects.interactobject")
local ClickObject = setmetatable({}, { __index = InteractObject })

function ClickObject:new(x, y, width, height, onClick)
    local obj = InteractObject.new(self, x, y, width, height) -- Call the base class constructor
    obj.onClick = onClick or function() print("Object clicked!") end
    return obj
end

function ClickObject:draw()
    love.graphics.setColor(0, 1, 0) -- Green color for ClickObject
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function ClickObject:handleClick(mx, my)
    if mx >= self.x and mx <= self.x + self.width and my >= self.y and my <= self.y + self.height then
        self.onClick()
    end
end

return ClickObject