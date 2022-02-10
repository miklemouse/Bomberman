function myLevels(arg_ts, mapX, mapY, bush, players, arg_health, bots)
	ts = arg_ts
		local myplayer1 = createP('w','a','s','d','space',ts*0,ts*0,arg_health,{"red",{255,0,0}},1)
		local myplayer2 = createP('up','left','down','right','return',(mapX-1)*ts,(mapY-1)*ts,arg_health,{"blue",{0,0,255}},2)
		local myplayer3 = createP('9','i','o','p','backspace',(mapX-1)*ts,0*ts,arg_health,{"green",{10,200,10}},3)
		local myplayer4 = createP('g','v','b','n','h',0*ts,(mapY-1)*ts,arg_health,{"pink",{255,100,100}},4)
	local localplayers = {myplayer1,myplayer2,myplayer3,myplayer4}
	local myplayers = {}
	for i=1,players do myplayers[i] = localplayers[i] end
	
	botsArrs = {}
	local mybots = {}
		--for i,v in pairs(bots) do 
			--local mybot1 = createBot(17*ts,6*ts,i,mapX,mapY,{'alien/'..i..'/Alien1' , 'alien/'..i..'/Alien2'},{targetYI=0})
			--table.insert( mybots , mybot )
		--end
		--mybot2=createBot(17*ts,6*ts,'fool')
	local myvalues = {
		{14, 'Boot'}, {28, 'Flame'}, {40, 'Boom'}, {47, 'Shield'}, {54, 'Detonator'}, {61, 'BS'}, {64, 'BBall'}, {68, 'FBall'},	{70, 'SFlame'}, {77, 'Health'}
	}
	local mapTarget={
		targetImages = {love.graphics.newImage('sides/Target.png'),
						love.graphics.newImage('sides/TargetGreen.png'),
						love.graphics.newImage('sides/TargetGrey.png')
		},
		imageNow = 0, 
		xS = 0,
		yS = 0
	}
	local myobs = {'K','B','S'}
	local mykilling = {'Fr','Fl','Fd','Fu','Fm','Spawn1','Spawn2','Spawn3'}
	local mapBon = {'K','Spawn1','Spawn2','Spawn3', "rip1", "rip2", "rip3", "rip4", "rip5",}
			mylevel1 = createL(mapX,mapY,mapX,mapY,bush*math.random(mapX/mapY),bush*math.random(mapY/mapX),true,myplayers,mybots,myvalues,{},true,myobs,mykilling,mapBon) 
			--for i=1,6 do mylevel1.map = Spawn (mylevel1.map,mylevel1.mapX,mylevel1.mapY) end
	if tonumber(bots)~=nil then 
		for i=1,tonumber(bots) do mylevel1.map = Spawn_rand (mylevel1.map,mylevel1.mapX,mylevel1.mapY) end 
	else 
		for iterator,v in pairs(bots) do 
			for i=1,v do mylevel1.map = Spawn (mylevel1.map,mylevel1.mapX,mylevel1.mapY, iterator) end
		end
	end
	return {
			level1 = mylevel1,
			--level2 = createL(24,13,24,13,false,myplayers,mybots,myvalues,{},true,myobs,mykilling,mapBon,map2),
			--mapCreator = createL(20,13,20,13,false,{},{},{},mapTarget,false,myobs,mykilling,mapBon),					
			--scrollTest = createL(24,13,14,10,false,myplayers,mybots,myvalues,myobs,mykilling,mapBon)
		}
end

function createL(mapX,mapY,mapXD,mapYD,argpl1,argpl2,bool,players,bots,values,vars,usual,obs,killing,mapBon,str)
	local map={}
	local fires={} 
	local sides={} 
	local bonuses={} 
	local allocation={}
	local territory = {}
	local DEATHSCORE = {}
		for i=1,mapX,1 do
			table.insert(map,{})
			table.insert(fires,{})			
			table.insert(sides,{})
			table.insert(bonuses,{})
			table.insert(allocation,{})
			table.insert( territory, {} )
			table.insert( DEATHSCORE, {} )
			for i2=1,mapY,1 do
				table.insert(map[i],0)
				table.insert(bonuses[i],0)
				table.insert(territory[i],0)
				table.insert(DEATHSCORE[i],{""})
				table.insert(allocation[i],0)
				table.insert(fires[i],{0,0})
				table.insert(sides[i],{0,0})
			end
		end
		if bool then
			for i=2,mapX,2 do
				for i2=2,mapY,2 do
					map[i][i2]='K'
				end
			end

			for integer=0,argpl1,1 do
				maprand = love.math.random(2,mapX-1)
				maprand2 = love.math.random(2,mapY-1)
				if map[maprand][maprand2]~='K'  then map[maprand][maprand2]='S' end
			end
			for integer=0,argpl2,1 do
				maprand=love.math.random(math.floor(mapY/2))
				for a=2,mapX-2,1 do
					map[a][maprand*2]='K'
				end
				maprand=love.math.random(math.floor(mapX/2))
				for a=2,mapY-2,1 do
					map[maprand*2][a]='K'
				end
			end	
		elseif str~= nil then 
			file = love.filesystem.read('maps/map2.txt')
			local myside = 0
				for word in string.gmatch(file, "%S+") do
						map[(myside%mapX)+1][math.floor(myside/mapX)+1] = word
						myside=myside+1
				end 			
		end
	return {
		values = values,
		map=map,
		fires=fires,
		sides=sides,
		bonuses=bonuses,
		bots = bots,
		players = players,
		mapX=mapX,
		mapY=mapY,
		mapXD=mapXD,
		mapYD=mapYD,
		usual=usual,
		vars=vars,
		allocation = allocation,
		obs = obs,
		killing = killing,
		mapBonuses = mapBon,
		bombsArr = {},
		territory = territory,
		DEATHSCORE = DEATHSCORE,
		botsArrs = botsArrs
	}
	
end
function Spawn_rand (arg_map,mapX,mapY)
	arg_map=arg_map
	maprand = math.random(8)
	maprand2 = math.random(6)
	maprand3 = math.random(4) if maprand3==4 then maprand3=3 end
	--for i=1,mapX do arg_map[i][4+maprand2]=0 end
	--for i=1,mapY do arg_map[8+maprand][i]=0 end
	arg_map[8+maprand][4+maprand2]='Spawn'..maprand3
	return arg_map
end
function Spawn (arg_map,mapX,mapY, it)
	arg_map=arg_map
	maprand = math.random(8)
	maprand2 = math.random(6)
	if it=="standart" then arg_map[8+maprand][4+maprand2]='Spawn'..1 
	elseif it=="chessknight" then arg_map[8+maprand][4+maprand2]='Spawn'..2 
	elseif it=="chessbishop" then arg_map[8+maprand][4+maprand2]='Spawn'..3 end
	return arg_map
end