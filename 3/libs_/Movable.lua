movableLib = {}

function movableLib.new (controltype,controlarr,Argimages,ts,x,y,a_varsides)
	local movevars = {moving = false,speed = ts*1,moveDirection = 0,targetX = 50,targetY = 0,x=x,y=y} --trash
	local bombsvars = {bombs = 1,maxBombs = 1,detonator = 3,ft = 1, range = 1} --trash
	local sports = {bascetball = false, football = false}
	--local footballvars = {football = false, targetS = 0,footCount = 0,footS = 0}
	local LImages = {}
	local Lmovable = {}
	if controltype~='float' then LImages = imageLib.loadImages(Argimages) else LImages = Argimages end
	
	die = false num = num
	if controltype=='player' then 
		local controlarr = {U=controlarr[1],L=controlarr[2],D=controlarr[3],R=controlarr[4],B=controlarr[5]}
		shitvars = {shit = false,shitT = 10}
		Lmovable = {
			sports=sports, bombsvars=bombsvars, shitvars=shitvars, controlarr=controlarr,
			controltype=controltype, die = false, num=num, movevars = movevars, xI = x/ts+1, yI = y/ts+1
		}
		Lmovable.direct = movableLib.direct
		Lmovable.put = movableLib.put		
	elseif controltype=='bot' then  
		Lmovable = {
			sports=sports, bombsvars=bombsvars, shitvars=shitvars,
			controltype=controltype, die = false, num=num, movevars = movevars, xI = x/ts+1, yI = y/ts+1, controlarr=controlarr
		}
		Lmovable.direct = II[controlarr[1]].direct
		local function side_empty () end --trash
		Lmovable.put = side_empty		
	elseif controltype=='float' then
		Lmovable = {
			movevars = movevars, controlarr = controlarr, controltype = controltype
		}
	end
	--variables
		Lmovable.imageNow = {'SWD',1} Lmovable.images = LImages
		Lmovable.brightness = 2
	if Lmovable.controltype~='float' then --functions
		Lmovable.death = movableLib.death
		Lmovable.condition = movableLib.condition
		Lmovable.develop = movableLib.develop
		Lmovable.setImage = imageLib.setImage
	end
	Lmovable.move = movableLib.move
	if a_varsides then
		Lmovable.varsides = a_varsides 
	else
		Lmovable.varsides = {}
	end
	return Lmovable
end

function movableLib.condition(a_movable)
	return (not a_movable.movevars.moving and level.map.cells.fatals[a_movable.movevars.x/level.ts+1][a_movable.movevars.y/level.ts+1]~=0)
end

function movableLib.death (a_movable)
	a_movable.imageNow = {'SWD',3}
	a_movable.die=true
	return a_movable
end
function movableLib.funbonus (ix,iy,dt) --trash (tobehaviour)
	if not level['arrF'] then level['arrF']={}
		for i=1,level.map.mapX do table.insert(level.arrF,{}) for i2=1,level.map.mapY do 
			table.insert(level.arrF,0) end end
	else
		for i=1,level.map.mapX do for i2=1,level.map.mapY do 
			local function forrecurs (S,S2)
				map[S+1][S2]='Fr'
				map[S-1][S2]='Fl'
				map[S][S2+1]='Fd'
				map[S][S2-1]='Fu'
			end
			forrecurs()
		end end
	end
