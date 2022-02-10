II = {chess = {},partI = {}}
	POINTSlib = {} --сделать для появления доп. объектов типа movable
chess = II.chess
partI = II.partI
function POINTSlib.load(movable, argmap)
	local lPOINTS = {}

	local lmap = argmap
	for i,v in ipairs (movable) do
		if v.controltype == 'bot' then
		
		if lPOINTS[v.controlarr[1]]==nil then lPOINTS[v.controlarr[1]] = {} end
		
		local P = lPOINTS[v.controlarr[1]] --рассматриваем массив класса
			
			if P[v.controlarr[2]]==nil then
				P[v.controlarr[2]]={}
				for i_x = 1, lmap.mapX do 
					table.insert(P[v.controlarr[2]],{})
					for i_y = 1, lmap.mapY do 
					table.insert(P[v.controlarr[2]][i_x],0)
				end end
			end
			lPOINTS [v.controlarr[1]] = P
		end
	end
	return lPOINTS
end
function POINTSlib.loadO ()
	return {0}
end
function POINTSlib.patf (x_target, y_target, speed_target, argmovable, argPOINTS)
	local lPOINTS = argPOINTS
	local lmovable = argmovable 
	for ic,vc in pairs(lPOINTS) do
		for it,vt in pairs(vc) do
			if II[ic].patf then vt = II[ic].patf (x_target, y_target, vt, map, it, 50) end
		end
	end
		
	for i,v in ipairs(lmovable) do
		if v.controltype=='bot' then
			local P = lPOINTS[v.controlarr[1]]
			v.controlarr[3] = P[v.controlarr[2]]
		end
	end
	return {P = lPOINTS, M = lmovable}
end
function chess.patf(x,y,argpoints,mapp,argtype,argmultyspeed)
	local mapX = level.map.mapX
	local mapY = level.map.mapY
	local function M(arg) 
		if arg-argmultyspeed>0 then
			return math.ceil((arg)/level.ts) --not trash yet 
		else 
			return math.ceil (arg/level.ts)
		end
	end
	map=mapp
	local obstructions = {}
	for i=1,mapX do 
		table.insert (obstructions,{})
		for i2=1,mapY do
			table.insert (obstructions[i], level.map.cells[i][i2].obstruction)
		end
	end
	local points=argpoints
	local function point (xv, yv)
		if xv<mapX and mapY<mapX and mapX>0 and mapY>0 then 
			if points[xv][yv]==0 and not obstructions[xv][yv] then points[xv][yv]=i end
		end
	end
	
	 
	if points[M(x)+1][M(y)+1]~=1 then 
		for i=1,mapX,1 do for v=1,mapY,1 do points[i][v]=0 end end 
	end
	
	if math.ceil(x/level.ts)<mapX and y<mapY*level.ts then 
		points[M(x)+1][M(y)+1]=1
	end
	for i=1,400,1 do
		for xv=1,mapX do for yv=1,mapY do
			if points[xv][yv]==i then 
		
				if argtype == 'standart' then
						if xv<mapX and points[xv+1][yv]==0 and obstructions[xv+1][yv]==0 then points[xv+1][yv]=i+1 end						
						if xv>1 and points[xv-1][yv]==0 and  obstructions[xv-1][yv]==0 then points[xv-1][yv]=i+1 end
						if yv<mapY and points[xv][yv+1]==0 and  obstructions[xv][yv+1]==0 then points[xv][yv+1]=i+1 end
						if yv>1 and points[xv][yv-1]==0 and  obstructions[xv][yv-1]==0 then points[xv][yv-1]=i+1 end
	
				elseif argtype == 'chessbishop' then

					if xv<mapX and yv<mapY and points[xv+1][yv+1]==0 and  obstructions[xv+1][yv+1]==0 then points[xv+1][yv+1]=i+1 end
					if xv<mapX and yv-1>0 and points[xv+1][yv-1]==0 and  obstructions[xv+1][yv-1]==0 then points[xv+1][yv-1]=i+1 end
					if yv-1>0 and  xv-1>0 and points[xv-1][yv-1]==0 and  obstructions[xv-1][yv-1]==0 then points[xv-1][yv-1]=i+1 end
					if yv<mapY and xv-1>0 and points[xv-1][yv+1]==0 and  obstructions[xv-1][yv+1]==0 then points[xv-1][yv+1]=i+1 end
					
				elseif argtype == 'chessknight' then
					if yv+2<mapY then
						if xv+1<mapX and points[xv+1][yv+2]==0 and  obstructions[xv+1][yv+2]==0 then points[xv+1][yv+2]=i+1 end
						if xv-1>0 and points[xv-1][yv+2]==0 and  obstructions[xv-1][yv+2]==0 then points[xv-1][yv+2]=i+1 end 
					end

					if yv+1<mapY then
						if xv+2<mapX and points[xv+2][yv+1]==0 and  obstructions[xv+2][yv+1]==0 then points[xv+2][yv+1]=i+1 end
						if xv-2>0 and points[xv-2][yv+1]==0 and  obstructions[xv-2][yv+1]==0 then points[xv-2][yv+1]=i+1 end 
					end

					if yv-1>0 then
						if xv+2<mapX and points[xv+2][yv-1]==0 and  obstructions[xv+2][yv-1]==0 then points[xv+2][yv-1]=i+1 end
						if xv-2>0 and points[xv-2][yv-1]==0 and  obstructions[xv-2][yv-1]==0 then points[xv-2][yv-1]=i+1 end 
					end

					if yv-2>0 then
						if xv+1<mapX and points[xv+1][yv-2]==0 and  obstructions[xv+1][yv-2]==0 then points[xv+1][yv-2]=i+1 end
						if xv-1>0 and points[xv-1][yv-2]==0 and  obstructions[xv-1][yv-2]==0 then points[xv-1][yv-2]=i+1 end 
					end

				end
			end
		end end
	end
	return (points)
