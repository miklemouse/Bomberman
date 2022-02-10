game = {}
	--ts = 50
	require 'scripts/Explode'
	require 'scripts/Behaviour'
	--require 'scripts/Levels'
function createPoints ()
	local local_points = create_table(mapX,mapY)
	local counter = 0
	local local_botArr = {
		points = local_points,
		moveType = itMove
	}
	for i=1, table.getn(botsArrs) do 
		counter = counter+1
		if botsArrs[i].moveType==itMove then local_boolean=false break end
	end
	if local_boolean then table.insert (botsArrs, local_botArr) local_numI = table.getn(botsArrs) 
	else local_numI = counter end
end
function createBot(XI,YI,itMove,mapX,mapY,argBotImages,arg_it_sides, speed)
	local LBotImages = {}
	local local_points = {}
	local local_boolean = true
	local local_numI = 0
	for i=1,mapX do 
		table.insert(local_points,{}) for i2=1, mapY do table.insert(local_points[i],0)
	end end
	local counter = 0
	local local_botArr = {
		points = local_points,
		moveType = itMove
	}
	for i=1, table.getn(botsArrs) do 
		counter = counter+1
		if botsArrs[i].moveType==itMove then local_boolean=false break end
	end
	if local_boolean then table.insert (botsArrs, local_botArr) local_numI = table.getn(botsArrs) 
	else local_numI = counter end
	for i=1,table.getn(argBotImages) do 
		Limage = love.graphics.newImage('bots/' .. argBotImages[i] .. '.png')
		table.insert(LBotImages,Limage) 
	end
	local speedI = speed if speedI==nil then speedI = ts*1 end
	return {
		yI = YI,
		--BotImage = love.graphics.newImage('sides/Bot.png'),
		xI = XI,
		targetI = 0,
		moveDirectionI = 0,
		BotImages = LBotImages,
		movingI = false,
		speedI = speedI,
		algorithm = itMove,
		bombsI = 1, maxBombsI = 1, 
		numI = local_numI,
		botvars = arg_it_sides 
	}
end
function createB(arg,arg2,arg3,arg4,arg5,pl)
	local b={
		xb = arg,
		yb = arg2,
		detonator = arg3,
		ft = arg4,
		timer = 0,
		exploded = false,
		range = arg5,
		bombPl = pl
	}
	table.insert(bombsArr,b)
	return b
end
function game.load()

	file = love.filesystem.read('maps/map2.txt')
	--levels
		
		imData = love.image.newImageData('sides/BomberIco.png')
		love.window.setIcon(imData)
		level = levels.level1
		file = love.filesystem.read('maps/map2.txt')
	level['strings'] = {}
	for i=1,level.mapX do table.insert(level.strings,{}) for i2=1,level.mapY do
		level['strings'][i][i2] = {}
		level.strings[i][i2]['boolean'] = false
		level.strings[i][i2]['str'] = ''
	end end
		if not level.usual then
			local myside = 0
				for word in string.gmatch(file, "%S+") do
						if word=='0' then
							level.map[(myside%level.mapX)+1][math.floor(myside/level.mapX)+1] = tonumber(word)
						else level.map[(myside%level.mapX)+1][math.floor(myside/level.mapX)+1] = word end
						myside=myside+1
				end 	
			local myside = 0
			file = love.filesystem.read('tegs/teg2.txt')
				for word in string.gmatch(file, "%S+") do
						if word=='0' then
							level.strings[(myside%level.mapX)+1][math.floor(myside/level.mapX)+1]['str'] = tonumber(word)
						else level.strings[(myside%level.mapX)+1][math.floor(myside/level.mapX)+1]['str'] = word end
						myside=myside+1
				end 	
		end
				     tabl = {}

         --s = file

           -- for k, v in string.gmatch(s,  "%a+") do

				--level.map[k][k] = v

		--	end
	--bombers
		bomberman = love.graphics.newImage('bombermen/Bomberman.png') 
		
		bombermanD = love.graphics.newImage('bombermen/BombermanD.png') 
		bombermanD2 = love.graphics.newImage('bombermen/BombermanD2.png') 
		bombermanD3 = love.graphics.newImage('bombermen/BombermanD3.png') 

		bombermanR = love.graphics.newImage('bombermen/BombermanR.png') 
		bombermanR2 = love.graphics.newImage('bombermen/BombermanR2.png') 
		bombermanR3 = love.graphics.newImage('bombermen/BombermanR3.png') 

		bombermanL = love.graphics.newImage('bombermen/BombermanL.png') 
		bombermanL2 = love.graphics.newImage('bombermen/BombermanL2.png') 
		bombermanL3 = love.graphics.newImage('bombermen/BombermanL3.png') 
		
		bombermanU = love.graphics.newImage('bombermen/BombermanU.png') 
		bombermanU2 = love.graphics.newImage('bombermen/BombermanU2.png') 
		bombermanU3 = love.graphics.newImage('bombermen/BombermanU3.png')
		
		--music = love.audio.newSource('sides/rastafuck.wav')
		
		rip = love.graphics.newImage ("sides/Rip.png")
		
		broke_CCC = love.graphics.newImage('sides/Break.png')
		
		--player1 = createP('w','a','s','d','space')
		--player2 = createP('up','left','down','right','return')
		players = level.players
		
		died = {}
		died_colors = {}
	--bots 
		bots = level.bots
	--map
		field = love.graphics.newImage('tiles/tile (1).png')
		bush  = love.graphics.newImage('tiles/tile (2).png')
		stone = love.graphics.newImage('tiles/tile (3).png')
		fireD = love.graphics.newImage('tiles/tile (4).png')
		fireL = love.graphics.newImage('tiles/tile (5).png')
		fireM = love.graphics.newImage('tiles/tile (6).png')		
		fireR = love.graphics.newImage('tiles/tile (7).png')
		fireU = love.graphics.newImage('tiles/tile (8).png')
		bomb  = love.graphics.newImage('tiles/tile (9).png')
		
		spawn1 = love.graphics.newImage('bots/alien/standart/AlienSpawn.png')
		spawn2 = love.graphics.newImage('bots/alien/chessknight/Spawn.png')
		spawn3 = love.graphics.newImage('bots/alien/chessbishop/AlienSpawn.png')
		
		bonus_background = love.graphics.newImage('sides/ForBonusBackground.png') 
		map = level.map
		fires = level.fires
		sides = level.sides
		bonuses = level.bonuses
		territory = level.territory
		DEATHSCORE = level.DEATHSCORE
		mapX = level.mapX 
		mapY = level.mapY
		vars = level.vars
		bombsArr = level.bombsArr
		botsArrs = level.botsArrs
		love.window.setMode(ts*mapX,ts*mapY,{})
		fireB = love.graphics.newImage('sides/FireB.png')
		--love.window.setFullscreen( true )

		--images
		
		flame = love.graphics.newImage('bonuses/Flame.png') --flamer
		boot = love.graphics.newImage('bonuses/Boot.png')   --
		prize = love.graphics.newImage('bonuses/Prize.png') --
		exploder = love.graphics.newImage('bonuses/Detonator.png') --
		shield = love.graphics.newImage('bonuses/Shield.png') --
		superflame = love.graphics.newImage('bonuses/SuperFlame.png') --
		bombS = love.graphics.newImage('bonuses/Boom.png')  --
		boom = love.graphics.newImage('bonuses/Bombs.png')  --
		Bascetball = love.graphics.newImage('bonuses/Bascetball.png') --
		Football = love.graphics.newImage('bonuses/Football.png') --
		Health = love.graphics.newImage('bonuses/Health.png') --
		an = love.graphics.newImage('anim/AnimSmall1.png')
		water = love.graphics.newImage('sides/Water.png')
		Yellow = love.graphics.newImage('sides/Yellow.png')
		
	--variables
		table_bool = false
		bbt = 0
		SpawnTimer = 0
		bbb_bots_bool_break = false
		victory = false
		dieB = false
		strengthMax = {}
		strSide = -999
		ctrl = false
		Shift = false
		space = false
		myboolean = true
		variableside = 0
		clipboard = {}
		pause = false
		writebool = false
	--players[1].speed = ts*10 --players[1].bascetball=true players[1].maxBombs=100	
	--players[2].shit=true players[2].shitT = -100000000000
	--map = create_table (20, 13)
	--map [10][10]='Spawn3'
	botscleartime = 0
