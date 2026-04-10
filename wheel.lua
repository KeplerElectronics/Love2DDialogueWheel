local pi=math.pi

wheel={	x,y,sliceRot=pi/4,
		target=pi/4,canMove=true,
		lockout=0,
		shaking=false,

		selectDir=3,
		selectTar=3,

		bg={w,h,rot=0,img},
		slice={	{w,h,img,res,selected=false},
				{w,h,img,res,selected=false},
				{w,h,img,res,selected=false},
				{w,h,img,res,selected=false}
		}
}

function wheel.setBG(path)
	wheel.bg.img=love.graphics.newImage(path)
	wheel.bg.w,wheel.bg.h=wheel.bg.img:getDimensions()
end

function wheel.setSliceImg(num,path)
	wheel.slice[num].img=love.graphics.newImage(path)
	wheel.slice[num].w,wheel.slice[num].h=wheel.slice[num].img:getDimensions()
end

function wheel.setSliceResult(num,val)
	wheel.slice[num].res=val
end

function wheel.setPos(x,y)
	wheel.x=x
	wheel.y=y
end

function wheel.update(dt)
	if wheel.shaking==true then
		wheel.sliceRot=wheel.sliceRot+math.sin(love.timer.getTime())*20
	end

	if wheel.target~=nil then
		if math.abs(wheel.target-wheel.sliceRot)>0.002 then
			wheel.canMove=false
			wheel.sliceRot=wheel.lerp(wheel.sliceRot,wheel.target,10,dt)
		else
			wheel.canMove=true
		end
	else
		wheel.canMove=true
	end

	if wheel.selectTar~=nil then
		if math.abs(wheel.selectTar-wheel.selectDir)>0.002 then
			wheel.canMove=false
			wheel.selectDir=wheel.lerp(wheel.selectDir,wheel.selectTar,10,dt)
		else
			wheel.canMove=true
		end
	else
		wheel.canMove=true
	end

	if wheel.canMove==true then
		if wheel.sliceRot>2*pi then
			wheel.sliceRot=wheel.sliceRot-2*pi
			wheel.target=wheel.target-2*pi
		elseif wheel.sliceRot<0 then
			wheel.sliceRot=wheel.sliceRot+2*pi
			wheel.target=wheel.target+2*pi
		end
	end

	if wheel.lockout>0 then 
		wheel.lockout=wheel.lockout-dt
		wheel.shaking=false
	end

end

function wheel.draw()

	love.graphics.draw(wheel.bg.img,wheel.x-wheel.bg.w,wheel.y-wheel.bg.h,wheel.rot)
	
	for i=1,4 do
		if wheel.slice[i].img~=nil then
			if wheel.slice[i].selected==true then
				love.graphics.setColor(love.math.colorFromBytes(30,30,30))
			end
			love.graphics.draw(wheel.slice[i].img,wheel.x-wheel.slice[i].w,wheel.y-wheel.slice[i].h,wheel.sliceRot-pi*i/2-pi/2)
			wheel.resDraw()
		end
	end

	love.graphics.circle("fill", wheel.x-wheel.bg.w/2+math.cos(wheel.selectDir*pi/2)*200,wheel.y-wheel.bg.h/2+math.sin(wheel.selectDir*pi/2)*200,30)
end

function wheel.getSelectedValue()
	local sel=0
	local rotationOffset=(wheel.sliceRot)/(pi/2)

	print("rotoff: "..rotationOffset)

	sel=wheel.selectDir

	sel=math.floor(-sel+rotationOffset)
	while sel>4 do
		sel=sel-4
	end
	while sel<1 do
		sel=sel+4
	end

	--print("Sel: "..sel)

	if wheel.slice[sel].selected==true then
		return false
	else
		wheel.slice[sel].selected=true
		return wheel.slice[sel].res
	end
end

function wheel.shake()
	wheel.shaking=true
end

function wheel.setTarget(target)
	if wheel.canMove==false then return end

	wheel.target=target
end

function wheel.selectTarget(target)
	if wheel.canMove==false then return end

	wheel.selectTar=wheel.selectTar+target
end

function wheel.lerp(a,b,t,dt) 
    return (b+(a-b)*math.exp(-t*dt))
    --Freya Holmer
end

function wheel.resDraw()
	love.graphics.setColor(love.math.colorFromBytes(255,255,255))
end