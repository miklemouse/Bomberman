levels.level2 = {}
function levels.level2.load()
	require 'libs/Behaviour'
	require 'libs/Movable'
	require 'libs/Map'
	require 'libs/Level'
	require 'libs/Image'
	level = levelLib.new(50,{},mapLib.new ({'level2'}, imageLib.standartMapImages, mapLib.standartProbability, 10,10, 0, 0)) --not trash yet
	level.POINTS = POINTSlib.load (level.movable,level.map)
	
	love.window.setFullscreen(true)
	t = 0
	times = {}
		for i=1,level.map.mapX do table.insert(times,{}) for i2=1,level.map.mapY do table.insert(times[i],{0,0}) end end
	local e = math.pow(1+1,1)
end
function DIRECT(v,controlarr) 
	--if true then return {movevars=v, controlarr=controlarr} end
local x=v.x/level.ts+1
local y=v.y/level.ts+1

	local function D(X,Y) 
		if not level.map.cells[controlarr[1]][X] then return end
		if level.map.cells[controlarr[1]][X][Y]==level.map.cells[controlarr[1]][x][y]+1 then
		if controlarr[2]=='cycle' or controlarr[2]=='+'	then
			v.targetX = (X-1)*level.ts
			v.targetY = (Y-1)*level.ts
			v.moving = true
			return true
		end 
		end
		if level.map.cells[controlarr[1]][X][Y]==0 then
			v.targetX = (X-1)*level.ts
			v.targetY = (Y-1)*level.ts
			v.moving = true
			--if controlarr[2]~='cycle' then controlarr[2]='+' end
			return true
		end
		if controlarr[2]=='-' and level.map.cells[controlarr[1]][X][Y]==level.map.cells[controlarr[1]][x][y]-1 then
			v.targetX = (X-1)*level.ts
			v.targetY = (Y-1)*level.ts
			v.moving = true
			return true
		end
		
	end
			if D(x+1,y) and x<level.map.mapX-1 then v.moveDirection=1 return {movevars=v,controlarr=controlarr} 
		elseif D(x-1,y) and x>1 then v.moveDirection=2 return {movevars=v,controlarr=controlarr}
		elseif D(x,y+1) and y<level.map.mapY-1 then v.moveDirection=3 return {movevars=v,controlarr=controlarr}
		elseif D(x,y-1) and y>1 then v.moveDirection=4 return {movevars=v,controlarr=controlarr} end
		
		if controlarr[2]~='cycle' then
			if controlarr[2]=='-' then
				if not D(x+1,y) and not D(x+1,y) and not D(x-1,y) and not D(x,y+1) and not D(x+1,y-1) then controlarr[2]='+' end
			else
				if not D(x+1,y) and not D(x+1,y) and not D(x-1,y) and not D(x,y+1) and not D(x+1,y-1) then controlarr[2]='-' end
			end
		end
	return {movevars=v,controlarr=controlarr}
end
function DEVELOP(a_movable)
	
	if not a_movable.movevars.moving then
		if level.map.cells.bonuses[a_movable.movevars.x/level.ts+1][a_movable.movevars.y/level.ts+1]=='Boom' then 
			level.map.cells.bonuses[a_movable.movevars.x/level.ts+1][a_movable.movevars.y/level.ts+1]=0 
			--a_movable.bombsvars.maxBombs = 2
			a_movable.bombsvars.bombs = 2
			
		end
	end
	return a_movable