end
function strengthR(arr)
	if arr.moving~=nil then 
		--if not arr.shit then return arr.speed/ts + arr.maxBombs + arr.bombs/2 + arr.range + 1/arr.detonator+arr.health
		--else return arr.speed/ts + arr.maxBombs + arr.bombs/2 + arr.range + 1/arr.detonator+3+arr.health end
		return arr.score
	else 
	--	if not arr.shitI then return arr.speedI/ts + arr.maxBombsI + arr.bombsI/2 + arr.rangeI + 1/arr.detonatorI
	--	else return arr.speedI/ts + arr.maxBombsI + arr.bombsI/2 + arr.rangeI + 1/arr.detonatorI end
		return 0
	end
end
function game.update(dt)
if not pause then
	--bots_clear(dt)
	bbt=bbt+dt*4
	for i, v in ipairs(players) do
		
		if v.immortal_t < 0 then players[i].immortal_t=players[i].immortal_t+dt 
		elseif v.immortal_t>0 then players[i].immortal_t=0 end
		
		
		if v.die == true then 
			local new_i = i
			for ITERATOR,VALUE in pairs(died) do
				if new_i==tonumber(ITERATOR) then new_i=new_i+1 end
			end
			died[tostring(new_i)] = players[i].score
			died_colors[tostring(new_i)] = players[i].Pcolor
			if math.floor(v.x/ts)<0 then v.x=1 end 
			if math.floor(v.y/ts)<0 then v.y=1 end
			map[math.floor(v.x/ts)+1][math.floor(v.y/ts)+1] = "rip"
			DEATHSCORE[math.floor(v.x/ts)+1][math.floor(v.y/ts)+1][1] = players[i].score
			
			DEATHSCORE[math.floor(v.x/ts)+1][math.floor(v.y/ts)+1][2] = players[i].Pcolor
			table.remove( players, i )
			for I=i,table.getn( players ) do players[I].num = players[I].num-1 end
			break
		end
		if v.health==0 then players[i].die = true strSide=-999 end
		
		if not v.shit and math.ceil(v.x/ts)<mapX and v.immortal_t>=0 then
		 
			--if on_fire(v.x,v.y,v.moveDirection)[1]==true and v.immortal_t>=0 then 
				--v.health=v.health-1 v.immortal_t = v.immortal_t-0.3 
				--if on_fire(v.x,v.y,v.moveDirection)[2]~=0 then 
					--local SCORE = players[on_fire(v.x,v.y,v.moveDirection)[2]].score
					--if players[i].health>0 then players[on_fire(v.x,v.y,v.moveDirection)[2]].score = SCORE+1
					--else players[on_fire(v.x,v.y,v.moveDirection)[2]].score = SCORE+10 end
				--end
			--end 
			if string.find(map[round(players[i].x/ts)+1][round(players[i].y/ts)+1],"F")~=nil then 
				v.health=v.health-1 v.immortal_t = v.immortal_t-0.3
				local TERR = territory[round(players[i].x/ts)+1][round(players[i].y/ts)+1]
				if TERR~=i then
					if TERR~=0 then 
						if v.health>0 then players[TERR].score = players[TERR].score + criterion.injures.hurt
						else players[TERR].score = players[TERR].score + criterion.injures.kill end
					end
				else
					if players[i].health>0 then players[i].score = players[i].score+criterion.injures.selfhurt 
					else players[i].score = players[i].score+criterion.injures.selfkill end
				end
			end
		end
		--if v.moveDirection == 1 then end
		if not v.moving then
				BX=v.x/ts+1
				BY=v.y/ts+1
				local develop = criterion.develop
				if bonuses[BX][BY]=='Boot' then v.speed = v.speed+ts bonuses[BX][BY]=0 v.score = v.score+develop.Boot
				elseif bonuses[BX][BY]=='Flame' then v.range = v.range+1 bonuses[BX][BY]=0 v.score = v.score+develop.Flame
				elseif bonuses[BX][BY]=='SFlame' then v.range = v.range+10 bonuses[BX][BY]=0 v.score = v.score+develop.SFlame
				elseif bonuses[BX][BY]=='BBall' then v.bascetball = true v.bascetS=v.bascetS+3 bonuses[BX][BY]=0 v.score = v.score+develop.BBall
				elseif bonuses[BX][BY]=='FBall' then v.football = true v.footS=v.footS+1 bonuses[BX][BY]=0 v.score = v.score+develop.FBall
				elseif bonuses[BX][BY]=='Detonator' then v.detonator = v.detonator*0.7 bonuses[BX][BY]=0 v.score = v.score+develop.Detonator
				elseif bonuses[BX][BY]=='Boom' then v.bombs = v.bombs+3 bonuses[BX][BY]=0 v.score = v.score+develop.Boom
				elseif bonuses[BX][BY]=='BS' then v.maxBombs = v.maxBombs+1 v.bombs = v.bombs+1 bonuses[BX][BY]=0 v.score = v.score+develop.BS
				elseif bonuses[BX][BY]=='Health' then players[i].health = players[i].health+1 bonuses[BX][BY]=0 v.score = v.score+develop.Health
				elseif bonuses[BX][BY]=='Shield' then v.shit = true v.shitT=v.shitT-10  bonuses[BX][BY]=0 v.score = v.score+develop.Shield end
			
			if love.keyboard.isDown( v.R ) and v.x<(mapX-1)*ts then 
				v.footCount = 0

				if v.bascetball then
					for ib=1,table.getn(bombsArr) do 
						if not bombsArr[ib].exploded then 
							if bombsArr[ib].xb==v.x+ts*2 and bombsArr[ib].yb==v.y+ts then 
								map[(v.x)/ts+2][(v.y)/ts+1]=0
								for a=v.x/ts+3,mapX do
									--if a<=v.bascetS then 
										if a<mapX and map[a][(v.y)/ts+1]==0 then
											bombsArr[ib].xb=ts*a  
											bascetBool=true	break 
										end
									--end
								end	
							end
						end
					end
				end

				if not obstructions(v.x/ts+2,v.y/ts+1) then
					v.target=v.x+ts 
					v.moving = true
					v.moveDirection = 1			
				end
			end
			if love.keyboard.isDown( v.L ) and v.x>0 then 
				v.footCount = 0
				if v.bascetball then
					for ib=1,table.getn(bombsArr) do 
						if not bombsArr[ib].exploded then 
							if bombsArr[ib].xb==v.x and bombsArr[ib].yb==v.y+ts then 
								map[(v.x)/ts][(v.y)/ts+1]=0
								for a=1,v.x/ts+1 do
									if a<=v.bascetS then 
										if (v.x)/ts-a>0 and map[(v.x)/ts-a][(v.y)/ts+1]==0 then
											bombsArr[ib].xb=v.x-ts*a  
											bascetBool=true	break 
										end
									end
								end	
							end
						end
					end
				end
				if not obstructions(v.x/ts,v.y/ts+1) then 
					v.target=v.x-ts
					v.moving = true
					v.moveDirection = 2
				end 
			end
			if love.keyboard.isDown( v.D ) and v.y<(mapY-1)*ts then
				v.footCount = 0
				if v.bascetball then
					for ib=1,table.getn(bombsArr) do 
						if not bombsArr[ib].exploded then 
							if bombsArr[ib].xb==v.x+ts and bombsArr[ib].yb==v.y+ts*2 then 
								map[(v.x)/ts+1][(v.y)/ts+2]=0
								for a=v.y/ts+3,mapY do
									--if a<=v.bascetS then 
										if map[(v.x)/ts+1][a]==0 then
											bombsArr[ib].yb=ts*a
											bascetBool=true	break
										end
									--end
								end	
							end
						end
					end
				end
				if not obstructions(v.x/ts+1,v.y/ts+2) then
					v.target=v.y+ts
					v.moving = true
					v.moveDirection = 3
				end
			end
			if love.keyboard.isDown( v.U ) and v.y>0 then 
				v.footCount = 0
					for ib=1,table.getn(bombsArr) do 
						if not bombsArr[ib].exploded then 
							if bombsArr[ib].xb==v.x+ts and bombsArr[ib].yb==v.y then 
								map[(v.x)/ts+1][(v.y)/ts]=0
								for a=1,v.y/ts+1 do
									if a<=v.bascetS then 
										if (v.y)/ts-a>0 and map[(v.x)/ts+1][(v.y)/ts-a]==0 then
											bombsArr[ib].yb=v.y-ts*a  
											bascetBool=true	break 
										end
									end
								end	
							end
						end
					end
				if not obstructions(v.x/ts+1,v.y/ts) then
					v.target=v.y-ts
					v.moving = true
					v.moveDirection = 4			
				end
			end
			if v.moveDirection==1 then v.bomberNow=bombermanR
			elseif v.moveDirection==2 then v.bomberNow=bombermanL 
			elseif v.moveDirection==3 then v.bomberNow=bombermanD 
			elseif v.moveDirection==4 then v.bomberNow=bombermanU end
		else --if moving
			if v.moveDirection==1 and v.x<ts*(mapX-1) then
					--map[math.ceil(v.x/ts)+1][(v.y/ts)+1]=0
				if math.floor(v.x/ts)>(mapX-2) or not obstructions(math.floor(v.x/ts)+2,v.y/ts+1) then
					if love.keyboard.isDown( v.R ) then
						v.x=v.x+dt*v.speed
						v.targetS = math.ceil(v.x/ts)*ts
						if v.targetS ~= v.target then players[i].footCount=players[i].footCount+1 end
						if v.x<ts*(mapX-1) then v.target = math.ceil(v.x/ts)*ts end
					end
					if not love.keyboard.isDown( v.R ) then
						if v.x<v.target then 
							if v.speed*dt<(v.target-v.x) then
								v.x=v.x+dt*v.speed
							else v.x=v.target v.moving=false end
						end
					end
					if v.x%ts<ts/2 then v.bomberNow=bombermanR2
					else v.bomberNow=bombermanR3 end			
				elseif v.football==false then v.x=math.floor(v.x/ts)*ts v.moving=false 
				elseif v.football==true then 
					v.x=math.floor(v.x/ts)*ts v.moving=false 
					for ib=1,table.getn(bombsArr) do
						if bombsArr[ib].exploded==false then 
							if bombsArr[ib].xb==v.x+ts*2 and bombsArr[ib].yb==v.y+ts then 
								map[math.floor(v.x/ts)+2][(v.y/ts)+1]=0
								for a=1,v.footCount+1 do
									if v.x+a*v.footS*ts<mapX*ts and map[(v.x)/ts+a*v.footS+2][(v.y)/ts+1]==0 then
										bombsArr[ib].xb=v.x+ts*a*v.footS+ts*2
									else break end
								end
							end
						end
					end
				end
			
			elseif v.moveDirection==1 then v.x=math.floor(v.x/ts)*ts v.moving=false end
			
			if v.moveDirection==2 then
			if v.x>0 and not obstructions(math.ceil(v.x/ts),v.y/ts+1) then			
				if love.keyboard.isDown( v.L ) then
					v.x=v.x-dt*v.speed
					v.targetS = math.floor(v.x/ts)*ts
					if v.targetS ~= v.target then v.footCount=v.footCount+1 end
					v.target = math.floor(v.x/ts)*ts
				end
				if not love.keyboard.isDown( v.L ) then
					if v.x>v.target then 
						if v.speed*dt<math.abs(v.target-v.x) then
							v.x=v.x-dt*v.speed
						else v.x=v.target v.moving=false end
					end
				end
				if v.x%ts>ts/2 then v.bomberNow=bombermanL2
				else v.bomberNow=bombermanL3 end
			else v.x=math.ceil(v.x/ts)*ts v.moving=false
			end
				if v.football then 
					for ib=1,table.getn(bombsArr) do 				
						if not bombsArr[ib].exploded then 
							if bombsArr[ib].xb==v.x and bombsArr[ib].yb==v.y+ts then 
								map[math.floor(v.x/ts)][(v.y/ts)+1]=0
								for a=1,v.footCount+1 do
									if v.x-a*v.footS>0 and map[(v.x)/ts-a*v.footS][(v.y)/ts+1]==0 then
										bombsArr[ib].xb=math.floor(v.x)-ts*a*v.footS  
									else break end
								end
							end
						end
					end
				end
			end			
			
			if v.moveDirection==3 then
			if v.y<ts*(mapY-1) and not obstructions(v.x/ts+1,math.floor(v.y/ts)+2) then				
				if love.keyboard.isDown( v.D ) then
					--v.y=v.y+dt*v.speed
					--v.target = math.ceil(v.y/ts)*ts
					v.y=v.y+dt*v.speed
					v.targetS = math.ceil(v.y/ts)*ts
					if v.targetS ~= v.target then players[i].footCount=players[i].footCount+1 end
					if v.y<ts*(mapY-1) then v.target = math.ceil(v.y/ts)*ts end
				end
				if not love.keyboard.isDown( v.D ) then
					if v.y<v.target then 
						if v.speed*dt<(v.target-v.y) then
							v.y=v.y+dt*v.speed
						else v.y=v.target v.moving=false end
					end
				end
				if v.y%ts<ts/2 then v.bomberNow=bombermanD2
				else v.bomberNow=bombermanD3 end			
			else v.y=math.floor(v.y/ts)*ts v.moving=false
			end
				if v.football==true then	
					for ib=1,table.getn(bombsArr) do
						if bombsArr[ib].exploded==false then 
							if bombsArr[ib].xb==v.x+ts and bombsArr[ib].yb==v.y+ts*2 then 
								map[(v.x/ts)+1][math.floor(v.y/ts)+2]=0
								for a=1,v.footCount+1 do
									if v.y+a*v.footS*ts<(mapY)*ts and map[(v.x)/ts+1][(v.y)/ts+a*v.footS+2]==0 then
										bombsArr[ib].yb=v.y+ts*a*v.footS+ts*2
									else break end
								end
							end
						end
					end
				end
			end
			
			if v.moveDirection==4 then
			if v.y>0 and not obstructions(v.x/ts+1,math.ceil(v.y/ts)) then							
				if love.keyboard.isDown( v.U ) then
					v.y=v.y-dt*v.speed
					v.targetS = math.floor(v.y/ts)*ts
					if v.targetS ~= v.target then v.footCount=v.footCount+1 end
					v.target = math.floor(v.y/ts)*ts
				end
				if not love.keyboard.isDown( v.U ) then
					if v.y>v.target then 
						if v.speed*dt<math.abs(v.target-v.y) then
							v.y=v.y-dt*v.speed
						else v.y=v.target v.moving=false end
					end
				end
				if v.y%ts>ts/2 then v.bomberNow=bombermanU2
				else v.bomberNow=bombermanU3 end
			
			else v.y=math.ceil(v.y/ts)*ts v.moving=false end
			
				if v.football then 
					for ib=1,table.getn(bombsArr) do
						if not bombsArr[ib].exploded then 
							if bombsArr[ib].xb==v.x+ts and bombsArr[ib].yb==v.y then 
								map[(v.x/ts)+1][math.floor(v.y/ts)]=0
								for a=1,v.footCount do
									if v.y-a*v.footS>0 and map[(v.x)/ts+1][(v.y)/ts-a*v.footS]==0 then
										bombsArr[ib].yb=v.y-ts*a*v.footS  
									else break end
								end
							end
						end
					end
				end
			end		
		end
		
		if love.keyboard.isDown( v.B ) then 
			if map[math.ceil(v.x/ts)+1][math.ceil(v.y/ts)+1]==0 and v.bombs>0 then
				for i2=1,table.getn(bombsArr) do 
					if bombsArr[i2].bombPl.num==v.num then 
						bombsArr[i2].timer=0
					end
				end
				v.bombs=v.bombs-1
				if v.moveDirection==1 then 
					createB(math.floor(v.x/ts+1)*ts,math.floor(v.y/ts+1)*ts,v.detonator,v.ft,v.range,v)
				elseif v.moveDirection==3 then
					createB(math.floor(v.x/ts+1)*ts,math.floor(v.y/ts+1)*ts,v.detonator,v.ft,v.range,v)
				else
					createB(math.ceil(v.x/ts+1)*ts,math.ceil(v.y/ts+1)*ts,v.detonator,v.ft,v.range,v)
				end
			end
		end
		if v.shit then v.shitT=v.shitT+dt end
		if v.shitT>10 then v.shit=false v.shitT=10 end
	end
	for i=1,table.getn(bombsArr) do 
		if bombsArr[i].exploded==false then
			map[bombsArr[i].xb/ts][bombsArr[i].yb/ts]='B'
			if bombsArr[i].timer>bombsArr[i].detonator then 
				if bombsArr[i].bombPl.bombs<bombsArr[i].bombPl.maxBombs then
					bombsArr[i].bombPl.bombs=bombsArr[i].bombPl.bombs+1
				end
				explode(bombsArr[i].xb,bombsArr[i].yb,bombsArr[i].range,bombsArr[i].ft,bombsArr[i].bombPl.num)
				bombsArr[i].exploded=true
			else 
				bombsArr[i].timer=bombsArr[i].timer+dt 
			end
		end
	end
	
	for i=1,table.getn(fires) do
		for i2=1,table.getn(fires[i]) do
			if fires[i][i2][2]~=0 then fires[i][i2][1]=fires[i][i2][1]+dt end
			if fires[i][i2][1]>fires[i][i2][2] and string.find( map[i][i2], "F" ) then map[i][i2]=0 fires[i][i2][1]=0 fires[i][i2][2]=0 territory[i][i2]=0 end
		end
	end

	for i=1,table.getn(sides) do
		for i2=1,table.getn(sides[i]) do
			if sides[i][i2][2]~=0 then sides[i][i2][1]=sides[i][i2][1]+dt end
			if sides[i][i2][1]>sides[i][i2][2] then sides[i][i2][1]=0 sides[i][i2][2]=0 end
		end
	end 
	if SpawnTimer>5 then
		SpawnTimer = 0
		for i=1,mapX do for i2=1,mapY do
			if map[i][i2]=='Spawn1' then 
				table.insert(bots,
					createBot((i-1)*ts,(i2-1)*ts,'standart',mapX,mapY,{'alien/standart/Alien1', 'alien/standart/Alien2'},{targetYI=0},ts*2))

			elseif map[i][i2]=='Spawn2' then 
				table.insert(bots,
					createBot((i-1)*ts,(i2-1)*ts,'chessknight',mapX,mapY,{'alien/chessknight/Chessknight1', 'alien/chessknight/Chessknight2'},{targetYI=0}))

			elseif map[i][i2]=='Spawn3' then 
				local STRANGE = math.random(1)
				if STRANGE<1 then
					table.insert(bots,
						createBot((i-1)*ts,(i2-1)*ts,'chessbishop',mapX,mapY,{'alien/chessbishop/Chessbishop1', 'alien/chessbishop/Chessbishop2'},{targetYI=0},ts*3))
				else
					STRANGE = math.random(4)
					local STRANGE_Y = 0
					local STRANGE_X = 0
				
					if STRANGE==1 then STRANGE_X = 1 STRANGE_Y = 0
					elseif STRANGE==2 then STRANGE_X = -1 STRANGE_Y = 0
					elseif STRANGE==3 then STRANGE_X = 0 STRANGE_Y = 1
					elseif STRANGE==4 then STRANGE_X = 0 STRANGE_Y = -1 end
					
					if obstructions(i+STRANGE_X,i2+STRANGE_Y) then STRANGE_X=0 STRANGE_Y=0 end
					table.insert(bots,
						createBot((i+STRANGE_X-1)*ts,(i2+STRANGE_Y-1)*ts,'chessbishop',mapX,mapY,{'alien/chessbishop/Chessbishop1', 'alien/chessbishop/Chessbishop2'},{targetYI=0},ts*3))
					
				end
			end

		end end
	else SpawnTimer=SpawnTimer+dt end
				
	for side=1,table.getn(players) do
		if strengthR(players[side])>strSide then strSide=strengthR(players[side]) strengthMax=players[side] end
	end

	for i,v in ipairs(botsArrs) do
		v.points = patf (strengthMax.x,strengthMax.y,v.points,map,v.moveType,strengthMax.speed*dt)
		--table.insert (botsArrs [i].points, {})
	end
	for i=1,table.getn(bots) do --flag)))
	if bots[i].algorithm=='standart' then			
		local local_bot = move(strengthMax.x,strengthMax.y,botsArrs[bots[i].numI].points,bots[i])
		bots[i].targetI = local_bot.targetI 
		bots[i].moveDirectionI = local_bot.moveDirectionI
		bots[i].movingI = local_bot.movingI
	elseif bots[i].algorithm=='fool' and bots[i].movingI==false then
		bots[i].xI = foolMove(bots[i]).xI
		variableside= variableside+1
		--bots[i].yI = foolMove(bots[i]).yI
	elseif bots[i].algorithm=='maze' and bots[i].movingI==false then 
		bots[i].targetI = mazeMove(bots[i]).targetI
		bots[i].moveDirectionI = mazeMove(bots[i]).moveDirectionI
		bots[i].movingI = mazeMove(bots[i]).movingI
	elseif bots[i].algorithm == 'chessknight' then
		if bots[i].movingI==false then 
			local local_bot = knightmove(strengthMax.x,strengthMax.y,botsArrs[bots[i].numI].points,bots[i])
			bots[i].botvars.targetYI = local_bot.botvars.targetYI
			bots[i].targetI = local_bot.targetI
			bots[i].movingI = local_bot.movingI 
		end
		--if math.ceil(bots[i].xI/ts)==math.ceil(strengthMax.x/ts) and math.ceil(bots[i].yI/ts)==math.ceil(strengthMax.y/ts) and 
			--not strengthMax.shit then 
			--for iS=1, table.getn(players) do
				--if players[iS].num == strengthMax.num and players[iS].immortal_t>=0 then players[iS].health=players[iS].health-1 players[iS].immortal_t = players[iS].immortal_t-0.3 end
			--end
		--end		
	elseif bots[i].algorithm == 'chessbishop' then
		
		local local_bot = bishopmove(strengthMax.x,strengthMax.y,botsArrs[bots[i].numI].points,bots[i])
		bots[i].botvars.targetYI = local_bot.botvars.targetYI
		bots[i].targetI = local_bot.targetI
		bots[i].movingI = local_bot.movingI
	end
	if bots[i].movingI then
		if bots[i].algorithm=='standart' then
			if bots[i].xI<bots[i].targetI and bots[i].moveDirectionI==1 then 
				if bots[i].speedI*dt<math.abs(bots[i].targetI-bots[i].xI) then
					bots[i].xI=bots[i].xI+dt*bots[i].speedI
				else bots[i].xI=bots[i].targetI bots[i].movingI=false end
			end
			
			if bots[i].xI>bots[i].targetI and bots[i].moveDirectionI==2 then 
				if bots[i].speedI*dt<math.abs(bots[i].targetI-bots[i].xI) then
					bots[i].xI=bots[i].xI-dt*bots[i].speedI
				else bots[i].xI=bots[i].targetI bots[i].movingI=false end
			end
			
			if bots[i].yI<bots[i].targetI and bots[i].moveDirectionI==3 then 
				if bots[i].speedI*dt<math.abs(bots[i].targetI-bots[i].yI) then
					bots[i].yI=bots[i].yI+dt*bots[i].speedI
				else bots[i].yI=bots[i].targetI bots[i].movingI=false end
			end
			
			if bots[i].yI>bots[i].targetI and bots[i].moveDirectionI==4 then 
				if bots[i].speedI*dt<math.abs(bots[i].targetI-bots[i].yI) then
					bots[i].yI=bots[i].yI-dt*bots[i].speedI
				else bots[i].yI=bots[i].targetI bots[i].movingI=false end
			end
		elseif bots[i].algorithm== 'chessknight' or bots[i].algorithm=='chessbishop' then
			if bots[i].moveDirectionI~=0 then 
				dx = (bots[i].xI-bots[i].targetI)
				dy = (bots[i].yI-bots[i].botvars.targetYI)
				local_distance = math.sqrt(dx*dx + dy*dy)
				bots[i].xI=bots[i].xI - bots[i].speedI*dt*dx/local_distance
				bots[i].yI=bots[i].yI - bots[i].speedI*dt*dy/local_distance
			end
			if bots[i].moveDirectionI==1 and bots[i].xI>=bots[i].targetI and bots[i].yI<=bots[i].botvars.targetYI then 
				bots[i].xI=bots[i].targetI bots[i].yI=bots[i].botvars.targetYI bots[i].movingI=false
			end
			if bots[i].moveDirectionI==2 and bots[i].xI<=bots[i].targetI and bots[i].yI>=bots[i].botvars.targetYI  then
				bots[i].xI=bots[i].targetI bots[i].yI=bots[i].botvars.targetYI bots[i].movingI=false					
			end
			if bots[i].moveDirectionI==3 and bots[i].xI>=bots[i].targetI and bots[i].yI>=bots[i].botvars.targetYI then
				bots[i].xI=bots[i].targetI bots[i].yI=bots[i].botvars.targetYI bots[i].movingI=false										
			end
			if bots[i].moveDirectionI==4 and bots[i].xI<=bots[i].targetI and bots[i].yI<=bots[i].botvars.targetYI then
				bots[i].xI=bots[i].targetI bots[i].yI=bots[i].botvars.targetYI bots[i].movingI=false										
			end
		end
	end
		--local resx = 2 local resy = 3
		--local XI = bots[i].xI/ts+1 local YI=bots[i].yI/ts+1
		--local dir = bots[i].moveDirectionI
		--if bots[i].algorithm=="standart" then
			--if dir==1 or dir==3 then resx = math.ceil(XI) resy = math.ceil(YI)
			--elseif dir==2 or dir==4 then resx = math.floor(XI) resy = math.floor(YI) end
		--end
		if string.find(map[round(bots[i].xI/ts)+1][round(bots[i].yI/ts)+1],"F")~=nil then 
			if territory[round(bots[i].xI/ts)+1][round(bots[i].yI/ts)+1]~=0 and players[territory[round(bots[i].xI/ts)+1][round(bots[i].yI/ts)+1]] then players[territory[round(bots[i].xI/ts)+1][round(bots[i].yI/ts)+1]].score=players[territory[round(bots[i].xI/ts)+1][round(bots[i].yI/ts)+1]].score+1 end
			table.remove(bots,i) break 
		end
		
		for iS,VALUE in ipairs ( players ) do if players[iS].shitT==10 then 
			if bots[i].xI+ts/2>players[iS].x and bots[i].xI-ts/2<players[iS].x and bots[i].yI+ts/2>players[iS].y and bots[i].yI-ts/2<players[iS].y then
				if players[iS].immortal_t>=0 then players[iS].health=players[iS].health-1 players[iS].immortal_t = players[iS].immortal_t-0.3 end
			end
		end end
		
	end
	if level==levels.mapCreator then
		if love.keyboard.isDown('lctrl') or love.keyboard.isDown('rctrl') then ctrl=true else ctrl=false end
		if love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift') then Shift=true else
			for i=1,mapX do for i2=1,mapY do level.allocation[i][i2]=0 end end
			Shift=false 
		end			
		if love.keyboard.isDown('space') then space=true Space() else space=false end
	end
	
