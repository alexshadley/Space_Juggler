--[[
	"Programming in Lua" is one of the best books ever written on Lua programming, and the whole thing is available online
for free.  I would highly recommending reading through the book, but definitely check out the chapter over OOP at
https://www.lua.org/pil/16.html .  I've summarized my knowledge below, but the book really is the golden standard.  I
also don't have time to explain how awesome (and weird) Lua tables are, so just go read about it in PIL:
https://www.lua.org/pil/11.html

	Ok, this warrants a quick explanation of how object oriented programming works in Lua.  Technically, Lua isn't object
oriented and can't have objects, but thanks to the flexibility of the language we can still write code that behaves exactly
like an object.  In Lua, tables are very flexible and can contain just about anything: variables of any type of data,
functions, and even other tables.  Since an object is really just a collection of methods and variables, we can create a
table, give it the desired functions and variables, and call it an object.

	One recuring anomaly you might have noticed is how we consistently use a colon instead of a dot when reffering to
functions of an object.  This is 'syntactic sugar' that implies an argument that comes before the first argument of the
function.  This argument is always the object calling the function, and is always set to 'self'.  Thus, the following two
function declarations are basically equivalent:

		function box.insertItem(self, item)

		function box:insertItem(item)
		
This allows for box member variables to be accessed from within box functions, for instance if box has a size variable, it
can be accessed with self.size.
]]

ball = {}

function ball:new(x, y)
	o = {}
	setmetatable(o, {__index = self})
	
	o.position = vector.new(x, y)
	o.velocity = vector.new(0, 0)
	
	-- balancig variables
	o.ACCELERATION_CONSTANT = 5000000 -- constant that can be modified to alter how quickly balls are drawn towards the player
	
	return o
end

function ball:update(dt)
	local differenceVector = player.position - self.position -- vector from the ball to the player
	local normalVector = differenceVector:normalized() -- normal vector pointing towards the player
	local accelerationVector = normalVector * (self.ACCELERATION_CONSTANT / (differenceVector:len()^2) ) -- based off of the gravitational acceleration equation, substituted the acceleration constant for mass of the player since that's arbitrary anyways
	
	self.velocity = self.velocity + accelerationVector * dt -- update velocity with acceleration
	self.position = self.position + self.velocity * dt -- update position with velocity
end

function ball:draw()
	love.graphics.setColor(255, 255, 255)
    
    love.graphics.draw(earth, self.position.x - earth:getWidth() * 1.5, self.position.y - earth:getHeight() * 1.5, 0, 3)
end