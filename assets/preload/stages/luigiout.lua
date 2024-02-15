function onCreate()
    addLuaScript('extra_scripts/flipHealthBar')
    makeLuaSprite('bg','mario/cityout/skyL',-200,-1000)
    scaleObject('bg',0.8,0.8)
    addLuaSprite('bg',false)

    --makeLuaSprite('build','mario/cityout/road plus building',500,200)
    --addLuaSprite('build',false)

    makeLuaSprite('build','mario/cityout/backBG',600,-540)
    setScrollFactor('build',0.9,0.9)
    addLuaSprite('build',false)

    makeLuaSprite('wall','mario/cityout/buildingSide',-950,-450)
    addLuaSprite('wall',false)

    
    makeLuaSprite('overlay','mario/cityout/Overlay All',-800,-550)
    scaleObject('overlay',1.2,1.2)
    setScrollFactor('overlay',1.2,1.2)
    addLuaSprite('overlay',true)

    --setObjectOrder('boyfriendGroup',getObjectOrder('dadGroup'))
    makeAnimatedLuaSprite('gfOut','mario/cityout/GF_LDO',-400,300)
    addAnimationByPrefix('gfOut','dance','ldo gf dance0',24,false)
    addAnimationByPrefix('gfOut','annoying','ldo gf dance annoyed',24,false)
    addAnimationByPrefix('gfOut','why','ldo gf why',24,false)
    updateHitbox('gfOut')
    playAnim('gfOut','dance')
    addLuaSprite('gfOut')

    
end
function onBeatHit()
    if getProperty('gfOut.animation.curAnim.name') == 'dance' or getProperty('gfOut.animation.curAnim.finished') then
        if getProperty('gfOut.animation.curAnim.name') ~= 'dance' then
            playAnim('gfOut','dance',false)
        end
        if curBeat % 2 == 0 then
            playAnim('gfOut','dance',true)
            --setProperty('gfOut.animation.curAnim.curFrame',0)
        else
            setProperty('gfOut.animation.curAnim.curFrame',17)
        end
    end

end
function onEvent(name,v1,v2)
    if name == 'Triggers Universal' then
        if v1 == '3' then
            playAnim('gfOut','why',false)
        elseif v1 == '4' then
            playAnim('gfOut','idle')
        end
    end
end
function onCreatePost()
    callScript('extra_scripts/flipHealthBar','setFlip',{true})
    if not middlescroll then
        for strums = 0,3 do
            setPropertyFromGroup('opponentStrums',strums,'x',732 + (112*strums))
            setPropertyFromGroup('playerStrums',strums,'x',92 + (112*strums))
        end
    end
end