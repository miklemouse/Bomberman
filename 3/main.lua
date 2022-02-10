levels = {} --!!			--level.map.cells = mapLib.randmodify(level.map.mapX,level.map.mapY,level.map.cells) --trash
	STR = 'mapCreator' --not trash yet
	--require ('levels/'..STR) 
	require 'levels/mapCreator'
	level = {}
function love.load ()
	acceleration = 1
	--sequence = {1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144}
	--phi = (1+math.sqrt(5))/2
	levels[STR].load()
end
function love.update (dt)
	levels[STR].update(dt)
end
function love.mousepressed(x,y,button)
	if levels[STR].mousepressed then levels[STR].mousepressed(x,y,button) end
end
function love.draw ()
	levels[STR].draw()
end
function love.keypressed(key)
	if levels[STR].keypressed then levels[STR].keypressed(key) end
end