end
end
function round (arg)
	if arg<=0 then return 0 end
	if arg%1<0.5 then return math.floor(arg) else return math.ceil(arg) end
end
function game.draw()
	for i=1,mapX do
		for i2=1,mapY do 
			love.graphics.draw(field,(i-1)*ts,(i2-1)*ts,0,ts/50)
			if map[i][i2]=='K'		then love.graphics.draw(bush,(i-1)*ts,(i2-1)*ts,0,ts/50)			
			elseif map[i][i2]=='B'  then love.graphics.draw(bomb,(i-1)*ts,(i2-1)*ts,0,ts/50) 		
			elseif map[i][i2]=='Fm'	then love.graphics.draw(fireM,(i-1)*ts,(i2-1)*ts,0,ts/50) 
			elseif map[i][i2]=='Fr' then love.graphics.draw(fireR,(i-1)*ts,(i2-1)*ts,0,ts/50) 
			elseif map[i][i2]=='Fl' then love.graphics.draw(fireL,(i-1)*ts,(i2-1)*ts,0,ts/50) 
			elseif map[i][i2]=='Fu' then love.graphics.draw(fireU,(i-1)*ts,(i2-1)*ts,0,ts/50) 
			elseif map[i][i2]=='Fd' then love.graphics.draw(fireD,(i-1)*ts,(i2-1)*ts,0,ts/50) 
			elseif map[i][i2]=='S'	then love.graphics.draw(stone,(i-1)*ts,(i2-1)*ts,0,ts/50)			
			elseif map[i][i2]=='Spawn1'	then love.graphics.draw(spawn1,(i-1)*ts,(i2-1)*ts,0,ts/50)			
			elseif map[i][i2]=='Spawn2'	then love.graphics.draw(spawn2,(i-1)*ts,(i2-1)*ts,0,ts/50)							
			elseif map[i][i2]=='Spawn3'	then love.graphics.draw(spawn3,(i-1)*ts,(i2-1)*ts,0,ts/50)
			elseif map[i][i2]=='rip'	then love.graphics.draw(rip,(i-1)*ts,(i2-1)*ts,0,ts/50) 
				love.graphics.setColor( DEATHSCORE[i][i2][2] )
				love.graphics.rectangle("fill",(i-1)*ts+10*50/ts,(i2-1)*ts+ts/2+ts/10,ts-20*50/ts,ts/2)
				love.graphics.setColor(255,255,255)
			end
		end
	end
	for i=1,mapX do for i2=1,mapY do 
		-- love.graphics.print( {{240,250,14},DEATHSCORE[i][i2][1]}, (i-0.55)*ts, (i2-0.3)*ts, 0, ts/50 ) -- new_comm
	end end
	for i=1,mapX do for i2=1,mapY do 
		love.graphics.print(level.strings[i][i2]['str'],(i-1)*ts,(i2-1)*ts,0,ts/50)
	end end
	if pause then love.graphics.print ('pause') end
	for i=1,mapX do
		for i2=1,mapY do
			if not FireKill(i,i2) then
				if bonuses[i][i2] == 'P' then love.graphics.draw(prize,(i-1)*ts,(i2-1)*ts,0,ts/50)
				elseif bonuses[i][i2] == 'Flame' then love.graphics.draw(flame,(i-1)*ts,(i2-1)*ts,0,ts/50) --			
				elseif bonuses[i][i2] == 'SFlame' then love.graphics.draw(superflame,(i-1)*ts,(i2-1)*ts,0,ts/50) --
				elseif bonuses[i][i2] == 'Boot' then love.graphics.draw(boot,(i-1)*ts,(i2-1)*ts,0,ts/50) --
				elseif bonuses[i][i2] == 'Detonator' then love.graphics.draw(exploder,(i-1)*ts,(i2-1)*ts,0,ts/50) --
				elseif bonuses[i][i2] == 'Shield' then love.graphics.draw(shield,(i-1)*ts,(i2-1)*ts,0,ts/50)
				elseif bonuses[i][i2] == 'BS' then love.graphics.draw(bombS,(i-1)*ts,(i2-1)*ts,0,ts/50) --
				elseif bonuses[i][i2] == 'Boom' then love.graphics.draw(boom,(i-1)*ts,(i2-1)*ts,0,ts/50) --
				elseif bonuses[i][i2] == 'BBall' then love.graphics.draw(Bascetball,(i-1)*ts,(i2-1)*ts,0,ts/50) --
				elseif bonuses[i][i2] == 'FBall' then love.graphics.draw(Football,(i-1)*ts,(i2-1)*ts,0,ts/50)  --
				elseif bonuses[i][i2] == 'Health' then love.graphics.draw(Health,(i-1)*ts,(i2-1)*ts,0,ts/50) end
			end
		end
	end
	--for i=1,table.getn(players) do love.graphics.draw(players[i].bomberNow,players[i].x,players[i].y) end
	
	for i=1,table.getn(bots) do 
		if bbb_bots_bool_break then bbb_bots_bool_break = false break end
		if bbt%4>2 then love.graphics.draw(bots[i].BotImages[1],bots[i].xI,bots[i].yI,0,ts/50) end
		if bbt%4<2 then love.graphics.draw(bots[i].BotImages[2],bots[i].xI,bots[i].yI,0,ts/50) end
	end
	--love.audio.play(music)
	for i=1,table.getn(level.allocation) do
		for i2=1,table.getn(level.allocation[i]) do
			if level.allocation[i][i2]~=0 then
				love.graphics.draw(water,(i-1)*ts,(i2-1)*ts,0,ts/50)
			end
		end
	end
	for i=1,table.getn(sides) do
		for i2=1,table.getn(sides[i]) do
			if sides[i][i2][2]~=0 then 
			--elseif bonuses[i][i2]~=0 then
				--love.graphics.draw(field,(i-1)*ts,(i2-1)*ts,0,ts/50)
				--love.graphics.draw(an,(i-0.5)*ts,(i2-0.5)*ts,bbt%100,ts/50,ts/50,50/2,50/2)
				love.graphics.draw(fireB,(i)*ts,(i2)*ts,0,ts/50)
				--love.graphics.draw(an,(i+0.5)*ts,(i2+0.5)*ts,bbt%100,ts/50,ts/50,50/2,50/2)
			end
		end
	end			
	
	-- if dieB then 
		-- for i=1,mapX do
			-- for i2=1,mapY do
				-- love.graphics.draw(field,(i-1)*ts,(i2-1)*ts)
			-- end
		-- end
		-- love.graphics.print("shark got u",(mapX/2-0.5)*ts,(mapY/2-0.5)*ts)		
	-- elseif victory then 
		-- for i=1,mapX do
			-- for i2=1,mapY do
				-- love.graphics.draw(water,(i-1)*ts,(i2-1)*ts)
			-- end
		-- end		
		-- love.graphics.print("u've done it!",(mapX/2-0.5)*ts,(mapY/2-0.5)*ts)
	-- end
	--for i,v in pairs( died ) do 
		--love.graphics.draw( rip, v.x, v.y, 0, ts/50 )
		--love.graphics.print( {{240,250,14},i}, (v.x/ts+0.45)*ts, (v.y/ts+0.7)*ts, 0, ts/50 )
	--end
		
		for i=1,table.getn(players) do 
			love.graphics.draw(players[i].backlight,players[i].x,players[i].y,0,ts/50)
			love.graphics.draw(players[i].bomberNow,players[i].x,players[i].y,0,ts/50)
			
			if players[i].shit then love.graphics.draw (shield, players[i].x-5*ts/57, players[i].y,0,ts/50) end
			if players[i].immortal_t<0 then love.graphics.draw( broke_CCC, players[i].x-5*ts/57, players[i].y,0,ts/50 ) end
			love.graphics.print({{255,0,0}, players[i].score}, players[i].x+ts/2-string.len(tostring(players[i].score))*6, players[i].y+ts-10,0,ts/50 )
			
			if table_bool then
				love.graphics.print ({{0, 0, 0}, players[i].speed/ts}, 20*ts/50*players[i].num, ts*0+5*ts/50, 0, ts/50)
				love.graphics.print ({{0, 0, 0}, players[i].bombs}, 20*ts/50*players[i].num, ts*0.5+5*ts/50, 0, ts/50)
				love.graphics.print ({{0, 0, 0}, players[i].maxBombs}, 20*ts/50*players[i].num, ts*1+5*ts/50, 0, ts/50)
				love.graphics.print ({{0, 0, 0}, players[i].range}, 20*ts/50*players[i].num, ts*1.5+5*ts/50, 0, ts/50)
				love.graphics.print ({{0, 0, 0}, math.floor(players[i].detonator)}, 20*ts/50*players[i].num, ts*2+5*ts/50, 0, ts/50)
				love.graphics.print ({{0, 0, 0}, players[i].health}, 20*ts/50*players[i].num, ts*2.5+5*ts/50, 0, ts/50)
				local round_shitt = 10-math.floor(players[i].shitT*10)/10 if math.floor(round_shitt)==round_shitt then round_shitt=round_shitt..'.0' end
				if players[i].shit then love.graphics.print ({{0, 0, 0}, round_shitt}, 20*ts/50*players[i].num, ts*3+5*ts/50, 0, ts/50) end
				if players[i].football then love.graphics.print ({{0, 0, 0}, players[i].footS}, 20*ts/50*players[i].num, ts*3.5+5*ts/50, 0, ts/50) end
				if players[i].bascetball then love.graphics.print ({{0, 0, 0}, players[i].bascetS}, 20*ts/50*players[i].num, ts*4+5*ts/50, 0, ts/50) end
			end
	end
	if table_bool then
		for i=0,7 do
			love.graphics.draw(bonus_background,0,i*ts/2,0,ts/50)
		end
		love.graphics.draw(boot,(-5)*ts/57,(-8)*ts/57,0,ts/50/2)
		love.graphics.draw(boom,(2)*ts/57,(2)*ts/57+ts/2,0,ts/50/3)
		love.graphics.draw(bombS,(-4)*ts/57,(-4)*ts/57+ts,0,ts/50/2)
		love.graphics.draw(flame,(2)*ts/57,(2)*ts/57+ts*1.5,0,ts/50/3)		
		love.graphics.draw(exploder,(-3)*ts/57,(-3)*ts/57+ts*2,0,ts/50/2)
		love.graphics.draw(Health,(-3)*ts/57,(-3)*ts/57+ts*2.5,0,ts/50/2)		
		love.graphics.draw(shield,(-3)*ts/57,(-3)*ts/57+ts*3,0,ts/50/2)
		love.graphics.draw(Football,(1)*ts/57,(1)*ts/57+ts*3.5,0,ts/50/3)
		love.graphics.draw(Bascetball,(-3)*ts/57,(-3)*ts/57+ts*4,0,ts/50/2)
	end
	if level==levels.mapCreator then 
		for i=1,table.getn(clipboard) do for i2=1,table.getn(clipboard[i]) do  
			love.graphics.print(clipboard[i][i2],(i-0.5)*ts,(i2-0.5)*ts,0,ts/50)
		end end 
		love.graphics.draw(vars.targetImages[vars.imageNow%3+1],vars.xS,vars.yS,0,ts/50)
		--if b then love.graphics.print('true') else love.graphics.print('false') end
		--love.graphics.print(love.filesystem.getSaveDirectory( ))
		--for word in string.gmatch("Hello Lua user", "%a+") do love.graphics.print(word) end 
	end
	if botsArrs~=nil then
		--for i=1,mapX do for i2=1, mapY do love.graphics.print({{0,0,0},botsArrs[1].points[i][i2]}, (i-0.5)*ts,(i2-0.5)*ts) end end
		
	end
	count = 0
	for i,v in pairs( died ) do 
		count = count + 1
		--love.graphics.print ( i..' '..v,  0, count*20)
	end	
	--for i=1,mapX do for i2=1,mapY do love.graphics.print({{0,0,0},territory[i][i2]},(i-0.5)*ts,(i2-0.5)*ts) end end
	--love.graphics.print ( {{0,0,0}, players[2].x} )
	--for i=1,table.getn( players ) do love.graphics.print( players[i].x, 0, ts*i ) end
