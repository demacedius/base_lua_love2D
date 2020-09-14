io.stdout:setvbuf('no')

love.graphics.setDefaultFilter("nearest")

if arg [#arg] == "-debug" then require("mobdebug").start() end

local hauteur
local largeur

local raquette = {}
raquette.x = 0
raquette.y = 0
raquette.width = 80
raquette.height = 20

local balle = {}
balle.x = 0
balle.y = 0
balle.rayon = 10
balle.colle = false
balle.vx = 0
balle.vy = 0

local brique = {}
local niveau = {}

function demarre()
    raquette.y = hauteur - (raquette.height / 2)

    brique.height = 25
    brique.width = largeur / 15

    balle.colle = true

    niveau = {}
    local l, c
    for l=1, 6 do
        niveau[l] = {}
        for c = 1,15 do
            niveau[l][c] = 1
        end
    end
end

function love.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()
    demarre()
end

function love.update(dt)
    raquette.x = love.mouse.getX()

    if balle.colle == true then
        balle.x = raquette.x
        balle.y = raquette.y - balle.rayon - raquette.height /2
    else
        balle.x = balle.x + balle.vx * dt
        balle.y = balle.y + balle.vy * dt
    end

    local c = math.floor(balle.x / brique.width) + 1
    local l = math.floor(balle.y / brique.height) + 1

    if l >= 1 and l <= #niveau and c >= 1 and c <= 15 then
        if niveau [l][c] == 1 then
            balle.vy = 0 - balle.vy
            niveau[l][c] = 0
        end
    end


    if raquette.x > largeur - raquette.width/2 then
        raquette.x = largeur - raquette.width/2
    end

    if balle.x > largeur then
        balle.vx = 0 - balle.vx
        balle.x = largeur
    end

    if balle.x < 0 then
        balle.vx = 0 - balle.vx
        balle.x = 0
    end

    if balle.y < 0 then
        balle.vy = 0 - balle.vy
        balle.y = 0
    end

    if balle.y > hauteur then
        balle.colle = true
    end

    -- collision raquette--

    local posCollisionPad = raquette.y - (raquette.height/2) - balle.rayon

    if balle.y > posCollisionPad then
        local distance = math.abs(raquette.x - balle.x)
        if distance < raquette.height/2 then
            balle.vy = 0 - balle.vy
            balle.y = posCollisionPad
        end
    end
end

function love.mousepressed(x,y,n)
    if balle.colle == true then
        balle.colle = false
        balle.vy = -200
        balle.vx = 200
    end
end

function love.draw()
    local l,c
    local bx, by = 0, 0
    for l = 1,6 do
        bx = 0
        for c = 1, 15 do
            if niveau[l][c] == 1 then
                love.graphics.rectangle("fill",bx + 1, by + 1, brique.width - 2 , brique.height - 2)
            end
            bx = bx + brique.width
        end
        by = by + brique.height
    end

    love.graphics.rectangle("fill",raquette.x - (raquette.width / 2), raquette.y - (raquette.height / 2),raquette.width,raquette.height)
    love.graphics.circle("fill", balle.x, balle.y, balle.rayon)


end


function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end
