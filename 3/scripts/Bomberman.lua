require 'Behaviour'
require 'Explode'
ts = 50
bombermen = {
	bomberman = love.graphics.newImage('bombermen/Bomberman.png'),
	
	bombermanD = love.graphics.newImage('bombermen/BombermanD.png'),
	bombermanD2 = love.graphics.newImage('bombermen/BombermanD2.png'),
	bombermanD3 = love.graphics.newImage('bombermen/BombermanD3.png'),

	bombermanR = love.graphics.newImage('bombermen/BombermanR.png'),
	bombermanR2 = love.graphics.newImage('bombermen/BombermanR2.png'),
	bombermanR3 = love.graphics.newImage('bombermen/BombermanR3.png'),

	bombermanL = love.graphics.newImage('bombermen/BombermanL.png'),
	bombermanL2 = love.graphics.newImage('bombermen/BombermanL2.png'),
	bombermanL3 = love.graphics.newImage('bombermen/BombermanL3.png'),
	
	bombermanU = love.graphics.newImage('bombermen/BombermanU.png'),
	bombermanU2 = love.graphics.newImage('bombermen/BombermanU2.png'),
	bombermanU3 = love.graphics.newImage('bombermen/BombermanU3.png'),
	}
player = {
    bomberNow = love.graphics.newImage('bombermen/Bomberman.png'),
	backlight = love.graphics.newImage('bombermen/Backlightred.png'),
	
	speed  = 50,
	range = 1,
	x = 0,
	y = 0,
	shit = false,
	shitT = 0,
	moveDirection = 0,
	moving = false,
	target = 0,
		fire = false,
		bombs = 1,
		timer  = 0,
		b  = false,
		f=0,
		maxBombs=1,
		detonator=3,
}

function player.new(xx,yy,bcl)
	local pl={}
	pl=player
	pl.x=xx
	pl.y=yy
	str='bombermen/' .. 'Backlight' .. bcl .. '.png'
	pl.backlight=love.graphics.newImage(str)
	return(pl)
end
bomb = {  
	timer = 0,
	f = 0,
	fire = false,
	xb = 0,
	yb = 0 ,
	detonatorB = 1,
	ft = 0
}
function bomb.new(xx,yy,detonator,ft,ff,pl)
	local BO={}
	BO=bomb
	BO.xb=xx
	BO.yb=yy
	BO.detonatorB=detonator
	BO.ft=ft
	BO.f=ff 
	map[xx/ts+1][yy/ts+1]='B'
	table.insert(bombsArr,BO)
end
function new(aa)
	local arr={}
	arr=aa
	return arr 
