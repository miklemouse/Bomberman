levels.mapCreator = {} 
function levels.mapCreator.load ()
	require 'libs_/Level'
	require 'libs_/Map'
	require 'libs_/Image'
	require 'libs_/Movable'
	require 'libs_/Behaviour'
	TARGET={x=1,y=1,image=love.graphics.newImage('sides/TargetGreen.png')}
	level = levelLib.new(50,{movetarget = TARGET},mapLib.new ({mapX=20,mapY=13}, imageLib.standartMapImages, mapLib.standartProbability, 10,10, 400, 50)) 
	love.window.setFullscreen(true)
	im = love.graphics.newImage('sides/Target.png')
	door = love.graphics.newImage('images/tiles/Door.png')
	doorOpen = love.graphics.newImage('images/tiles/DoorOpen.png')
	key = love.graphics.newImage('images/tiles/Key.png')
	cross = love.graphics.newImage('sides/Cross.png')
	eye = love.graphics.newImage('sides/Eye.png')
	ctrl = false
	Shift = false
	bool_A = false
	insert = false
	timer = 0
	--local tiles = mapLib.load('map2')
	--local controls = mapLib.load('teg2') --!
	level.map.boolarr = {}
	for i=1,level.map.mapX do level.map.boolarr[i] = {} 
	for i2=1,level.map.mapY do level.map.boolarr[i][i2]=false
	end end 
	local function empty() end
	local function OpenClose(i,i2,dt)
		for iterator,v in ipairs(level.movable) do if v.varsides.key1 then
			if v.varsides.key1==true and i==15 and i2==2 then 
				if v.movevars.x/level.ts+1==i-1 and v.movevars.y/level.ts+1==i2 then
					level.map.cells[i][i2].control.open=true level.map.cells[i][i2].obstruction=0 
				end
			end 
		end
	end end
	local function Key(i,i2,a_control,dt)
		for iterator,v in ipairs(level.movable) do 
			if iterator~='movetarget' and v.movevars.x/level.ts+1==i and v.movevars.y/level.ts+1==i2 and v.controltype=='player' then 
				v.varsides.key1=true return (nil) 
			else return a_control end
		end
	end
	function SpawnPlayer(i,i2,a_control,dt) --not trash yet (local)
		if a_control.bool==true then table.insert(level.movable,movableLib.new('player',{'w','a','s','d','space'},imageLib.standartImages,level.ts,(i-1)*level.ts,(i2-1)*level.ts)) 
		a_control.bool=false end
		return a_control
	end
		local function SpawnBotS(i,i2,a_control,dt)
			if level.map.cells[i][i2].control.bool==true then table.insert(level.movable,movableLib.new('bot',{'chess','standart',{}},imageLib.standartImages,level.ts,(i-1)*level.ts,(i2-1)*level.ts))
			level.POINTS = POINTSlib.load (level.movable,level.map)
			level.map.cells[i][i2].control.bool=false end
		end
		local function SpawnBotR(i,i2,a_control,dt)
			if level.map.cells[i][i2].control.bool==true then table.insert(level.movable,movableLib.new('bot',{'partI','RoundMove',{}},imageLib.standartImages,level.ts,(i-1)*level.ts,(i2-1)*level.ts,{x=i+1,y=i2}))
			level.POINTS = POINTSlib.load (level.movable,level.map)
			level.map.cells[i][i2].control.bool=false end
		end
	for i=1,level.map.mapX do for i2=1,level.map.mapY do 
		
		--level.map.cells[i][i2].tile = tiles[i][i2]
		--if tiles[i][i2]=='S' or tiles[i][i2]=='B' then level.map.cells[i][i2].obstruction=1 end
		
		if false then
		v = level.map.cells[i][i2].control --for i,v in controls[controls] do
		
			v.name = controls[i][i2]
			if v.name=='door' then v.open=false v.perform = OpenClose level.map.cells[i][i2].obstruction=1
			elseif v.name=='start' then v.bool=true v.perform = SpawnPlayer
			elseif v.name=='bots' then v.bool=true	v.perform = SpawnBotS 
			elseif v.name=='botr' then v.bool=true	v.perform = SpawnBotR --botRound
			elseif v.name=='key' then v.perform = Key
			else v.perform = empty	end
		
		level.map.cells[i][i2].control = v
		end
	end end
	clipboard = {}
	bars = {
		b = {
			tiles={{'B'}},obstructions={{1}},fatals={{0}},enrichings={{'B'}}
		},
		s = {tiles={{'S'}},obstructions={{1}},fatals={{0}},enrichings={{''}}}
	}
	layers = {'tiles','obstructions'}
	vision = {{'tiles',true},{'obstructions',false}}
	test = false
	public = {mapX=20,mapY=13,offsetX=level.map.offsetX,offsetY=level.map.offsetY,viewX=11,viewY=13,mapImages=imageLib.standartMapImages,bool=false}
	enum = 0 written = ''
	crossX = {}
	level.map.cells['allocates'] = {}
	for i=1,level.map.mapX do table.insert(level.map.cells['allocates'],{}) for i2=1,level.map.mapY do table.insert(level.map.cells['allocates'][i],0) end end
