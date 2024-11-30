function love.load()

    -- Maximize the window size
    local desktopWidth, desktopHeight = love.window.getDesktopDimensions()
    love.window.setMode(desktopWidth, desktopHeight, { fullscreen = false, resizable = true })

    animate = require 'libs/anim8'

    -- List of character folders
    characters = { "Shinobi", "Fighter", "Samurai" }
    
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

    -- Current character index to display one character at a time
    currentCharacterIndex = 1

    -- Function to load animations for a specific character
    function loadCharacterAnimations(character)
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

    -- Load the first character initially
    loadCharacterAnimations(characters[currentCharacterIndex])

end

function love.update(dt)
    for _, animation in pairs(animations[characters[currentCharacterIndex]]) do
        animation:update(dt)
    end
end

function love.keypressed(key)
    if key == "left" then
        -- Switch to the previous character
        currentCharacterIndex = (currentCharacterIndex - 2) % #characters + 1
        loadCharacterAnimations(characters[currentCharacterIndex])
    elseif key == "right" then
        -- Switch to the next character
        currentCharacterIndex = (currentCharacterIndex % #characters) + 1
        loadCharacterAnimations(characters[currentCharacterIndex])
    end
end

function love.draw()

    -- Set a gray background
    love.graphics.clear(0.2, 0.2, 0.2)

    local y = 400
    local rowSpacing = 200 -- Add more spacing between rows
    local x = 200

    -- Draw the animations for the current character
    for animType, animation in pairs(animations[characters[currentCharacterIndex]]) do
        -- Draw the animation
        animation:draw(sprites[characters[currentCharacterIndex]][animType], x, y)

        -- Draw the animated reflection below the animation
        love.graphics.setColor(1, 1, 1, 0.5) -- Set transparency for reflection
        animation:draw(
            sprites[characters[currentCharacterIndex]][animType],
            x, y + 260,                  -- Position below the original sprite
            0,                          -- No rotation
            1, -1                        -- Flip vertically
        )
        love.graphics.setColor(1, 1, 1, 1) -- Reset color to default

        x = x + 150 -- Spacing between animations in a row
    end

    -- Draw left and right arrows for navigation
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("<", 0, love.graphics.getHeight() / 2 - 50, 100, "center")
    love.graphics.printf(">", love.graphics.getWidth() - 100, love.graphics.getHeight() / 2 - 50, 100, "center")
    love.graphics.setColor(1, 1, 1)

    -- Display current character name
    love.graphics.printf(characters[currentCharacterIndex], 0, 50, love.graphics.getWidth(), "center")
end