end

--function заготовки 
	-- (blitz)	
	--elseif bonuses[i][i2]~=0 then
		--love.graphics.draw(field,(i-1)*ts,(i2-1)*ts,0,ts/50)
	--	love.graphics.draw(an,(i-0.5)*ts,(i2-0.5)*ts,bbt%100,ts/50,ts/50,50/2,50/2)
	--bbt=bbt+dt*4
--end
function Space()
	if space then
		if vars.imageNow%3+1==1 then 
			map[vars.xS/ts+1][vars.yS/ts+1]=0
		elseif vars.imageNow%3+1==2 then 
			map[vars.xS/ts+1][vars.yS/ts+1]='K'
		elseif vars.imageNow%3+1==3 then 
			map[vars.xS/ts+1][vars.yS/ts+1]='S'			
		end
	end
end
function love.mousepressed(x,y,button)
	--if level.strings[math.floor(x/ts)+1][math.floor(y/ts)+1]['boolean']~=true then
		--for i=1,mapX do for i2=1,mapY do level.strings[i][i2]['boolean']=false end end
		--level.strings[math.floor(x/ts)+1][math.floor(y/ts)+1]['boolean']=true writebool=true 
	--else level.strings[math.floor(x/ts)+1][math.floor(y/ts)+1]['boolean']=false writebool=false 
	--end