end
function movableLib.put (a_movable,dt)
	local ts = level.ts
	if not a_movable.movevars.moving and love.keyboard.isDown(a_movable.controlarr.B) then
		if a_movable.bombsvars.bombs>0 and level.map.cells.impermanents[a_movable.movevars.x/ts+1][a_movable.movevars.y/ts+1] == 0 and level.map.cells.tiles[a_movable.movevars.x/ts+1][a_movable.movevars.y/ts+1]~='Bomb' then
			level.map.cells.impermanents[a_movable.movevars.x/ts+1][a_movable.movevars.y/ts+1] = {0,a_movable.bombsvars.detonator,ft = a_movable.bombsvars.ft,range = a_movable.bombsvars.range, Im='Bomb', numB = a_movable.num}
			level.map.cells.impermanents[a_movable.movevars.x/ts+1][a_movable.movevars.y/ts+1].countdown = mapLib.StImpermanent_detonate 
			level.map.cells.obstructions[a_movable.movevars.x/ts+1][a_movable.movevars.y/ts+1] = 1
			level.map.cells.tiles[a_movable.movevars.x/ts+1][a_movable.movevars.y/ts+1] = 'Bomb'
			a_movable.bombsvars.bombs=a_movable.bombsvars.bombs-1
			for i=1,level.map.mapX do for i2=1,level.map.mapY do 
			if level.map.cells.impermanents[i][i2]~=0 then
				if level.map.cells.impermanents[i][i2].numB == a_movable.num and level.map.cells.impermanents[i][i2].range then
					level.map.cells.impermanents[i][i2][1]=0 
					level.map.cells.impermanents[i][i2]['ft']=level.map.cells.impermanents[i][i2]['ft']*0.9
				end
			end
			end end
		
		end
	end
end

function movableLib.develop (a_movable)
	local mychar = level.map.cells.bonuses[a_movable.movevars.x/level.ts+1][a_movable.movevars.y/level.ts+1]
		if mychar=='Boot' then a_movable.movevars.speed = a_movable.movevars.speed+level.ts mychar = 0
		elseif mychar=='Flame' then a_movable.bombsvars.range = a_movable.bombsvars.range+1 mychar = 0
		elseif mychar=='SFlame' then a_movable.bombsvars.range = a_movable.bombsvars.range+10 mychar = 0 --not trash yet
		elseif mychar=='Boom' then a_movable.bombsvars.maxBombs = a_movable.bombsvars.maxBombs+1
			a_movable.bombsvars.bombs = a_movable.bombsvars.bombs+1 mychar = 0
		elseif mychar=='BS' then a_movable.bombsvars.bombs = a_movable.bombsvars.bombs+3 mychar = 0
		elseif mychar=='Shield' then a_movable.shitvars.shit = true mychar = 0 --trash not here 
		elseif mychar=='Detonator' then a_movable.bombsvars.detonator=a_movable.bombsvars.detonator*0.7 a_movable.bombsvars.ft=a_movable.bombsvars.ft*1.1 mychar = 0
		elseif mychar=='BBall' then 
		elseif mychar=='FBall' then 
		end
	level.map.cells.bonuses[a_movable.movevars.x/level.ts+1][a_movable.movevars.y/level.ts+1] = mychar
	return a_movable
end

function movableLib.move (argl_movable,dt)
	local l_movable = argl_movable
	if l_movable.moveDirection~=0 and l_movable.moving then 
		local dx = (l_movable.x-l_movable.targetX)
		local dy = (l_movable.y-l_movable.targetY)
		local local_distance = math.sqrt(dx*dx + dy*dy)
		if local_distance==0 then local_distance = 1 end
		local lx = l_movable.x - l_movable.speed*dt*dx/local_distance
		local ly = l_movable.y - l_movable.speed*dt*dy/local_distance
				
		l_movable.x = lx l_movable.y = ly 
		
		if l_movable.moveDirection==1 and l_movable.x>=l_movable.targetX and l_movable.y<=l_movable.targetY then 
			l_movable.x=l_movable.targetX l_movable.y=l_movable.targetY l_movable.moving=false
		
		elseif l_movable.moveDirection==2 and l_movable.x<=l_movable.targetX and l_movable.y>=l_movable.targetY  then
			l_movable.x=l_movable.targetX l_movable.y=l_movable.targetY l_movable.moving=false					
		
		elseif l_movable.moveDirection==3 and l_movable.x>=l_movable.targetX and l_movable.y>=l_movable.targetY then
			l_movable.x=l_movable.targetX l_movable.y=l_movable.targetY l_movable.moving=false										
		
		elseif l_movable.moveDirection==4 and l_movable.x<=l_movable.targetX and l_movable.y<=l_movable.targetY then
			l_movable.x=l_movable.targetX l_movable.y=l_movable.targetY l_movable.moving=false										
		end
	end
	return l_movable
