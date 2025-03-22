local InteractObject = {}
InteractObject.__index = InteractObject
local mouseinput = require("Input.mouseinput")

function InteractObject:new(x, y, radius)
    local obj = setmetatable({}, self)
    obj.x = x or 0
    obj.y = y or 0
    obj.radius = radius
    obj.spawnTime = 0
    obj.growDuration = 2 
    obj.isSpawning = false
    obj.isDestroyed = false 
    obj.dragging = false
    return obj
end

function InteractObject:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", self.x, self.y, self.radius)
end

function InteractObject:update(dt)
    if self.isSpawning then
        self.spawnTime = self.spawnTime + dt
        local progress = math.min(self.spawnTime / self.growDuration, 1)
        self.radius = self.targetRadius * progress 
        if progress >= 1 then
            self.isSpawning = false
        end
    end
    mouseinput.checkMouseHover(self)
end

function InteractObject:_spawn(growDuration)
    self.targetRadius = self.radius
    self.radius = 0 
    self.spawnTime = 0 
    self.growDuration = growDuration or self.growDuration 
    self.isSpawning = true
end

function InteractObject:_destroy()
    print("InteractObject destroyed!")
    self.isDestroyed = true
end

return InteractObject