end
function love.keypressed(key)
	if not writebool then
		if key=='escape' then 
			if not pause then pause=true 
			else pause=false end
		end

		if key=='r' then love.load() bool = false end
		if key=='t' then 
			if table_bool then table_bool = false 
			else table_bool = true end
		end
		if level==levels.mapCreator then
			if not ctrl and Shift then level.allocation[vars.xS/ts+1][vars.yS/ts+1]=1 end
			
			if love.keyboard.isDown('right') and vars.xS<(mapX-1)*ts then 
				if not ctrl then vars.xS=vars.xS+ts 
				elseif not Shift then for i=vars.xS/ts,mapX-1 do vars.xS=i*ts Space() end 
				elseif ctrl and Shift then for i=vars.xS/ts,mapX-1,2 do vars.xS=i*ts Space() end end
				if not ctrl and Shift then  
					for i=1,mapY do 
						if level.allocation[vars.xS/ts][i]==1 then
							level.allocation[vars.xS/ts+1][i]=1
						end
					end 
				end
				
			elseif love.keyboard.isDown('left') and vars.xS>0 then 
				if not ctrl then vars.xS=vars.xS-ts 
				elseif not Shift then for i=vars.xS/ts,0,-1 do vars.xS=i*ts Space() end 
				elseif ctrl and Shift then for i=vars.xS/ts,0,-2 do vars.xS=i*ts Space() end end
				if not ctrl and Shift then  
					for i=1,mapY do 
						if level.allocation[vars.xS/ts+2][i]==1 then
							level.allocation[vars.xS/ts+1][i]=1
						end
					end 
				end
				
			elseif love.keyboard.isDown('down') and vars.yS<(mapY-1)*ts then 
				if not ctrl then vars.yS=vars.yS+ts 
				elseif not Shift then for i=vars.yS/ts,mapY-1 do vars.yS=i*ts Space() end 
				elseif ctrl and Shift then for i=vars.yS/ts,mapY-1,2 do vars.yS=i*ts Space() end end
				if not ctrl and Shift then  
					for i=1,mapX do 
						if level.allocation[i][vars.yS/ts]==1 then
							level.allocation[i][vars.yS/ts+1]=1
						end
					end 
				end
				
			elseif love.keyboard.isDown('up') and vars.yS>0 then 
				if not ctrl then vars.yS=vars.yS-ts 
				elseif not Shift then for i=vars.yS/ts,0,-1 do vars.yS=i*ts Space() end 
				elseif ctrl and Shift then for i=vars.yS/ts,0,-2 do vars.yS=i*ts Space() end end
				
				if not ctrl and Shift then  
					for i=1,mapX do 
						if level.allocation[i][vars.yS/ts+2]==1 then
							level.allocation[i][vars.yS/ts+1]=1
						end
					end 
				end

			elseif key=='tab' then
				vars.imageNow=vars.imageNow+1
			elseif key=='space' then 
				Space()
			--elseif key=='s' then
				--if ctrl then 
					--str = ''
					--love.filesystem.newFile('maps/map2.txt')
					--for i=1,mapY do 
						--for i2=1,mapX do 
							--str = str..map[i2][i]..' ' 
						--end 
					--end
					--love.filesystem.write('maps/map2.txt',str,string.len(str))
					
					--str = ''
					--love.filesystem.newFile('tegs/teg2.txt')
					--for i=1,mapY do 
						--for i2=1,mapX do 
							--str = str..level.strings[i2][i]['str']..' ' 
						--end 
					--end
					--love.filesystem.write('tegs/teg2.txt',str,string.len(str))
				--end
			elseif key=='c' then
				if ctrl then 
					clipboard={}
					mySide=0
					for i=1,mapX do for i2=1,mapY do
						if level.allocation[i][i2]==1 then
							table.insert(clipboard,{}) mySide=mySide+1
							for i3=i2,mapY do
								if level.allocation[i][i3]==1 then
									table.insert(clipboard[mySide],map[i][i3]) else break
								end
							end
							break
						end
					end end
				end
			elseif key=='v' then
				if ctrl then
					for i=1,table.getn(clipboard) do
						for i2=1,table.getn(clipboard[i]) do
							map[i+vars.xS/ts][i2+vars.yS/ts]=clipboard[i][i2]
						end
					end
				end
			elseif key=='backspace' then
				for i=1,mapX do
					for i2=1,mapY do
						if level.allocation[i][i2]==1 then
							map[i][i2]=0
						end
					end
				end
			end
		end
	end
	for i=1,mapX do for i2=1,mapY do 
		if level.strings[i][i2]['boolean'] and key~='backspace' then 
			level.strings[i][i2]['str'] = level.strings[i][i2]['str'] .. key
		elseif level.strings[i][i2]['boolean'] and key=='backspace' then
			level.strings[i][i2]['str'] = ''
		end
	end end
