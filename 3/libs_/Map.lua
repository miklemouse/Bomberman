mapLib = {
	standartProbability = {
		randLim = 80, {14, 'Boot'}, {28, 'Flame'}, {40, 'Boom'}, {47, 'Shield'}, {54, 'Detonator'}, {61, 'BS'}, {64, 'BBall'}, {68, 'FBall'},	{70, 'SFlame'}	
	}
}
function mapLib.StImpermanent_exploddy(ix,iy)
	local ft = level.map.cells.impermanents[ix][iy].ft
	local function littleline(arg,X,Y) 
		if X>0 and X<=level.map.mapX and Y>0 and Y<=level.map.mapY then
			if level.map.cells.obstructions[X][Y]==0 or level.map.cells.tiles[X][Y]=='B' or arg=='Fm' then
				level.map.cells.impermanents[X][Y]={0,ft,Im=arg}
				level.map.cells.obstructions[X][Y]=0
				level.map.cells.tiles[X][Y]=0
				level.map.cells.fatals[X][Y]=1	
			end
		end
	end
	littleline('Fm',ix,iy)
	littleline('Fr',ix+1,iy)
	littleline('Fl',ix-1,iy)
	littleline('Fd',ix,iy+1)
	littleline('Fu',ix,iy-1)
end
function mapLib.StImpermanent_explode(ix,iy) --not trash yet (map = level.map)
	local map = level.map
	l_impermanent = map.cells[ix][iy].impermanent
	local function line(S,S2,arg)
		local var = map.cells[S][S2].impermanent
		local boolean = false
		if S>0 then
			if map.cells[S][S2].enriching~='' then boolean=true end
			--if var == nil or var == 'Fr' or var == 'Fm' or var == 'Fd' or var == 'Fl' or var == 'Fu' then
			if not boolean and map.cells[S][S2].obstruction==0 then
				if var~=arg and var~=nil then local_fire='Fm' else local_fire=arg end 
					map.cells[S][S2]['impermanent']={}
					map.cells[S][S2]['impermanent']={0,l_impermanent.ft,Im=local_fire}
					map.cells[S][S2]['impermanent'].countdown= mapLib.StImpermanent_burn
					map.cells[S][S2].fatal = 1
					map.cells[S][S2].tile = 0
			elseif boolean then	local a=math.random(map.probability.randLim)

						for i,v in ipairs(map.probability) do
							if a<=v[1] then map.cells[S][S2].bonus=v[2] break end
						end
						
						map.cells[S][S2]['impermanent']={0,l_impermanent.ft,Im = 'Fb'} --trash (fire .. map.cells[S][S2].enriching)
						map.cells[S][S2]['impermanent'].countdown = mapLib.StImpermanent_burn
						map.cells[S][S2].enriching=''
						map.cells[S][S2].tile=0
						map.cells[S][S2].obstruction=0
			end
			--end 
		end
	end
			map.cells[ix][iy].tile=0
			map.cells[ix][iy].obstruction=0
			for i,v in ipairs(level.movable) do if l_impermanent.num==v.num and v.bombsvars.bombs<v.bombsvars.maxBombs then locallocalnum=v.num v.bombsvars.bombs = v.bombsvars.bombs+1 end end
			local range = l_impermanent.range
			map.cells[ix][iy].impermanent={0,l_impermanent.ft,Im='Fm'}
			map.cells[ix][iy].fatal = 1
			map.cells[ix][iy]['impermanent'].countdown = mapLib.StImpermanent_burn
			local mapX = map.mapX local mapY = map.mapY
			for side=1,range do if ix+side<=mapX then if map.cells[ix+side][iy].obstruction~=0 then line(ix+side,iy,'Fr') break end line(ix+side,iy,'Fr') end end
			for side=1,range do if ix-side>=1 then if map.cells[ix-side][iy].obstruction~=0 then line(ix-side,iy,'Fl') break end line(ix-side,iy,'Fl') end end
			for side=1,range do if iy+side<=mapY then if map.cells[ix][iy+side].obstruction~=0 then line(ix,iy+side,'Fd') break end line(ix,iy+side,'Fd') end end
			for side=1,range do if iy-side>=1 then if map.cells[ix][iy-side].obstruction~=0 then line(ix,iy-side,'Fu') break end line(ix,iy-side,'Fu') end end
	return (map.cells)