end

function chess.direct(bot,arg_controls)
	local map = level.map
	local ts = level.ts
	local points = arg_controls[3]
	local argtype=arg_controls[2]
	local mapX = map.mapX local mapY = map.mapY
	local bot=bot
	local X = bot.x/ts+1
	local Y = bot.y/ts+1
	local fX = bot.x
	local fY = bot.y
	local function Boo() bot.moving = true 
		local targetY = bot.targetY
		local targetX = bot.targetX
		if fY>=targetY then 
			if fX<=targetX then bot.moveDirection = 1 return
			elseif fX>targetX then bot.moveDirection = 2 return end 
		elseif fY<targetY then
			if fX<=targetX then bot.moveDirection = 1 return
			elseif fX>targetX then bot.moveDirection = 2 return end 
		end		
	end
	if not bot.movingI and X%1==0 and Y%1==0 then

	local i=points[X][Y]
	
		if argtype=='standart' then
				if X<mapX and points[X+1][Y]==i-1 and points[X+1][Y]~=0 then bot.targetX=(X+1-1)*ts bot.targetY=(Y-1)*ts bot.moving=true bot.moveDirection=1 end
				if X-1>0 and points[X-1][Y]==i-1 and points[X-1][Y]~=0 then bot.targetX=(X-1-1)*ts bot.targetY=(Y-1)*ts bot.moving=true bot.moveDirection=2 end

				if Y<mapY and points[X][Y+1]==i-1 and points[X][Y+1]~=0 and map.cells[X][Y+1].obstruction==0 then bot.targetX=(X-1)*ts bot.targetY=(Y+1-1)*ts bot.moving=true bot.moveDirection=3 end
				if Y-1>0 and points[X][Y-1]==i-1 and points[X][Y-1]~=0 then bot.targetX=(X-1)*ts bot.targetY=(Y-1-1)*ts bot.moving=true bot.moveDirection=4 end

		elseif argtype=='chessknight' then 
		
			if Y+2<mapY then
				if X+1<mapX and points[X+1][Y+2]==i-1 and points[X+1][Y+2]~=0 then bot.targetX=(X+1-1)*ts bot.targetY=(Y+2-1)*ts Boo() end
				if X-1>0 and points[X-1][Y+2]==i-1 and points[X-1][Y+2]~=0 then bot.targetX=(X-1-1)*ts bot.targetY=(Y+2-1)*ts Boo() end end

			if Y+1<mapY then
				if X+2<mapX and points[X+2][Y+1]==i-1 and points[X+2][Y+1]~=0 then bot.targetX=(X+2-1)*ts bot.targetY=(Y+1-1)*ts Boo() end
				if X-2>0 and points[X-2][Y+1]==i-1 and points[X-2][Y+1]~=0 then bot.targetX=(X-2-1)*ts bot.targetY=(Y+1-1)*ts Boo() end end

			if Y-1>0 then
				if X+2<mapX and points[X+2][Y-1]==i-1 and points[X+2][Y-1]~=0 then bot.targetX=(X+2-1)*ts bot.targetY=(Y-1-1)*ts Boo() end
				if X-2>0 and points[X-2][Y-1]==i-1 and points[X-2][Y-1]~=0 then bot.targetX=(X-2-1)*ts bot.targetY=(Y-1-1)*ts Boo() end end

			if Y-2>0 then
				if X+1<mapX and points[X+1][Y-2]==i-1 and points[X+1][Y-2]~=0 then bot.targetX=(X+1-1)*ts bot.targetY=(Y-2-1)*ts Boo() end
				if X-1>0 and points[X-1][Y-2]==i-1 and points[X-1][Y-2]~=0 then bot.targetX=(X-1-1)*ts bot.targetY=(Y-2-1)*ts Boo() end end
		
		elseif argtype=='chessbishop' then

			if Y<mapY then
				if X<mapX and points[X+1][Y+1]==i-1 and points[X+1][Y+1]~=0 then bot.targetX=(X+1-1)*ts bot.targetY=(Y+1-1)*ts Boo() end
				if X-1>1 and points[X-1][Y+1]==i-1 and points[X-1][Y+1]~=0 then bot.targetX=(X-1-1)*ts bot.targetY=(Y+1-1)*ts Boo() end end

			if Y-1>0 then
				if X-1>0 and points[X-1][Y-1]==i-1 and points[X-1][Y-1]~=0 then bot.targetX=(X-1-1)*ts bot.targetY=(Y-1-1)*ts Boo() end
				if X<mapX and points[X+1][Y-1]==i-1 and points[X+1][Y-1]~=0 then bot.targetX=(X+1-1)*ts bot.targetY=(Y-1-1)*ts Boo() end end
			
		end
	end
	
	return (bot)
