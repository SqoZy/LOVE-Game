local InteractObject = require("Objects.InteractObjects.interactobject")
local mouseinput = require("Input.mouseinput")
local anim8 = require("Libraries.anim8")

local clickSpirit = setmetatable({}, { __index = InteractObject })

function clickSpirit:new(x, y, radius)
    local spirit = InteractObject.new(self, x, y, radius) 
    setmetatable(spirit, { __index = self }) 
    spirit.spiritType = "click"

    spirit.spritesheet = love.graphics.newImage("assets/spirits/Blood_wisp-Sheet.png")
    spirit.animations = {}
    spirit.animations.idle = anim8.newAnimation(anim8.newGrid(160, 144, spirit.spritesheet:getWidth(), spirit.spritesheet:getHeight())('1-10', 1), 0.1)
    spirit.animations.death = anim8.newAnimation(anim8.newGrid(160, 144, spirit.spritesheet:getWidth(), spirit.spritesheet:getHeight())('1-8', 3), 0.1, function() spirit.isDestroyed = true end)
    spirit.currentAnimation = spirit.animations.idle

    return spirit
end

function clickSpirit:update(dt)
    InteractObject.update(self, dt)
    if love.mouse.isDown(1) then
        if mouseinput.checkMouseHover(self) then
            self:_destroy()
        end
    end
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function clickSpirit:draw()
    love.graphics.setColor(0, 1, 0) 
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1)
    self.currentAnimation:draw(self.spritesheet, self.x - 80, self.y - 72)
end

function clickSpirit:_spawn(growDuration)
    InteractObject._spawn(self, growDuration) 
end

return clickSpirit