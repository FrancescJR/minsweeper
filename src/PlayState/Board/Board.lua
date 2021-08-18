--
-- Created by IntelliJ IDEA.
-- User: cesc
-- Date: 22/07/2021
-- Time: 17:09
-- To change this template use File | Settings | File Templates.
--
Board = Class{}

function Board:init(columnsNumber, rowsNumber, width)
    love.graphics.setFont(gFonts['smaller'])
    self.columnsNumber = columnsNumber;
    self.rowsNumber = rowsNumber;

    self.tiles = {}

    self.selectedX = 1;
    self.selectedY = 1;

    self:generate();


    self.tiles[self.selectedY][self.selectedX]:select()
end

function Board:generate()
    for tileY = 1, self.rowsNumber do
        table.insert(self.tiles, {})
        for tileX = 1, self.columnsNumber do
            local number = math.random(0, 10)
            table.insert(self.tiles[tileY], Tile(tileX, tileY, 4, number > 8))
        end
    end
    self:updateBombsIndicatorAndAdjacentTiles();
end



function Board:updateBombsIndicatorAndAdjacentTiles()
    for tileY = 1, self.rowsNumber do
        for tileX = 1, self.columnsNumber do
            local bombs = 0;
            local tile = self.tiles[tileY][tileX];
            local adjacentTiles = self:GetAdjacentTiles(tile)
            for k, adjacenTile in pairs(adjacentTiles) do
                local addBomb = adjacenTile.hasBomb == true and 1 or 0
                bombs = bombs + addBomb
                tile:addAdjacentTile(adjacenTile)
            end


            tile:setAdjacentsBombsIndicater(bombs)
        end
    end
end

function Board:GetAdjacentTiles(tile)
    local adjacentTiles = {};
    self:AddPreviousRowAdjacentTiles(tile, adjacentTiles)
    self:AddSameRowHorizontalTiles(tile, adjacentTiles)
    self:AddNextRowHorizontalTiles(tile, adjacentTiles)
    return adjacentTiles;
end

function Board:AddPreviousRowAdjacentTiles(tile, adjacentTiles)
    if tile.posY - 1 > 0 then
        if tile.upInGrid then
            if tile.posX - 1 > 0 then
                table.insert(adjacentTiles, self.tiles[tile.posY - 1][tile.posX-1])
            end
            table.insert(adjacentTiles, self.tiles[tile.posY - 1][tile.posX])
            if tile.posX + 1 <= self.columnsNumber then
                table.insert(adjacentTiles, self.tiles[tile.posY - 1][tile.posX + 1])
            end
        else
            table.insert(adjacentTiles, self.tiles[tile.posY - 1][tile.posX])
        end
    end
end

function Board:AddSameRowHorizontalTiles(tile, adjacentTiles)
    if tile.posX - 1 > 0 then
        table.insert(adjacentTiles, self.tiles[tile.posY][tile.posX-1])
    end
    if tile.posX + 1 <= self.columnsNumber then
        table.insert(adjacentTiles, self.tiles[tile.posY][tile.posX + 1])
    end
end

function Board:AddNextRowHorizontalTiles(tile, adjacentTiles)
    if tile.posY + 1 <= self.rowsNumber then
        if tile.upInGrid then
            table.insert(adjacentTiles, self.tiles[tile.posY + 1][tile.posX])
        else
            if tile.posX - 1 > 0 then
                table.insert(adjacentTiles, self.tiles[tile.posY + 1][tile.posX - 1])
            end
            table.insert(adjacentTiles, self.tiles[tile.posY + 1][tile.posX])
            if tile.posX + 1 <= self.columnsNumber then
                table.insert(adjacentTiles, self.tiles[tile.posY + 1][tile.posX + 1])
            end
        end
    end
end

--=================== End creation logic
function Board:update()
    if love.keyboard.wasPressed('up') then
        self.selectedY = self.selectedY-1
        if self.selectedY < 1 then
            self.selectedY = self.rowsNumber
        end
        self:updateSelected();
    elseif love.keyboard.wasPressed('down') then
        self.selectedY = math.min(self.rowsNumber, self.selectedY+1)
        if self.selectedY > self.rowsNumber then
            self.selectedY = 1
        end
        self:updateSelected();
    elseif love.keyboard.wasPressed('left') then
        self.selectedX = self.selectedX-1
        if self.selectedX < 1 then
            self.selectedX = self.columnsNumber
        end
        self:updateSelected();
    elseif love.keyboard.wasPressed('right') then
        self.selectedX = self.selectedX+1
        if self.selectedX > self.columnsNumber then
            self.selectedX = 1
        end
        self:updateSelected();
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.tiles[self.selectedY][self.selectedX]:uncover(self);
--        self:printBoard()
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

function Board:gameOver()
    print("here")
    gStateStack:pop()
    gStateStack:push(GameOverState(self))
end

--====== AUX function

function Board:printBoard()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[y] do
            local bombs = 'false';
            if self.tiles[y][x].uncovered then
                bombs = 'true'
            end
            print(y .. ' ' .. x .. ' '.. bombs)
        end
    end
end