end
function levels.mapCreator.update (dt)	
	if love.keyboard.isDown('lctrl') or love.keyboard.isDown('rctrl') then ctrl=true else ctrl=false end
	if love.keyboard.isDown('lshift') then Shift=true else Shift=false end
	if love.keyboard.isDown('a') then bool_A=true else bool_A=false end
	timer = timer+dt
	for i=1,level.map.mapX do for i2=1,level.map.mapY do 
		--if level.map.cells[i][i2].control.name == '' and level.map.boolarr[i][i2]==false then level.map.cells[i][i2].control.name=0 end
	end end  
	if test then
		for iterator,v in pairs(level.map.cells.controls) do
			for i=1,level.map.mapX do for i2=1,level.map.mapY do 
					if v[i][i2].perform then 
						v[i][i2] = v[i][i2].perform(i,i2,v[i][i2],dt) end
			end
			end end --to_global!! trash
		levelLib.ForMovableUpdate(dt)
	end
end
function levels.mapCreator.mousepressed(x,y,button)
	local l = 0
	
	if y<level.map.offsetY and y>20 then 
		for i,v in ipairs(crossX) do if x>v-3 and x<v+string.len(layers[i]) then
			if y>30 and y<40 then
				table.remove(layers,i) table.remove(vision,i) crossX={} break
			else 
				if vision[i][2]==true then vision[i][2]=false else vision[i][2]=true end
			end
		end end
	end
	
	if y<level.map.offsetY and y<20 then 
		if	x>level.map.viewX*level.ts/2+level.map.offsetX then enum='layer'
		else	layers={} crossX={} vision={}	for i,v in pairs(level.map.cells) do table.insert(layers,i) table.insert(vision,{i,false}) end end 
	end --NOT TRASH
		
	if x>level.map.offsetX+level.map.viewX*level.ts then
		local choose=''
		for i,v in ipairs(layers) do --define 10: high of font
			if y>=(i-1)*30+level.map.offsetY and y<i*30+level.map.offsetY then choose='tile'..' '..v end
		end
		enum=choose
	end
	
	if public.bool and x<level.map.offsetX then 
		if y>100 and y<111 and x>100 and x<180 then enum='mapX' public.mapX='' end
		if y>111 and y<121 and x>100 and x<180 then enum='mapY' public.mapY='' end
	end

