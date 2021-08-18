--
-- Created by IntelliJ IDEA.
-- User: cesc
-- Date: 18/08/2021
-- Time: 17:58
-- To change this template use File | Settings | File Templates.
--
--
-- Created by IntelliJ IDEA.
-- User: cesc
-- Date: 22/07/2021
-- Time: 17:34
-- To change this template use File | Settings | File Templates.
--
GameOverState = Class{}


function GameOverState:init(Board)
    print("enterinf game over state")
    self.board = Board
    self.panel = Panel(
        VIRTUAL_WIDTH/2- 64,
        VIRTUAL_HEIGHT/2 - 64,
        64,
        64
    )
end


function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(StartState())
    end
end

function GameOverState:render()
    self.board:render()
    self.panel:render()
end



