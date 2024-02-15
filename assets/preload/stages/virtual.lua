function onCreate()
    makeLuaSprite('bg','mario/virtual/Wall Bg',-1170,-770)
    setScrollFactor('bg',0.4,0.4)
    addLuaSprite('bg',false)
    
    makeLuaSprite('backPipes','mario/virtual/Back Pipes',-1170,-770)
    setScrollFactor('backPipes',0.8,0.8)
    addLuaSprite('backPipes',false)

    makeLuaSprite('backPlatform','mario/virtual/Back Platform',-1170,-740)
    setScrollFactor('backPlatform',0.8,0.8)
    addLuaSprite('backPlatform',false)

    if not lowQuality then
        makeAnimatedLuaSprite('koopaLeft','mario/virtual/v_koopa_thorny',200,250)
        setScrollFactor('koopaLeft',0.8,0.8)
        scaleObject('koopaLeft',0.8,0.8)
        addAnimationByPrefix('koopaLeft','idle','Koopa Idle Glitch',24,false)
        addAnimationByPrefix('koopaLeft','exit','glitch in',24,false)
        playAnim('koopaLeft','idle')
        setProperty('koopaLeft.alpha',0.001)
        addLuaSprite('koopaLeft',false)

        makeAnimatedLuaSprite('koopaRight','mario/virtual/v_koopa_thorny',800,250)
        setScrollFactor('koopaRight',0.8,0.8)
        scaleObject('koopaRight',0.8,0.8)
        setProperty('koopaRight.flipX',true)
        addAnimationByPrefix('koopaRight','idle','Koopa Idle Glitch',24,false)
        addAnimationByPrefix('koopaRight','exit','glitch in',24,false)
        playAnim('koopaRight','idle')
        setProperty('koopaRight.alpha',0.001)
        addLuaSprite('koopaRight',false)
    end

    makeLuaSprite('frontPipes','mario/virtual/Front Pipes',-1170,-770)
    addLuaSprite('frontPipes',false)

    makeLuaSprite('platform','mario/virtual/Main Platform',-1170,-770)
    addLuaSprite('platform',false)


    if songName == 'Paranoia' then
        makeLuaSprite('lateBG','mario/virtual/toolateBG',0,0)
        setScrollFactor('lateBG',0,0)
        setProperty('lateBG.alpha',0.001)
        addLuaSprite('lateBG',false)

        makeLuaSprite('headBG','mario/virtual/headbg',-700,-400)
        setScrollFactor('headBG',0,0)
        scaleObject('headBG',1.4,1.4)
        setProperty('headBG.alpha',0.001)
        addLuaSprite('headBG',false)

        makeLuaSprite('gfPlatform','mario/virtual/Platform',-1170,-200)
        addLuaSprite('gfPlatform',false)
        setProperty('gfPlatform.alpha',0.001)
    end
    if version > '0.6.3' then
        setPropertyFromClass('states.PlayState','SONG.arrowSkin','noteSkins/Virtual_NOTE_assets')
        setPropertyFromClass('states.PlayState','SONG.splashSkin','noteSplashes/noteSplashes-Virtual')
    else
        setPropertyFromClass('PlayState','SONG.arrowSkin','noteSkins/Virtual_NOTE_assets')
        setPropertyFromClass('PlayState','SONG.splashSkin','noteSplashes/noteSplashes-Virtual')
    end
end
function onCreatePost()
    for strums = 0,7 do
        setPropertyFromGroup('strumLineNotes',strums,'scale.x',3.5)
        setPropertyFromGroup('strumLineNotes',strums,'scale.y',3.5)
        updateHitboxFromGroup('strumLineNotes',strums)
    end
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'texture') == '' or getPropertyFromGroup('unspawnNotes',notes,'noteTexture') == nil then
            setPropertyFromGroup('unspawnNotes',notes,'scale.x',3.5)
            if getPropertyFromGroup('unspawnNotes',notes,'isSustainNote') then
                setPropertyFromGroup('unspawnNotes',notes,'offsetX',0)
            else
                setPropertyFromGroup('unspawnNotes',notes,'scale.y',3.5)
            end
        end
        updateHitboxFromGroup('unspawnNotes',notes)
    end