end
function levels.mapCreator.keypressed(key)
	local mapX = level.map.mapX
	local mapY = level.map.mapY
	local l_move=false
	if key=='escape' then enum=0 end
	if key=='-' then 
		if level.map.viewX<level.map.mapX then level.map.viewX=level.map.viewX+1 end
		if level.map.viewY<level.map.mapY then level.map.viewY=level.map.viewY+1 end
		
		level.ts=math.ceil(level.ts-level.ts/level.map.viewX)
		local difference = math.ceil(level.ts-level.ts/level.map.viewX)-(level.ts-level.ts/level.map.viewX)
		level.map.offsetX = level.map.offsetX-difference
		--level.map.offsetY = level.map.offsetY-difference
	end
	if key=='=' then
		if level.map.viewX>0 then level.map.viewX=level.map.viewX-1 end
		if level.map.viewY>0 then level.map.viewY=level.map.viewY-1 end

		level.ts=math.ceil(level.ts+level.ts/level.map.viewX)
		local difference = math.ceil(level.ts+level.ts/level.map.viewX)-(level.ts-level.ts/level.map.viewX)
		--level.map.offsetX = level.map.offsetX+difference

	end

	--if key=='i' then level.ts=math.random(60) end
	
	for iterator,v in pairs(level.movable) do if enum==0 and iterator=='movetarget' then
		if love.keyboard.isDown('right') and v.x<(mapX) then  --move
			if not ctrl then v.x=v.x+1 
			elseif not Shift then v.x=mapX
			elseif ctrl and Shift then for i=v.x,mapX do if level.map.cells.tiles[v.x][v.y]==0 then v.x=i level.map.cells.allocates[v.x][v.y]='A' else break end end end
			if not ctrl and Shift then  
				for i=1,mapY do 
					if level.map.cells.allocates[v.x-1][i]=='A' then
						level.map.cells.allocates[v.x][i]='A'
					end
				end 
				if v.x<mapX-1 and level.map.cells.allocates[v.x+1][v.y]=='A' then
					for i=v.x-1,1,-1 do for i2=1,mapY do
						level.map.cells.allocates[i][i2]=0
					end end
				end
			end
			
		elseif love.keyboard.isDown('left') and v.x>1 then 
			if not ctrl then v.x=v.x-1 
			elseif not Shift then v.x=1
			elseif ctrl and Shift then for i=v.x,1,-1 do if level.map.cells.tiles[v.x][v.y]==0 then v.x=i level.map.cells.allocates[v.x][v.y]='A' else break end end end
			if not ctrl and Shift then  
				for i=1,mapY do 
					if level.map.cells.allocates[v.x+1][i]=='A' then
						level.map.cells.allocates[v.x][i]='A'
					end
				end 
				if v.x>1 and level.map.cells.allocates[v.x-1][v.y]=='A' then
					for i=v.x+1,mapX do for i2=1,mapY do
						level.map.cells.allocates[i][i2]=0
					end end
				end
			end

		elseif love.keyboard.isDown('down') and v.y<(mapY) then 
			if not ctrl then v.y=v.y+1 
			elseif not Shift then v.y=mapY
			elseif ctrl and Shift then for i=v.y,mapY do if level.map.cells.tiles[v.x][v.y]==0 then v.y=i level.map.cells.allocates[v.x][v.y]='A' else break end end end
			if not ctrl and Shift then  
				for i=1,mapX do 
					if level.map.cells.allocates[i][v.y-1]=='A' then
						level.map.cells.allocates[i][v.y]='A'
					end
				end 
				if v.y<mapY-1 and level.map.cells.allocates[v.x][v.y+1]=='A' then
					for i=v.y-1,1,-1 do for i2=1,mapX do
						level.map.cells.allocates[i2][i]=0
					end end
				end
			end
			
		elseif love.keyboard.isDown('up') and v.y>1 then 
			if not ctrl then v.y=v.y-1 
			elseif not Shift then v.y=1
			elseif ctrl and Shift then for i=v.x,1,-1 do if level.map.cells.tiles[v.x][v.y]==0 then v.y=i level.map.cells.allocates[v.x][v.y]='A' else break end end end
			if not ctrl and Shift then  
				for i=1,mapX do 
					if level.map.cells.allocates[i][v.y+1]=='A' then
						level.map.cells.allocates[i][v.y]='A'
					end
				end 
				if v.y>1 and level.map.cells.allocates[v.x][v.y-1]=='A' then
					for i=v.y+1,mapY do for i2=1,mapX do
						level.map.cells.allocates[i2][i]=0
					end end
				end
			end
		end

		if not ctrl then timer=-0.15
			if key=='insert' then if insert then insert=false else insert=true end end

			if Shift then level.map.cells.allocates[v.x][v.y]='A' 
			elseif key=='right' or key=='left' or key=='up' or key=='down' or key=='esc' then
				for i=1,mapX do for i2=1,mapY do level.map.cells.allocates[i][i2]=0 end end 
			end

			if bars[key] then
				for iterator,value in pairs(bars[key]) do 
					for i=1,table.getn(layers) do if iterator==layers[i] then bool=true break end end
					if bool then
						for i=1,table.getn(value) do if i<=level.map.mapX then 
							for i2=1,table.getn(value[i]) do if i2<=level.map.mapY then
								if level.map.cells[iterator]~=nil then
									level.map.cells[iterator][i+v.x-1][i2+v.y-1]=value[i][i2]
								end
							end end
						end end
					end
				end 
				l_move=true
			end		
			
			if key=='backspace' then 
				if v.x>1 and not insert then for _,value in ipairs(layers) do if level.map.cells[value] and level.map.cells[value][v.x-1] then level.map.cells[value][v.x-1][v.y]=0 end end end
				if v.x>1 and insert then for _,value in ipairs(layers) do if level.map.cells[value] and level.map.cells[value][v.x] then level.map.cells[value][v.x][v.y]=0 end end end
			end

			if not insert then 
				if l_move and v.x<level.map.mapX then v.x=v.x+1 end
				if key=='backspace' and v.x>1 then v.x=v.x-1 end 
			end
			
		elseif ctrl then
			
			if key=='n' then
				public.bool = true
			end

			if key=='return' and public.bool==true then level.map=mapLib.new({mapX=public.mapX,mapY=public.mapY},public.mapImages,{},public.viewX,public.viewY,public.offsetX,public.offsetY) public.bool=false end
			
			if key=='c' then
				clipboard={}
				local l_bool = true
				local ix = 0 local iy = 0
				for i=1,level.map.mapX do for i2=1,level.map.mapY do 
				
					if level.map.cells.allocates[i][i2]=='A' and l_bool then l_bool=false ix=i-1 iy=i2-1 end
					
					if level.map.cells.allocates[i][i2]=='A' then
						for num=1,table.getn(layers) do if level.map.cells[layers[num]] and level.map.cells[layers[num]][i] and layers[num]~='allocates' then
						
							if clipboard[layers[num]]==nil then clipboard[layers[num]]={} end
							if clipboard[layers[num]][i-ix]==nil then clipboard[layers[num]][i-ix]={} end
							if clipboard[layers[num]][i-ix] and clipboard[layers[num]] and level.map.cells[layers[num]][i][i2] then 
								table.insert(clipboard[layers[num]][i-ix],level.map.cells[layers[num]][i][i2]) end
						
						end end
					end
				
				end end
			end
			
			if key=='v' then 
				for iterator,value in pairs(clipboard) do --not trash yet
					for i=1,table.getn(value) do
						for i2=1,table.getn(value[i]) do
							level.map.cells[iterator][i+v.x][i2+v.y]=value[i][i2]
						end
					end
				end
			end
			
			if key=='t' then newLayer() end
			
			if bool_A then bars[key]=clipboard end
			
			if key=='s' then enum='save' return end
			
			if key=='o' then enum='load' return end

		end
	end end

	if string.find(enum,'layer')~=nil then
		if key == 'backspace' then
			written = ''					
		elseif string.len(key)==1 then
			written = written..key
		elseif key == 'space' or key=='return' then
			table.insert(layers,written) table.insert(vision,{written,false}) crossX = {}
			if not level.map.cells[written] then level.map.cells[written]={}
				for i=1,level.map.mapX do table.insert(level.map.cells[written],{}) for i2=1,level.map.mapY do table.insert(level.map.cells[written][i],0) end end
			end
			written = ''
			enum = 0
		end
	elseif string.find(enum,'tile')~=nil then
		if key == 'backspace' then
			written = ''				
		elseif string.len(key)==1 then
			if not Shift then written = written..key
			else written = written .. string.upper(key) end
		elseif key == 'space' or key=='return' then
			for word in string.gmatch(enum,"%w+") do if word~='tile' then
				level.map.cells[word][level.movable['movetarget'].x][level.movable['movetarget'].y]=written
			end end
			enum=0 written=''
		end
	elseif string.find(enum,'save')~=nil then 
		if key == 'backspace' then
			written = ''				
		elseif string.len(key)==1 then
			written = written..key
		elseif key == 'space' or key=='return' then	
			mapLib.save(level.map,written)
			written = ''
			enum = 0
		end
	elseif string.find(enum,'load')~=nil then
		if key == 'backspace' then
			written = ''				
		elseif string.len(key)==1 then
			written = written..key
		elseif key == 'space' or key=='return' then	
			level.map.cells=mapLib.load(written)
			level.map.mapX = table.getn(level.map.cells['tiles'])
			level.map.mapY = table.getn(level.map.cells['tiles'][1])
			written = ''
			enum = 0
		end
	elseif string.find(enum,'mapX')~=nil then
		if key == 'backspace' then
			public.mapX = ''				
		elseif string.len(key)==1 and tonumber(key)~=nil then
			public.mapX = public.mapX..key
		elseif key == 'space' or key=='return' then	
			public.mapX = tonumber(public.mapX)
			if public.viewX>public.mapX then public.viewX=public.mapX end
			enum = 0
		end
	elseif string.find(enum,'mapY')~=nil then
		if key == 'backspace' then
			public.mapY = ''				
		elseif string.len(key)==1 and tonumber(key)~=nil then
			public.mapY = public.mapY..key
		elseif key == 'space' or key=='return' then	
			public.mapY = tonumber(public.mapY)
			if public.viewY>public.mapY then public.viewY=public.mapY end
			enum = 0
		end
	end