end
function levels.level2.update(dt)
	--acceleration = acceleration+dt
	levelLib.ForMovableUpdate(dt)
	for iterator,v in pairs(level.map.cells) do 
		for i=1,level.map.mapX do for i2=1,level.map.mapY do
			if iterator=='spawn' then
				if v[i][i2]=='player' then table.insert(level.movable,movableLib.new('player',{'w','a','s','d','space'},imageLib.standartImages,50,0,0)) level.movable[1].bombsvars.bombs=0 level.movable[1].develop=DEVELOP v[i][i2]=0 end
				if v[i][i2]=='bot' then table.insert(level.movable,movableLib.new('bot',{'partI','standart'},imageLib.standartImages,50,i*level.ts,i2*level.ts)) level.movable[table.getn(level.movable)].movevars.speed=level.ts*table.getn(level.movable)*2 v[i][i2]=0 end
			elseif iterator=='door2' then 
				if v[i][i2]=='key' then for it,value in pairs(level.movable) do --not trash yet
					if value.movevars.x==(i-1)*level.ts and value.movevars.y==(i2-1)*level.ts then value.varsides['door1key1']=true  v[i][i2]=0 level.map.cells['tiles'][i][i2]=0 end 
				end end
				if v[i][i2]=='door' then for it,value in pairs(level.movable) do  
					if value.varsides['door1key1'] then local function emp() level.map.cells.obstructions[i][i2]=0 v[i][i2]=0 level.map.cells['tiles'][i][i2]=0 end
						if value.movevars.x+level.ts==(i-1)*level.ts and value.movevars.y==(i2-1)*level.ts and value.varsides['door1key1'] then emp() end
						if value.movevars.x-level.ts==(i-1)*level.ts and value.movevars.y==(i2-1)*level.ts and value.varsides['door1key1'] then emp() end
						if value.movevars.x==(i-1)*level.ts and value.movevars.y+level.ts==(i2-1)*level.ts and value.varsides['door1key1'] then emp() end
						if value.movevars.x==(i-1)*level.ts and value.movevars.y-level.ts==(i2-1)*level.ts and value.varsides['door1key1'] then emp() end
					end
				end end
			elseif iterator=='door1' then 
				if v[i][i2]=='door' then 
					if level.map.cells.obstructions[i][i2]==0 then level.map.cells.tiles[i][i2]='dooropen'
					else level.map.cells.tiles[i][i2]='door' end
				elseif v[i][i2]=='piston' then
					if level.map.cells.obstructions[i][i2]==0 then level.map.cells.tiles[i][i2]='piston'
					else level.map.cells.tiles[i][i2]='S' end
				elseif v[i][i2]=='button' and level.map.cells.obstructions[i][i2]~=0 then 
					for iS=1,level.map.mapX do for i2S=1,level.map.mapY do
						if (level.map.cells.door1[iS][i2S]=='door') then times[iS][i2S][1]=0 times[iS][i2S][2]=1.5 level.map.cells.obstructions[iS][i2S]=0 end 
						if (level.map.cells.door1[iS][i2S]=='piston') then times[i][i2S][1]=0 times[iS][i2S][2]=3 level.map.cells.obstructions[iS][i2S]=0 end 				
					end end
				end
			elseif iterator=='impermanents' then
				if v[i][i2]~=0 then
					if v[i][i2].Im=='Bomb' then
						if i2<=level.map.mapY/2-1 and i<=level.map.mapX/2 then
							if v[i][i2][1]<v[i][i2][2] then level.map.cells['impermanents'][i][i2][1]=level.map.cells['impermanents'][i][i2][1]+dt
							else mapLib.StImpermanent_exploddy(i,i2) end
						else level.map.cells.impermanents[i][i2]=0 level.map.cells.tiles[i][i2]='Bomb' level.map.cells.obstructions[i][i2]=1
						end
					elseif v[i][i2].Im=='Fr' or v[i][i2].Im=='Fl' or v[i][i2].Im=='Fd' or v[i][i2].Im=='Fu' or v[i][i2].Im=='Fm' then
						if v[i][i2][1]<v[i][i2][2] then level.map.cells['impermanents'][i][i2][1]=level.map.cells['impermanents'][i][i2][1]+dt
						else level.map.cells['impermanents'][i][i2]=0 level.map.cells['tiles'][i][i2]=0 level.map.cells['obstructions'][i][i2]=0 level.map.cells['fatals'][i][i2]=0
						end						
					end
				end
			elseif string.find(iterator,'bot') then
				if v[i][i2]=='bot' then
					II[iterator]={} II[iterator].direct = DIRECT local local_str = ''
					if iterator=='bot1' then local_str='+' end
					if iterator=='bot2' then local_str='cycle' end
					level.movable[iterator]=(movableLib.new('bot',{iterator,local_str},imageLib.standartImages,50,(i-1)*level.ts,(i2-1)*level.ts)) 
					for IS=1,level.map.mapX do for I2S=1,level.map.mapY do if level.map.cells[iterator][IS][I2S]==0 then level.map.cells[iterator][IS][I2S]='' end end end
					if v[i][i2]=='0;' then v[i][i2]=0 end
					if iterator=='bot2' then level.map.cells[iterator][i][i2]=0
					elseif iterator=='bot1' then level.map.cells[iterator][i][i2]=4 end
				end
			end
		end end
	end
	for i=1,level.map.mapX do for i2=1,level.map.mapY do 
		if level.map.cells['door1'][i][i2]=='door' then
			if times[i][i2][2]~=0 then
				if times[i][i2][1]<=times[i][i2][2] then times[i][i2][1]=times[i][i2][1]+dt level.map.cells.obstructions[i][i2]=0
				else level.map.cells.obstructions[i][i2]=1 times[i][i2][1]=0 times[i][i2][2]=0 end
			elseif times[i][i2][2]==0 and level.map.cells.door1[i][i2]=='door' then
				level.map.cells.obstructions[i][i2]=1 	
			end
		elseif level.map.cells['door1'][i][i2]=='piston' then
			if times[i][i2][2]~=0 then
				if times[i][i2][1]<=times[i][i2][2] then times[i][i2][1]=times[i][i2][1]+dt level.map.cells.obstructions[i][i2]=1 t=mapLib.funbonus(t,dt,7,7)
				else level.map.cells.obstructions[i][i2]=1 times[i][i2][1]=0 times[i][i2][2]=0 t=mapLib.funbonus(t,dt,7,7) end
			elseif times[i][i2][2]==0 and level.map.cells.door1[i][i2]=='piston' then
				level.map.cells.obstructions[i][i2]=0
			end			
		end
	end end

	for iterator,v in pairs(level.movable) do
		if not v.movevars.moving and level.map.cells.door1[v.movevars.x/level.ts+1][v.movevars.y/level.ts+1] == 'button' then
			for i=1,level.map.mapX do for i2=1,level.map.mapY do 
			
				if (level.map.cells.door1[i][i2]=='door') then times[i][i2][1]=0 times[i][i2][2]=1.5 level.map.cells.obstructions[i][i2]=0 end 
				if (level.map.cells.door1[i][i2]=='piston') then times[i][i2][1]=0 times[i][i2][2]=3 level.map.cells.obstructions[i][i2]=0 end 
			
			end end
		end
		
		if level.movable[1]~=nil and iterator~=1 then
			local b_x = false local b_y = false
				if level.movable[1].movevars.x<=v.movevars.x+level.ts/2 and level.movable[1].movevars.x>=v.movevars.x-level.ts/2 then b_x=true end
				if level.movable[1].movevars.y<=v.movevars.y+level.ts/2 and level.movable[1].movevars.y>=v.movevars.y-level.ts/2 then b_y=true end			
			if b_x and b_y then level.movable[1]=level.movable[1].death(level.movable[1]) end
		end
	end

	for i=1,level.map.mapX do for i2=1,level.map.mapY do if level.map.cells['impermanents'][i][i2]~=0 then
		if level.map.cells['impermanents'][i][i2][1]>=level.map.cells['impermanents'][i][i2][2] then 
			level.map.cells['impermanents'][i][i2]=0 if f_points then f_points[i][i2]=0 end level.map.cells.fatals[i][i2]=0
		else
			level.map.cells['impermanents'][i][i2][1]=level.map.cells['impermanents'][i][i2][1]+dt
		end
	end end end

end
function levels.level2.draw()
	levelLib.draw(false)
	--e = math.pow(1+1/acceleration,acceleration)
	--if acceleration>4 then love.graphics.print({{0,0,255},'wt',{0,100,0},'f ar u do',{100,50,300},'in',{0,100,200},'g?'},100,200,math.pow(e,1/acceleration)) end
		--for i=1,level.map.mapX do for i2=1,level.map.mapY do love.graphics.print(times[i][i2],(i-0.5)*level.ts,(i2-0.5)*level.ts) end end
	--love.graphics.print(e)
end