local mt
mt = {
			__add = function(point1,point2)
						return point(point1.x+point2.x,point1.y+point2.y)
					end,
			__unm = function(arg_point)
						return point(-arg_point.x,-arg_point.y)
					end,
			__sub = function(point1,point2)
						return point1 + (-point2)
					end,
			__mul = function(arg_point,arg_num)
						return	point(arg_point.x*arg_num,arg_point.y*arg_num) 	
					end,
			__div = function(arg_point,arg_num)
						return arg_point*(1/arg_num)
					end,
			__eq = function (point1,point2)
						return (point1.x == point2.x and point1.y == point2.y)
					end
		}

function point(_x,_y) 
	local p = 
	{
		x = _x or 0,
		y = _y or _x or 0,
		
		-- возвращает все клеточки^^(разные типы клеточек^^), на которых стоит точка 
		tiles = function (self,_map)
			local tiles = {}
			for i,v in pairs(_map.cells) do 
				tiles[i] = v[math.floor(self.x)][math.floor(self.y)]
			end
			return tiles
		end,
		
		-- обращает в ноль все, что < 0, обращает в значение размера карты, все что больше значения размера карты :*
		to_limit = function (self,_map)
			self.x = math.max(0,self.x)
			self.x = math.min((_map.map_x-1)*_map.tilesize,self.x)
			self.y = math.max(0,self.y)
			self.y = math.min((_map.map_y-1)*_map.tilesize,self.y)
		end,
		
		length = function (self)
			return math.sqrt(math.pow(self.x,2) + math.pow(self.y,2))
		end
	}
	
	setmetatable(p,mt)
	return p
end

-- делает модуль вектора, равным 1
to_orthonormalO = function (_point)
		
	local sign_x = 1
		if _point.x < 0 then sign_x = -1 end
	local sign_y = 1
		if _point.y < 0 then sign_y = -1 end
	
	local k = _point.y/_point.x
	local x = 1/math.sqrt(1+k^2)
	
	return point( -100, k*x )
end

function sign(_point)
	local _sign = point()
	
	if _point.x < 0 then _sign.x = -1 
	elseif _point.x > 0 then _sign.x = 1 end
	
	if _point.y < 0 then _sign.y = -1 
	elseif _point.y > 0 then _sign.y = 1 end

	return _sign
end

function to_orthonormal (_point)	
	if _point.x == 0 or _point.y == 0 then return sign(_point) end
	return _point/(_point:length())
end