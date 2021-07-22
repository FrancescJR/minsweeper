--
-- Created by IntelliJ IDEA.
-- User: cesc
-- Date: 22/07/2021
-- Time: 17:09
-- To change this template use File | Settings | File Templates.
--
Board = Class{}

function Board:init(columnsNumber, rowsNumber, width)

    self.columnsNumber = columnsNumber;
    self.rowsNumber = rowsNumber;

    self.tiles = {}

    self.selectedX = 1;
    self.selectedY = 1;

    for tileY = 1, rowsNumber do
        table.insert(self.tiles, {})
        for tileX = 1, columnsNumber do
            table.insert(self.tiles[tileY], Tile(tileX, tileY, 4, 0))
        end
    end

    self.tiles[self.selectedY][self.selectedX]:select()
end

function Board:update()
    if love.keyboard.wasPressed('up') then
        self.selectedY = math.max(1, self.selectedY-1)
        self:updateSelected();
    elseif love.keyboard.wasPressed('down') then
        self.selectedY = math.min(self.rowsNumber, self.selectedY+1)
        self:updateSelected();
    elseif love.keyboard.wasPressed('left') then
        self.selectedX = math.max(1, self.selectedX-1)
        self:updateSelected();
    elseif love.keyboard.wasPressed('right') then
        self.selectedX = math.min(self.columnsNumber,self.selectedX+1)
        self:updateSelected();
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.tiles[self.selectedY][self.selectedX]:uncover();
    end

end

function Board:updateSelected()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            self.tiles[y][x]:unSelect()
        end
    end

    self.tiles[self.selectedY][self.selectedX]:select()
end

function Board:render()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            self.tiles[y][x]:render(self.x, self.y)
        end
    end
end
