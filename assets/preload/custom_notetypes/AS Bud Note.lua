function opponentNoteHit(id,data,type,sus)
    if type == 'AS Bud Note' then
        if gfSection == true then
            playAnim('dad',getProperty('singAnimations['..data..']'),true)
            setProperty('dad.holdTimer',0)
        else
            playAnim('gf',getProperty('singAnimations['..data..']'),true)
            setProperty('gf.holdTimer',0)
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'AS Bud Note' then
        if gfSection == true then
            playAnim('boyfriend',getProperty('singAnimations['..data..']'),true)
            setProperty('boyfriend.holdTimer',0)
        else
            playAnim('gf',getProperty('singAnimations['..data..']'),true)
            setProperty('gf.holdTimer',0)
        end
    end
end