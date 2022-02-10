object = {
	position = point(), 
	image = love.graphics.newImage("blank.png"),
	trigger = function (self,p) return false end,
	update = function (self,dt,layers) end
}
function object:new(o)
	local o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

movable = object:new{
	target = point(),
	speed = 50,
	moving = false,
	move = function (self,target,dt)
		local position = self.position + to_orthonormal(target - self.position)*(self.speed*dt)
		if not(sign(position-target)==sign(self.position-target)) then
			self.position = target
			self.moving = false
		else 
			self.position = position
			self.moving = true 
		end
	end
}

tile = object:new()

player = movable:new{
	controlArr = {
		right = "d", left = "a", up = "w", down = "s"
	},
	update = function (self,dt,objects)
		local function choose_target()	
			if love.keyboard.isDown(self.controlArr.right) then
				self.target = self.position + point (50,0)
				self.moving = true
			elseif love.keyboard.isDown(self.controlArr.left) then
				self.target = self.position - point (50,0)
				self.moving = true
			elseif love.keyboard.isDown(self.controlArr.up) then
				self.target = self.position - point (0,50)
				self.moving = true
			elseif love.keyboard.isDown(self.controlArr.down) then
				self.target = self.position + point (0,50)
				self.moving = true
			end
		end
		if self.moving == false then choose_target() 
		elseif self.moving == true then self:move(self.target,dt) end
	end
}