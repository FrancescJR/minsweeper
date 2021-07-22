StartState = Class{}


function StartState:init()
    self.panel = Panel(
        VIRTUAL_WIDTH/2- 64,
        VIRTUAL_HEIGHT/2 - 64,
        64,
        64
    )

    self.menu = Menu (
        self.panel,
        {
            {
                text = 'New Game',
                onSelect = function()
                    gStateStack:pop()
                    gStateStack:push(PlayState())
                end
            },
            {
                text = 'Quit',
                onSelect = function()
                    love.event.quit()
                end
            }
        }
    )

end

function StartState:enter()

end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    self.menu:update()
end

function StartState:render()

    love.graphics.setColor(0, 0, 0, 128/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    self:drawTitle()
    self.menu:render()
end

function StartState:drawTitle()

    -- draw semi-transparent rect behind MATCH 3
    love.graphics.setColor(1, 1, 1, 128/255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 76, VIRTUAL_HEIGHT / 2 +36 - 11, 150, 58, 6)

    -- draw MATCH 3 text shadows
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Mine Sweeper", 0, VIRTUAL_HEIGHT / 2 + 36,
        VIRTUAL_WIDTH, 'center')
end

function StartState:exit()
end