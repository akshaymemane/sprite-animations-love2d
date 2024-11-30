
function love.load()

    -- Maximize the window size
    local desktopWidth, desktopHeight = love.window.getDesktopDimensions()
    love.window.setMode(desktopWidth, desktopHeight, { fullscreen = false, resizable = true })

    animate = require 'libs/anim8'

    -- List of character folders
    local characters = { "Shinobi", "Fighter", "Samurai" }
    
    -- List of animation types with default duration
    local animationTypes = {
        { name = "Idle", duration = 0.05 },
        { name = "Attack_1", duration = 0.1 },
        { name = "Attack_2", duration = 0.25 },
        { name = "Attack_3", duration = 0.15 },
        { name = "Dead", duration = 0.5 },
        { name = "Hurt", duration = 0.5 },
        { name = "Jump", duration = 0.1 },
        { name = "Run", duration = 0.1 },
        { name = "Shield", duration = 0.1 },
        { name = "Walk", duration = 0.1 }
    }

    -- Table to store animations for each character
    sprites = {}
    animations = {}

    -- Load animations for each character
    for _, character in ipairs(characters) do
        sprites[character] = {}
        animations[character] = {}

        for _, animType in ipairs(animationTypes) do
            local imagePath = string.format("sprites/%s/%s.png", character, animType.name)
            local spriteImage = love.graphics.newImage(imagePath)
            sprites[character][animType.name] = spriteImage

            -- Calculate frame count dynamically
            local frameCount = spriteImage:getWidth() / 128
            
            local grid = animate.newGrid(128, 128, spriteImage:getWidth(), spriteImage:getHeight())
            local frames = string.format("1-%d", frameCount)
            animations[character][animType.name] = animate.newAnimation(grid(frames, 1), animType.duration)
        end
    end
end

function love.update(dt)
    for _, characterAnimations in pairs(animations) do
        for _, animation in pairs(characterAnimations) do
            animation:update(dt)
        end
    end
end

function love.draw()

    -- Set a gray background
    love.graphics.clear(0.2, 0.2, 0.2)


    local y = 100
    local rowSpacing = 200 -- Add more spacing between rows

    for character, characterAnimations in pairs(animations) do
        local x = 100
        for animType, animation in pairs(characterAnimations) do
            -- Draw the animation
            animation:draw(sprites[character][animType], x, y)

            -- Draw the animated reflection below the animation
            love.graphics.setColor(1, 1, 1, 0.5) -- Set transparency for reflection
            animation:draw(
                sprites[character][animType],
                x, y + 260,                  -- Position below the original sprite
                0,                          -- No rotation
                1, -1                        -- Flip vertically
            )
            love.graphics.setColor(1, 1, 1, 1) -- Reset color to default
            
            x = x + 150 -- Spacing between animations in a row
        end
        y = y + rowSpacing -- Add spacing between rows
    end
end
