imageLib = {
	standartImages = {
		SWD = { --Start Win and Death
			'bombermen/Bomberman',
			'bombermen/Bomberman',
			'bombermen/Bomberman'}, 
		
		D = {
			'bombermen/BombermanD',
			'bombermen/BombermanD2',
			'bombermen/BombermanD3'
		},
		R = {
			'bombermen/BombermanR',
			'bombermen/BombermanR2', 
			'bombermen/BombermanR3'
		},
		L = {
			'bombermen/BombermanL',
			'bombermen/BombermanL2', 
			'bombermen/BombermanL3'
		},
		U = {
			'bombermen/BombermanU',
			'bombermen/BombermanU2', 
			'bombermen/BombermanU3'
		}
	},
	standartMapImages = {
		tiles = {
			B = 'Bush',S = 'Stone', F = 'Field', door = 'Door', key = 'Key', button = 'Button', unbutton = 'Unbutton', waterbutton = 'Waterbutton', exit = 'Exit', spawn = 'Spawn', piston = 'Piston', dooropen = 'DoorOpen', pistonopen = 'DoorOpen', Bomb = 'Bomb', T = 'Torch'
		},
		bonuses = {
			Boot = 'Boot', Flame = 'Flame', Boom='Boom', Shield='Shield', Detonator='Detonator', BS='Bombs', BBall='Bascetball', FBall='Football', SFlame='SuperFlame'
		},
		impermanents = {
			Fr = 'FireR', Fl = 'FireL', Fd = 'FireD', Fu = 'FireU', Fb = 'FireB', Fm = 'FireM', Bomb = 'Bomb',  BombBurn = 'BombBurn'
		},
		allocates = {
			A = 'Water', Line = 'WaterLine', Line1 = 'WaterLine1', Line2 = 'WaterLine2', Line3 = 'WaterLine3'
		},
		water = {
			W = 'Water'
		}
	}
}

function imageLib.loadImages(Argimages)
	local LImages = {}
	for i,v in pairs(Argimages) do
		LImages[i]={}
		for i2, v2 in ipairs(v) do
			local Limage = love.graphics.newImage(v2 .. '.png')
			table.insert(LImages[i],Limage) 
		end
	end
	return LImages
end

function imageLib.setImage(argMovable)
	local vars = argMovable
	local to_return = {}

	if true then 
		local v = vars.moveDirection
		if v==1 then to_return[1]='R' 
		elseif v==2 then to_return[1]='L'
		elseif v==3 then to_return[1]='D'
		elseif v==4 then to_return[1]='U' 
		elseif v==0 then to_return[1]='SWD' end	
	end
	if vars.moving == false then to_return[2]=1 return to_return end
	if vars.moving and math.sqrt(math.pow((vars.targetX-vars.x),2) + math.pow((vars.targetY-vars.y),2))/level.ts<=0.5 then
		to_return[2] = 2
	elseif vars.moving then to_return[2] = 3 end
	return to_return
end
