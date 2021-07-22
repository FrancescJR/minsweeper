
Selection = Class{}

function Selection:init(items, x, y, height, width)
    self.items = items
    self.x = x
    self.y = y

    self.height = height
    self.width = width
    self.font = gFonts['small']

    self.gapHeight = self.height / #self.items

    self.currentSelection = 1
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') then
        if self.currentSelection == 1 then
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
        end
        
--        gSounds['blip']:stop()
--        gSounds['blip']:play()
    elseif love.keyboard.wasPressed('down') then
        if self.currentSelection == #self.items then
            self.currentSelection = 1
        else
            self.currentSelection = self.currentSelection + 1
        end
        
--        gSounds['blip']:stop()
--        gSounds['blip']:play()
    elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        self.items[self.currentSelection].onSelect()

--        gSounds['blip']:stop()
--        gSounds['blip']:play()
    end
end

function Selection:render()
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw selection marker if we're at the right index
        if i == self.currentSelection then
            local image = love.graphics.newImage('assets/graphics/cursor.png')
            love.graphics.draw(image, self.x - 8, paddedY)
        end
        love.graphics.setFont(self.font)
        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        currentY = currentY + self.gapHeight
    end
end