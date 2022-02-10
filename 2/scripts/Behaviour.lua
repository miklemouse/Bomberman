function patf(x,y,argpoints,mapp,argtype,argmultyspeed)
	local function M(arg) 
		if arg-argmultyspeed>0 then
			return math.ceil((arg-argmultyspeed)/ts)
		else 
			return math.ceil (arg/ts)
		end
	end
	local points=argpoints
	local function point (xv, yv)
		if xv<mapX and mapY<mapX and mapX>0 and mapY>0 then 
			if points[xv][yv]==0 and not obstructions(xv,yv) then points[xv][yv]=i end
		end
	end
	map=mapp
		
	
	 
	if points[M(x)+1][M(y)+1]~=1 then 
		for i=1,mapX,1 do for v=1,mapY,1 do points[i][v]=0 end end 
	end
	
	if math.ceil(x/ts)<mapX and y<mapY*ts then 
		points[M(x)+1][M(y)+1]=1
	end
	for i=1,400,1 do
		for xv=1,mapX,1 do for yv=1,mapY,1 do
			if points[xv][yv]==i then 
		
				if argtype == 'standart' then
						if xv<mapX and points[xv+1][yv]==0 and not obstructions(xv+1,yv) then points[xv+1][yv]=i+1 end						
						if xv>1 and points[xv-1][yv]==0 and not obstructions(xv-1,yv) then points[xv-1][yv]=i+1 end
						if yv<mapY and points[xv][yv+1]==0 and not obstructions(xv,yv+1) then points[xv][yv+1]=i+1 end
						if yv>1 and points[xv][yv-1]==0 and not obstructions(xv,yv-1) then points[xv][yv-1]=i+1 end
	
				elseif argtype == 'chessbishop' then

					if xv<mapX and yv<mapY and points[xv+1][yv+1]==0 and not obstructions(xv+1,yv+1) then points[xv+1][yv+1]=i+1 end
					if xv<mapX and yv-1>0 and points[xv+1][yv-1]==0 and not obstructions(xv+1,yv-1) then points[xv+1][yv-1]=i+1 end
					if yv-1>0 and  xv-1>0 and points[xv-1][yv-1]==0 and not obstructions(xv-1,yv-1) then points[xv-1][yv-1]=i+1 end
					if yv<mapY and xv-1>0 and points[xv-1][yv+1]==0 and not obstructions(xv-1,yv+1) then points[xv-1][yv+1]=i+1 end
					
				elseif argtype == 'chessknight' then
					if yv+2<mapY then
						if xv+1<mapX and points[xv+1][yv+2]==0 and not obstructions(xv+1,yv+2) then points[xv+1][yv+2]=i+1 end
						if xv-1>0 and points[xv-1][yv+2]==0 and not obstructions(xv-1,yv+2) then points[xv-1][yv+2]=i+1 end 
					end

					if yv+1<mapY then
						if xv+2<mapX and points[xv+2][yv+1]==0 and not obstructions(xv+2,yv+1) then points[xv+2][yv+1]=i+1 end
						if xv-2>0 and points[xv-2][yv+1]==0 and not obstructions(xv-2,yv+1) then points[xv-2][yv+1]=i+1 end 
					end

					if yv-1>0 then
						if xv+2<mapX and points[xv+2][yv-1]==0 and not obstructions(xv+2,yv-1) then points[xv+2][yv-1]=i+1 end
						if xv-2>0 and points[xv-2][yv-1]==0 and not obstructions(xv-2,yv-1) then points[xv-2][yv-1]=i+1 end 
					end

					if yv-2>0 then
						if xv+1<mapX and points[xv+1][yv-2]==0 and not obstructions(xv+1,yv-2) then points[xv+1][yv-2]=i+1 end
						if xv-1>0 and points[xv-1][yv-2]==0 and not obstructions(xv-1,yv-2) then points[xv-1][yv-2]=i+1 end 
					end

				end
			end
		end end
	end
	return (points)
