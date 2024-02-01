local x, y, z, xd, zd = 0, 0, 0, 1, 0
local qSize = 16
local collected = 0
local unloaded = 0

local function refuel(amount)
	local fuelLevel = turtle.getFuelLevel()
	if fuelLevel == "unlimited" then
		return true
	end
	
	local needed = amount or (x + y + z + 10)
	if turtle.getFuelLevel() < needed then
		local fueled = false
		for n=1,16 do
			if turtle.getItemCount(n) > 0 then
				turtle.select(n)
				if turtle.refuel(1) then
					while turtle.getItemCount(n) > 0 and turtle.getFuelLevel() < needed do
						turtle.refuel(1)
					end
					if turtle.getFuelLevel() >= needed then
						turtle.select(1)
						return true
					end
				end
			end
		end
		turtle.select(1)
		return false
	end
	
	return true
end

local function unload(_bKeepOneFuelStack)
	print("Unloading items...")
	for n=1,16 do
		local nCount = turtle.getItemCount(n)
		if nCount > 0 then
			turtle.select(n)			
			local bDrop = true
			if _bKeepOneFuelStack and turtle.refuel(0) then
				bDrop = false
				_bKeepOneFuelStack = false
			end			
			if bDrop then
				turtle.drop()
                unloaded = unloaded + nCount
			end
		end
	end
	collected = 0
	turtle.select(1)
end

local function collect()	
	local bFull = true
	local nTotalItems = 0
	for n=1,16 do
		local nCount = turtle.getItemCount(n)
		if nCount == 0 then
			bFull = false
		end
		nTotalItems = nTotalItems + nCount
	end
	
	if nTotalItems > collected then
		collected = nTotalItems
        if math.fmod(collected + unloaded, 50) == 0 then
			print("Mined "..(collected + unloaded).." items.")
		end
	end
	
	if bFull then
		print("No empty slots left.")
		return false
	end

	return true
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
                    sleep(0.2)
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
                    sleep(0.2)
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
                    sleep(0.2)
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
                    sleep(0.2)
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
            sleep(0.2)
        until xd == xd2 and zd == zd2
    end
end

local function returnSupplies()
    local x2, y2, z2, xd2, zd2 = x, y, z, xd, zd
    goTo(0, 0, 0, -1, 0)

    local neededFuel = 2*(x+y+z)+20
    if not refuel(neededFuel) then
        unload(true)
        print("Waiting for fuel")
		while not refuel(neededFuel) do
			os.pullEvent("turtle_inventory")
		end
    else
        unload(true)
    end

    print("Resuming mining...")
	goTo(x2, y2, z2, xd2, zd2)
end

local function turnLeft()
    turtle.turnLeft()
    updateCoords("Left")
end

local function turnRight()
    turtle.turnRight()
    updateCoords("Right")
end

local function goForward()
    if turtle.forward() then
        updateCoords("Forward")
        return true
    end
    return false
end

local function goBack()
    if turtle.back() then
        updateCoords("Back")
        return true
    end
    return false
end

local function goUp()
    if turtle.up() then
        updateCoords("Up")
        return true
    end
    return false
end

local function goDown()
    if turtle.down() then
        updateCoords("Down")
        return true
    end
    return false
end

local function digForward()
    if not refuel() then
		print("Not enough Fuel")
		returnSupplies()
	end

    if turtle.dig() then
        if not collect() then
            returnSupplies()
        end
    else
        return false
    end
    return true
end

local function digUpAndDown()
    if not refuel() then
		print("Not enough Fuel")
		returnSupplies()
	end
    if turtle.digUp() then
        if not collect() then
            returnSupplies()
        end
    end
    if turtle.digDown() then
        if not collect() then
            returnSupplies()
        end
    end
end

local function digDown()
    if not refuel() then
		print("Not enough Fuel")
		returnSupplies()
	end

    if turtle.digDown() then
        if not collect() then
            returnSupplies()
        end
    else
        return false
    end
    return true
end

if not refuel() then
	print("Out of Fuel")
	return
end

print("Excavating...")

turtle.select(1)

local done = false
local alternate = 0

while not done do
    for i=1, 2 do
        digDown()
        if not goDown() then
            done = true
            break
        end
    end
    for i=1, qSize do
        for i=1, qSize-1 do
            digForward()
            if not goForward() then
                done = true
                break
            end
            digUpAndDown()
        end
        repeat
             turnRight() 
             sleep(0.2)
        until zd == 1
        digForward()
        if not goForward() then
            done = true
            break
        end
        digUpAndDown()
        if i ~= 16 then
            if alternate == 0 then
                repeat
                    turnRight() 
                    sleep(0.2)
               until xd == -1
               alternate = 1
            elseif alternate == 1 then
                repeat
                    turnRight()
                    sleep(0.2)
               until xd == 1
               alternate = 0
            end
        end
    end
    alternate = 0
    goTo(0, y, 0, 1, 0)
end

print( "Returning to surface..." )

-- Return to where we started
goTo( 0,0,0,0,-1 )
unload( false )
goTo( 0,0,0,0,1 )

print("Mined "..(collected + unloaded).." items total.")