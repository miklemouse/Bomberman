	for i,v in ipairs ( supermind ) do 
		--if v.bombs > 0 then createB( v.x, v.y, v.num.... ) v.bombs = v.bombs-1 --1 cпособ
		-- 2
		--разделить на (1) исполнение вс€кой вс€чины ( например убавление бомбы из v.bombs ) 
					 --(2) на сaмо поведение ( например : видишь бомбу - беги )
		if v.moving==true then 
			if v.moveDirection==1 then 
				if v.x<v.targetX then v.x = v.x+v.speed*dt 
				else v.x = v.targetX v.moveDirection = 0 end
			elseif v.moveDirection==2 then 
				if v.x>v.targetX then v.x = v.x-v.speed*dt 
				else v.x = v.targetX v.moveDirection = 0 end
			elseif v.moveDirection==3 then 
				if v.y<v.targetY then v.y = v.y+v.speed*dt 
				else v.y = v.targetY v.moveDirection = 0 end
			elseif v.moveDirection==4 then 
				if v.y>v.targetY then v.y = v.y-v.speed*dt 
				else v.y = v.targetY v.moveDirection = 0 end
			end
		
		elseif v.moving==false then 
			
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
			
			for iterator,value in ipairs( players ) do 
				if value.scores < v.scores then v.macro = {"hunt",iterator} break end
				if iterator==table.getn(players) then v.macro = { "farm" } end
			end
		
		end
		
		if v.macro[1] == "hunt" then  end --patf ( players[v.macro[2]].x, players[v.macro[2]].y, v.x, v.y.... )
		if v.macro[1] == "farm" then 
			for ix=1,mapX do for iy=1,mapY do 
				if ix+3>v.x and ix-3<v.x and iy+3>v.y and iy-3<v.y then 
					--patf ( ix, iy, v.x, v.y... )
					v.micro = {"pick"}
					break
				end
			end end
			if v.micro[1]~="pick" then 
				local bool = false local X = v.x/ts+1 local Y = v.y/ts+1
				if map[X][Y]=="B" then map end
			end
		end 
	end
