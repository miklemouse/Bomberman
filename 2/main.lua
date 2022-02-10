function love.load()
	ts = 50
	bg = love.graphics.newImage("menu/Desert.png")
	prost = love.graphics.newImage("menu/Prost.png")
	bomber1 = love.graphics.newImage("bombermen/BombermanL.png")
	bomber2 = love.graphics.newImage("bombermen/BombermanL2.png")
	bomber3 = love.graphics.newImage("bombermen/BombermanL3.png")

	bomber_x = 780 bomber_y = 60
	
	buttom = love.graphics.newImage("menu/Buttom.png")
	bombBB = love.graphics.newImage("menu/Something3.png")
	fireM = love.graphics.newImage("menu/FireM.png")
	fireR = love.graphics.newImage("menu/fireR.png")
	flame = love.graphics.newImage( "menu/SuperFlame.png" )
	anim = love.graphics.newImage("menu/Animation.png")
	bb = true
	xBB = 100
	yBB = 100
	xbB = 200
	ybB = 200
	bbB = false
	timerBB = 0 
	BBB = false
	fBB = false
	timerfBB = 0
	fBBB = false
	RADIANS = 0
	bool = false
	require "scripts/Levels"
	menubotimages = {
		chessknight = love.graphics.newImage("bots/alien/chessknight/Chessknight1.png"),
		chessbishop = love.graphics.newImage("bots/alien/chessbishop/Chessbishop1.png"),
		standart = love.graphics.newImage("bots/alien/standart/Alien1.png")
	}
	global_time = 0
	caption = love.graphics.newImage( "sides/Name.png" )
	caption2 = love.graphics.newImage ( "sides/NAME2.png" )
	caption2part2 = love.graphics.newImage ( "sides/name2part2.png" )
	bombergo = bomber1
	
	written = ''
	write = 0
	write2 = 0
	
	to_new = {
		bush=6, 
		players=2, 
		map = {tilesize=50, mapX=24, mapY=13}, 
		bots={standart=0, chessknight=0, chessbishop=0},
		health = 1
	}
	criterion = {
		injures = {
			monster = 1,
			kill = 10,
			hurt = 1,
			selfhurt = -1,
			selfkill = -5
		},
		develop = {
			Boot = 0.1,
			Flame = 0.1,
			SFlame = 0.10,
			BBall = 0.5,
			FBall = 0.5,
			Detonator = 0.9,
			Boom = 0.3,
			BS = 0.4,
			Shield = 0,
			Health = 0
		}
	}
	ending = false 
	local function EMPTY() return {false} end
	primarys = {}
	function primarys.deathmatch() 
		if table.getn(players) == 1 then 
			return {true, ""}
		else return {false}  end
	end
	function primarys.against_aliens()
		local bool = true
		for i,v in ipairs( players ) do bool=false end
		if bool==true then return {true, "defeated"} end
		for i,v in ipairs (bots) do if map[math.ceil(v.x/ts)+1][math.ceil(v.y/ts)+1]~="S" then return {false} end end
		for i=1,mapX do for i2=1,mapY do if string.find(map[i][i2],"Spawn")~=nil then return {false} end end end
		return {true,"win"}
	end
	function primarys.against_all()
		if table.getn(players)==0 then return {true,"defeated"} end
		for i,v in ipairs(bots) do if map[math.ceil(v.x/ts)+1][math.ceil(v.y/ts)+1]~="S" then return {false} end end
		for i=1,mapX do for i2=1,mapY do if string.find(map[i][i2],"Spawn") then return {false} end end end
		if table.getn(players)==1 then return {true, ""} end
		return {false}
	end
	end_primary = EMPTY
end
function createP(U,L,D,R,B,X,Y,health,color,num)
	return {
		moving = false,
		speed = ts*2,
		moveDirection = 0,
		keyDirection = 0,
		bomberNow = love.graphics.newImage('bombermen/Bomberman.png'),
		backlight = love.graphics.newImage('bombermen/Backlight'..color[1]..'.png'),
		Pcolor = color[2],
		num = num,
		target = 0,
		x = X,
		y = Y,
		
		detonator = 3,
		ft = 1,
		range = 1,
		
		bombs = 1,
			maxBombs = 1,
		
		bascetball = false,
			bascetS = 0, 
		football = false,
			targetS = 0,
			footCount = 0,
			footS = 0,
		
		shit = false,
			shitT = 10, 
				
			R=R,
			L=L,
			D=D,
			U=U,
			B=B,
			
		health = health,
		immortal_t = 0,
			
		score = 0,
		
		die = false
	}
