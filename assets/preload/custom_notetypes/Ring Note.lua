function onCreate()
    precacheSound('ringhit')
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'Ring Note' then
            setPropertyFromGroup('unspawnNotes',i,'texture','ringNES_NOTE_assets')
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Ring Note' then
        playSound('ringhit')
    end
end