end
function knightmove(xx,yy,points,bot)
	--local bot={x3=bot.xI,yI=bot.yI}
	local X = bot.xI/ts+1
	local Y = bot.yI/ts+1
	local fX = bot.xI
	local fY = bot.yI
	boo = false
	local function Boo() bot.movingI = true 
		local targetY = bot.botvars.targetYI
		local targetX = bot.targetI
		if fY>targetY then 
			if fX<targetX then bot.moveDirectionI = 1 
			elseif fX>targetX then bot.moveDirectionI = 4 end 
		elseif fY<targetY then
			if fX<targetX then bot.moveDirectionI = 3 
			elseif fX>targetX then bot.moveDirectionI = 2 end
		end
		
	end
	if bot.xI~=xx or bot.yI~=yy then
		if not bot.movingI and X%1==0 and Y%1==0 then 
		
			local i=points[X][Y]

			if Y+2<mapY then
				if X+1<mapX and points[X+1][Y+2]==i-1  then bot.targetI=(X+1-1)*ts bot.botvars.targetYI=(Y+2-1)*ts Boo() end
				if X-1>0 and points[X-1][Y+2]==i-1  then bot.targetI=(X-1-1)*ts bot.botvars.targetYI=(Y+2-1)*ts Boo() end end

			if Y+1<mapY then
				if X+2<mapX and points[X+2][Y+1]==i-1  then bot.targetI=(X+2-1)*ts bot.botvars.targetYI=(Y+1-1)*ts Boo() end
				if X-2>0 and points[X-2][Y+1]==i-1  then bot.targetI=(X-2-1)*ts bot.botvars.targetYI=(Y+1-1)*ts Boo() end end

			if Y-1>0 then
				if X+2<mapX and points[X+2][Y-1]==i-1  then bot.targetI=(X+2-1)*ts bot.botvars.targetYI=(Y-1-1)*ts Boo() end
				if X-2>0 and points[X-2][Y-1]==i-1  then bot.targetI=(X-2-1)*ts bot.botvars.targetYI=(Y-1-1)*ts Boo() end end

			if Y-2>0 then
				if X+1<mapX and points[X+1][Y-2]==i-1  then bot.targetI=(X+1-1)*ts bot.botvars.targetYI=(Y-2-1)*ts Boo() end
				if X-1>0 and points[X-1][Y-2]==i-1  then bot.targetI=(X-1-1)*ts bot.botvars.targetYI=(Y-2-1)*ts Boo() end end
		end
	end
	
	return (bot)
end
function bishopmove (xx,yy,points,bot)
	local X = bot.xI/ts+1
	local Y = bot.yI/ts+1
	local fX = bot.xI
	local fY = bot.yI
	boo = false
	local function Boo() bot.movingI = true 
		local targetY = bot.botvars.targetYI
		local targetX = bot.targetI
		if fY>targetY then 
			if fX<targetX then bot.moveDirectionI = 1 
			elseif fX>targetX then bot.moveDirectionI = 4 end 
		elseif fY<targetY then
			if fX<targetX then bot.moveDirectionI = 3 
			elseif fX>targetX then bot.moveDirectionI = 2 end
		end
		
	end
	if bot.xI~=xx or bot.yI~=yy then
		if not bot.movingI then 
			local i=points[X][Y]

			if Y<mapY then
				if X<=mapX and points[X+1][Y+1]==i-1  then bot.targetI=(X+1-1)*ts bot.botvars.targetYI=(Y+1-1)*ts Boo() end
				if X-1>=1 and points[X-1][Y+1]==i-1  then bot.targetI=(X-1-1)*ts bot.botvars.targetYI=(Y+1-1)*ts Boo() end end

			if Y-1>0 then
				if X-1>0 and points[X-1][Y-1]==i-1  then bot.targetI=(X-1-1)*ts bot.botvars.targetYI=(Y-1-1)*ts Boo() end
				if X<=mapX and points[X+1][Y-1]==i-1  then bot.targetI=(X+1-1)*ts bot.botvars.targetYI=(Y-1-1)*ts Boo() end end
		end
	end
	
	return (bot)
end