end
function mapLib.StImpermanent_detonate (ix,iy,imp,dt) --trash
	if imp[1]<imp[2] then 
		imp[1]=imp[1]+dt
	else level.map.cells = mapLib.StImpermanent_explode(ix,iy,level.map)
		imp = level.map.cells[ix][iy].impermanent --not trash yet
	end
	return imp
end
function mapLib.StImpermanent_burn (ix,iy,imp,dt)
	if imp[1]<imp[2] then 
		imp[1]=imp[1]+dt
	else imp = nil
		level.map.cells[ix][iy].fatal = 0
	end
	return imp
end
function mapLib.StImpermanent_loadfunc()
	if level.map then 
		for i=1,level.map.mapX do for i2=1,level.map.mapY do
			if level.map.cells[i][i2].impermanent and string.find(level.map.cells[i][i2].impermanent['Im'],'F')~=nil then
				level.map.cells[i][i2].impermanent.countdown = mapLib.StImpermanent_burn
			end
			if level.map.cells[i][i2].impermanent and string.find(level.map.cells[i][i2].impermanent['Im'],'B')~=nil then
				level.map.cells[i][i2].impermanent.countdown = mapLib.StImpermanent_detonate
			end
		end end
	end
end
function mapLib.new (arg_T, argmapImages, a_probability, a_mapViewX, a_mapViewY, a_mapOffsetX, a_mapOffsetY)		
	local l_mapX = 0 local l_mapY = 0
	local l_cells = {}
	local l_boolT = false
	for i,v in pairs(arg_T) do if i=='mapX' then l_boolT=false else l_boolT=true end break end
	if l_boolT then l_cells = mapLib.load(arg_T[1]) l_mapX = table.getn(l_cells.tiles) l_mapY = table.getn(l_cells.tiles[1])
	else l_mapX = arg_T['mapX'] l_mapY = arg_T['mapY'] end
	local l_map = {
		cells = l_cells, floats = {},
		mapX = l_mapX, mapY = l_mapY,
		viewX = a_mapViewX, viewY = a_mapViewY,
		offsetX = a_mapOffsetX, offsetY = a_mapOffsetY,
		mapImages = {}, probability = a_probability
	}
if not l_boolT then
	local function cell (arg)
		local l_cell = {}
		for i = 1, l_map.mapX do 
			table.insert (l_cell, {})
			for i2=1, l_map.mapY do
				table.insert (l_cell[i],arg)
			end
		end
		return l_cell
	end
	
	l_map.cells['tiles']=cell(0)
	l_map.cells['fatals']=cell(0)
	l_map.cells['bonuses']=cell(0)
	l_map.cells['allocates']=cell(0)
	l_map.cells['obstructions']=cell(0)
	l_map.cells['impermanents']=cell(0)
	l_map.cells['enrichings']=cell(0)
	l_map.cells['lights']=cell(0)
	l_map.cells['lamps']=cell(0)
end
	for i,v in pairs(argmapImages) do
		l_map.mapImages[i]={}
		for i3,v3 in pairs(v) do
			if i3 == 'F' then i3='0' end
			l_map.mapImages[i][i3] = love.graphics.newImage ('images/' .. i .. '/' .. v3 .. '.png')
		end
	end
	if l_map.cells.lights~=nil then if arg_T.ts==nil then arg_T.ts=50 end
	canvas = love.graphics.newCanvas(l_map.viewX*arg_T.ts,l_map.viewY*arg_T.ts)
	cells_canvas = love.graphics.newCanvas(l_map.viewX*arg_T.ts,l_map.viewY*arg_T.ts)
	movable_canvas = love.graphics.newCanvas(l_map.viewX*arg_T.ts,l_map.viewY*arg_T.ts)
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()
	love.graphics.setCanvas(cells_canvas)
		love.graphics.clear()
		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()
	love.graphics.setCanvas(movable_canvas)
		love.graphics.clear()
		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()
	end
	return l_map
end

