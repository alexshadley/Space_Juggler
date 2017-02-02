HC = require 'HC'
vector = require 'hump.vector'

require 'ball'

player = {}
player.position = vector.new(0, 0)

ballList = {}

function love.load()
	love.mouse.setPosition(400, 300)
	
	ballList[1] = ball:new(100, 100)
	ballList[2] = ball:new(700, 500)
end

function love.update(dt)
	player.position.x = love.mouse.getX()
	player.position.y = love.mouse.getY()
	
	for i, v in ipairs(ballList) do
		v:update(dt)
	end
end

function love.draw()
	for i, v in ipairs(ballList) do
		v:draw()
	end
end