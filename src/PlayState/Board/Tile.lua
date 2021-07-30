--
-- Created by IntelliJ IDEA.
-- User: cesc
-- Date: 22/07/2021
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
--
Tile = Class{}

function Tile:init(posX, posY, width, hasBomb)
    self.posX = posX
    self.posY = posY
    self.x = posX * width * 2 + 10
    if (posX % 2 == 0) then
        self.y = posY * 2 * width + 10;
    else
        self.y = posY * 2 * width - width + 10;
    end
    self.width = width

    self.upInGrid = posX % 2 == 1;

    self:generateVertices()
    self.hasBomb = hasBomb;

    self.adjacentBombsIndicator = 5;
    self.uncovered = false;
    self.selected = false;
end

function Tile:generateVertices()
    self.vertices = {}
    table.insert(self.vertices, self.x)
    table.insert(self.vertices, self.y)
    table.insert(self.vertices, self.x + self.width)
    table.insert(self.vertices, self.y)
    table.insert(self.vertices, self.x + 2 * self.width)
    table.insert(self.vertices, self.y + self.width)
    table.insert(self.vertices, self.x + self.width)
    table.insert(self.vertices, self.y + 2 * self.width)
    table.insert(self.vertices, self.x)
    table.insert(self.vertices, self.y + 2 * self.width)
    table.insert(self.vertices, self.x - self.width )
    table.insert(self.vertices, self.y + self.width)
end

function Tile:setAdjacentsBombsIndicater(number)
    self.adjacentBombsIndicator = number
end

function Tile:uncover()
    self.uncovered = true
end

function Tile:select()
    self.selected = true
end

function Tile:unSelect()
    self.selected = false
end

function Tile:render()

    if self.selected then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.polygon("fill", self.vertices)
    else
        if self.hasBomb then
            love.graphics.setColor(1, 0, 1, 1)
            love.graphics.polygon("fill", self.vertices)
            love.graphics.setColor(1, 1, 1, 1)
        else
--            if self.uncovered then
--                love.graphics.setColor(1, 255, 1, 1)
--                love.graphics.polygon("fill", self.vertices)
--            else
                love.graphics.setColor(1, 1, 1, 1)
                if self.adjacentBombsIndicator > 0 then
                    love.graphics.printf(tostring(self.adjacentBombsIndicator), self.x, self.y + 1, self.width * 1.5, 'center')
                end
                love.graphics.polygon("line", self.vertices)
--            end
        end
    end



end