function mapLib.updateimpermanent (a_map,dt) --trash
	local map = a_map
	for i=1,map.mapX do 
	for i2=1,map.mapY do 
		if map.cells[i][i2].impermanent and map.cells[i][i2].impermanent.countdown then
			map.cells[i][i2].impermanent = map.cells[i][i2].impermanent.countdown(i,i2,map.cells[i][i2].impermanent,dt)
		end 
	end 
	end
	for i,v in ipairs(map.floats) do v.movevarsF = v.move(v.movevarsF,dt) 
		if not v.movevarsF.moving and v.movevarsF.x%level.ts==0 and v.movevarsF.y%level.ts==0 then 
			map.cells[ v.movevarsF.x/level.ts+1 ][ v.movevarsF.y/level.ts+1 ] = v.cellF
			map.floats[i]=nil break
		end
	end
end
function mapLib.funbonus (t,dt,ix,iy)
if f_points==nil then
	f_points = {}
	for i=1,level.map.mapX do table.insert(f_points,{}) for i2=1,level.map.mapY do table.insert(f_points[i],0) end end
	f_points[ix][iy]='Fm'
end
f_points[ix][iy]='Fm'
if t<0.1 then t=t+dt else t=0
	for i=1,level.map.mapX do for i2=1,level.map.mapX do 
		if (f_points[i][i2]=='Fm') then 
			if i<level.map.mapX and f_points[i+1][i2]==0 and level.map.cells.obstructions[i+1][i2]==0 then f_points[i+1][i2]='Fr' end
			if i>1 and f_points[i-1][i2]==0 and level.map.cells.obstructions[i-1][i2]==0 then f_points[i-1][i2]='Fl' end
			if i2<level.map.mapY and f_points[i][i2+1]==0 and level.map.cells.obstructions[i][i2+1]==0 then f_points[i][i2+1]='Fd' end
			if i2>1 and f_points[i][i2-1]==0 and level.map.cells.obstructions[i][i2-1]==0 then f_points[i][i2-1]='Fu' end
		end 
		if f_points[i][i2]=='Fr' or f_points[i][i2]=='Fl' or f_points[i][i2]=='Fd' or f_points[i][i2]=='Fu' then 
			f_points[i][i2]='Fm'
		end
	end end
	for i=1,level.map.mapX do for i2=1,level.map.mapY do 
		if f_points[i][i2]~=0 then 
			level.map.cells.impermanents[i][i2]={0,3,Im=f_points[i][i2]}
			level.map.cells.fatals[i][i2]=1
		end 
	end end
end
	return t
end

function mapLib.save(argmap,argstr)
	local str = '' 
	str = argmap.mapX
	
	for iterator,v in pairs(argmap.cells) do if iterator~='enrichings' then --not trash yet
		local smallstr = "\r\n"..iterator
		str = str..smallstr
		for i2=1,argmap.mapY do for i=1,argmap.mapX do
			str=str..' '..v[i][i2]
		end end
	end end
	
	love.filesystem.write('maps/'..argstr..'.txt',str)

end
function mapLib.saveO(argmap,argstr)
	str = argmap.mapX
	for iterator,v in pairs(argmap.cells) do 
		local smallstr = "\r\n"..iterator
		str = str..smallstr
		for i=1,argmap.mapX do for i2=1,argmap.mapY do if v[i][i2]~=nil then
			str = str..' '..v[i][i2]
		end end end
	end
	return str
end
function mapLib.load(arg)
	local file = love.filesystem.read('maps/'..arg..'.txt')
	local l_map = {}
	local X = 1
	local C = 0
	for line in string.gmatch(file,"[^\r\n]+") do X=tonumber(line) break end
	for line in string.gmatch(file,"[^\r\n]+") do if C>0 then
		local myside = -1
		for word in string.gmatch(line,"%w+") do 
			if myside==-1 then key = word l_map[key]={} 
			else
				if tonumber(word)~=nil then if string.find(word,'-')==nil then word=tonumber(word) else word=-tonumber(word) end end
				if l_map[key][(myside%X)+1]==nil then l_map[key][(myside%X)+1]={} end
				l_map[key][(myside%X)+1][math.floor(myside/X)+1] = word
			end
			myside=myside+1
		end
	else C=1
	end end
	return l_map
