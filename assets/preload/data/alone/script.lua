function onCreate()
    setProperty('skipArrowStartTween',true)
    addLuaScript('extra_scripts/extraCharacter')
    callScript('extra_scripts/extraCharacter','createCharacter',{'mario','mario-alone',500,-500,false})
    scaleObject('mario',0.001,0.001)
    setProperty('mario.alpha',0.001)

    addLuaScript('custom_events/Set Cur Target')

    setCamPos(720,-100,'mario')
end
function onCreatePost()
    makeLuaSprite('black',nil)
    makeGraphic('black',screenWidth,screenHeight,'000000')
    setObjectCamera('black','other')
    addLuaSprite('black',true)

    setProperty('boyfriend.alpha',0.001)
    setProperty('gf.alpha',0.001)

    makeLuaSprite('whiteBG',nil,-200,-100)
    makeGraphic('whiteBG',screenWidth + 500,screenHeight + 400,'FFFFFF')
    setScrollFactor('whiteBG',0,0)
    addLuaSprite('whiteBG',true)
    setProperty('whiteBG.alpha',0.001)

    makeAnimatedLuaSprite('bfHang','modstuff/Beta_BF_Hang',650,-160)
    addAnimationByPrefix('bfHang','anim','BFHang',24,true)
    setScrollFactor('bfHang',0,0)
    setProperty('bfHang.alpha',0.001)
    addLuaSprite('bfHang',true)

    setCamPos(350,500,'dad')

    setObjectOrder('mario',getObjectOrder('bgFront'))
end
function onSongStart()
    setProperty('camGame.zoom',getProperty('defaultCamZoom')+0.2)
    doTweenZoom('gameZoom','camGame',getProperty('defaultCamZoom'),3,'quartOut')
    doTweenAlpha('blackAlpha','black',0,3,'cubeOut')
    callScript('scripts/global_functions','hudAlpha',{0,0.5,'linear'})
    for strum = 0,4 do
        setPropertyFromGroup('opponentStrums',strum,'alpha',0.001)
        setPropertyFromGroup('playerStrums',strum,'alpha',0.001)
    end
end

local songPos = 0
function onUpdate()
    local velocity = 15
    songPos = getSongPosition()

    local songCal = songPos/bpm
    local cos = math.cos(songCal/velocity)
    local sin = math.cos(songCal/(velocity/2))

    if luaSpriteExists('mario') then
        local marioCal = (songPos - 300000)/bpm
        setProperty('mario.x',470 + (250 * math.cos(marioCal/15)))
        if songPos < 216800 then
            setProperty('mario.y',-350 + (100 * math.sin(marioCal/10)))
        end
    end

    if songPos < 3000 then
        callScript('scripts/global_functions','hudAlpha',{0,0,'linear'})
    end

    if getProperty('gf.curCharacter') == 'gfbetanew' then
        setProperty('gf.x',getProperty('gfGroup.x') + 50 + (100 * cos))
        setProperty('gf.y',getProperty('gfGroup.y') + 50 - (30 * sin))
    end

    if getProperty('boyfriend.curCharacter') == 'bfbetanew' then
        setProperty('boyfriend.x',getProperty('boyfriendGroup.x') + 50 + (40 * cos))
        setProperty('boyfriend.y',getProperty('boyfriendGroup.y') + 150 + (30 * sin))
    end

    for strum = 0,3 do
        if not middlescroll then
            setPropertyFromGroup('playerStrums',strum,'x',732 + (112 * (strum)) + (30 * math.sin(songCal/8 - (50 * strum))))
        end
    end
end
function onUpdatePost()
    local noteAngle = 20
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'isSustainNote')and getPropertyFromGroup('notes',notes,'mustPress') then
            local cal = (getPropertyFromGroup('notes',notes,'strumTime') - songPos)/80
            if not downscroll then
                setPropertyFromGroup('notes',notes,'angle',-noteAngle * math.sin(cal))
            else
                setPropertyFromGroup('notes',notes,'angle',noteAngle * math.sin(cal))
            end
            setPropertyFromGroup('notes',notes,'offset.x',-20 + (noteAngle * 2.1 * math.cos(cal)))
        end
    end