end
function love.load()
	tree = love.graphics.newImage('Tree.png') 
	player2=player.new(123,123,'red')
	c = true
	k = 0
	bg = love.graphics.newImage('Desert.png')
	prost = love.graphics.newImage('Prost.png')
	buttom = love.graphics.newImage('Buttom.png')
	bombBB = love.graphics.newImage('Something3.png')
	fireM = love.graphics.newImage('fire/FireM.png')
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
	an = love.graphics.newImage('anim/AnimSmall1.png')
	arr = {an1,an2,an3,an4}
	love.window.setMode(1050, 650,{})
		bomberNow = love.graphics.newImage('bombermen/Bomberman.png')
		bomberSide = love.graphics.newImage('Bush.png')
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
		backlight = love.graphics.newImage('bombermen/Backlightred.png')
		
		bomberNow2 = love.graphics.newImage('bombermen/Bomberman.png')
		backlight2 = love.graphics.newImage('bombermen/Backlightlilac.png')
	
	
		flame = love.graphics.newImage('bonuses/Flame.png') --flamer
		boot = love.graphics.newImage('bonuses/Boot.png')   --
		prize = love.graphics.newImage('bonuses/Prize.png') --
		exploder = love.graphics.newImage('bonuses/Detonator.png') --
		shield = love.graphics.newImage('bonuses/Shield.png') --
		superflame = love.graphics.newImage('bonuses/SuperFlame.png') --
		bombS = love.graphics.newImage('bonuses/Boom.png')  --
		boom = love.graphics.newImage('bonuses/Bombs.png')  --
		Bascetball = love.graphics.newImage('bonuses/Bascetball.png') --
	field = love.graphics.newImage('Something.png')
	bombI = love.graphics.newImage('Something3.png')
	fireR = love.graphics.newImage('fire/FireR.png')
		fireD = love.graphics.newImage('fire/FireD.png')
		fireL = love.graphics.newImage('fire/FireL.png')
		fireU = love.graphics.newImage('fire/FireU.png')
		fireM = love.graphics.newImage('fire/FireM.png')
		fireB = love.graphics.newImage('fire/FireB.png')

		fireM3 = love.graphics.newImage('fire/FireM3.png')
		
		fireR2 = love.graphics.newImage('fire/FireR2.png')
		fireD2 = love.graphics.newImage('fire/FireD2.png')
		fireL2 = love.graphics.newImage('fire/FireL2.png')
		fireU2 = love.graphics.newImage('fire/FireU2.png')
		fireB2 = love.graphics.newImage('fire/FireB2.png')
		fireM2 = love.graphics.newImage('fire/FireM2.png')

	bush = love.graphics.newImage('Bush.png')      
	stone = love.graphics.newImage('Stone.png')
	maprand = 0
	maprand2 = 0
	map ={
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,'Shield',0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,'K',0,'K',0,'K',0,'K',0,'K',0,'K',0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0},
		  }
	sides = {
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	}
	points = {
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	} 
	bombsArr={}
	for integer=0,2,1 do
		maprand=love.math.random(6)
		for a=2,19,1 do
			map[a][maprand*2]='K'
		end
		maprand=love.math.random(10)
		for a=2,12,1 do
			map[maprand*2][a]='K'
		end
	end
	for integer=0,7,1 do
		maprand = love.math.random(2,20)
		maprand2 = love.math.random(2,12)
		if map[maprand][maprand2]~='K'  then map[maprand][maprand2]='S' end
	end
	int = 0
	nt = 0
	water =	love.graphics.newImage('Water.png')
	--II
		behaviour=true
		x3 = ts*14 y3 = ts*8
		bomberNow3 = love.graphics.newImage('bombermen/Bomberman.png')
		bbt=0
		floodb=true
	--multipleer
		multipleer=true
		speed2 = ts*3
		range2=1
		x2 = ts*20
		y2 = ts*12
		shit2=false
		shitT2=0
		moveDirection2=0
		moving2=false
		target2=0
			fire2=false
			bombs2=1
			timer2 = 0
			b2 = false
			f2=0
			maxBombs2=1
			detonator2=3
	--player
		t4 = 0
		b4 = false
		--f = 0
		fire = false
		y = 0
		x = 0
		moving = false
		moveDirection = 0; -- 0 вправо, 1 влево, 2 вверх, 3 вниз
		target = 0
		speed = ts*3
		BSpeed = false
		bSpeed = true
		SSpeed = 0
		
		timer = 0
		b = false
		
	-- bonuses
		gl1 = 0
		gl2 = 0
		range = 1 --
		bombs = 1 --
		maxBombs = 1 --
		detonator = 3 --
		bascetball = false --
		football = false
		allin = false
		-- left 
			randL = 0
			rand2L = 0
			rand2D = 0
			booleanL = true
			bSL = false
			xSL = 0
			ySL = 0
		--right
			xS = 0
			yS = 0
			bS = false
			boolean = true
			rand2 = 0
			rand = 0
		--down 
			xSD = 0
			ySD = 0
			bSD = false
			rand2D = 0
			randD = 0
			booleanD = true
		--up 
			randU = 0 
			booleanU = true
			rand2U = 0
			xSU = 0
			ySU = 0
			bSU = false
	shit = false
	shitT=0
	integer = 0
	-- guys 
		--Sped
			spedT = 0
			spedBool = false speedC = 0
			spedTimer = 0
			sped = love.graphics.newImage('guys/sped (1).png')
			sped2 = love.graphics.newImage('guys/sped (2).png')
		--Flamer
			flamerT = 0
			flamerBool = false
			flamerTimer = 0
			flamer = love.graphics.newImage('guys/Flamer.png')
			flamer2 = love.graphics.newImage('guys/Flamer2.png')
		--Rock
			rockT = 0
			rockBool = false ShitC=1
			rockTimer = 0
			rock = love.graphics.newImage('guys/Rock.png')
			rock2 = love.graphics.newImage('guys/Rock2.png')