end
function onDestroy()
    if version > '0.6.3' then
        setPropertyFromClass('states.PlayState','SONG.arrowSkin','')
        setPropertyFromClass('states.PlayState','SONG.splashSkin','')
        setPropertyFromClass('states.PlayState','SONG.disableNoteRGB',false)
    else
        setPropertyFromClass('PlayState','SONG.arrowSkin','')
        setPropertyFromClass('PlayState','SONG.splashSkin','')
    end
end
function onUpdatePost()
    if luaSpriteExists('lateBG') then
        local cal = getProperty('camGame.zoom')
        setProperty('lateBG.scale.x',0.6 + (1 - cal)*2)
        setProperty('lateBG.scale.y',0.6 + (1 - cal)*2)

        setProperty('lateBG.x',-250 + (-50 * (1 - cal)*3))
        setProperty('lateBG.y',-250 + (-50 * (1-cal)*3))
    end
    if luaSpriteExists('koopaLeft') then
        if getProperty('koopaLeft.animation.curAnim.finished') and getProperty('koopaLeft.animation.curAnim.name') == 'exit' then
            removeLuaSprite('koopaLeft',true)
            removeLuaSprite('koopaRight',true)
        end
    end
end
function onBeatHit()
    if luaSpriteExists('headBG') and getProperty('headBG.alpha') > 0.01 and curBeat % 4 == 0 then
        setProperty('headBG.y',-450)
        setProperty('headBG.alpha',0.8)
        doTweenY('headBGY','headBG',getProperty('headBG.y')+50,stepCrochet*0.004,'circOut')
        doTweenAlpha('headBGalpha','headBG',0.3,stepCrochet*0.004,'circOut')
    end
    if luaSpriteExists('koopaLeft') then
        if curBeat % 2 == 0 then
            if getProperty('koopaLeft.animation.curAnim.name') ~= 'exit' then
                playAnim('koopaLeft','idle',true)
            end
            if getProperty('koopaRight.animation.curAnim.name') ~= 'exit' then
                playAnim('koopaRight','idle',true)
            end
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Paranoia' then
        if v1 == '0.25' then
            if not lowQuality then
                playAnim('koopaLeft','idle',true)
                setProperty('koopaLeft.alpha',1)
                playAnim('koopaRight','idle',true)
                setProperty('koopaRight.alpha',1)
            end
        elseif v1 == '0.5' then
            doTweenAlpha('bgAlpha','bg',0,1,'sineOut')
            if not lowQuality then
                playAnim('koopaLeft','exit',true,true)
                playAnim('koopaRight','exit',true,true)
            end
        elseif v1 == '0.75' then
            cancelTween('bgAlpha')
            removeLuaSprite('bg',true)
            removeLuaSprite('backPipes',true)
            removeLuaSprite('backPlatform',true)
            removeLuaSprite('frontPipes',true)
            removeLuaSprite('platform',true)

    
            setProperty('lateBG.alpha',1)
            setProperty('gfPlatform.alpha',1)
            if luaSpriteExists('koopaLeft') then
                removeLuaSprite('koopaLeft',true)
                removeLuaSprite('koopaRight',true)
            end
            callOnHScript('optimizeStage',{'virtual',1})--Used on scripts/otimization.hx
        elseif v1 == '2' then
            setProperty('headBG.alpha',0.6)
            removeLuaSprite('lateBG',true)
            removeLuaSprite('gfPlatform',true)
            callOnHScript('optimizeStage',{'virtual',2})
        end
    end
end
function onMoveCamera(focus)
    if focus == 'boyfriend' and (songName == 'Paranoia' and (curStep < 960 or curStep > 1040) or songName ~= 'Paranoia') then
        setProperty('defaultCamZoom',0.7)
    elseif focus == 'dad' then
        setProperty('defaultCamZoom',0.5)
    end
end