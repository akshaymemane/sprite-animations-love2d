function love.load()
    animate = require 'libs/anim8'

    sprites = {}
    sprites.shinobiIdle = love.graphics.newImage('sprites/Shinobi/Idle.png')
    sprites.shinobiAttack1 = love.graphics.newImage('sprites/Shinobi/Attack_1.png')
    sprites.shinobiAttack2 = love.graphics.newImage('sprites/Shinobi/Attack_2.png')
    sprites.shinobiAttack3 = love.graphics.newImage('sprites/Shinobi/Attack_3.png')
    sprites.shinobiDead = love.graphics.newImage('sprites/Shinobi/Dead.png')
    sprites.shinobiHurt = love.graphics.newImage('sprites/Shinobi/Hurt.png')

    local shinobiIdleGrid = animate.newGrid(128, 128, sprites.shinobiIdle:getWidth(), sprites.shinobiIdle:getHeight())
    local shinobiAttack1Grid = animate.newGrid(128, 128, sprites.shinobiAttack1:getWidth(), sprites.shinobiAttack1:getHeight())
    local shinobiAttack2Grid = animate.newGrid(128, 128, sprites.shinobiAttack2:getWidth(), sprites.shinobiAttack2:getHeight())
    local shinobiAttack3Grid = animate.newGrid(128, 128, sprites.shinobiAttack3:getWidth(), sprites.shinobiAttack3:getHeight())
    local shinobiDeadGrid = animate.newGrid(128, 128, sprites.shinobiDead:getWidth(), sprites.shinobiDead:getHeight())
    local shinobiHurtGrid = animate.newGrid(128, 128, sprites.shinobiHurt:getWidth(), sprites.shinobiHurt:getHeight())


    animations = {}
    animations.shinobiIdle = animate.newAnimation(shinobiIdleGrid('1-6', 1), 0.05)

    animations.shinobiAttack1 = animate.newAnimation(shinobiAttack1Grid('1-5', 1), 0.1)
    animations.shinobiAttack2 = animate.newAnimation(shinobiAttack2Grid('1-3', 1), 0.25)
    animations.shinobiAttack3 = animate.newAnimation(shinobiAttack3Grid('1-4', 1), 0.15)

    animations.shinobiDead = animate.newAnimation(shinobiDeadGrid('1-4', 1), 0.5)
    animations.shinobiHurt = animate.newAnimation(shinobiHurtGrid('1-2', 1), 0.5)


end

function love.update(dt)
    animations.shinobiIdle:update(dt)

    animations.shinobiAttack1:update(dt)
    animations.shinobiAttack2:update(dt)
    animations.shinobiAttack3:update(dt)
    animations.shinobiDead:update(dt)
    animations.shinobiHurt:update(dt)
end

function love.draw()
    animations.shinobiIdle:draw(sprites.shinobiIdle, 100, 100)

    animations.shinobiAttack1:draw(sprites.shinobiAttack1, 100, 200)
    animations.shinobiAttack2:draw(sprites.shinobiAttack2, 200, 200)
    animations.shinobiAttack3:draw(sprites.shinobiAttack3, 300, 200)
    animations.shinobiHurt:draw(sprites.shinobiHurt, 100, 300)
    animations.shinobiDead:draw(sprites.shinobiDead, 200, 300)
end