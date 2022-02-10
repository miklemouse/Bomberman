--levelLib
levelLib = {
		ts = 0,
		map = {},
		movable = {}
}
function levelLib.new (argts,movable,map)
	local locallevel = {
		ts = argts,
		--mapX = mapX, mapY = mapY,
		map = map,
		movable = movable,
		POINTS = {}
	}
	--love.window.setMode(map.mapX*argts,map.mapY*argts,{})
	return locallevel
end

function levelLib.load (arglevel) --trash
	local levelLib = arglevel
	POINTS = POINTSlib.load (levelLib.movable, levelLib.map)
	map = levelLib.map 
	ts = levelLib.ts
	mapX = map.mapX mapY=map.mapY
	movable = levelLib.movable
	map.cells = mapLib.modify(mapX,mapY,map.cells) 
end
function levelLib.ForMovableUpdate (dt)
	dt = dt*acceleration
	local lPOINTS = level.POINTS
	local lmap = level.map
	local lts = level.ts 
	--local lpatf = POINTSlib.patf (II.strengthMax(level.movable).movevars.x,
	--II.strengthMax(level.movable).movevars.y,
	--II.strengthMax(level.movable).movevars.speed,
	--level.movable,
	--lPOINTS)
	
	--lPOINTS = lpatf.P 
	--levelLib.movable = lpatf.M
	
	for i,v in pairs(level.movable) do if v.controltype~='float' and not v.die then
		local trasharr={} --trash
		if v.controltype=='bot' then trasharr=v.varsides elseif v.controltype=='player' then trasharr=v.sports end
		if not v.movevars.moving then 
			if v.direct(v.movevars,v.controlarr,trasharr).movevars~=nil then v.movevars = v.direct(v.movevars,v.controlarr,trasharr).movevars
				--v.movevars = v.direct(v.movevars,v.controlarr,trasharr) 
			end
			v = v.develop(v) 
			if v.direct(v.movevars,v.controlarr,trasharr).controlarr~=nil then v.controlarr=v.direct(v.movevars,v.controlarr,trasharr).controlarr end
		end
		v.movevars=v.move(v.movevars,dt)
		if v.condition(v) then 
			level.movable[i] = v.death(v) end
		v.put(v,dt)
	elseif v.controltype~='float' then
		if v.varsides.time_to_death==nil then v.varsides.time_to_death = 0
		elseif v.varsides.time_to_death<3 then v.varsides.time_to_death=v.varsides.time_to_death+dt
		else
			if tonumber(i)~=nil then table.remove(level.movable,i) 
			else level.movable[i]=nil end
			break
		end 
	elseif v.controltype=='float' then
		if v.movevars.moving==false then 
			
			local VALUE = v.controlarr[v.movevars.x/level.ts+1][v.movevars.y/level.ts+1] 
			local variation = {}
			
			if v.movevars.x<(level.map.mapX-1)*level.ts and v.controlarr[v.movevars.x/level.ts+2][v.movevars.y/level.ts+1]==VALUE+1 then
				table.insert(variation, {v.movevars.x+level.ts, v.movevars.y, 1}) end
			if v.movevars.x>0 and v.controlarr[v.movevars.x/level.ts][v.movevars.y/level.ts+1]==VALUE+1 then
				table.insert(variation, {v.movevars.x-level.ts, v.movevars.y, 2}) end
			if v.controlarr[v.movevars.x/level.ts+1][v.movevars.y/level.ts+2]==VALUE+1 then
				table.insert(variation, {v.movevars.x, v.movevars.y+level.ts, 3}) end
			if v.controlarr[v.movevars.x/level.ts+1][v.movevars.y/level.ts]==VALUE+1 then
				table.insert(variation, {v.movevars.x, v.movevars.y-level.ts, 4}) end
			if table.getn(variation)>0 then 
				local element = variation[math.random(table.getn(variation))]
				v.movevars.targetX = element[1]
				v.movevars.targetY = element[2]
				v.movevars.moveDirection = element[3]
				v.movevars.moving = true
			end
		end
		
		--v.movevars = II.chess.direct(v.movevars,{0,'standart',v.controlarr})
		v.movevars = v.move(v.movevars,dt)
	end	end 
	
--	for i,v in pairs(level.movable) do v.movevars.move=true end
end
p_boolEAN = true
function levelLib.draw (arg)
	local st_var = 0
	local localchar = ''
	for i,v in pairs(level.movable) do --if i~='movetarget' then
		local m_x = 0 local m_y = 0
		m_x = v.movevars.x/level.ts-math.floor(level.map.viewX/2)+1 m_y = v.movevars.y/level.ts-math.floor(level.map.viewY/2)+1
		if v.movevars.x/level.ts>=level.map.mapX-math.ceil(level.map.viewX/2)-1 then m_x=level.map.mapX-math.floor(level.map.viewX/2)*2-level.map.viewX%2 end
		if v.movevars.x/level.ts<math.floor(level.map.viewX/2)-1 then m_x=0 end
		if m_x==v.movevars.x/level.ts-math.floor(level.map.viewX/2)+1 then end

		if v.movevars.y/level.ts>=level.map.mapY-math.ceil(level.map.viewY/2)-1 then m_y=level.map.mapY-math.floor(level.map.viewY/2)*2-level.map.viewY%2 end
		if v.movevars.y/level.ts<math.floor(level.map.viewY/2)-1 then m_y=0 end
		if m_y==v.movevars.y/level.ts-math.floor(level.map.viewY/2)+1 then end
		level.map['m_x']=math.floor(m_x)
		level.map['m_y']=math.floor(m_y)
		if v.movevars.x/level.ts<math.floor(level.map.viewX/2)-1 or m_x==level.map.mapX-math.floor(level.map.viewX/2)*2-level.map.viewX%2 then level.map['m_xr']=0 else level.map['m_xr']=(v.movevars.x)%level.ts end
		if v.movevars.y/level.ts<math.floor(level.map.viewY/2)-1 or m_y==level.map.mapY-math.floor(level.map.viewY/2)*2-level.map.viewY%2 then level.map['m_yr']=0 else level.map['m_yr']=(v.movevars.y)%level.ts end
	break end --end
	if level.map.viewX>=level.map.mapX then level.map.m_x=0 end --not trash yet
	if level.map.viewY>=level.map.mapY then level.map.m_y=0 end --not trash yet
	if level.map.m_x==nil then level.map.m_x=0 end
	if level.map.m_y==nil then level.map.m_y=0 end
	if level.map.m_xr==nil then level.map.m_xr=0 end
	if level.map.m_yr==nil then level.map.m_yr=0 end
	mapLib.draw(level.map.m_x,level.map.m_y,-level.map.m_xr,-level.map.m_yr)
	movableLib.draw(-level.map.m_x,-level.map.m_y,-level.map.m_xr,-level.map.m_yr)
	if arg==true then mapLib.lightDraw(level.map.m_x,level.map.m_y,-level.map.m_xr,-level.map.m_yr) end
	love.graphics.draw(cells_canvas)
	love.graphics.draw(movable_canvas)
	if arg==true then love.graphics.draw(canvas,m_xr,m_yr) end
end