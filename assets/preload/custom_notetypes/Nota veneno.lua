local healthDrain = 0
function onCreate()
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'Nota veneno' then
            setPropertyFromGroup('unspawnNotes',i,'texture','poisonMario_NOTE_assets')
            setPropertyFromGroup('unspawnNotes',i,'ignoreNote',true)
        end
    end
end
function onUpdate(delta)
    if healthDrain > 0 then
        healthDrain = healthDrain - delta
        setHealth(getHealth() - (delta*math.floor(healthDrain+1))/3)
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Nota veneno' then
        if healthDrain < 0 then
            healthDrain = 0
        end
        healthDrain = healthDrain + 1
    end
end