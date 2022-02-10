levels.lighttest = {}

function levels.lighttest.load()
	require 'libs/Level'
	require 'libs/Map'
	require 'libs/Movable'
	require 'libs/Image'
	level = levelLib.new(50,{},mapLib.new ({'lighttest'}, imageLib.standartMapImages, mapLib.standartProbability, 20,13, 0, 0))
	
	canvas = love.graphics.newCanvas(level.map.viewX*level.ts,level.map.viewY*level.ts)
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		love.graphics.setBlendMode("alpha")
		love.graphics.setColor(255, 0, 0, 128)
	love.graphics.setCanvas()

end

function levels.lighttest.update(dt)
end

function levels.lighttest.draw()
	love.graphics.setColor(255,255,255)
	levelLib.draw(true)
end