end

function love.update(dt)
if not bool then
	if choose==nil then 
		choose = love.math.random( 2 ) 
		if choose==1 then 
			lim = 250 
			str = "its cool, that youve picked the best bonus in the game, "
			str2 = "but a lot of aliens are occupy our planet,what are you doing here??"
		else 
			str = "wow! youve exploded the table with inscription exterrestrians, "
			str2 = "but why are you dont kill true exterrestrians?"
			lim = 300 
		end
	end
	global_time = global_time + dt
	if yBB > 60 then
		xBB = xBB-1
		yBB = yBB-1.5
	end
	if yBB < 60 or xBB == 10 then bbB = true end
	if bbB then timerBB = timerBB+dt end
	if timerBB > 1 then 
		bbB = false
		BBB = true
		timerBB = 0
	end
	if BBB then
		xbB = xbB+0.5
		ybB = ybB+1
	end
	if xbB > lim then 
		BBB = false 
		fBB = true
	end
	if fBB then timerfBB = timerfBB+dt end
	if timerfBB>1 then 
		fBBB = true 
	end
	if fBBB then 
		fBB = false
	end
	if fBBB then 
	end
	RADIANS = RADIANS + dt*global_time
	if global_time<32-20 and global_time>30-20 then 
		if global_time<=30.6-20 then bombergo = bomber2 
		elseif global_time<31.3-20 then bombergo = bomber3
		elseif global_time<32-20 then bombergo = bomber2
		end
		bomber_x = bomber_x-dt*50
	end
	if global_time > 32-20 and forbombergo==nil then bombergo = bomber1 forbombergo = true end
end
if bool and ending==false then 
	if end_primary()[1]==false then
		game.update(dt) 
	else res=end_primary() ending=true end
end
end
function love.mousepressed(x,y)
	local COUNT = 1
	write = 0 write2 = 0
	for i,v in pairs( to_new ) do 
		if i~="map" and i~="bots" then
			if x>600 and y>(COUNT-1)*20+100 and y<COUNT*20+100 then
				to_new[i] = ''
				write = i
			end
			COUNT = COUNT+1
		else 
			for iterator,value in pairs( v ) do 
				if x>600 and y>(COUNT-1)*20+100 and y<COUNT*20+100 then
					to_new[i][iterator] = ''
					write = i
					write2 = iterator
				end
				COUNT = COUNT+1				
			end
		end
	end
	COUNT = 1 
	for i,v in pairs( primarys ) do 
		if x>400 and x<600 and y>(COUNT-1)*20+100 and y<COUNT*20+100 then
			end_primary = v
		end
		COUNT = COUNT+1
	end
	if x<350 and x>250 and y<370 and y>270 then 
		local BOTS = {} 
		BOTS["standart"] = to_new.bots["standart"] 
		BOTS["chessknight"] = to_new.bots["chessknight"]
		BOTS["chessbishop"] = to_new.bots["chessbishop"]
	
		levels = myLevels(to_new.map.tilesize, to_new.map.mapX, to_new.map.mapY, to_new.bush, to_new.players, to_new.health, BOTS)
		require "game"
		game.load()
		bool = true
	end
end
function love.keypressed( key )
	if write~=0 and write2==0 then 
		if string.len(key)==1 and tonumber(key)~=nil then
			to_new[write] = to_new[write]..key
			to_new[write] = tonumber(to_new[write])
		elseif key=="backspace" then 
			to_new[write] = ''
		end
	end
	if write~=0 and write2~=0 then 
		if string.len(key)==1 and tonumber(key)~=nil then
			to_new[write][write2] = to_new[write][write2]..key
			to_new[write][write2] = tonumber(to_new[write][write2])
		elseif key=="backspace" then 
			to_new[write][write2] = ''
		end		
	end
	if key=="return" or key=="space" then
		local BOTS = {} 
		BOTS["standart"] = to_new.bots["standart"] 
		BOTS["chessknight"] = to_new.bots["chessknight"]
		BOTS["chessbishop"] = to_new.bots["chessbishop"]
	
		levels = myLevels(to_new.map.tilesize, to_new.map.mapX, to_new.map.mapY, to_new.bush, to_new.players, to_new.health, BOTS)
		require "game"
		game.load()
		bool = true
	end