end
function movableLib.standartBascetball(a_x,a_y,arg)
	local map = level.map
	local ts = level.ts
	local x=(a_x-1)*ts local y=(a_y-1)*ts
				local targX = x/ts+1
				local targY = y/ts+1
			if arg=='R' then
				for i=x/ts+1,level.map.mapX-1 do
					if level.map.cells[i][y/ts+1].obstruction~=0 then targX=targX+1 l_moveDirection=1 else break end
				end
			elseif arg=='L' then
				for i=x/ts+1,1,-1 do
					if level.map.cells.obstructions[i][y/ts+1]~=0 then targX=targX-1 l_moveDirection=2 else break end
				end	
			elseif arg=='D' then
				for i=y/ts+1,level.map.mapY-1 do
					if level.map.cells.obstructions[x/ts+1][i]~=0 then targY=targY+1 l_moveDirection=3 else break end
				end
			elseif arg=='U' then
				for i=y/ts+1,0,-1 do
					if level.map.cells.obstructions[x/ts+1][i]~=0 then targY=targY-1 l_moveDirection=4 else break end
				end			
			end
				local imageF = level.map.mapImages['impermanent'][tostring(level.map.cells[x/ts+1][y/ts+1]['impermanent'].Im)]	
				local cellF={tile = 0, fatal = 0, bonus = 0, allocate = 0, obstruction = 1, enriching = '',impermanent=level.map.cells[x/ts+1][y/ts+1].impermanent}
			
			local floatB = {cellF=cellF, imageF = imageF, fIM=level.map.cells[x/ts+1][y/ts+1].impermanent.Im,movevarsF={x=x,y=y,targetX=(targX-1)*ts,targetY=(targY-1)*ts,moveDirection=l_moveDirection,moving=true,speed=500}} --trash
			floatB.move = movableLib.move
			table.insert(level.map.floats,floatB)
		
		level.map.cells.impermanents[x/ts+1][y/ts+1] = nil
		level.map.cells.obstructions[x/ts+1][y/ts+1] = 0
end

function movableLib.standartFootball(a_x,a_y,arg)
	local map = level.map
	local ts = level.ts
	local x=(a_x-1)*ts local y=(a_y-1)*ts
				local targX = x/ts+1
				local targY = y/ts+1
				local l_moveDirection = 0
			if arg=='R' then
				for i=x/ts+2,level.map.mapX-1 do
					if level.map.cells.obstructions[i][y/ts+1]==0 then targX=targX+1 l_moveDirection=1 else break end
				end
			elseif arg=='L' then
				for i=x/ts,1,-1 do
					if level.map.cells.obstructions[i][y/ts+1]==0 then targX=targX-1 l_moveDirection=2 else break end
				end				
			elseif arg=='D' then
				for i=y/ts+2,level.map.mapY-1 do
					if level.map.cells.obstructions[x/ts+1][i]==0 then targY=targY+1 l_moveDirection=3 else break end
				end
			elseif arg=='U' then
				for i=y/ts,1,-1 do
					if level.map.cells.obstructions[x/ts+1][i]==0 then targY=targY-1 l_moveDirection=4 else break end
				end
			end
				local imageF = level.map.mapImages['impermanent'][tostring(level.map.cells['impermanent'][x/ts+1][y/ts+1].Im)]
				local cellF={tile = 0, fatal = 0, bonus = 0, allocate = 0, obstruction = 1, enriching = '',impermanent=level.map.cells[x/ts+1][y/ts+1].impermanent}
			local floatB = {cellF=cellF, imageF = imageF, fIM=level.map.cells[x/ts+1][y/ts+1].impermanent.Im,movevarsF={x=x,y=y,targetX=(targX-1)*ts,targetY=(targY-1)*ts,moveDirection=l_moveDirection,moving=true,speed=500}} --trash
			floatB.move = movableLib.move
			table.insert(level.map.floats,floatB)
		
		level.map.cells.impermanents[x/ts+1][y/ts+1] = nil
		level.map.cells.obstructions[x/ts+1][y/ts+1] = 0
