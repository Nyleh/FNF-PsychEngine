function opponentNoteHit(id,data,type,sus)
    if type == 'GF Duet' then
        if gfSection ~= true then
            characterPlayAnim('gf',getProperty('singAnimations['..data..']'),true)
            setProperty('gf.holdTimer',0)
        else
            characterPlayAnim('dad',getProperty('singAnimations['..data..']'),true)
            setProperty('dad.holdTimer',0)
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'GF Duet' then
        if gfSection ~= true then
            characterPlayAnim('gf',getProperty('singAnimations['..data..']'),true)
            setProperty('gf.holdTimer',0)
        else
            characterPlayAnim('boyfriend',getProperty('singAnimations['..data..']'),true)
            setProperty('boyfriend.holdTimer',0)
        end
    end
end