end
function mapLib.randmodify(mapX,mapY,a_cells)
	local l_cells=a_cells
	for i=2,mapX-1,2 do
		for i2=2,mapY-1,2 do
			l_cells[i][i2].tile='B'
			l_cells[i][i2].obstruction=1
			l_cells[i][i2].enriching='B'
		end
	end
	for integer=0,math.floor(mapX*mapY/25) do
		maprand = love.math.random(2,mapX-1)
		maprand2 = love.math.random(2,mapY-1)
		if l_cells[maprand][maprand2].tile~='B' then l_cells[maprand][maprand2].tile='S'
			l_cells[maprand][maprand2].obstruction=1 end
	end
	for integer=0,mapX*mapY/36 do
		maprand=love.math.random(math.floor(mapY/2))
		for a=2,mapX-2 do
			l_cells[a][maprand*2].tile='B'
			l_cells[a][maprand*2].enriching='B'
			l_cells[a][maprand*2].obstruction=1
		end
		maprand=love.math.random(math.floor(mapX/2))
		for a=2,mapY-2 do
			l_cells[maprand*2][a].tile='B'
			l_cells[maprand*2][a].enriching='B'		
			l_cells[maprand*2][a].obstruction=1
		end
	end	
	return l_cells
end
function mapLib.drawO (m_x,m_y)
	local map = level.map
	local ts = level.ts
	local mapX = map.mapX 
	local mapY = map.mapY
	for iterator,v in map.cells do
		for i=1,map.viewX do
		for i2=1,map.viewY do
			love.graphics.draw(map.mapImages['tiles']['0'], (i-1)*ts+level.map.offsetX,(i2-1)*ts+level.map.offsetY,0,50/ts)
			for it,vc in pairs (map.cells[i+m_x][i2+m_y]) do
				if map.mapImages[it] then --not trash yet
					if map.mapImages[it][tostring(v)] then 
					love.graphics.draw(map.mapImages[it][tostring(v)], (i-1)*ts+level.map.offsetX,(i2-1)*ts+level.map.offsetY,0,50/ts)
					elseif v~=0 then
						if map.mapImages[it][tostring(v.Im)] then --not trash yet
							love.graphics.draw(map.mapImages[it][tostring(v.Im)], (i-1)*ts+level.map.offsetX,(i2-1)*ts+level.map.offsetY,0,50/ts)
						end	
					end
				end
				if it=='allocate' and v=='A' then 
					if i2+m_y>1 and map.cells[i+m_x][i2+m_y-1].allocate~='A' then love.graphics.draw(map.mapImages['allocate']['Line'], (i-1)*ts+level.map.offsetX,(i2-1)*ts+level.map.offsetY,0,50/ts) end
					if i+m_x<mapX-1 and map.cells[i+m_x+1][i2+m_y].allocate~='A' then love.graphics.draw(map.mapImages['allocate']['Line1'], (i-1)*ts+level.map.offsetX,(i2-1)*ts+level.map.offsetY,0,50/ts) end
					if i2+m_y<mapY-1 and map.cells[i+m_x][i2+m_y+1].allocate~='A' then love.graphics.draw(map.mapImages['allocate']['Line2'], (i-1)*ts+level.map.offsetX,(i2-1)*ts+level.map.offsetY,0,50/ts) end
					if i+m_x>1 and map.cells[i+m_x-1][i2+m_y].allocate~='A' then love.graphics.draw(map.mapImages['allocate']['Line3'], (i-1)*ts+level.map.offsetX,(i2-1)*ts+level.map.offsetY,0,50/ts) end				
				end
			end
		end
		end
	end
	for it,v in ipairs(map.floats) do love.graphics.draw(v.imageF,v.movevarsF.x,v.movevarsF.y) end
