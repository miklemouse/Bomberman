require "vector"
require "classes"
require "map"

function love.load()
	map = create_map(10,10)
	local player = movable:new{image = love.graphics.newImage("Bomberman.png")}
	local tiles = {}
	local permanents = {}
	for ix = 0, 10 do 
		for iy = 0, 10 do 
			table.insert(tiles, tile:new {x = ix*50, y = iy*50,
											objects = {},
											update = function(self,dt,layers) 
												for i,v in ipairs(layers) do 
													for it,val in ipairs(v) do 
														if val.x >= self.x and val.x-50 <= self.y and val.y >= self.y and val.y-50 <= self.y then 
															
														end
													end
												end
											end
			})
			table.insert(permanents, tile:new {x = ix*50, y = iy*50, image = love.graphics.newImage("Field.png")})
		end
	end
	
	map.layers[1] = create_layer(500,500,"permanents",permanents,true,false,true)
	
	map.layers[2] = create_layer(500,500,"movable",{player})
end

function love.update(dt)
	map:update(dt)
end

function love.draw()
	map:draw()
end