function explode(xb,yb,range,ft)
	u=xb/ts
	l=yb/ts
	local function line(S,S2,arg)
		--if S>0 and S<mapX and S2>0 and S2<mapY then
		local var = map[S][S2]
		local boolean = false
		if S>0 then
			for i=1,table.getn(level.mapBonuses) do if var==level.mapBonuses[i] then boolean=true end end
			if var == 0 or var == 'Fr' or var == 'Fm' or var == 'Fd' or var == 'Fl' or var == 'Fu' then
				if var~=arg and var~=0 then map[S][S2]='Fm' else map[S][S2]=arg end 
					fires[S][S2][1]=0 fires[S][S2][2]=ft
			elseif boolean then	a=math.random(80)

						for i=1,table.getn(level.values) do
							if a<=level.values[i][1] then bonuses[S][S2]=level.values[i][2] break end
						end				
						map[S][S2]=0
			--if S>1 and S2>1 then 
				sides[S-1][S2-1][1]=0 sides[S-1][S2-1][2]=ft end
			--end 
		end
		end
	-- local function obsBool (ux,ly)
		-- for i=1, table.getn(level.obs) do 
			-- if map[ux][ly]==level.obs[i] then 
				-- return true 
			-- end
		-- end
		-- return false
	-- end
			map[u][l]='Fm' fires[u][l][2]=ft
			for side=1,range,1 do if u+side<=mapX then if obstructions(u+side,l) then line(u+side,l,'Fr') break end line(u+side,l,'Fr') end end
			for side=1,range,1 do if u-side>=1 then if obstructions(u-side,l) then line(u-side,l,'Fl') break end line(u-side,l,'Fl') end end
			for side=1,range,1 do if l+side<=mapY then if obstructions(u,l+side) then line(u,l+side,'Fd') break end line(u,l+side,'Fd') end end
			for side=1,range,1 do if l-side>=1 then if obstructions(u,l-side) then line(u,l-side,'Fu') break end line(u,l-side,'Fu') end end
	
	return (map)

end