end
function mapLib.lightDrawO(m_x,m_y) if black==nil then black=love.graphics.newImage('sides/Black.png') the_black=love.graphics.newImage('sides/THEBLACK.png') end
	local phi = (1+math.sqrt(5))/2
	for i=1,level.map.mapX do for i2=1,level.map.mapY do if level.map.cells.tiles[i][i2]~='T' then level.map.cells.lights[i][i2]=0 end
		if level.map.cells.impermanents[i][i2]~=0 then local CHAR = level.map.cells.impermanents[i][i2].Im
			if string.find(CHAR,'F')~=nil then level.map.cells.lights[i][i2]=8 end
		end
	end end
	if level.movable[1] then level.map.cells.lights[math.floor(level.movable[1].movevars.x/level.ts)+1][math.floor(level.movable[1].movevars.y/level.ts)+1]=10 end
	for _=1,25 do
		for i=1,level.map.mapX do for i2=1,level.map.mapY do 
			if level.map.cells.lights[i][i2]~=0 then 
				if i>1 then level.map.cells.lights[i-1][i2]=math.max(level.map.cells.lights[i-1][i2],level.map.cells.lights[i][i2]-1) end
				if i<level.map.mapX then level.map.cells.lights[i+1][i2]=math.max(level.map.cells.lights[i+1][i2],level.map.cells.lights[i][i2]-1) end
				if i2>1 then level.map.cells.lights[i][i2-1]=math.max(level.map.cells.lights[i][i2-1],level.map.cells.lights[i][i2]-1) end
				if i2<level.map.mapY then level.map.cells.lights[i][i2+1]=math.max(level.map.cells.lights[i][i2]-1,level.map.cells.lights[i][i2+1]) end

				if i>1 and i2>1 then level.map.cells.lights[i-1][i2-1]=math.max(level.map.cells.lights[i-1][i2-1],((level.map.cells.lights[i][i2]-1)/math.sqrt(2))) end
				if i>1 and i2<level.map.mapY then level.map.cells.lights[i-1][i2+1]=math.max(level.map.cells.lights[i-1][i2+1],((level.map.cells.lights[i][i2]-1)/math.sqrt(2))) end
				if i<level.map.mapX and i2>1 then level.map.cells.lights[i+1][i2-1]=math.max(level.map.cells.lights[i+1][i2-1],((level.map.cells.lights[i][i2]-1)/math.sqrt(2))) end
				if i<level.map.mapX and i2<level.map.mapY then level.map.cells.lights[i+1][i2+1]=math.max(level.map.cells.lights[i+1][i2+1],((level.map.cells.lights[i][i2]-1)/math.sqrt(2))) end

			end
		end end
	end
	for i=1,level.map.viewX do for i2=1,level.map.viewY do
		local X = level.map.cells.lights[i+m_x][i2+m_y] if X==0 then X=1 end
		--local lim = X*2
		local lim = math.ceil((math.pow(phi,X)-math.pow(-phi,-X))/2*phi-1)-1
		for integer=5,math.ceil(lim/5),-1 do love.graphics.draw(the_black,(i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY) end
		for integer=5,(lim+math.ceil(lim/5)),-1 do love.graphics.draw(black,(i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY) end
	end end
end
function previous(X)
	function nn(n)
		if n==0 then n=1 end
		return math.ceil((math.pow(phi,n)-math.pow(-phi,-n))/2*phi-1)
	end
	function num(arg_X)
		local NUM = 0
		local i = 0
		while (i<=arg_X) do 
			i = nn(i+1)
			NUM = i
			if i>100 then break end
		end
		return NUM
	end
	return ( nn(num(X)-1) )
end
function L_OBS(i,i2,arg1,arg2)
	return (level.map.cells.obstructions[i+arg1][i2]==0 or level.map.cells.obstructions[i][i2+arg2]==0)
end
function mapLib.lightDraw(m_x,m_y,m_xr,m_yr)
	for i=1,level.map.mapX do for i2=1,level.map.mapY do 
	
		level.map.cells.lights[i][i2]=level.map.cells.lamps[i][i2]

	end end

	if level.movable[1] then 
		local xi = math.floor(level.movable[1].movevars.x/level.ts)+1 local yi = math.floor(level.movable[1].movevars.y/level.ts)+1
		level.map.cells.lights[xi][yi]=math.max(level.map.cells.lights[xi][yi],level.movable[1].brightness) 
		local l_char = level.movable[1].imageNow[1]
		local vi1=xi local vi2=yi
		if l_char=='R' then vi1=xi+1
		elseif l_char=='L' then vi1=xi-1
		elseif l_char=='D' then vi2=yi+1
		elseif l_char=='U' then vi2=yi-1 end
		if vi1<level.map.mapX and vi1>0 and vi2<level.map.mapY and vi2>0 then level.map.cells.lights[vi1][vi2]=math.max(level.map.cells.lights[vi1][vi2],level.movable[1].brightness-0.7) end
	end
	for _=1,25 do
	for i=1,level.map.mapX do for i2=1,level.map.mapY do
		if level.map.cells.lightobs==nil and level.map.cells.obstructions[i][i2]==0 then bool=true end
		if bool or level.map.cells.lights[i][i2]~=0 and level.map.cells.lightobs[i][i2]==0 then 
			if i>1 then level.map.cells.lights[i-1][i2]=math.max(level.map.cells.lights[i-1][i2],level.map.cells.lights[i][i2]-1) end
			if i<level.map.mapX then level.map.cells.lights[i+1][i2]=math.max(level.map.cells.lights[i+1][i2],level.map.cells.lights[i][i2]-1) end
			if i2>1 then level.map.cells.lights[i][i2-1]=math.max(level.map.cells.lights[i][i2-1],level.map.cells.lights[i][i2]-1) end
			if i2<level.map.mapY then level.map.cells.lights[i][i2+1]=math.max(level.map.cells.lights[i][i2+1],level.map.cells.lights[i][i2]-1) end

			if i>1 and i2>1 and L_OBS(i,i2,-1,-1) then level.map.cells.lights[i-1][i2-1]=math.max(level.map.cells.lights[i-1][i2-1],((level.map.cells.lights[i][i2])/1.62)) end
			if i>1 and i2<level.map.mapY and L_OBS(i,i2,-1,1) then level.map.cells.lights[i-1][i2+1]=math.max(level.map.cells.lights[i-1][i2+1],((level.map.cells.lights[i][i2])/1.62)) end
			if i<level.map.mapX and i2>1 and L_OBS(i,i2,1,-1) then level.map.cells.lights[i+1][i2-1]=math.max(level.map.cells.lights[i+1][i2-1],((level.map.cells.lights[i][i2])/1.62)) end
			if i<level.map.mapX and i2<level.map.mapY and L_OBS(i,i2,1,1) then level.map.cells.lights[i+1][i2+1]=math.max(level.map.cells.lights[i+1][i2+1],((level.map.cells.lights[i][i2])/1.62)) end

		end
	end end
	end

	if level.map.viewX+m_x<level.map.mapX then VIEWX = level.map.viewX+1 else VIEWX = level.map.viewX end
	if level.map.viewY+m_y<level.map.mapY then VIEWY = level.map.viewY+1 else VIEWY = level.map.viewY end
	if m_x>0 then BEGIN1=0 else BEGIN1=1 end
	if m_y>0 then BEGIN2=0 else BEGIN2=1 end

	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		for i=BEGIN2,VIEWX do for i2=BEGIN2,VIEWY do
			love.graphics.setColor(0,0,0,255-level.map.cells.lights[i+m_x][i2+m_y]*10)
			love.graphics.rectangle('fill',(i-1)*level.ts+level.map.offsetX+m_xr,(i2-1)*level.ts+level.map.offsetY+m_yr,level.ts,level.ts) 
			love.graphics.setColor(255,255,255)
			--love.graphics.print(num(level.map.cells.lights[i][i2]),(i-0.5)*level.ts,(i2-0.5)*level.ts,0,0.6)
		end end
	love.graphics.setCanvas()

end
function mapLib.lightDrawO2(m_x,m_y) if black==nil then black=love.graphics.newImage('sides/Black.png') the_black=love.graphics.newImage('sides/THEBLACK.png') end
	if bool then for i=1,level.map.mapX do for i2=1,level.map.mapY do 
		level.map.cells.lights=lightning(level.map.cells.lights[i][i2])
	end end bool=false end
	for i=1,level.map.mapX do for i2=1,level.map.mapY do 
		if i>1 then level.map.cells.lights[i-1][i2]=math.max(level.map.cells.lights[i-1][i2],level.map.cells.lights[i][i2]-1) end
		if i<level.map.mapX then level.map.cells.lights[i+1][i2]=math.max(level.map.cells.lights[i+1][i2],level.map.cells.lights[i][i2]-1) end
		if i2>1 then level.map.cells.lights[i][i2-1]=math.max(level.map.cells.lights[i][i2-1],level.map.cells.lights[i][i2]-1) end
		if i2<level.map.mapY then level.map.cells.lights[i][i2+1]=math.max(level.map.cells.lights[i][i2]-1,level.map.cells.lights[i][i2+1]) end		
	end end
end
function mapLib.draw(m_x,m_y,m_xr,m_yr)
love.graphics.setCanvas(cells_canvas)
	love.graphics.clear()
	if level.map.viewX+m_x<level.map.mapX then VIEWX = level.map.viewX+1 else VIEWX = level.map.viewX end
	if level.map.viewY+m_y<level.map.mapY then VIEWY = level.map.viewY+1 else VIEWY = level.map.viewY end
	if m_x>0 then BEGIN1=0 else BEGIN1=1 end
	if m_y>0 then BEGIN2=0 else BEGIN2=1 end
	for i=BEGIN1,VIEWX do for i2=BEGIN2,VIEWY do
		love.graphics.draw(level.map.mapImages['tiles']['0'],(i-1)*level.ts+level.map.offsetX+m_xr,(i2-1)*level.ts+level.map.offsetY+m_yr,0,level.ts/50)
	end end
	for iterator,value in pairs(level.map.cells) do
		for i=BEGIN1,VIEWX do for i2=BEGIN2,VIEWY do
			if level.map.mapImages[iterator]~=nil and level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])]~=nil and level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])]~=nil then
				love.graphics.draw(level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])],(i-1)*level.ts+level.map.offsetX+m_xr,(i2-1)*level.ts+level.map.offsetY+m_yr,0,level.ts/50)
			--elseif level.map.mapImages[iterator] and level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])] then
				--if level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])][1]<=math.random(40) then 
					--love.graphics.draw(level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])])
				--end not trash 
			end

			if iterator=='impermanents' and value[i+m_x][i2+m_y]~=0 then 
				if level.map.mapImages[iterator] and level.map.mapImages[iterator][value[i+m_x][i2+m_y].Im] then
					love.graphics.draw(level.map.mapImages[iterator][value[i+m_x][i2+m_y].Im],(i-1)*level.ts+level.map.offsetX+m_xr,(i2-1)*level.ts+level.map.offsetY+m_yr,0,level.ts/50)
				end
			end
	
		end end 
	end
	--local value = level.map.cells.water 
		--for i=BEGIN1,VIEWX do for i2=BEGIN2,VIEWY do
			--love.graphics.print(tostring(value[i+m_x][i2+m_y]),(i-1)*level.ts+level.map.offsetX+m_xr,(i2-1)*level.ts+level.map.offsetY+m_yr,0,level.ts/50)
		--end end
		
