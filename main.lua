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
require 'star'

math.randomseed(os.time())

player = {} -- make a player 'Object'
player.position = vector.new(0, 0) -- use the vector library to make a vector object containing the player's position and assign it to the player

ballList = {} -- a list that contains all of the balls in the game

song = love.audio.newSource("Space_Juggler.wav") -- import music
earth = love.graphics.newImage("Earthy.png") -- import sprite
earth:setFilter("nearest", "nearest") -- really important line here; sets the filter used for scalaing to nearest instead of linear, which prevents blur

function love.load()
  love.window.setTitle("Space Juggler") -- Sets the title of the program

	-- For the timer
  dtotal = 0
  milSeconds = 0
  seconds = 0
  minutes = 0
  time = ""

	love.window.setFullscreen(true)

	background = love.graphics.newCanvas() -- create a background canvas to draw all background stars (default size is the screen dimensions
	love.graphics.setCanvas(background) -- sets all future rendering operations to the canvas

	local w, h = love.window.getMode()
	local numStars = w * h / 2000

	local stars = {}
	for i = 1, numStars do -- make a shit-ton of stars
		table.insert(stars, star:new())
	end

	for i, v in ipairs(stars) do
		v:draw()
	end

	love.graphics.setCanvas()

	love.audio.play(song)

	love.mouse.setPosition(400, 300) -- start the mouse in the center of the screen at the beginning of the game

	ballList[1] = ball:new(100, 100) -- make some balls and put them in the ball list
	ballList[2] = ball:new(700, 500)

	gametime = 0
	lastSpawnTime = 0
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

function love.update(dt)
	gametime = gametime + dt
	timer(dt)

	player.position.x = love.mouse.getX() -- set the player position to the cursor; note that we can access the x and y components of the vector object directly
	player.position.y = love.mouse.getY()

	for i, v in ipairs(ballList) do -- generic for that loops through ballList and calls the update function of each ball
		v:update(dt)
	end
end

-- Makes the timer in the top left hand corner
function timer(dt)
  dtotal = dtotal + dt
  milSeconds = math.floor(dtotal * 100) -- Milliseconds
  if milSeconds >= 100 then
    milSeconds = 99
  end
	if dtotal >= 1 then
    dtotal = dtotal - 1
    seconds = seconds + 1
  end
  if seconds == 60 then
    seconds = 0
    minutes = minutes + 1
  end
  if minutes < 10 then
    time = "0" .. minutes
  else
    time = minutes
  end
  if seconds < 10 then
    time = time .. ":0" .. seconds
  else
    time = time .. ":" .. seconds
  end
  if milSeconds < 10 then
    time = time .. ":0" .. milSeconds
  else
    time = time .. ":" .. milSeconds
  end
end

function love.draw()
  love.graphics.draw(background)

  love.graphics.setNewFont("zero_hour.ttf", 40)
  love.graphics.setColor(125, 125, 125)
  love.graphics.rectangle("fill", 15, 15, 450, 55)
  love.graphics.setColor(255, 255, 255)
	love.graphics.print("Time: " .. time, 25, 20)

	for i, v in ipairs(ballList) do -- generic for that loops through ballList and calls the draw function of each ball
		v:draw()
	end
end
