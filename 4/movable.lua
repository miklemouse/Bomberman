movable = class:new {
	position = point(),
	target = point(),
	speed = 1, -- клеточки в секунду ^^
	update = function (self) return self end,
	image_now = love.graphics.newImage("blank.png")
}

player = movable:new {	
	controlArr = {
		right = "d",
		left = "a",
		up = "w",
		down = "s"
	},
	obstructionArr = {
		field = {"B"}
	},
	update = function (self,_map,dt)
		local ts = _map.tilesize
		
		local function choose_target()	
			if self.position.x%1~=0 or self.position.y%1~=0 then return self.target end
			
			local target_new = point()
			
			-- непосредественно задание цели <3
			if love.keyboard.isDown(self.controlArr.right) then
				target_new = self.position + point (ts,0)
			elseif love.keyboard.isDown(self.controlArr.left) then
				target_new = self.position - point (ts,0)
			elseif love.keyboard.isDown(self.controlArr.up) then
				target_new = self.position - point (0,ts)
			elseif love.keyboard.isDown(self.controlArr.down) then
				target_new = self.position + point (0,ts)
			end
			
			-- минус хрень :3
			target_new:to_limit(_map)
			for i,v in pairs(self.obstructionArr) do 
				if _map.cells[i] == nil then self.obstructionArr[i] = nil end
			end
			
			-- проверка на непроходимости (великий и могучий русский язык)0))
			for it,val in pairs (self.obstructionArr) do 
				for i,v in ipairs (val) do 
					if target_new:tiles(_map)[it] == v then return self.position end
				end
			end
			return target_new
		end
		
		local function move(dt)
			self.position = self.position + to_orthonormal(self.target-self.position)*self.speed*ts*dt
		end
		self.target = choose_target()
		move(dt)
	end,
	image_now = love.graphics.newImage("Bush.png")
}
