local rectangle = {}
local width, height = 200, 100
local spawnx, spawny = 400, 100

function rectangle.load()
    rectangle.x = spawnx
    rectangle.y = spawny
    rectangle.width = width
    rectangle.height = height
end

return rectangle
