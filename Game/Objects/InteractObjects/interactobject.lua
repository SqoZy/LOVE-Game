local InteractObject = {}
InteractObject.__index = InteractObject

function InteractObject:new(x, y, width, height)
    local obj = setmetatable({}, self)
    obj.x = x or 0
    obj.y = y or 0
    obj.width = width or 50
    obj.height = height or 50
    return obj
end

function InteractObject:draw()
    love.graphics.setColor(1, 1, 1) -- Default color: white
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

function InteractObject:update(dt)
    -- Default update logic (can be overridden)
end

return InteractObject