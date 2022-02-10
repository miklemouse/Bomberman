levels.level3 = {}

function levels.level3.load()
	require 'libs/Level'
	require 'libs/Map'
	require 'libs/Movable'
	require 'libs/Image'
	require 'libs/Behaviour'
	level = levelLib.new(50,{},mapLib.new ({'level3',ts=50}, imageLib.standartMapImages, mapLib.standartProbability, 13,13, 0, 0)) --not trash yet
	love.window.setFullscreen(true)
	level.map.mapImages.tiles.S = love.graphics.newImage('images/tiles/StoneCave.png')
	level.map.mapImages.tiles['0'] = love.graphics.newImage('images/tiles/FieldCave.png')
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

function levels.level3.update(dt)
	levelLib.ForMovableUpdate(dt)
	for iterator,v in pairs(level.map.cells) do 
		for i=1,level.map.mapX do for i2=1,level.map.mapY do
			
			if iterator=='tiles' and v[i][i2]=='T' and level.movable[1] then 
				if level.movable[1].movevars.x/level.ts<=i and level.movable[1].movevars.x/level.ts>=(i-2) and 
					level.movable[1].movevars.y/level.ts<=i2 and level.movable[1].movevars.y/level.ts>=(i2-2) then 
						level.map.cells.lights[i][i2]=4
						level.map.cells.lamps[i][i2]=4
					end
						if level.movable[1] and level.map.cells.tiles[i][i2]=='T' then
							if level.movable[1].movevars.x/level.ts==i-1 and level.movable[1].movevars.y/level.ts==i2-1 then 
								level.map.cells.tiles[i][i2]=0 
								level.map.cells.lights[i][i2]=0
								level.map.cells.lamps[i][i2]=0
								level.movable[1].brightness = level.movable[1].brightness+2
							end 
						end
			
			elseif iterator=='spawn' then if v[i][i2]=='player' then table.insert(level.movable,movableLib.new('player',{'w','a','s','d','space'},imageLib.standartImages,50,0,0))  level.movable[1].movevars.speed=level.ts*1 level.map.cells.spawn=nil break end 
			elseif iterator=='door1' and level.movable[1] then
				if v[i][i2]=='key' and level.movable[1].movevars.x/level.ts<=(i+2) and level.movable[1].movevars.x/level.ts>=(i-2) and 
					level.movable[1].movevars.y/level.ts<=(i2+2) and level.movable[1].movevars.y/level.ts>(i2-5) then 
						level.map.cells.lights[i][i2]=1
						level.map.cells.lamps[i][i2]=1
				elseif v[i][i2]=='key' then level.map.cells.lamps[i][i2]=0	end
				
				if v[i][i2]=='key' and level.movable[1].movevars.x/level.ts==(i-1) and level.movable[1].movevars.y/level.ts==(i2-1) then level.movable[1].varsides['door1key1']=true level.map.cells.tiles[i][i2]=0 level.map.cells.door1[i][i2]=0 level.map.cells.lamps[i][i2]=0 end
				
				if v[i][i2]=='door' then local value=level.movable[1]
					local BOOL=false 
					if value.varsides['door1key1'] then local function emp() level.map.cells.obstructions[i][i2]=0 v[i][i2]=0 level.map.cells['tiles'][i][i2]=0 end
						if value.movevars.x+level.ts==(i-1)*level.ts and value.movevars.y==(i2-1)*level.ts and value.varsides['door1key1'] then emp() BOOL=true end
						if value.movevars.x-level.ts==(i-1)*level.ts and value.movevars.y==(i2-1)*level.ts and value.varsides['door1key1'] then emp() BOOL=true end
						if value.movevars.x==(i-1)*level.ts and value.movevars.y+level.ts==(i2-1)*level.ts and value.varsides['door1key1'] then emp() BOOL=true end
						if value.movevars.x==(i-1)*level.ts and value.movevars.y-level.ts==(i2-1)*level.ts and value.varsides['door1key1'] then emp() BOOL=true end
					end
					if not BOOL then level.map.cells.obstructions[i][i2]=1 end
				end
			elseif string.find(iterator,'bot') then
				if v[i][i2]=='bot' then
					II[iterator]={} II[iterator].direct = DIRECT local local_str = ''
					if iterator=='bot1' then local_str='+' 
					elseif iterator=='bot2' then local_str='+' 
					elseif iterator=='bot3' then local_str='+' end
					level.movable[iterator]=(movableLib.new('bot',{iterator,local_str},imageLib.standartImages,50,(i-1)*level.ts,(i2-1)*level.ts)) 
					for IS=1,level.map.mapX do for I2S=1,level.map.mapY do if level.map.cells[iterator][IS][I2S]==0 then level.map.cells[iterator][IS][I2S]='' end end end
					if v[i][i2]=='0;' then v[i][i2]=0 end
					if iterator=='bot2' then level.map.cells[iterator][i][i2]=0
					elseif iterator=='bot1' then level.map.cells[iterator][i][i2]=0 
					elseif iterator=='bot3' then level.map.cells[iterator][i][i2]=0 end
				end
			elseif iterator=='impermanents' then
				if v[i][i2]~=0 then
					if v[i][i2].Im=='Bomb' then
						if v[i][i2][1]<v[i][i2][2] then level.map.cells['impermanents'][i][i2][1]=level.map.cells['impermanents'][i][i2][1]+dt
						else mapLib.StImpermanent_exploddy(i,i2) end
					elseif v[i][i2].Im=='Fr' or v[i][i2].Im=='Fl' or v[i][i2].Im=='Fd' or v[i][i2].Im=='Fu' or v[i][i2].Im=='Fm' then
						if v[i][i2][1]<v[i][i2][2] then level.map.cells['impermanents'][i][i2][1]=level.map.cells['impermanents'][i][i2][1]+dt
						else level.map.cells['impermanents'][i][i2]=0 level.map.cells['tiles'][i][i2]=0 level.map.cells['obstructions'][i][i2]=0 level.map.cells['fatals'][i][i2]=0
						end						
					end
				end			
			end			
		end end
	end
	for iterator,v in pairs(level.movable) do
		if level.movable[1]~=nil and iterator~=1 then
			local b_x = false local b_y = false
				if level.movable[1].movevars.x<=v.movevars.x+level.ts/2 and level.movable[1].movevars.x>=v.movevars.x-level.ts/2 then b_x=true end
				if level.movable[1].movevars.y<=v.movevars.y+level.ts/2 and level.movable[1].movevars.y>=v.movevars.y-level.ts/2 then b_y=true end			
			if b_x and b_y then level.movable[1]=level.movable[1].death(level.movable[1]) end
		end
	end
	
end
function levels.level3.draw()
	levelLib.draw(true)
end