end

function love.update(dt)
	z=dt
	if bb then 
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
		if xbB > 250 then 
			BBB = false 
			fBB = true
		end
		if fBB then timerfBB = timerfBB+dt end
		if timerfBB>1 then 

			fBBB = true 
		end
		if fBBB then bbt=bbt+dt*10 end
	end
	if not bb then
	--ts=ts+dt*30
	if speedC >= 5 and not spedBool and not b then spedT = 1 speed=ts*10 spedBool = true end
	if spedBool then 
		if spedT==1 then spedTimer=spedTimer+dt if speed>1000 then x=0 y=0 end end
		if spedTimer>0.3 then speed=speed+ts/10 spedT=0 spedTimer=-0.3 end
		if spedTimer<0 then spedT=2 spedTimer=spedTimer+dt end
		if spedTimer>0 and spedTimer<0.3 then spedT=1 end
	elseif rockBool then 
		if rockT==1 then rockTimer=rockTimer+dt end
		if rockTimer>0.3 then rockT=0 rockTimer=-0.3 if speed>ts/1.5 then speed=speed*0.97 end if detonator<=5 then detonator=detonator*1.01 end end
		if rockTimer<0 then rockT=2 rockTimer=rockTimer+dt end
		if rockTimer>0 and rockTimer<0.3 then rockT=1 end
	end
	if not moving then	
	if speedBool then speed=speed+10 detonator=detonator*0.96 end
	if
	map[(x)/ts+1][(y)/ts+1] == 'Fr' or map[(x)/ts+1][(y)/ts+1] == 'Fl' or map[(x)/ts+1][(y)/ts+1] == 'Fu' or map[(x)/ts+1][(y)/ts+1] == 'Fd' or map[(x)/ts+1][(y)/ts+1] == 'Fm3' or map[(x)/ts+1][(y)/ts+1] == 'Fm' or
	map[(x)/ts+1][(y)/ts+1] == 'Fr2' or map[(x)/ts+1][(y)/ts+1] == 'Fl2' or map[(x)/ts+1][(y)/ts+1] == 'Fu2' or map[(x)/ts+1][(y)/ts+1] == 'Fd2' or map[(x)/ts+1][(y)/ts+1] == 'Fm2' then
		if not shit then if rockT~=2 then x = 0 y = 0 else map[x/ts+1][y/ts+1]='S' end end 
	end
	if shit then shitT=shitT-dt end
	if shitT<0 and shit then shit=false end
	
	if map[(x)/ts+1][(y)/ts+1] == 'Boot' then speedC=speedC+1 speed = speed+ts map[(x)/ts+1][(y)/ts+1]=0
	
	elseif map[(x)/ts+1][(y)/ts+1] == 'SFlame' then range = range+10 map[(x)/ts+1][(y)/ts+1] = 0 
	
	elseif map[(x)/ts+1][(y)/ts+1] == 'Shield' then ShitC=ShitC+1 if ShitC==4 then rockBool=true rockT=1 speed=ts*4 detonator=1 end shit = true shitT=shitT+3 map[(x)/ts+1][(y)/ts+1] = 0 
	
	elseif map[(x)/ts+1][(y)/ts+1] == 'BBall' then bascetball=true map[(x)/ts+1][(y)/ts+1] = 0 
	
	elseif map[(x)/ts+1][(y)/ts+1]== 'Boom' then bombs=bombs+3 map[(x)/ts+1][(y)/ts+1]= 0 
	
	elseif map[(x)/ts+1][(y)/ts+1] == 'Detonator' then SSpeed=SSpeed+ts detonator = detonator*0.9 map[(x)/ts+1][(y)/ts+1]= 0
	
	elseif map[(x)/ts+1][(y)/ts+1] == 'BS' then maxBombs = maxBombs+1 map[(x)/ts+1][(y)/ts+1]= 0
	
	elseif map[(x)/ts+1][(y)/ts+1] == 'Flame' then range = range + 1 map[(x)/ts+1][(y)/ts+1] = 0 end
		if love.keyboard.isDown('d') then
			bomberNow=bombermanR
		if x < ts*20 then
			if (map[(x)/ts+2][(y)/ts+1]~='K' and map[(x)/ts+2][(y)/ts+1]~='S' and map[(x)/ts+2][(y)/ts+1]~='S') then	
				moving = true						
				moveDirection = 0					
				target = x + ts
			end
			if bascetball and map[(x)/ts+2][(y)/ts+1]=='B' then
				map[(x)/ts+2][(y)/ts+1]=0
				for a=1,x/ts+1,1 do
					if map[(x)/ts+a+2][(y)/ts+1]~='K' and map[(x)/ts+a+2][(y)/ts+1]~='B' and map[(x)/ts+a+2][(y)/ts+1]~='S' then
						map[(x)/ts+a+2][(y)/ts+1]='B' break 
					end
				end				 				 
			end	
		end
		
		elseif love.keyboard.isDown('a') then
			bomberNow = bombermanL
			if(x > 0) then
			if map[(x)/ts][(y)/ts+1] ~='K' and map[(x)/ts][(y)/ts+1] ~= 'S' and map[(x)/ts][(y)/ts+1] ~= 'B' then
				moving = true
				moveDirection = 1
				target = x - ts
				 				 
			end
			if bascetball and map[(x)/ts][(y)/ts+1]=='B' then
				map[(x)/ts][(y)/ts+1]=0
				for a=1,x/ts+1,1 do
					if map[(x)/ts-a][(y)/ts+1]~='K' and map[(x)/ts-a][(y)/ts+1]~='B' and map[(x)/ts-a][(y)/ts+1]~='S' then
						map[(x)/ts-a][(y)/ts+1]='B' break 
					end
				end
			end
			end
		elseif love.keyboard.isDown('s') then
			bomberNow = bombermanD
			if(y < ts*12) then
			if map[(x)/ts+1][(y)/ts+2]~='K' and map[(x)/ts+1][(y)/ts+2]~= 'S' and map[(x)/ts+1][(y)/ts+2]~= 'B' then
				moving = true
				moveDirection = 3
				target = y + ts
				bomberman = bomberman
				timerB = true 
			end
			if bascetball and map[(x)/ts+1][(y)/ts+2]=='B' then
				map[(x)/ts+1][(y)/ts+2]=0
				for a=1,y/ts+1,1 do
					if map[(x)/ts+1][(y)/ts+a+2]~='K' and map[(x)/ts+1][(y)/ts+a+2]~='B' and map[(x)/ts+1][(y)/ts+a+2]~='S' then
						map[(x)/ts+1][(y)/ts+a+2]='B' break 
					end
				end
			end
			end
		elseif love.keyboard.isDown('w') then
			bomberNow = bombermanU
			if (y > 0) then
			if map[(x)/ts+1][(y)/ts]~='B' and map[(x)/ts+1][(y)/ts]~= 'K' and map[(x)/ts+1][(y)/ts]~= 'S' then
				moving = true
				moveDirection = 2
				target = y - ts 
			end
			if bascetball and map[(x)/ts+1][(y)/ts]=='B' then
				map[(x)/ts+1][(y)/ts]=0
				for a=1,y/ts+1,1 do
					if map[(x)/ts+1][(y)/ts-a]~='K' and map[(x)/ts+1][(y)/ts-a]~='B' and map[(x)/ts+1][(y)/ts-a]~='S' then
						map[(x)/ts+1][(y)/ts-a]='B' break 
					end
				end
			end
			end
		end
	end
	if moving then
		if moveDirection==3 then
			if (y < target) then
				y = y + (speed * dt)
				if target-y>30 then 
					bomberNow=bombermanD2
				elseif target-y>10 then
					bomberNow=bombermanD3
				else 
					bomberNow=bombermanD
				end
			else
				y = target
				moving = false
			end
		end
		if moveDirection == 2 then
				if (y > target) then
					y = y - (speed * dt)
					if y-target>30 then 
						bomberNow=bombermanU2
					elseif y-target>10 then
						bomberNow=bombermanU3
					else 
						bomberNow=bombermanU
					end
			else
				y = target
				moving = false
			end
		end
		if moveDirection == 0 then
				if (x < target) then
					x = x + (speed * dt)
					if target-x>30 then 
						bomberNow=bombermanR2
					elseif target-x>10 then
						bomberNow=bombermanR3
					else 
						bomberNow=bombermanR
					end
				else
				x = target
				moving = false
			end
		end
		if moveDirection == 1 then
			if (x > target) then
				x = x - (speed * dt)
				if x-target>30 then 
					bomberNow=bombermanL2
				elseif x-target>10 then
					bomberNow=bombermanL3
				else 
					bomberNow=bombermanL
				end
			else
				x = target
				moving = false
			end
		end
	end
	
	
	-- explode!!
		for i=1,table.getn(bombsArr),1 do 
			bombsArr[i].f=bombsArr[i].f+dt
			if bombsArr[i].f>bombsArr[i].detonatorB then
				explode(map,bombsArr[i].xb,bombsArr[i].yb)
			
		end
		
	-- explode.
	x3=move(x,y,points,x3,y3).x3
	y3=move(x,y,points,x3,y3).y3
	points=patf(x,y,moving,points,map,x3,y3)

	--explode(map)
	--bomb.f=bomb.f+dt