end
function love.draw(dt)
if bool==false then
	love.graphics.draw(bg,0,0)
	love.graphics.draw(prost,yBB,xBB)
	love.graphics.draw(buttom,245,245)
	if BBB then love.graphics.draw(bombBB,xbB,ybB) end
		if choose==1 and fBB and not fBBB then love.graphics.draw(fireM,xbB,ybB) end
	if fBBB and choose==1 and global_time<=6 then love.graphics.draw( anim, xbB+50, ybB+50, RADIANS, 1, 1, 100, 100 ) end
	
	if global_time>6 and choose==1 and global_time<30-20 then 
		if verystrangeboolean==nil then verystrangeboolean = true myxbB=xbB myybB=ybB end
		love.graphics.draw( flame, myxbB+50, myybB+50 ) 
	end
	if choose<2 then love.graphics.draw( caption, 150, 400 ) end
	local COUNT = 0
	for i,v in pairs (to_new) do 
		if i~="map" and i~="bots" then
			love.graphics.print( i..'  '..v, 600, 100+COUNT*20 )
			COUNT = COUNT+1
		elseif i=="map" then
			for iterator,value in pairs(v) do 
				love.graphics.print( iterator..'  '..value, 600, 100+COUNT*20 )
				COUNT = COUNT+1
			end
		elseif i=="bots" then
			for iterator,value in pairs(v) do 
				love.graphics.print( value, 600+20, 100+COUNT*20 )
				love.graphics.draw( menubotimages[iterator] ,600,100+COUNT*20, 0, 4/11 )
				COUNT = COUNT+1
			end
		end
	end
	COUNT = 0
	for i,v in pairs( primarys ) do
		local to_print=i if v==end_primary then to_print={{0,0,0},i} end
		love.graphics.print(to_print,400, 100+COUNT*20)
		COUNT = COUNT+1
	end
	if choose>1 then 
		if fBB and global_time<5.2 then love.graphics.draw(fireM,xbB,ybB) end
		if global_time<5.5 then love.graphics.draw( caption, 150, 400 ) end
		if global_time>5.2 and global_time<5.8 then love.graphics.draw( fireM, xbB, ybB ) end
		if global_time>5.5 and global_time<5.8 then 
			for i=1,5 do 
				love.graphics.draw( fireR, xbB + i*50, ybB )
			end
		end
		if global_time>5.7 then love.graphics.draw( caption2, 155, 400 ) love.graphics.draw( caption2part2, 340, 380 ) end
	end
	love.graphics.draw( bombergo, bomber_x, bomber_y )
	if global_time>30-20 then
		local XX = 0 if choose==1 then XX=-65 end
		love.graphics.print({{250,240,13},str}, 400, 10) 
		love.graphics.print({{250,240,13},str2}, 450+XX, 30) 
	end

end
if bool then game.draw() end
if ending==true then 
	if scores==nil then 
		local function last_element(arr) MAX=0 for i,v in ipairs(arr) do if i>MAX then MAX=i end end return MAX end
		scores = {}
		for i,v in pairs ( died ) do scores[tonumber(i)]={} scores[tonumber(i)][1]=tostring(v) scores[tonumber(i)][2]=died_colors[i] end
		for i,v in ipairs(players) do for i2=i,100 do if scores[i2]==nil then scores[i2]={} scores[i2][1]=v.score scores[i2][2]=v.Pcolor break end end end
	end
	
	local color_of_win = {255,255,255,100}
	if res[2] == "win" then color_of_win = {240,250,25,100} 
	elseif res[2] == "defeated" then color_of_win = {50,0,40,100} 
	elseif res[2] == "" then if players[1] and players[1].Pcolor then color_of_win = players[1].Pcolor else color_of_win = {100,250,20,100} end end
	if color_of_win[4]==nil then color_of_win[4] = 100 end
	love.graphics.setColor ( color_of_win )
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
	love.graphics.setColor (60,60,60,200)
	
	love.graphics.rectangle ("fill",love.graphics.getWidth()/2-200,love.graphics.getHeight()/2-250,400,500)

	love.graphics.setColor(255,255,255)
	
	local COUNT = 0
	for i,v in pairs ( scores ) do 
		if v[2]==nil then v[2] = {255,255,255} end
		love.graphics.print( {v[2],i..'  '..v[1]}, love.graphics.getWidth()/2-200, love.graphics.getHeight()/2-250+COUNT*30 )
		--love.graphics.print( v[2], love.graphics.getWidth()/2-200, love.graphics.getHeight()/2-250+COUNT*30 )
		COUNT = COUNT+1
	end
	
end
end