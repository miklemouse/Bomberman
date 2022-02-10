empty_canvas = love.graphics.newCanvas(1,1)

MAP = {
	new = function (self,o)
			o = o or {}
			setmetatable(o,self)
			self.__index = self
			return o
	end,
	set_canvases = function (self)
					for i,v in ipairs(self.layers) do
						if v.drawable==true then 
							self.canvases[i] = v:draw()
						else self.canvases[i] = empty_canvas end
					end
	end,
	draw = function (self,x,y)
			self:set_canvases()
			for i,v in ipairs(self.canvases) do 
				love.graphics.draw(v,x or 0, y or 0)
			end
	end,
	update = function (self,dt)
				for i,v in ipairs(self.layers) do 
					v:update(dt,self.layers)
				end
	end,
	mapx = 0,
	mapy = 0,
	layers = {},
	tiles = {},
	canvases = {}
}

function create_map (arg1,arg2)
	return MAP:new {
		mapx = arg1,
		mapy = arg2,		
		layers = {}
	}
end

function create_layer (arg1,arg2,argname,argobjects,argdrawable,argupdateable,argchangeable)
	return {
		name = argname or '',
		canvas = love.graphics.newCanvas(arg1,arg2),
		objects = argobjects or {},
		
		drawable = argdrawable or true,
		updateable = argupdateable or true,
		changeable = argchangeable or true,
		
		draw = function (self)
			if self.changeable == true then 
				love.graphics.setCanvas(self.canvas)
					
					love.graphics.clear()
					love.graphics.setColor(255,255,255)
					
					for i,v in ipairs(self.objects) do 
							if v.image then 
								love.graphics.draw(v.image,v.x or 0,v.y or 0)
							end
					end
				love.graphics.setCanvas()
			end
			return self.canvas
		end,
		update = function (self,dt,layers)
			if self.updateable == true then 
				for i,v in ipairs(self.objects) do 
					v:update(dt,layers)
				end
			end
		end
	}
end
