function onCreate()
    makeLuaSprite('sky','mario/EXE1/starman/SS_sky',-1100,-600)
    setScrollFactor('sky',0.1,0.1)
    addLuaSprite('sky',false)
    makeLuaSprite('castle','mario/EXE1/starman/SS_Castle',-1350,-500)
    scaleObject('castle',1.1,1.1)
    setScrollFactor('castle',0.2,0.2)
    addLuaSprite('castle',false)

    makeAnimatedLuaSprite('fireLeft','mario/EXE1/starman/Starman_BG_Fire_Assets',-1500,-1000)
    addAnimationByPrefix('fireLeft','anim','fire anim effects',24,true)
    --scaleObject('fireLeft',0.7,0.7)
    setScrollFactor('fireLeft',0.6,0.6)
    --setProperty('fireLeft.alpha',0.001)
    addLuaSprite('fireLeft',false)

    makeAnimatedLuaSprite('fireRight','mario/EXE1/starman/Starman_BG_Fire_Assets',1100,-1000)
    addAnimationByPrefix('fireRight','anim','fire anim effects',24,true)
    setProperty('fireRight.flipX',true)
    --scaleObject('fireRight',0.7,0.7)
    setScrollFactor('fireRight',0.6,0.6)
    addLuaSprite('fireRight',false)

    makeLuaSprite('farPlatform','mario/EXE1/starman/SS_farplatforms',-900,-600)
    setScrollFactor('farPlatform',0.6,0.6)
    --scaleObject('farPlatform',1.2,1.2)
    addLuaSprite('farPlatform',false)

    makeLuaSprite('pow','mario/EXE1/starman/SS_POWblock',870,600)
    scaleObject('pow',1.1,1.1)
    setScrollFactor('pow',0.6,0.6)
    addLuaSprite('pow',false)
    
    makeLuaSprite('midPlatform','mario/EXE1/starman/SS_midplatforms',-1000,-800)
    setScrollFactor('midPlatform',0.7,0.7)
    --scaleObject('farPlatform',1.2,1.2)
    addLuaSprite('midPlatform',false)

    makeLuaSprite('floor','mario/EXE1/starman/SS_floor',-820,-700)
    addLuaSprite('floor',false)
    scaleObject('floor',1.05,1.05)
    setObjectOrder('gfGroup',getObjectOrder('boyfriendGroup')-1)

    makeLuaSprite('foreground','mario/EXE1/starman/SS_foreground',-1300,-800)
    scaleObject('foreground',1.2,1.2)
    setScrollFactor('foreground',1.3,1.3)
    addLuaSprite('foreground',true)

    makeAnimatedLuaSprite('gfSS','characters/SS_GF_scared_Assets',1900,425)
    addAnimationByIndices('gfSS','danceLeft','GF Dancing Beat','0,1,2,3,4,5,6,7,8,9,10,11,12,13,14',24)
    addAnimationByIndices('gfSS','danceRight','GF Dancing Beat','15,16,17,18,19,20,21,22,23,24,25,26,27,28,29',24)
    addLuaSprite('gfSS',false)

    setObjectOrder('gfGroup',getObjectOrder('dadGroup')-2)
end
function onCreatePost()
    setObjectOrder('gfSS',getObjectOrder('boyfriendGroup')-1)
end
function onBeatHit()
    if curBeat % 2 == 0 then
        playAnim('gfSS','danceRight')
    else
        playAnim('gfSS','danceLeft')
    end
end
local curFocus = ''
function onMoveCamera(focus)
    if focus ~= curFocus then
        if focus == 'gf' then
            setProperty('defaultCamZoom',0.7)
        else
            if curFocus == 'gf' then
                setProperty('defaultCamZoom',0.5)
            end
        end
        curFocus = focus
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Starman Slaughter'  then
        if v1 == '5' then
            removeLuaSprite('pow',true)
        elseif v1 == '17' then
            removeLuaSprite('sky',true)
            removeLuaSprite('castle',true)
            removeLuaSprite('fireLeft',true)
            removeLuaSprite('fireRight',true)
            removeLuaSprite('midPlatform',true)
            removeLuaSprite('farPlatform',true)
            removeLuaSprite('floor',true)
            removeLuaSprite('foreground',true)
        end
    end
end