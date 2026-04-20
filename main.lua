
require "wheel"

local opinion=0

function love.load()
    wheel.setBG("WheelBG.png")

    wheel.setSliceImg(1,"WheelSlice1.png")
    wheel.setSliceImg(2,"WheelSlice2.png")
    wheel.setSliceImg(3,"WheelSlice3.png")
    wheel.setSliceImg(4,"WheelSlice4.png")

    wheel.setSliceResult(1,1)
    wheel.setSliceResult(2,10)
    wheel.setSliceResult(3,-1)
    wheel.setSliceResult(4,-10)

    wheel.setPos(300,300)
end

function love.update(dt)

	if wheel.canMove then
		if right() then 
			--wheel.setTarget(wheel.sliceRot+math.pi/2)
            wheel.selectTarget(1)
		elseif left() then
			--wheel.setTarget(wheel.sliceRot-math.pi/2)
            wheel.selectTarget(-1)
		elseif select() and wheel.lockout<=0 then
            local result=wheel.getSelectedValue()
            --print(result)
			if result~=false and result ~=nil then
                opinion=opinion+result
    			wheel.lockout=0.4
                wheel.setTarget(wheel.sliceRot+math.pi/2)
            else
                wheel.shake()
                wheel.lockout=0.3
            end
		end
	end

	wheel.update(dt)
end

function love.draw()
	love.graphics.print("hello worms",30,30)
	love.graphics.print(wheel.sliceRot,30,50)
	love.graphics.print(opinion,30,70)
	wheel.draw()
end

--basic input code I didn't want to rewrite. replace these with whatever you want
keymap={select="z",

        up="up",
        down="down",
        left="left",
        right="right"}

function left(plyr)
    if love.keyboard.isDown(keymap.left) then
        return true
    end
end

function right(plyr)
    if love.keyboard.isDown(keymap.right) then
        return true
    end
end

function select(plyr)
    if love.keyboard.isDown(keymap.select) then
        return true
    end
end