end
-- function love.errhand(msg)
	-- mapLib.save(level.map, 'reserve')
-- end
function levels.mapCreator.draw ()
	local ts = level.ts
	level.movable['movetarget'].x=(level.movable['movetarget'].x-1)*ts
	level.movable['movetarget'].y=(level.movable['movetarget'].y-1)*ts --not trash yet
	movableLib.draw()
	for i,v in pairs(level.movable) do --if i~='movetarget' then
		local m_x = 0 local m_y = 0
		m_x = v.x/level.ts-math.floor(level.map.viewX/2)+1 m_y = v.y/level.ts-math.floor(level.map.viewY/2)+1
		if v.x/level.ts>=level.map.mapX-math.ceil(level.map.viewX/2)-1 then m_x=level.map.mapX-math.floor(level.map.viewX/2)*2-level.map.viewX%2 end
		if v.x/level.ts<math.floor(level.map.viewX/2)-1 then m_x=0 end
		if m_x==v.x/level.ts-math.floor(level.map.viewX/2)+1 then end
		
		if v.y/level.ts>=level.map.mapY-math.ceil(level.map.viewY/2)-1 then m_y=level.map.mapY-math.floor(level.map.viewY/2)*2-level.map.viewY%2 end
		if v.y/level.ts<math.floor(level.map.viewY/2)-1 then m_y=0 end
		if m_y==v.y/level.ts-math.floor(level.map.viewY/2)+1 then end
		level.map['m_x']=math.floor(m_x)
		level.map['m_y']=math.floor(m_y)
	break end --end
	local m_x=level.map.m_x local m_y=level.map.m_y
	local layer_str = ''
	local vision_str = ''
	for _,v in ipairs(layers) do layer_str=layer_str..v end
	for _,v in ipairs(vision) do vision_str=vision_str..v[1]..' ' end
	local function WordVision(iterator) 
		for i,v in ipairs(vision) do if v[1]==iterator then return (v[2]) end end
		return false
	end
	for i=1,level.map.viewX do for i2=1,level.map.viewY do
		love.graphics.draw(level.map.mapImages['tiles']['0'],(i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50)
	end end
	level.movable['movetarget'].x=(level.movable['movetarget'].x)/ts+1 level.movable['movetarget'].y=(level.movable['movetarget'].y)/ts+1
	
	for iterator,value in pairs(level.map.cells) do if WordVision(iterator) or iterator=='allocates' then
		
		for i=1,level.map.viewX do for i2=1,level.map.viewY do
			if level.map.mapImages[iterator] and level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])] then
				love.graphics.draw(level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])],(i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50)
			elseif iterator~='allocates' then
				love.graphics.print({{string.len(iterator)*1,string.len(iterator)*10,string.len(iterator)*1},value[i+m_x][i2+m_y]},(i-0.5)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50)
			end
		
			if iterator=='allocates' and value[i+m_x][i2+m_y]=='A' then 
				if i2+m_y>1 and level.map.cells.allocates[i+m_x][i2+m_y-1]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50) end
				if i+m_x<level.map.mapX-1 and level.map.cells.allocates[i+m_x+1][i2+m_y]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line1'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50) end
				if i2+m_y<level.map.mapY-1 and level.map.cells.allocates[i+m_x][i2+m_y+1]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line2'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50) end
				if i+m_x>1 and level.map.cells.allocates[i+m_x-1][i2+m_y]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line3'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50) end				
			end
		
		end end

	end	end 
	-- for i=1,level.map.viewY do
		-- love.graphics.print( i+m_y , level.map.offsetX-string.len(i)*7, level.map.offsetY+(i-1)*level.ts )
	-- end
	for iterator,v in pairs(level.movable) do if iterator=='movetarget' then
		if timer%0.5<0.34 or timer<0 then 
			local m_x = v.x local m_y = v.y
			if v.x>level.map.mapX-math.ceil(level.map.viewX/2) then m_x=level.map.mapX-level.map.viewX 
			elseif v.x<math.floor(level.map.viewX/2) then m_x=0 
			else m_x=(v.x)-math.floor(level.map.viewX/2) end

			if v.y>level.map.mapY-math.ceil(level.map.viewY/2) then m_y=level.map.mapY-level.map.viewY 
			elseif v.y<math.floor(level.map.viewY/2) then m_y=0 
			else m_y=(v.y)-math.floor(level.map.viewY/2) end

			if not insert then love.graphics.draw(v.image,(v.x-m_x-1)*level.ts+level.map.offsetX,(v.y-m_y-1)*level.ts+level.map.offsetY,0,level.ts/50) 
			else for i=1,2 do love.graphics.draw(v.image,(v.x-m_x-1)*level.ts+level.map.offsetX,(v.y-m_y-1)*level.ts+level.map.offsetY,0,level.ts/50) end end
		end
	end end
	local indent = level.map.offsetX+level.map.viewX*level.ts
	--local indent = 1000
	str_layer = ''
	local I = 0
	for iterator,v in pairs(bars) do local l_tiles = v.tiles
		for i=1,table.getn(l_tiles) do 
			for i2=1,table.getn(l_tiles[i]) do
				im_str = l_tiles[i][i2]
				if im_str~=nil and im_str~=0 and level.map.mapImages['tiles'][im_str] then
					love.graphics.draw(level.map.mapImages['tiles'][im_str],(i-1)*50/(level.ts/20),I*level.ts+(i2-1)*50/(level.ts/20),0,20/level.ts) --not trash yet(level.ts/20==const)
				end
			end
		end
	I=I+table.getn(l_tiles) end
	for i=1,table.getn(layers) do
		local local_str = ''
		if level.map.cells[layers[i]] and level.map.cells[layers[i]][level.movable['movetarget'].x] and level.map.cells[layers[i]][level.movable['movetarget'].x][level.movable['movetarget'].y]~=nil then 
			local_str=level.map.cells[layers[i]][level.movable['movetarget'].x][level.movable['movetarget'].y]
		else local_str=''
		end

		love.graphics.print({{255,1,1},layers[i],{0,0,0},' ',{1,255,1},local_str},indent,(i)*30+20,0,2)

		str_layer = str_layer..layers[i]
		str_layer = str_layer..' '
	end
	love.graphics.print({{100,100,100},'now you see:'},level.map.offsetX+level.map.viewX*level.ts/2-40,10)
	love.graphics.print({{100,100,100},str_layer},level.map.offsetX+(level.map.viewX*level.ts/2-string.len(str_layer)*3),30)
	local i=0
	local num = 0
		for word in string.gmatch(str_layer , "%w+") do 
			num = num+1
			love.graphics.draw(cross,level.map.offsetX+(level.map.viewX*level.ts/2-string.len(str_layer)*3)+i*7,30)
			if WordVision(word) then love.graphics.draw(eye,level.map.offsetX+(level.map.viewX*level.ts/2-string.len(str_layer)*3)+i*7-3,40) end
			if crossX[num]==nil then crossX[num]=level.map.offsetX+(level.map.viewX*level.ts/2-string.len(str_layer)*3)+i*7 end
			i=i+string.len(word) 
			if string.find(word,'i')~=nil then i=i-0.5 end
			if string.find(word,'l')~=nil then i=i-0.5 end
			if string.find(word,'m')~=nil then i=i+1 end
			if string.find(word,'p')~=nil then i=i+0.5 end
			if string.find(word,'n')~=nil then i=i+0.5 end
		end
	if enum~='' then love.graphics.print(enum) else love.graphics.print('empty') end
	love.graphics.print(written,0,50)
	love.graphics.print(level.map.mapX,100)
	love.graphics.print(level.map.mapY,200)
	
	if public.bool==true then 
		love.graphics.print({{255,240,16},'mapX is  '..public.mapX},100,100)
		love.graphics.print({{255,240,16},'mapY  is  '..public.mapY},100,111)
	end
end
function newLayer()
	local counter = 1
	local arr_of_controls = {}
	for i,v in pairs(level.map.cells) do if string.find('control',i) then counter=counter+1 end end
	local l_name = 'control'..counter

		local l_cell = {}
		for i = 1, level.map.mapX do 
			table.insert (l_cell, {})
			for i2=1,level.map.mapY do
				table.insert (l_cell[i],{})
			end
		end
	
	level.map.cells[l_name] = l_cell
	return l_name
end 
