function onCreate()
    addLuaScript('extra_scripts/flipHealthBar')
    makeAnimatedLuaSprite('bg','mario/promo/promobg',0,20)
    addAnimationByPrefix('bg','static','bg normal',24,true)
    addLuaSprite('bg',false)

    makeAnimatedLuaSprite('table','mario/promo/promodesk',740,552)
    addAnimationByPrefix('table','static','Promario desk static',24,true)

    if songName == 'Promotion' then
        makeAnimatedLuaSprite('bgDepre','mario/promo/promobg',0,20)
        addAnimationByPrefix('bgDepre','depre','bg depression',24,true)
        setProperty('bgDepre.alpha',0.001)
        addLuaSprite('bgDepre',false)

        makeAnimatedLuaSprite('lg','mario/promo/promo_luigi',200,275)
        addAnimationByPrefix('lg','danceLeft','luigi idle left',24,false)
        addAnimationByPrefix('lg','danceRight','luigi idle right',24,false)
        setProperty('lg.alpha',0.001)
        addLuaSprite('lg',false)

        makeAnimatedLuaSprite('peach','mario/promo/promo_peach',1225,225)
        addAnimationByPrefix('peach','danceLeft','peach idle left',24,false)
        addAnimationByPrefix('peach','danceRight','peach idle right',24,false)
        setProperty('peach.alpha',0.001)
        addLuaSprite('peach',false)

        addAnimationByPrefix('table','flash','Promario desk flash',24,false)
        addAnimationByPrefix('table','lg','Promario desk luigi',24,true)

        makeLuaSprite('darkFloor','mario/promo/wood floor',600,800)
        setProperty('darkFloor.alpha',0.001)
        addLuaSprite('darkFloor',false)
        
    end
    addLuaSprite('table',false)
    playAnim('bg','static')
    playAnim('table','static')

    addLuaScript('extra_scripts/createShader')
    local function callShader(func,vars)
        callScript('extra_scripts/createShader',func,vars)
    end
    callShader('createShader',{'tvShader','TvEffect'})
    callShader('runShader',{'game','tvShader'})
    callShader('createShader',{'tvHudShader','TvEffect'})
    callShader('runShader',{'hud','tvHudShader'})

    setShaderFloat('tvShader','multiply',1.5)
    setShaderFloat('tvShader','contrast',-0.1)
    setShaderFloat('tvShader','vignetteIntensity',0)
    setShaderBool('tvShader','lineTv',true)

    setShaderFloat('tvHudShader','multiply',1.5)
    setShaderFloat('tvHudShader','tvDistorcion',0.0)
    setShaderFloat('tvHudShader','vignetteIntensity',0.05)
    setShaderBool('tvHudShader','vignetteFollowAlpha',false)
end
function onCreatePost()
    if not middlescroll then
        for strums = 0,3 do
            setPropertyFromGroup('playerStrums',strums,'x',92 + (112*strums))
            setPropertyFromGroup('opponentStrums',strums,'x',732 + (112*strums))
        end
    end
    callScript('extra_scripts/flipHealthBar','setFlip',{true})
end
function onCountdownTick()
    if not middlescroll then
        for strums = 0,3 do
            setPropertyFromGroup('playerStrums',strums,'x',92 + (112*strums))
            setPropertyFromGroup('opponentStrums',strums,'x',732 + (112*strums))
        end
    end
end
function onBeatHit()
    if curBeat % 2 == 0 then
        local dance = 'danceLeft'
        if curBeat % 4 == 0 then
            dance = 'danceRight'
        end
        if luaSpriteExists('lg') then
            playAnim('lg',dance)
        end
        if luaSpriteExists('peach') then
            playAnim('peach',dance)
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'tableLuigi' then
        playAnim('table','lg')
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Promotion' then
        if v1 == '1' then
            cancelTween('bgAlpha')
            cancelTween('bgDepreAlpha')
            cancelTimer('tableLuigi')
            setProperty('boyfriend.visible',false)
            setProperty('gf.visible',false)
            setProperty('dadGroup.x',700)
            setProperty('dadGroup.y',170)
            setProperty('darkFloor.alpha',1)
            removeLuaSprite('bg',true)
            removeLuaSprite('bgDepre',true)
            removeLuaSprite('table',true)
        elseif v1 == '2' then
            doTweenAlpha('lgAlpha','lg',1,0.4,'sineOut')
        elseif v1 == '3' then
            doTweenAlpha('peachAlpha','peach',1,0.4,'sineOut')
        elseif v1 == '5' then
            playAnim('table','flash')
            runTimer('tableLuigi',0.4)
            doTweenAlpha('bgAlpha','bg',0,3,'linear')
            doTweenAlpha('bgDepreAlpha','bgDepre',1,3,'linear')
            playAnim('dad','depression',true)
            setProperty('dad.specialAnim',true)
            setProperty('dad.idleSuffix','-alt')
        end
    end
end