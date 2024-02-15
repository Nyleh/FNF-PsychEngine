function onCreate()
    precacheImage('coinMario_NOTE_assets')
    precacheSound('refill')
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'Coin Note' then
            setPropertyFromGroup('unspawnNotes',notes,'texture','coinMario_NOTE_assets')
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Coin Note' then
        playSound('refill')
    end
end