end
function partI.direct(argbot,arg_control,axis)
	local ts = level.ts
	mapX = level.map.mapX mapY = level.map.mapY
	local bot=argbot
	local X = bot.x/ts+1
	local Y = bot.y/ts+1
	if axis.x==nil or axis.y==nil then axis={} axis.x=8 axis.y=7 end --
	if X<=axis.x and Y>axis.y then bot.moveDirection=1 bot.targetX=bot.x+ts bot.targetY=bot.y
	elseif X>=axis.x and Y<axis.y then bot.moveDirection=2 bot.targetX=bot.x-ts bot.targetY=bot.y
	elseif X<axis.x and Y<=axis.y+1 then bot.moveDirection=3 bot.targetX=bot.x bot.targetY=bot.y+ts
	elseif X>axis.x and Y>=axis.y then bot.moveDirection=4 bot.targetX=bot.x bot.targetY=bot.y-ts end
	bot.moving=true
	return (bot)
end
function foolMove(bot)
	if not bot.movingI then
	if bot.x<(mapX-1)*ts and variableside%10<5 then --bot.x=bot.x+ts
		bot.targetX=bot.x+ts bot.moveDirection=1 bot.movingI=true
	elseif bot.x>0 and variableside%10>=5 then --bot.x=bot.x-ts
		bot.targetX=bot.x-ts bot.moveDirection=2 bot.movingI=true
	elseif bot.y<mapY*ts and variableside==0 then --bot.y=bot.y+ts
		bot.targetX=bot.y+ts bot.moveDirection=3 bot.movingI=true
	elseif bot.y>0 and variableside==0 then --bot.y=bot.y-ts
		bot.targetX=bot.y-ts bot.moveDirection=4 bot.movingI=true
	end	
	end
	return bot
