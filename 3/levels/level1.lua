levels.level1={}
function levels.level1.load()
	require 'libs/Behaviour'
	require 'libs/Movable'
	require 'libs/Map'
	require 'libs/Level'
	require 'libs/Image'
	level = levelLib.new(50,{},mapLib.new ({'level1'}, imageLib.standartMapImages, mapLib.standartProbability, 20,13, 0, 0))
	level.POINTS = POINTSlib.load (level.movable,level.map)
	love.window.setFullscreen(true)
	String = ''

	canvas = love.graphics.newCanvas(level.map.viewX*level.ts,level.map.viewY*level.ts)
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()

end
function levels.level1.update(dt)
	levelLib.ForMovableUpdate(dt)
	for iterator,v in pairs(level.map.cells) do 
		for i=1,level.map.mapX do for i2=1,level.map.mapY do
			if iterator=='spawn' then
				if v[i][i2]=='player' then table.insert(level.movable,movableLib.new('player',{'w','a','s','d','space'},imageLib.standartImages,50,0,0)) level.movable[1].bombsvars.bombs=0 level.movable[1].movevars.speed=level.ts*2 v[i][i2]=0 end
				if v[i][i2]=='bot' then table.insert(level.movable,movableLib.new('bot',{'partI','axis'},imageLib.standartImages,50,i*level.ts,i2*level.ts)) level.movable[table.getn(level.movable)].movevars.speed=level.ts*table.getn(level.movable)*2 v[i][i2]=0 end
			elseif iterator=='door1' then 
				if v[i][i2]=='key' then for it,value in pairs(level.movable) do --not trash yet 
					if value.movevars.x==(i-1)*level.ts and value.movevars.y==(i2-1)*level.ts then value.varsides['door1key1']=true  v[i][i2]=0 level.map.cells['tiles'][i][i2]=0 end 
				end end
				if v[i][i2]=='door' then for it,value in pairs(level.movable) do  
					if value.movevars.x+level.ts==(i-1)*level.ts and value.movevars.y==(i2-1)*level.ts and value.varsides['door1key1'] then level.map.cells.obstructions[i][i2]=0 v[i][i2]=0 level.map.cells['tiles'][i][i2]=0 end 					
				end end
			elseif iterator=='impermanents' then
				if v[i][i2]~=0 then
					if v[i][i2].Im=='Bomb' then
						if v[i][i2][1]<v[i][i2][2] then level.map.cells['impermanents'][i][i2][1]=level.map.cells['impermanents'][i][i2][1]+dt
						else mapLib.StImpermanent_exploddy(i,i2)
						end
					elseif v[i][i2].Im=='Fr' or v[i][i2].Im=='Fl' or v[i][i2].Im=='Fd' or v[i][i2].Im=='Fu' or v[i][i2].Im=='Fm' then
						if v[i][i2][1]<v[i][i2][2] then level.map.cells['impermanents'][i][i2][1]=level.map.cells['impermanents'][i][i2][1]+dt
						else level.map.cells['impermanents'][i][i2]=0 level.map.cells['tiles'][i][i2]=0 level.map.cells['obstructions'][i][i2]=0 level.map.cells['fatals'][i][i2]=0
						end						
					end
				end
			end
		end end
	end
	if table.getn(level.movable)>=2 then
		if level.movable[1].movevars.x==level.movable[2].movevars.x and level.movable[1].movevars.y==level.movable[2].movevars.y then
			level.movable[1].die=true
			level.movable[1].imageNow = {'SWD',3}
		end 
	end
	if table.getn(level.movable)>=3 then
		if level.movable[1].movevars.x==level.movable[3].movevars.x and level.movable[1].movevars.y==level.movable[3].movevars.y then
			level.movable[1].die=true
			level.movable[1].imageNow = {'SWD',3}		
		end
	end
end
function levels.level1.draw()
	love.graphics.setColor(255, 255, 255, 255)
	
	levelLib.draw(false)
	love.graphics.print({{0,0,0},String},400)
end