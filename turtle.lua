local x, y, z, xd, zd = 0, 0, 0, 1, 0

local function printCoords()
    print(x, y, z, xd, zd)
end

local function refuel()

end

local function goTo()

end

local function returnSupplies()

end

local function unload()

end

local function checkInventory()

end

local function updateCoords(dir)
    if dir == "Forward" then
        if xd == 1 then
            x = x + 1
        elseif zd == 1 then
            z = z + 1
        elseif xd == -1 then
            x = x - 1
        elseif zd == -1 then
            z = z - 1
        end
    elseif dir == "Back" then
        if xd == 1 then
            x = x - 1
        elseif zd == 1 then
            z = z - 1
        elseif xd == -1 then
            x = x + 1
        elseif zd == -1 then
            z = z + 1
        end
    elseif dir == "Up" then
            y = y + 1
    elseif dir == "Down" then
            y = y - 1
    elseif dir == "Left" then
        if xd == 1 then
            xd = 0
            zd = -1
        elseif zd == -1 then
            zd = 0
            xd = -1
        elseif xd == -1 then
            xd = 0
            zd = 1
        elseif zd == 1 then
            zd = 0
            xd = 1
        end
    elseif dir == "Right" then
        if xd == 1 then
            xd = 0
            zd = 1
        elseif zd == -1 then
            zd = 0
            xd = 1
        elseif xd == -1 then
            xd = 0
            zd = -1
        elseif zd == 1 then
            zd = 0
            xd = -1
        end
    end
end

if turtle.forward() then
    updateCoords("Forward")
    printCoords()
end

if turtle.turnLeft() then
    updateCoords("Left")
    printCoords()
end

if turtle.forward() then
    updateCoords("Forward")
    printCoords()
end

if turtle.turnRight() then
    updateCoords("Right")
    printCoords()
end

if turtle.forward() then
    updateCoords("Forward")
    printCoords()
end

if turtle.turnRight() then
    updateCoords("Right")
    printCoords()
end

if turtle.forward() then
    updateCoords("Forward")
    printCoords()
end

if turtle.turnRight() then
    updateCoords("Right")
    printCoords()
end

if turtle.forward() then
    updateCoords("Forward")
    printCoords()
end

if turtle.forward() then
    updateCoords("Forward")
    printCoords()
end

if turtle.up() then
    updateCoords("Up")
    printCoords()
end