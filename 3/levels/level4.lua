levels.level4 = {}

function levels.level4.load()
	require 'libs/Level'
	require 'libs/Map'
	require 'libs/Movable'
	require 'libs/Image'
	require 'libs/Behaviour'
	level = levelLib.new(50,{},mapLib.new ({'level4',ts=50}, imageLib.standartMapImages, mapLib.standartProbability, 13,13, 0, 0)) --not trash yet
	love.window.setFullscreen(true)
	level.map.mapImages.tiles.S = love.graphics.newImage('images/tiles/StoneCave.png')
	level.map.mapImages.tiles['0'] = love.graphics.newImage('images/tiles/FieldCave.png')
	timer_for_water = 0
	ITERATOR = 0
	level.map.cells.water_patf = {}
	for i=1,level.map.mapX do table.insert(level.map.cells.water_patf,{}) for i2=1,level.map.mapY do table.insert(level.map.cells.water_patf[i],0) end end
	for iterator,v in pairs(level.map.cells) do 
		if string.find(iterator,"door") then 
			local DOOR = {door={},times={},bool=false,unbool=false}
			for i=1,level.map.mapX do table.insert(DOOR.times,{}) table.insert(DOOR.door,{}) for i2=1,level.map.mapY do 
				DOOR.door[i][i2] = v[i][i2]
				DOOR.times[i][i2] = {0,0}
			end end
			level.map.cells[iterator] = DOOR
		end
	end
	for i=1,level.map.mapX do for i2=1,level.map.mapY do level.map.cells.water[i][i2]="W" end end
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

