--
-- Created by IntelliJ IDEA.
-- User: cesc
-- Date: 22/07/2021
-- Time: 17:34
-- To change this template use File | Settings | File Templates.
--
PlayState = Class{}


function PlayState:init()
    self.board = Board(44,24)
end

function PlayState:enter()

end

function PlayState:update(dt)
    self.board:update()
end

function PlayState:render()
    self.board:render()
end

