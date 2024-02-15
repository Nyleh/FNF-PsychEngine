function onCreate()
    makeLuaSprite('bg','mario/EXE1/Castillo fondo de hasta atras',-1000,-850)
    addLuaSprite('bg')
    makeLuaSprite('ground','mario/EXE1/Suelo y brillo atmosferico',-1000,-850)
    addLuaSprite('ground')


    makeLuaSprite('trees','mario/EXE1/Arboles y sombra',-1000,-850)
    addLuaSprite('trees')

    makeLuaSprite('vignette','mario/EXE1/dark',0,0)
    setObjectCamera('vignette','other')
    addLuaSprite('vignette')


    addLuaScript('extra_scripts/extraCam')
    if songName == 'Its a me' then


        makeAnimatedLuaSprite('fireLeft','mario/EXE1/starman/Starman_BG_Fire_Assets',-1200,550)
        addAnimationByPrefix('fireLeft','anim','fire anim effects',24,true)
        setObjectOrder('fireLeft',getObjectOrder('ground'))
        scaleObject('fireLeft',0.7,0.7)
        setScrollFactor('fireLeft',0.6,0.6)
        addLuaSprite('fireLeft',true)
        setProperty('fireLeft.alpha',0.001)

        makeAnimatedLuaSprite('fireRight','mario/EXE1/starman/Starman_BG_Fire_Assets',1000,550)
        addAnimationByPrefix('fireRight','anim','fire anim effects',24,true)
        setProperty('fireRight.flipX',true)
        setObjectOrder('fireRight',getObjectOrder('ground'))
        scaleObject('fireRight',0.7,0.7)
        setScrollFactor('fireRight',0.6,0.6)
        setProperty('fireRight.alpha',0.001)
        addLuaSprite('fireRight',true)

        makeLuaSprite('smokeFire','mario/EXE1/smoke',0,0)
        setObjectCamera('smokeFire','hud')
        setProperty('smokeFire.alpha',0.001)
        addLuaSprite('smokeFire',false)
        callScript('extra_scripts/extraCam','insertObjectOnCam',{'smokeFire'})
    end


    callScript('extra_scripts/extraCam','insertObjectOnCam',{'vignette'})
    removeLuaScript('extra_scripts/extraCam')
end
function onEvent(name,v1,v2)
    if name == 'Triggers Its a me' then
        if v1 == '0' then
            cameraShake('game',0.005,getProperty('songLength'))
            cameraShake('hud',0.005,getProperty('songLength'))
            doTweenY('fireLeftY','fireLeft',-350,15,'linear')
            doTweenY('fireRightY','fireRight',-350,15,'linear')
            setProperty('fireLeft.alpha',1)
            setProperty('fireRight.alpha',1)
            doTweenAlpha('fireSmoke','smokeFire',0.7,15,'linear')
        elseif v1 == '1' then
            doTweenZoom('gameZoom','camGame',getProperty('camGame.zoom')+0.3,5,'cubeIn')
            cameraFade('game','000000',stepCrochet*0.044,false)
            cameraFade('hud','000000',stepCrochet*0.044,false)
        end
    end
end