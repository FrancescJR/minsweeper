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
    self:updateBombsIndicator();

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
end

function Board:updateBombsIndicator()
    for tileY = 1, self.rowsNumber do
        for tileX = 1, self.columnsNumber do
            local bombs = 0;
            local tile = self.tiles[tileY][tileX];
            local adjacentTiles = self:GetAdjacentTiles(tile)
            for k, adjacenTile in pairs(adjacentTiles) do
                local addBomb = adjacenTile.hasBomb == true and 1 or 0
                bombs = bombs + addBomb
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
