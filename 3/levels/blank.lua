levels.blank = {}

function levels.blank.load()
	require 'libs/LevelLib'
	require 'libs/Map'
	require 'libs/Movable'
	require 'libs/Image'
	level = levelLib.new(50,{},mapLib.new ({'blank'}, imageLib.standartMapImages, mapLib.standartProbability, 10,10, 0, 0)) --not trash yet
end

function levels.blank.update(dt)
end

function levels.blank.draw()
	blank.draw()
end