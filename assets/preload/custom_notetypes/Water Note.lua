function onCreate()
    precacheSound('waterswitch')
    for notes = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'Water Note' then
            setPropertyFromGroup('unspawnNotes',notes,'texture','waterMario_NOTE_assets')
            setPropertyFromGroup('unspawnNotes',notes,'noAnimation',true)
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Water Note' then
        playSound('waterswitch')
    end
end