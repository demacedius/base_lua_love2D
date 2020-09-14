io.stdout:setvbuf('no')

love.graphics.setDefaultFilter("nearest")

if arg [#arg] == "-debug" then require("mobdebug").start() end


function love.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()
end

function love.update(dt)

end

function love.mousepressed(x,y,n)

end

function love.draw()

end


function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end