function move(xx,yy,points,bot)
	--local bot={x3=bot.xI,yI=bot.yI}
	if bot.xI~=xx or bot.yI~=yy then
		if not bot.movingI then
		i=points[(bot.xI)/ts+1][(bot.yI)/ts+1] 
			if bot.xI<(mapX-1)*ts and points[bot.xI/ts+2][bot.yI/ts+1]==i-1 and points[bot.xI/ts+2][bot.yI/ts+1]~=0 then --bot.xI=bot.xI+ts
				bot.targetI=bot.xI+ts bot.moveDirectionI=1 bot.movingI=true
			elseif bot.xI>0 and points[bot.xI/ts][bot.yI/ts+1]==i-1 and points[bot.xI/ts][bot.yI/ts+1]~=0 then --bot.xI=bot.xI-ts
				bot.targetI=bot.xI-ts bot.moveDirectionI=2 bot.movingI=true
			elseif bot.yI<mapY*ts and points[bot.xI/ts+1][bot.yI/ts+2]==i-1 and points[bot.xI/ts+1][bot.yI/ts+2]~=0 then --bot.yI=bot.yI+ts 
				bot.targetI=bot.yI+ts bot.moveDirectionI=3 bot.movingI=true
			elseif bot.yI>0 and points[bot.xI/ts+1][bot.yI/ts]==i-1 and points[bot.xI/ts+1][bot.yI/ts]~=0 then --bot.yI=bot.yI-ts
				bot.targetI=bot.yI-ts bot.moveDirectionI=4 bot.movingI=true
			end
		end
	end
	return (bot)
end
function foolMove(bot)
	if not bot.movingI then
	if bot.xI<(mapX-1)*ts and variableside%10<5 then --bot.xI=bot.xI+ts
		bot.targetI=bot.xI+ts bot.moveDirectionI=1 bot.movingI=true
	elseif bot.xI>0 and variableside%10>=5 then --bot.xI=bot.xI-ts
		bot.targetI=bot.xI-ts bot.moveDirectionI=2 bot.movingI=true
	elseif bot.yI<mapY*ts and variableside==0 then --bot.yI=bot.yI+ts
		bot.targetI=bot.yI+ts bot.moveDirectionI=3 bot.movingI=true
	elseif bot.yI>0 and variableside==0 then --bot.yI=bot.yI-ts
		bot.targetI=bot.yI-ts bot.moveDirectionI=4 bot.movingI=true
	end	
	end
	return bot
end