end
end
 
function love.keypressed(k)
	if not bb then
		if k == 'space' then
			--local xx=x local y=y
			if moveDirection ==0 and x <ts* 0 then if map[math.ceil(x /ts)+1][y /ts+1]==0 then 
						bomb.new(math.ceil(x/ts)*ts,y,1,3,0,1) end
			elseif moveDirection ==3 and y <ts*12  then if map[x /ts+1][math.ceil(y /ts)+1]==0 then 
						bomb.new(x,math.ceil(y/ts)*ts,1,3,0,1) end
			elseif map[math.floor(x /ts)+1][math.floor(y /ts)+1]==0 then 
						bomb.new(math.floor(x/ts)*ts,math.floor(y/ts)*ts,1,3,0,1) end 
		end
		-- if k == 'return' and not fire2 and bombs2>0 then
			-- if moveDirection2==0 and x2<ts*20 then if map[math.ceil(x2/ts)+1][y2/ts+1]==0 then map[math.ceil(x2/ts)+1][y2/ts+1]='B2' bombs2=bombs2-1 timer2=0 f2=0 end
			-- elseif moveDirection2==3 and y2<ts*12 then if map[x2/ts+1][math.ceil(y2/ts)+1]==0 then map[x2/ts+1][math.ceil(y2/ts)+1]='B2' bombs2=bombs2-1 timer2=0 f2=0 end
			-- elseif map[math.floor(x2/ts)+1][math.floor(y2/ts)+1]==0 then map[math.floor(x2/ts)+1][math.floor(y2/ts)+1]='B2' bombs2=bombs2-1 timer2=0 f2=0 end 
		-- end
		if k == '1' then map[math.floor(x/ts)+1][math.floor(y/ts)+1]="K" end
		if k == 'l' then map[math.floor(x2/ts)+1][math.floor(y2/ts)+1]="K" end
	end

	if bb then if k=='1' or k=='2' or k=='3' or k=='4' or k=='5' or k=='6' or k=='7' or k=='8' or k=='9' then 
	ts=k*10 speed=ts speed2=ts x2=ts*20 y2=ts*12 x3=ts*14 y3=ts*8
	
	else if k=='0' then for i=1,21,1 do for v=1,21,1 do map[i][v]=0 end end end
	end end
	if k=='r' then love.load() end