love.graphics.setCanvas()
end
function mapLib.drawO(m_x,m_y) --NOT TRASH
	for i=1,level.map.viewX do for i2=1,level.map.viewY do
		love.graphics.draw(level.map.mapImages['tiles']['0'],(i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50)
	end end
	for iterator,value in pairs(level.map.cells) do
		for i=1,level.map.viewX do for i2=1,level.map.viewY do
			if level.map.mapImages[iterator] and level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])] then
				love.graphics.draw(level.map.mapImages[iterator][tostring(value[i+m_x][i2+m_y])],(i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50)
			end

			if iterator=='impermanents' and value[i+m_x][i2+m_y]~=0 then 
				if level.map.mapImages[iterator] and level.map.mapImages[iterator][value[i+m_x][i2+m_y].Im] then
					love.graphics.draw(level.map.mapImages[iterator][value[i+m_x][i2+m_y].Im],(i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,level.ts/50)
				end
			end
		
		if iterator=='allocates' and value[i+m_x][i2+m_y]=='A' then 
			if i2+m_y>1 and level.map.cells.allocates[i+m_x][i2+m_y-1]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,50/level.ts) end
			if i+m_x<level.map.mapX-1 and level.map.cells.allocates[i+m_x+1][i2+m_y]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line1'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,50/level.ts) end
			if i2+m_y<level.map.mapY-1 and level.map.cells.allocates[i+m_x][i2+m_y+1]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line2'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,50/level.ts) end
			if i+m_x>1 and level.map.cells.allocates[i+m_x-1][i2+m_y]~='A' then love.graphics.draw(level.map.mapImages['allocates']['Line3'], (i-1)*level.ts+level.map.offsetX,(i2-1)*level.ts+level.map.offsetY,0,50/level.ts) end				
		end
		end end 
	end
end