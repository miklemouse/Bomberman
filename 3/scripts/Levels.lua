function myLevels()
		local myplayer1 = createP('w','a','s','d','space',ts*0,ts*0,1)
		local myplayer2 = createP('up','left','down','right','return',23*ts,12*ts,2)
	local myplayers = {myplayer1,myplayer2}
	botsArrs = {}
		--mybot1=createBot(17*ts,6*ts,'standart',24,13,{'alien/standart/Alien1' , 'alien/standart/Alien2'},{targetYI=0})
		--mybot2=createBot(17*ts,6*ts,'fool')
	local mybots = {mybot1}
	local myvalues = {
		{14, 'Boot'}, {28, 'Flame'}, {40, 'Boom'}, {47, 'Shield'}, {54, 'Detonator'}, {61, 'BS'}, {64, 'BBall'}, {68, 'FBall'},	{70, 'SFlame'}
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
	local mapBon = {'K','Spawn1','Spawn2','Spawn3'}
			mylevel1 = createL(24,13,24,13,true,myplayers,mybots,myvalues,{},true,myobs,mykilling,mapBon) 
			for i=1,2 do mylevel1.map = Spawn (mylevel1.map,mylevel1.mapX,mylevel1.mapY) end
	return {
			level1 = mylevel1,
			level2 = createL(24,13,24,13,false,myplayers,mybots,myvalues,{},true,myobs,mykilling,mapBon,map2),
			mapCreator = createL(40,24,40,24,false,{},{},{},mapTarget,false,myobs,mykilling,mapBon),					
			scrollTest = createL(24,13,14,10,false,myplayers,mybots,myvalues,myobs,mykilling,mapBon)
		}
end

function createL(mapX,mapY,mapXD,mapYD,bool,players,bots,values,vars,usual,obs,killing,mapBon,str)
	local map={}
	local fires={} 
	local sides={} 
	local bonuses={} 
	local allocation={}
		for i=1,mapX,1 do
			table.insert(map,{})
			table.insert(fires,{})			
			table.insert(sides,{})
			table.insert(bonuses,{})
			table.insert(allocation,{})
			for i2=1,mapY,1 do
				table.insert(map[i],0)
				table.insert(bonuses[i],0)
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

			for integer=0,mapX*mapY/25,1 do
				maprand = love.math.random(2,mapX-1)
				maprand2 = love.math.random(2,mapY-1)
				if map[maprand][maprand2]~='K'  then map[maprand][maprand2]='S' end
			end
			for integer=0,mapX*mapY/36,1 do
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
		--botsArrs = {}
		botsArrs = botsArrs
	}
	
end
function Spawn (arg_map,mapX,mapY)
	arg_map=arg_map
	maprand = math.random(8)
	maprand2 = math.random(6)
	maprand3 = 3 --math.random(2) if maprand3==4 then maprand3=3 end
	--for i=1,mapX do arg_map[i][4+maprand2]=0 end
	--for i=1,mapY do arg_map[8+maprand][i]=0 end
	arg_map[8+maprand][4+maprand2]='Spawn'..maprand3
	return arg_map
end