function mazeMove(bot)
	if bot.special=='r' then
		if not bot.movingI then
			if bot.moveDirectionI==1 and obstructions(bot.xI/ts+1,bot.yI/ts+2) then
				if not obstructions(bot.xI/ts,bot.yI/ts+2) then
					bot.targetI=bot.yI+ts bot.movingI = true bot.moveDirectionI=3 return bot
				end
			elseif bot.moveDirectionI==2 and obstructions(bot.xI/ts+1,bot.yI/ts) then
				if not obstructions(bot.xI/ts+2,bot.yI/ts) then
					bot.targetI=bot.yI-ts bot.movingI = true bot.moveDirectionI=4 return bot
				end
			elseif bot.moveDirectionI==3 and obstructions(bot.xI/ts,bot.yI/ts+1) then
				if not obstructions(bot.xI/ts,bot.yI/ts) then
					bot.targetI=bot.xI-ts bot.movingI = true bot.moveDirectionI=2 return bot
				end
			elseif bot.moveDirectionI==4 and obstructions(bot.xI/ts+2,bot.yI/ts+1) then
				if not obstructions(bot.xI/ts+2,bot.yI/ts+2) then
					bot.targetI=bot.xI+ts bot.movingI = true bot.moveDirectionI=1 return bot
				end
			end
			if (bot.moveDirectionI==1 or b) and bot.xI<(level.mapX-2)*ts and not obstructions(bot.xI/ts+1,bot.yI/ts+2) and obstructions(bot.xI/ts+2,bot.yI/ts+1) then 
				bot.targetI=bot.xI+ts bot.movingI = true bot.moveDirectionI=1 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1 
			elseif (bot.moveDirectionI==2 or b) and not obstructions(bot.xI/ts+1,bot.yI/ts) and bot.xI>ts and obstructions(bot.xI/ts,bot.yI/ts+1) then
				bot.targetI=bot.xI-ts bot.movingI = true bot.moveDirectionI=2 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1
			elseif (bot.moveDirectionI==3 or b) and bot.yI<(mapY-2)*ts and not obstructions(bot.xI/ts,bot.yI/ts+1) and obstructions(bot.xI/ts+1,bot.yI/ts+2) then
				bot.targetI=bot.yI+ts bot.movingI = true bot.moveDirectionI=3 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1
			elseif (bot.moveDirectionI==4 or b) and bot.yI<((mapY-1)*ts) and not obstructions(bot.xI/ts+2,bot.yI/ts+1) and obstructions(bot.xI/ts+1,bot.yI/ts) then
				bot.targetI=bot.yI-ts bot.movingI = true bot.moveDirectionI=4 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1
			elseif not b then bot.moveDirectionI = 0 return bot
			end	
		end
	elseif bot.special=='l' then 
		if not bot.movingI then
			if bot.moveDirectionI==2 or b and obstructions(bot.xI/ts+1,bot.yI/ts+2) then
				if not obstructions(bot.xI/ts,bot.yI/ts+2) then
					bot.targetI=bot.yI+ts bot.movingI = true bot.moveDirectionI=3 return bot
				end
			elseif bot.moveDirectionI==1 or b and obstructions(bot.xI/ts+1,bot.yI/ts) then
				if not obstructions(bot.xI/ts+2,bot.yI/ts) then
					bot.targetI=bot.yI-ts bot.movingI = true bot.moveDirectionI=4 return bot
				end
			elseif bot.moveDirectionI==4 or b and obstructions(bot.xI/ts,bot.yI/ts+1) then
				if not obstructions(bot.xI/ts,bot.yI/ts) then
					bot.targetI=bot.xI-ts bot.movingI = true bot.moveDirectionI=2 return bot
				end
			elseif bot.moveDirectionI==3 or b and obstructions(bot.xI/ts+2,bot.yI/ts+1) then
				if not obstructions(bot.xI/ts+2,bot.yI/ts+2) then
					bot.targetI=bot.xI+ts bot.movingI = true bot.moveDirectionI=1 return bot
				end
			elseif not b then bot.moveDirectionI = 0 return bot			
			end
			-- if (bot.moveDirectionI==1 or b) and bot.xI<(level.mapX-2)*ts and not obstructions(bot.xI/ts+1,bot.yI/ts+2) and obstructions(bot.xI/ts+2,bot.yI/ts+1) then 
				-- bot.targetI=bot.xI+ts bot.movingI = true bot.moveDirectionI=1 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1 
			-- elseif (bot.moveDirectionI==2 or b) and not obstructions(bot.xI/ts+1,bot.yI/ts) and bot.xI>ts and obstructions(bot.xI/ts,bot.yI/ts+1) then
				-- bot.targetI=bot.xI-ts bot.movingI = true bot.moveDirectionI=2 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1
			-- elseif (bot.moveDirectionI==3 or b) and bot.yI<(mapY-2)*ts and not obstructions(bot.xI/ts,bot.yI/ts+1) and obstructions(bot.xI/ts+1,bot.yI/ts+2) then
				-- bot.targetI=bot.yI+ts bot.movingI = true bot.moveDirectionI=3 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1
			-- elseif (bot.moveDirectionI==4 or b) and bot.yI<((mapY-1)*ts) and not obstructions(bot.xI/ts+2,bot.yI/ts+1) and obstructions(bot.xI/ts+1,bot.yI/ts) then
				-- bot.targetI=bot.yI-ts bot.movingI = true bot.moveDirectionI=4 --bot.points[bot.xI/ts+1,bot.yI/ts+1)=1
			-- elseif not b then bot.moveDirectionI = 0 return bot
			-- end	
		end		
	end
	return bot
end	