local bullets = 3
function onCreate()
    precacheSound('pico_shoot')
    --makeLuaSprite('bulletAmmo','')
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'Bullet' then
            setPropertyFromGroup('unspawnNotes',notes,'texture','BulletMario_NOTE_assets')
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Bullet' then
        cameraShake('game',0.007,0.15)
        cameraShake('hud',0.007,0.15)
        playAnim('boyfriend','singUP-alt',true)
        setProperty('boyfriend.holdTimer',0)
        playSound('pico_shoot')

    end
end
function noteMiss(id,data,type,sus)
    if type == 'Bullet' then
        playSound('FAILGUN')
    end
end