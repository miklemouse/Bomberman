levels.scroll = {}
level = levels.scroll

function levels.scroll.load()
	require "libs/Level"
	require "libs/Map"
	require "libs/Image"
	require "libs/Movable" 
	level = levelLib.new(50,{},mapLib.new ({mapX = 20, mapY = 13}, imageLib.standartMapImages, mapLib.standartProbability, 20,13, 0, 0)) 
	level.map.cells.water = {}
	for i=1,level.map.mapX do level.map.cells.water[i]={} for i2=1,level.map.mapY do 
		level.map.cells.water[i][i2]="W"
	end end
end
function levels.scroll.update(dt)
end
function levels.scroll.draw()
	levelLib.draw()
end