end
function my() if not b then BSpeed=true b=true end bombs=bombs-1 f=0 timer=0 end
function love.draw()
	if not bb then
		for int = 1,21, int + 1 do
		for nt = 1,21, nt + 1 do
				if map[int][nt] == 'K' then love.graphics.draw(field,(int - 1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(bush,(int-1)*ts,(nt-1)*ts,0,ts/50)
					
				elseif map[int][nt] == 0 then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'W' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(water,(int-1)*ts,(nt-1)*ts,0,ts/50)

				
				elseif map[int][nt] == 'B' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(bombI,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'B2' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(bombI,(int-1)*ts,(nt-1)*ts,0,ts/50)

				elseif map[int][nt] == 'S' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(stone,(int-1)*ts,(nt-1)*ts,0,ts/50)
				
				elseif map[int][nt] == 'P' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(prize,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'Flame' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(flame,(int-1)*ts,(nt-1)*ts,0,ts/50)				
				elseif map[int][nt] == 'Boot' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(boot,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'Detonator' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(exploder,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt]=='BS' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(bombS,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'SFlame' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(superflame,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'Shield' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(shield,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'Boom' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(boom,(int-1)*ts,(nt-1)*ts,0,ts/50)
				elseif map[int][nt] == 'BBall' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) love.graphics.draw(Bascetball,(int-1)*ts,(nt-1)*ts,0,ts/50)

				
					elseif map[int][nt]=='Fr' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireR,(int-1)*ts,(nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fl' then love.graphics.draw(field,(int-1)*ts, (nt-1)*ts,0,ts/50)	love.graphics.draw(fireL, (int-1)*ts, (nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fu' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireU, (int-1)*ts, (nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fd' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireD, (int-1)*ts, (nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fm' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireM, (int-1)*ts, (nt-1)*ts,0,ts/50)
					
					elseif map[int][nt]=='Fm3' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50) 	love.graphics.draw(fireM3, (int-1)*ts, (nt-1)*ts,0,ts/50)					
					
					elseif map[int][nt]=='Fm2' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireM2, (int-1)*ts, (nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fr2' then love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireR2,(int-1)*ts,(nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fl2' then love.graphics.draw(field,(int-1)*ts, (nt-1)*ts,0,ts/50)	love.graphics.draw(fireL2, (int-1)*ts, (nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fu2' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireU2, (int-1)*ts, (nt-1)*ts,0,ts/50)
					elseif map[int][nt]=='Fd2' then	love.graphics.draw(field,(int-1)*ts,(nt-1)*ts,0,ts/50)	love.graphics.draw(fireD2, (int-1)*ts, (nt-1)*ts,0,ts/50)
				end
			end
		end	
	for i=1,21,1 do
		for i2=1,21,1 do
			if sides[i][i2]==1 then love.graphics.draw(fireB,i*ts,i2*ts,0,ts/50) end
			if sides[i][i2]==2 then love.graphics.draw(fireB2,i*ts,i2*ts,0,ts/50) end			 
		end
	end
		love.graphics.draw(backlight,x,y,0,ts/50)
		love.graphics.draw(backlight2,x2,y2,0,ts/50)
		love.graphics.draw(water,14*ts,8*ts,0,ts/50)
		
					love.graphics.draw(bomberNow,x,y,0,ts/50)
					love.graphics.draw(bomberNow2,x2,y2,0,ts/50)
					love.graphics.draw(bomberNow3,x3,y3,0,ts/50)
					--love.graphics.draw(player.bomberman,player.x,player.y,0,ts/50)
					love.graphics.draw(player2.bomberNow,player2.x,player2.y,0,ts/50)

					
		if shit then love.graphics.draw(shield,x,y) end
		if shit2 then love.graphics.draw(shield,x2,y2) end
		if speed > 324 then 
			if spedT == 1 then love.graphics.draw(sped,x,y,0,ts/50) end
			if spedT == 2 then love.graphics.draw(sped2,x,y,0,ts/50) end
		end
		if rockBool then 
			if rockT == 1 then love.graphics.draw(rock,x-5,y-5,0,ts/50) end
			if rockT == 2 then love.graphics.draw(rock2,x-5,y-5,0,ts/50) end
		end
	
			
		-- for i=1,21,1 do	
			-- for i2=1,16,1 do 
				-- if points[i][i2]~=0 then love.graphics.print(points[i][i2],(i-0.5)*ts,(i2-0.5)*ts,0,1.3) end 
			-- end
		-- end	
		for i=1,table.getn(bombsArr),1 do love.graphics.print(bombsArr[i].f,0,i*ts) end
		love.graphics.print(bomb.f)
	else
		--music:setPitch(1.5)
		love.graphics.draw(bg,0,0)
		love.graphics.draw(prost,yBB,xBB)
		love.graphics.draw(tree,220,235)
		love.graphics.draw(buttom,245,245)
		if BBB then love.graphics.draw(bombBB,xbB,ybB) end
		if not fBBB then if timerfBB>0 then love.graphics.draw(fireM,xbB,ybB) end end
		if fBBB then love.graphics.draw(an,xbB+60,ybB+60,bbt%100,bbt/10%20,bbt/10%20,100,100) end
end
end
function love.mousepressed(x1, y1, button, istouch)
	if (button == 1) and ((x1<350 and x1>250) or (y1<350 and y1>250)) then bb = false end
end

function obstruction(val1, val2)
	if (val1>1050 or val1<0) or (val2>650 or val2<0) then return false 
	else
		if map[(val1)/ts+1][(val2)/ts+1]=='K' or map[(val1)/ts+1][(val2)/ts+1]=='S' then return false 
		else return true end
	end
end
			for i=1,table.getn(bombsArr),1 do 
				if bombsArr[i].f<bombsArr[i].detonatorB and bombsArr[i].fire==false then
					bombsArr[i].f = bombsArr[i].f+dt
				elseif bombsArr[i].fire==false and bombsArr[i]~={} then explode(map,bombsArr[i].xb,bombsArr[i].yb,4) bombsArr[i].fire=true
				end
			end
					if k == 'space' then
			--local xx=x local y=y
			if moveDirection == 0 and x <ts* 20 then if map[math.ceil(x/ts)+1][y /ts+1]==0 then 
						table.insert(bombsArr,create(math.ceil(x/ts)*ts,y,1)) end
			elseif moveDirection == 3 and y <ts*12  then if map[x /ts+1][math.ceil(y /ts)+1]==0 then 
						table.insert(bombsArr,create(x,math.ceil(y/ts)*ts+1,1)) end
			elseif map[math.floor(x /ts)+1][math.floor(y /ts)+1]==0 then 
						table.insert(bombsArr,create(math.floor(x/ts)*ts,math.floor(y/ts)*ts,1)) end 
		end
		bombsArr = {}