end
function on_fire (argX,argY,arg_moveDirection)
	-- if arg_moveDirection == 1 and math.floor(argX/ts)+1>0  then 
	
		-- return FireKill (math.ceil(argX/ts)+1, math.floor(argY/ts)+1)
	
	-- elseif arg_moveDirection == 2 and math.floor(argX/ts)+1>0 then
		
		-- return FireKill (math.floor(argX/ts)+1, math.floor(argY/ts)+1)
		
	-- elseif arg_moveDirection == 3 and math.floor(argY/ts)+1>0 then
		
		-- return FireKill (math.floor(argX/ts)+1, math.ceil(argY/ts)+1)
	
	-- elseif arg_moveDirection == 4 and math.ceil(argY/ts)+1<mapY then
		
		-- return FireKill (math.floor(argX/ts)+1, math.floor(argY/ts)+1)		
	
	-- end
	if argX==0 then argX=1 end
	if FireKill(math.ceil(argX/ts+0.33),math.ceil(argY/ts+0.6)) then 
		local mapchar=map[math.ceil(argX/ts+0.33)][math.floor(argY/ts+0.6)]
		if mapchar~='Fd' and mapchar~='Fu' then 
			return {true,territory[math.ceil(argX/ts+0.33)][math.floor(argY/ts+0.6)]} end end
			
	if FireKill(math.floor(argX/ts+1.33),math.floor(argY/ts+1.33)) then
		local mapchar=map[math.floor(argX/ts+1.33)][math.floor(argY/ts)+1.33]
		if mapchar~='Fd' and mapchar~='Fu' then 
			return {true,territory[math.floor(argX/ts+1.33)][math.floor(argY/ts)+1.33]} end end
	
	if FireKill(math.floor(argX/ts+1.66),math.floor(argY/ts+1.04)) then
		local mapchar=map[math.floor(argX/ts+1)][math.floor(argY/ts+1.04)]
		if mapchar~='Fl' and mapchar~='Fr' then 
			return {true,territory[math.floor(argX/ts+1)][math.floor(argY/ts+1.04)]} end end

	if FireKill(math.floor(argX/ts+1.66),math.ceil(argY/ts+0.86)) then 
		local mapchar=map[math.floor(argX/ts+1)][math.ceil(argY/ts+0.86)]
		if mapchar~='Fl' and mapchar~='Fr' then 
			return {true,territory[math.floor(argX/ts+1)][math.ceil(argY/ts+0.86)]} end end
	return {false,0}
end
function FireKill (arg2X, arg2Y)
	if arg2X<=0 then arg2X=1 end
	for i=1, table.getn(level.killing) do
		sideChar = level.killing[i]
		if map[arg2X][arg2Y]==sideChar then return true end
	end
	return false
end
function obstructions(arg1,arg2)
	for i=1, table.getn(level.obs) do
		sideChar = level.obs[i]
		if map[arg1][arg2]==sideChar then return true end
	end
end
function create_table(mapX,mapY) 
	local_arr = {}
	for i=1,mapX do table.insert(local_arr,{}) 
		for i2=1,mapY do table.insert(local_arr[i],0) end 
	end 
	return local_arr
end