end
function mazeMove(bot)
	if bot.special=='r' then
		if not bot.movingI then
			if bot.moveDirection==1 and obstructions(bot.x/ts+1,bot.y/ts+2) then
				if not obstructions(bot.x/ts,bot.y/ts+2) then
					bot.targetX=bot.y+ts bot.movingI = true bot.moveDirection=3 return bot
				end
			elseif bot.moveDirection==2 and obstructions(bot.x/ts+1,bot.y/ts) then
				if not obstructions(bot.x/ts+2,bot.y/ts) then
					bot.targetX=bot.y-ts bot.movingI = true bot.moveDirection=4 return bot
				end
			elseif bot.moveDirection==3 and obstructions(bot.x/ts,bot.y/ts+1) then
				if not obstructions(bot.x/ts,bot.y/ts) then
					bot.targetX=bot.x-ts bot.movingI = true bot.moveDirection=2 return bot
				end
			elseif bot.moveDirection==4 and obstructions(bot.x/ts+2,bot.y/ts+1) then
				if not obstructions(bot.x/ts+2,bot.y/ts+2) then
					bot.targetX=bot.x+ts bot.movingI = true bot.moveDirection=1 return bot
				end
			end
			if (bot.moveDirection==1 or b) and bot.x<(level.mapX-2)*ts and not obstructions(bot.x/ts+1,bot.y/ts+2) and obstructions(bot.x/ts+2,bot.y/ts+1) then 
				bot.targetX=bot.x+ts bot.movingI = true bot.moveDirection=1 --bot.points[bot.x/ts+1,bot.y/ts+1)=1 
			elseif (bot.moveDirection==2 or b) and not obstructions(bot.x/ts+1,bot.y/ts) and bot.x>ts and obstructions(bot.x/ts,bot.y/ts+1) then
				bot.targetX=bot.x-ts bot.movingI = true bot.moveDirection=2 --bot.points[bot.x/ts+1,bot.y/ts+1)=1
			elseif (bot.moveDirection==3 or b) and bot.y<(mapY-2)*ts and not obstructions(bot.x/ts,bot.y/ts+1) and obstructions(bot.x/ts+1,bot.y/ts+2) then
				bot.targetX=bot.y+ts bot.movingI = true bot.moveDirection=3 --bot.points[bot.x/ts+1,bot.y/ts+1)=1
			elseif (bot.moveDirection==4 or b) and bot.y<((mapY-1)*ts) and not obstructions(bot.x/ts+2,bot.y/ts+1) and obstructions(bot.x/ts+1,bot.y/ts) then
				bot.targetX=bot.y-ts bot.movingI = true bot.moveDirection=4 --bot.points[bot.x/ts+1,bot.y/ts+1)=1
			elseif not b then bot.moveDirection = 0 return bot
			end	
		end
	elseif bot.special=='l' then 
		if not bot.movingI then
			if bot.moveDirection==2 or b and obstructions(bot.x/ts+1,bot.y/ts+2) then
				if not obstructions(bot.x/ts,bot.y/ts+2) then
					bot.targetX=bot.y+ts bot.movingI = true bot.moveDirection=3 return bot
				end
			elseif bot.moveDirection==1 or b and obstructions(bot.x/ts+1,bot.y/ts) then
				if not obstructions(bot.x/ts+2,bot.y/ts) then
					bot.targetX=bot.y-ts bot.movingI = true bot.moveDirection=4 return bot
				end
			elseif bot.moveDirection==4 or b and obstructions(bot.x/ts,bot.y/ts+1) then
				if not obstructions(bot.x/ts,bot.y/ts) then
					bot.targetX=bot.x-ts bot.movingI = true bot.moveDirection=2 return bot
				end
			elseif bot.moveDirection==3 or b and obstructions(bot.x/ts+2,bot.y/ts+1) then
				if not obstructions(bot.x/ts+2,bot.y/ts+2) then
					bot.targetX=bot.x+ts bot.movingI = true bot.moveDirection=1 return bot
				end
			elseif not b then bot.moveDirection = 0 return bot			
			end
			-- if (bot.moveDirection==1 or b) and bot.x<(level.mapX-2)*ts and not obstructions(bot.x/ts+1,bot.y/ts+2) and obstructions(bot.x/ts+2,bot.y/ts+1) then 
				-- bot.targetX=bot.x+ts bot.movingI = true bot.moveDirection=1 --bot.points[bot.x/ts+1,bot.y/ts+1)=1 
			-- elseif (bot.moveDirection==2 or b) and not obstructions(bot.x/ts+1,bot.y/ts) and bot.x>ts and obstructions(bot.x/ts,bot.y/ts+1) then
				-- bot.targetX=bot.x-ts bot.movingI = true bot.moveDirection=2 --bot.points[bot.x/ts+1,bot.y/ts+1)=1
			-- elseif (bot.moveDirection==3 or b) and bot.y<(mapY-2)*ts and not obstructions(bot.x/ts,bot.y/ts+1) and obstructions(bot.x/ts+1,bot.y/ts+2) then
				-- bot.targetX=bot.y+ts bot.movingI = true bot.moveDirection=3 --bot.points[bot.x/ts+1,bot.y/ts+1)=1
			-- elseif (bot.moveDirection==4 or b) and bot.y<((mapY-1)*ts) and not obstructions(bot.x/ts+2,bot.y/ts+1) and obstructions(bot.x/ts+1,bot.y/ts) then
				-- bot.targetX=bot.y-ts bot.movingI = true bot.moveDirection=4 --bot.points[bot.x/ts+1,bot.y/ts+1)=1
			-- elseif not b then bot.moveDirection = 0 return bot
			-- end	
		end		
	end
	return bot
end	
function II.strengthMax (arrs)
	local function defineStrength(arr,num) return (num) --trash
	end
	local t = arrs[1]
	for i,v in ipairs(arrs) do
		if defineStrength(v,i)>defineStrength(t,i) then t = v end
	end
	return arrs[1]
end