end
function movableLib.direct (argf_movable,arg_arr,arg_sports)
	local l_movable = argf_movable
	local map = level.map
	local mapX = map.mapX local mapY = map.mapY
	local ts = level.ts
	local keys = arg_arr
	local sports = arg_sports
	local x = l_movable.x local y = l_movable.y
	local xI = l_movable.x/level.ts+1 local yI = l_movable.y/level.ts+1
	
	if love.keyboard.isDown (keys['R']) and x<(mapX-1)*ts and map.cells.obstructions[xI+1][yI]==0 then
		l_movable.targetX = x+ts l_movable.targetY = y
		l_movable.moving = true l_movable.moveDirection = 1
	elseif love.keyboard.isDown (keys.L) and x>0 and map.cells.obstructions[xI-1][yI]==0 then
		l_movable.targetX = x-ts l_movable.targetY = y
		l_movable.moving = true l_movable.moveDirection = 2
	elseif love.keyboard.isDown (keys.D) and y<mapY*ts and map.cells.obstructions[xI][yI+1]==0 then
		l_movable.targetX = x l_movable.targetY = y+ts
		l_movable.moving = true l_movable.moveDirection = 3
	elseif love.keyboard.isDown (keys.U) and y>0 and map.cells.obstructions[xI][yI-1]==0 then
		l_movable.targetX = x l_movable.targetY = y-ts
		l_movable.moving = true l_movable.moveDirection = 4
	end
	
	if sports.bascetball==true then
		if love.keyboard.isDown (keys.R) and x<mapX*ts and map.cells.impermanents[xI+1][yI] and map.cells.impermanents[xI+1][yI].Im=='Bomb' then
			movableLib.standartBascetball(xI+1,yI,'R')
		elseif love.keyboard.isDown (keys.L) and  x>0 and map.cells.impermanents[xI-1][yI] and map.cells.impermanents[xI-1][yI].Im=='Bomb' then
			movableLib.standartBascetball(xI-1,yI,'L')
		elseif love.keyboard.isDown (keys.D) and y<mapY*ts and map.cells.impermanents[xI][yI+1] and map.cells.impermanents[xI][yI+1].Im=='Bomb' then
			movableLib.standartBascetball(xI,yI+1,'D')
		elseif love.keyboard.isDown (keys.U) and y>0 and map.cells.impermanents[xI][yI-1] and map.cells.impermanents[xI][yI-1].Im=='Bomb' then
			movableLib.standartBascetball(xI,yI-1,'U')	
		end
	elseif sports.football==true then
		if love.keyboard.isDown (keys.R) and map.cells.impermanents[xI+1][yI] and map.cells.impermanents[xI+1][yI].Im=='Bomb' then
			movableLib.standartFootball(xI+1,yI,'R')
		elseif love.keyboard.isDown (keys.L) and map.cells.impermanents[xI-1][yI] and map.cells.impermanents[xI-1][yI].Im=='Bomb' then
			movableLib.standartFootball(xI-1,yI,'L')
		elseif love.keyboard.isDown (keys.D) and map.cells.impermanents[xI][yI+1] and map.cells.impermanents[xI][yI+1].Im=='Bomb' then
			movableLib.standartFootball(xI,yI+1,'D')
		elseif love.keyboard.isDown (keys.U) and map.cells.impermanents[xI][yI-1] and map.cells.impermanents[xI][yI-1].Im=='Bomb' then
			movableLib.standartFootball(xI,yI-1,'U')	
		end		
	end
	return {movevars=l_movable,controlarr=keys}
end
YELLOW = love.graphics.newImage('sides/Yellow.png')
function movableLib.draw (m_x,m_y,m_xr,m_yr)
love.graphics.setCanvas(movable_canvas)
	love.graphics.clear()
	for i,v in pairs(level.movable) do if v.controltype~='float' then --love.graphics.draw(YELLOW,v.movevars.x+m_x*level.ts,v.movevars.y+m_y*level.ts)
		if not v.die and v.imageNow then
			v.imageNow = imageLib.setImage (v.movevars)
		end
		if v.imageNow then love.graphics.draw (v.images[v.imageNow[1]][v.imageNow[2]],v.movevars.x+m_x*level.ts+level.map.offsetX+m_xr,v.movevars.y+m_y*level.ts+level.map.offsetY+m_yr) end
		else love.graphics.draw (v.images,v.movevars.x+m_x*level.ts+level.map.offsetX+m_xr,v.movevars.y+m_y*level.ts+level.map.offsetY+m_yr)
	end end
love.graphics.setCanvas()
end
