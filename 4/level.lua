require "class"
require "map"
require "movable"

level = class:new {
	movables = {player:new()},
	map = {},
	movable_update = function (self,dt)
		for i,v in ipairs(self.movables) do 
			v:update(self.map,dt)
		end
	end,
	map_update = function (self,dt)
		
	end,
	draw = function (self)
		self.map:draw(0,0)
		for i,v in ipairs(self.movables) do 
			love.graphics.draw(v.image_now,v.position.x,v.position.y)
		end
	end
}