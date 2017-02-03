--[[
	Before you go any further, you should definitely go to the Love2d wiki (love2d.org/wiki) and go through the hello world
example.  Most of what's written below is just a rehash of what you'll learn there, but not as good.

	With Love2d, main.lua is always where the engine starts.  love.load() is called once when the program is started up, and
love.update() and love.draw() are each called once per frame (default fps is 60).  love.update() is in charge of updating the
game state, for instance moving players, enemies, and bullets, checking to see if bullets have collided with players or if
players have collided with walls, etc.  95% of our time will be spend working on things that happen during this function call.
love.draw() is responsible for drawing everything to the screen, and in general is where most of our interaction with the
Love2d engine will happen.
]]

HC = require 'HC' -- Import collision library, equivalent to #include<some_library> in C++, except this library is third-party
vector = require 'hump.vector' -- Import vector library

require 'ball' -- Include our ball.lua file, which contains the ball object.  Equivalent to #include "ball.h" in C++

player = {} -- make a player 'Object'
player.position = vector.new(0, 0) -- use the vector library to make a vector object containing the player's position and assign it to the player

ballList = {} -- a list that contains all of the balls in the game

function love.load()
	love.mouse.setPosition(400, 300) -- start the mouse in the center of the screen at the beginning of the game
	
	ballList[1] = ball:new(100, 100) -- make some balls and put them in the ball list
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