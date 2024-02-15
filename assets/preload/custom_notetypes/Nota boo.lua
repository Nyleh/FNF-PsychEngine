function onCreate()
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'Nota boo' then
            setPropertyFromGroup('unspawnNotes',notes,'multAlpha',0.6)
        end
    end
end