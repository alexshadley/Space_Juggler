ball = {}

function ball:new(x, y)
	o = {}
	setmetatable(o, {__index = self})
	
	o.position = vector.new(x, y)
	o.velocity = vector.new(0, 0)
	
	--balancig variables
	o.ACCELERATION_CONSTANT = 5000000 --constant that can be modified to alter how quickly balls are drawn towards the player
	
	return o
end

function ball:update(dt)
	--debug.debug()

	local differenceVector = player.position - self.position
	local normalVector = differenceVector:normalized()
	local accelerationVector = normalVector * (self.ACCELERATION_CONSTANT / (differenceVector:len()^2) )
	
	self.velocity = self.velocity + accelerationVector * dt
	self.position = self.position + self.velocity * dt
end

function ball:draw()
	love.graphics.setColor(30, 30, 150)
	love.graphics.circle("fill", self.position.x, self.position.y, 16, 20)
	love.graphics.setColor(120, 120, 240)
	love.graphics.circle("fill", self.position.x, self.position.y, 13, 20)
end