local x, y, z, xd, zd = 0, 0, 0, 1, 0

local function printCoords()
    print(x, y, z, xd, zd)
end

local function refuel()

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

local function goTo(x2, y2, z2 ,xd2, zd2)
    if z ~= z2 then
        if z < z2 then
            if zd ~= 1 then
                repeat
                    turtle.turnRight()
                    updateCoords("Right")
                until zd == 1
            end
            repeat
                if turtle.forward() then
                    updateCoords("Forward")
                else
                    turtle.dig()
                end
            until z == z2
        elseif z > z2 then
            if zd ~= -1 then
                repeat
                    turtle.turnRight()
                    updateCoords("Right")
                until zd == -1
            end
            repeat
                if turtle.forward() then
                    updateCoords("Forward")
                else
                    turtle.dig()
                end
            until z == z2
        end
    end
    if x ~= x2 then
        if x < x2 then
            if xd ~= 1 then
                repeat
                    turtle.turnRight()
                    updateCoords("Right")
                until xd == 1
            end
            repeat
                if turtle.forward() then
                    updateCoords("Forward")
                else
                    turtle.dig()
                end
            until x == x2
        elseif x > x2 then
            if xd ~= -1 then
                repeat
                    turtle.turnRight()
                    updateCoords("Right")
                until xd == -1
            end
            repeat
                if turtle.forward() then
                    updateCoords("Forward")
                else
                    turtle.dig()
                end
            until x == x2
        end
    end
    if y ~= y2 then
        if y < y2 then
            repeat
                if turtle.up() then
                    updateCoords("Up")
                else
                    turtle.digUp()
                end
            until y == y2
        elseif y > y2 then
            repeat
                if turtle.down() then
                    updateCoords("Down")
                else
                    turtle.digDown()
                end
            until y == y2
        end
    end
    if xd ~= xd2 and zd ~= zd2 then
        repeat
            turtle.turnRight()
        until xd == xd2 and zd == zd2
    end
end

goTo(10, 5, 10, -1, 0)