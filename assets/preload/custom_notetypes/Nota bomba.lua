function onCreate()
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'Nota bomba' then
            setPropertyFromGroup('unspawnNotes',notes,'texture','bombMario_NOTE_assets')
            setPropertyFromGroup('unspawnNotes',notes,'ignoreNote',true)
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Nota bomba' then
        setHealth(getHealth()-1)
    end
end