end
function opponentNoteHit(id,data,type,sus)
    if type == 'Yoshi Note' or type == 'GF Duet' then
        playAnim('mario',getProperty('singAnimations['..data..']'),true)
        setProperty('mario.holdTimer',0)
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Universal' then
        if v1 == '6' then
            doTweenAlpha('bfAlpha','boyfriend',0.8,7,'cubeOut')
            doTweenAlpha('gfAlpha','gf',0.8,7,'cubeOut')

        end
    elseif name == 'Triggers Alone' then
        if v1 == '0' then
            setProperty('whiteBG.alpha',1)
            setProperty('bfHang.alpha',1)
            doTweenAlpha('whiteAlpha','whiteBG',0,1.2,'linear')
            doTweenAlpha('bfHangAlpha','bfHang',0,1.2,'linear')
            doTweenAlpha('blackThing','blackBarThingie',0,3,'quadIn')
        --elseif v1 == '1' then
            --setCamPos(230,500,'dad')
            
        elseif v1 == '1.25' then
            setCamPos('middlebfdadX','middlebfdadY-200')

        elseif v1 == '1.5' then
            setCamPos(nil,nil)
            callScript('scripts/global_functions','hudAlpha',{1,3,'linear'})
            for strum = 0,3 do
                if not middlescroll then
                    noteTweenAlpha('noteAlpha'..strum,strum,1,3,'linear')
                else
                    noteTweenAlpha('noteAlpha'..strum,strum,0.3,3,'linear')
                end
                noteTweenAlpha('noteAlpha'..(strum+4),strum+4,0.7,3,'linear')
            end

        elseif v1 == '2' then
            cameraFlash('game','FFFFFF',1)
            cancelTween('blackThing')
            setProperty('blackBarThingie.alpha',0.5)

        elseif v1 == '3' then
            setCamPos(720,-100)
            callScript('custom_events/Set Cur Target','setTarget',{'mario','all'})
            setProperty('defaultCamZoom',0.6)
            doTweenX('marioScaleX','mario.scale',1,3,'quadInOut')
            doTweenY('marioScaleY','mario.scale',1,3,'quadInOut')
            doTweenAlpha('marioAlpha','mario',0.9,3,'quadInOut')
        elseif v1 == '3.5' then
            callScript('custom_events/Set Cur Target','setTarget',{nil,'all'})
            doTweenY('marioY','mario',-700,2,'quadIn')
            doTweenAlpha('marioAlpha','mario',0,2,'quadIn')
        elseif v1 == '4' then
            setProperty('defaultCamZoom',0.8)
            setCamPos(300,400,'dad')
            setCamPos(720,400,'bf')
        elseif v1 == '5' then
            callScript('scripts/global_functions','hudAlpha',{0,3,'sineInOut'})
            for strums = 4,7 do
                noteTweenAlpha('noteUniAlpha'..strums,strums,0,3,'sineIn')
            end
            doTweenAlpha('bfAlpha','boyfriend',0,3,'sineIn')
            doTweenAlpha('gfAlpha','gf',0,3,'sineIn')


        end
    elseif name == 'Ocultar HUD' then
        cancelTween('blackAlpha')
        removeLuaSprite('black',true)
        if middlescroll then
            for strum = 0,3 do
                noteTweenAlpha('noteAlpha'..strum,strum,0.3,stepCrochet*0.002,'cubeOut')
            end
        else
            for strum = 0,3 do
                noteTweenAlpha('noteAlpha'..strum,strum,0.7,stepCrochet*0.002,'cubeOut')
            end
        end

    end
end

function setCamPos(x,y,target)
    callScript('scripts/cameraMoviment','setCamPos',{x,y,target})
end
function setOffs(ofs,target)
    callScript('scripts/cameraMoviment','setOffs',{ofs,target})
end
function onTweenCompleted(tag)
    if tag == 'marioY' then
        cancelTween('marioScaleX')
        cancelTween('marioScaleY')
        cancelTween('marioScaleAlpha')
        callScript('extra_scripts/extraCharacter','removeCharacter',{'mario'})
        callOnHScript('removeFromMemory',{'characters/Alone_Mario_Assets'})
    elseif tag == 'bfHangAlpha' then
        removeLuaSprite('bfHang',true)
        callOnHScript('removeFromMemory',{'modstuff/Beta_BF_Hang'})
    end
end