function levels.level4.update(dt) 
	levelLib.ForMovableUpdate(dt)
	for iterator,v in pairs(level.map.cells) do if string.find(iterator,"door")==nil then
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
			elseif iterator=='spawn' then if v[i][i2]=='player' then table.insert(level.movable,movableLib.new('player',{'w','a','s','d','space'},imageLib.standartImages,50,0,0)) level.movable[1].varsides["door4"]=true level.movable[1].varsides["door3"]=true level.movable[1].movevars.speed = level.ts*2 level.map.cells.spawn=nil break end 
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
			-- elseif iterator=='water_patf' then
				-- if level.map.cells.water[i][i2]=='button' then
					-- if level.movable[1] and level.movable[1].movevars.x==(i-1)*level.ts and level.movable[1].movevars.y==(i2-1)*level.ts then level.map.cells.water_patf[i+1][i2]=1
					-- if timer_for_water<=0.3 then timer_for_water=timer_for_water+dt else 
						-- timer_for_water=0 ITERATOR=ITERATOR+1
						-- for IX=1,level.map.mapX do for IY=1,level.map.mapY do 
							-- if v[IX][IY]==ITERATOR then  
								-- if IX<level.map.mapX and level.map.cells.water[IX+1][IY]~='button' and v[IX+1][IY]==0 and level.map.cells.obstructions[IX+1][IY]==0 then level.map.cells.water_patf[IX+1][IY]=ITERATOR+1 end
								-- if IX>1 and level.map.cells.water[IX-1][IY]~='button' and v[IX-1][IY]==0 and level.map.cells.obstructions[IX-1][IY]==0 then level.map.cells.water_patf[IX-1][IY]=ITERATOR+1 end
								-- if IY<level.map.mapY and level.map.cells.water[IX][IY+1]~='button' and v[IX][IY+1]==0 and level.map.cells.obstructions[IX][IY+1]==0 then level.map.cells.water_patf[IX][IY+1]=ITERATOR+1 end
								-- if IY>1 and level.map.cells.water[IX][IY-1]~='button' and v[IX][IY-1]==0 and level.map.cells.obstructions[IX][IY-1]==0 then level.map.cells.water_patf[IX][IY-1]=ITERATOR+1 end
							-- end
						-- end end 
					-- end 
					-- end
				-- end
				-- if level.map.cells.water_patf[i][i2]~=0 and level.map.cells.water[i][i2]~='button' then level.map.cells.water[i][i2]='W'
					-- if (i-1)*level.ts==level.movable[1].movevars.x and (i2-1)*level.ts==level.movable[1].movevars.y then 
						-- if math.random(4)<2 then LIM = level.map.mapImages.tiles.Bomb else LIM = level.map.mapImages.impermanents.BombBurn end
						-- table.insert(level.movable , movableLib.new('float',level.map.cells.water_patf,LIM,50,(i-1)*level.ts,(i2-1)*level.ts))
					-- end
				-- end
			end
		end end
	end end
	for iterator,v in pairs (level.map.cells) do 
		if string.find(iterator,"door")~=nil then 
		
			if iterator=="door1" or iterator=="door2" then
				for i=1,level.map.mapX do for i2=1,level.map.mapY do 
					if v.door[i][i2]=="button" or v.door[i][i2]=="unbutton" then 
						for ITERATOR,value in pairs(level.movable) do 
							--v.bool = false
							if math.abs(value.movevars.x-(i-1)*level.ts)<level.ts and math.abs(value.movevars.y-(i2-1)*level.ts)<level.ts then
								if v.door[i][i2]=="button" then v.bool = true end
								if v.bool==false and v.door[i][i2]=="unbutton" then v.unbool = true end
							end
						end
						if level.map.cells.obstructions[i][i2]==1 then if v.door[i][i2]=="button" then v.bool = true end if v.bool==false and v.door[i][i2]=="unbutton" then v.unbool = true end end
					
					elseif v.door[i][i2]=="door" then
						if v.bool==true then 
							v.times[i][i2][2] = 3
							if v.times[i][i2][1]>=v.times[i][i2][2] then 
								level.map.cells.obstructions[i][i2]=1
								level.map.cells.tiles[i][i2] = "door"
								level.map.cells[iterator].bool=false
								level.map.cells[iterator].times[i][i2][1] = 0 level.map.cells[iterator].times[i][i2][2] = 0
							else
								v.times[i][i2][1] = v.times[i][i2][1]+dt
								level.map.cells.obstructions[i][i2]=0
								level.map.cells.tiles[i][i2] = "dooropen"
							end
						else 
							level.map.cells.obstructions[i][i2]=1
							level.map.cells.tiles[i][i2] = "door"
						end
					
					elseif v.door[i][i2]=="piston" then
						local BOOLEAN = false
						if v.bool==true then 
							v.times[i][i2][2] = 3
							if v.times[i][i2][1]>v.times[i][i2][2] then 
								--level.map.cells.obstructions[i][i2]=0
								--level.map.cells.tiles[i][i2] = "piston"
								v.bool=false BOOLEAN = true
								v.times[i][i2] = {0,0}
							else
								v.times[i][i2][1] = v.times[i][i2][1]+dt
								level.map.cells.obstructions[i][i2]=1
								level.map.cells.tiles[i][i2] = "S"
							end
						else
							level.map.cells.tiles[i][i2]="piston"
						end
						if v.bool==false and v.unbool==true and BOOLEAN==false then
						
							v.times[i][i2][2] = 3
							if v.times[i][i2][1]>v.times[i][i2][2] then 
								level.map.cells.obstructions[i][i2]=1
								level.map.cells.tiles[i][i2] = "S"
								v.unbool=false
								v.times[i][i2] = {0,0}
							else
								v.times[i][i2][1] = v.times[i][i2][1]+dt
								level.map.cells.obstructions[i][i2]=0
								level.map.cells.tiles[i][i2] = "piston"
							end						
						end
						if v.bool==false and v.unbool==false then level.map.cells.obstructions[i][i2]=1 level.map.cells.tiles[i][i2] = "S" end
						if BOOLEAN==true then level.map.cells.obstructions[i][i2]=1 level.map.cells.tiles[i][i2] = "S" end
					end
				
				end end
			
			elseif iterator=="door3" or iterator=="door4" then
				for i=1,level.map.mapX do for i2=1,level.map.mapY do
					for ITERATOR,value in ipairs(level.movable) do 
						if v.door[i][i2]=="key" then 
							if value.movevars.x == (i-1)*level.ts and value.movevars.y==(i2-1)*level.ts then
								value.varsides[iterator] = true
								level.map.cells.tiles[i][i2]=0
							end 
						
						elseif v.door[i][i2]=="door" then
							level.map.cells.obstructions[i][i2]=1 level.map.cells.tiles[i][i2]="door"
							if value.varsides[iterator]==true and value.movevars.x-(i-1)*level.ts>=0 and value.movevars.x-(i-1)*level.ts<=level.ts and math.abs (value.movevars.y-(i2-1)*level.ts) <= level.ts then
								level.map.cells.obstructions[i][i2]=0
								level.map.cells.tiles[i][i2]="dooropen"
								level.map.cells[iterator].door[i][i2]=0
							end
						end
					end
					
				end end
			end
		end
	end
	
	for iterator,v in pairs(level.movable) do if v.controltype~='float' then
		if level.movable[1]~=nil and iterator~=1 then
			local b_x = false local b_y = false
				if level.movable[1].movevars.x<=v.movevars.x+level.ts/2 and level.movable[1].movevars.x>=v.movevars.x-level.ts/2 then b_x=true end
				if level.movable[1].movevars.y<=v.movevars.y+level.ts/2 and level.movable[1].movevars.y>=v.movevars.y-level.ts/2 then b_y=true end			
			if b_x and b_y then level.movable[1]=level.movable[1].death(level.movable[1]) end
		end	
	end end
	
end
function levels.level4.draw()
	levelLib.draw(true)
end