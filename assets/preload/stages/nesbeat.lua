local curFocus = ''
local curNesStage = 0
local birdCount = 0
local fireBallCount = 0
local bulletCount = 0
--local birdRemoved = 0
function onCreate()
    makeAnimatedLuaSprite('nesStatic','modstuff/estatica_uwu',0,0)
    addAnimationByPrefix('nesStatic','anim','Estatica papu',24,true)
    setObjectCamera('nesStatic','hud')
    setProperty('nesStatic.alpha',0.001)
    addLuaSprite('nesStatic',true)

    makeLuaSprite('bgBlack',nil,-200,-200)
    makeGraphic('bgBlack',screenWidth+400,screenHeight+400,'000000')
    setScrollFactor('bgBlack',0,0)
    
    if songName == 'Unbeatable' then
        setProperty('bgBlack.alpha',1)

        addNesStage('duck',false)
        addNesStage('koopa',false)
        addNesStage('duckGlitch',false)
        if not lowQuality then
            addBird(0,false)
            addBird(1,false)
            addBird(2,false)
            setProperty('Bird0.alpha',0.001)
            setProperty('Bird1.alpha',0.001)
            setProperty('Bird2.alpha',0.001)

            precacheImage('mario/beatus/fire')
            precacheImage('mario/beatus/bullet')
        end

        

    end
    addNesStage('nes',false)
    addLuaSprite('bgBlack',false)

    setObjectOrder('gfGroup',getObjectOrder('boyfriendGroup')-1)
    --setProperty('bgBlack.alpha',0.001)
    
    --[[makeLuaSprite('tvScreen','modstuff/tvscreen',0,0)
    setObjectCamera('tvScreen','hud')
    addLuaSprite('tvScreen',true)
    scaleObject('tvScreen',10,10)]]--
end
function callShader(func,vars)
    callScript('extra_scripts/createShader',func,vars)
end
function setupShaders()
    addLuaScript('extra_scripts/createShader')
    callShader('createShader',{'tvShader','TvEffect'})
    callShader('createShader',{'glitchShader','GlitchEffect'})
    callShader('runShader',{'game',{'tvShader','glitchShader'}})
    callShader('runShader',{'hud','tvShader'})
    

    setShaderFloat('tvShader','frequency',0.1)
    setShaderFloat('tvShader','vignetteIntensity',0.05)
    setShaderFloat('tvShader','tvIntensity',0.001)
    setShaderFloat('tvShader','chromIntensity',0.003)

    setShaderFloat('glitchShader','intensity',0)
end
function onCreatePost()
    setupShaders()
    setScrollFactor('gfGroup',0.9,.9)
    if songName == 'Unbeatable' then
        removeNesStage('duck',false)
        removeNesStage('koopa',false)
        removeNesStage('duckGlitch',false)
        removeNesStage('koopaGlitch',false)
        removeLuaSprite('nesGlitchStatic',false)
    end
end

function doGlitch(intensity,duration,stay)
    if intensity ~= nil then
        setShaderFloat('glitchShader','intensity',intensity)
    end
    if not stay and duration ~= nil then
        callShader('doShaderTween',{'glitchShader','intensity',0,duration,'linear'})
    end
end

function doScreenGlitch()
    setProperty('nesStatic.alpha',0.7)
    doTweenAlpha('staticAlpha','nesStatic',0,0.5,'linear')
end

function onEvent(name,v1,v2)
    if name == 'Triggers Unbeatable' then
        if v1 == '2' then
            addNesStage('duck',true)
            removeNesStage('nes',true)
            setNesStageFront('nes')
            curNesStage = 1
        elseif v1 == '11' then
            if v2 == '' then
                removeNesStage('duck',true)
                curNesStage = 2
            elseif v2 == '1' then
                addNesStage('koopa',true)
            elseif v2 == '4' then
                doTweenY('lavaYGo','koopaLava',690,1.2,'quadInOut')
            end

        elseif v1 == '33' and v2 == '1' or v1 == '6' and v2 == '1' then
            addNesStage('duckGlitch',false)
            doGlitch(0.035,0.5)

        elseif v1 == '33' and v2 == '2' or v1 == '7' and v2 == '1' then
            addNesStage('koopaGlitch')
            removeNesStage('nes',false)
            doGlitch(0.035,0.5)

        elseif v1 == '24' then
            addNesStage('nes',false)
            setNesStageFront('koopa')
            removeNesStage('koopa',true)

        elseif v1 == '3' then
            if curNesStage == 1 then
                nesStageBump()
            end
        elseif v1 == '4' then
            if not lowQuality then
                addBird(getRandomInt(0,2),getRandomInt(0,4))
            end
        elseif v1 == '14' then
            doTweenAlpha('bgBlack','bgBlack',0.7,5,'linear')

        elseif v1 == '19' then
            addNesStage('nes',false)
            setProperty('bgBlack.alpha',0.8)
            removeLuaSprite('nesGlitchStatic',true)
            removeNesStage('duckGlitch',false)
            removeNesStage('koopaGlitch',false)


        elseif v1 == '20' then
            doScreenGlitch()
            if curNesStage ~= 0 then
                addNesStage('nes')
                removeLuaSprite('nesGlitchStatic',true)
                removeNesStage('duckGlitch',false)
                removeNesStage('koopaGlitch',false)
            end
            if v2 == '1' then
                removeNesStage('nes')
            end
        elseif v1 == '12' then
            doScreenGlitch()

        elseif v1 == '13' then
            removeNesStage('nes')
            doScreenGlitch()
        
        elseif v1 == '16' then
            setProperty('nesStatic.visible',false)
        elseif v1 == '17' and v2 == '2'  then
            setProperty('nesStatic.visible',true)
            doGlitch(0.035,0.3)

        elseif v1 == '28' then
            if v2 == '0' or v2 == '1' or v2 == '' then
                doGlitch(0.035,0.6)
            elseif v2 == '3' then
                doGlitch(0.035,0.3)
            end
        
        elseif v1 == '31' then
            if not lowQuality then
                if v2 == '' then
                    addBulletKoopa(false)
                else
                    addBulletKoopa(true)
                end
            end
        elseif v1 == '32' then
            if v2 == '' then
                nesStageBump()
                if not lowQuality then
                    addFireBall(1)
                end
            end
        
        end
    end
end

function addBird(type,direction)
    local x = -100
    local y = 100
    local tweenX = 0
    local tweenY = 0
    local tweenTime = 3
    local flip = false

    if direction == 0 then
        x = 1500
        y = -200
        tweenX = -400
        tweenY = 300
        flip = true
    elseif direction == 1 then
        x = 0
        y = 800
        tweenX = 600
        tweenY = -500
        tweenTime = 3.5
    elseif direction == 2 then
        x = -800
        y = 0
        tweenX = 1600
        tweenY = 300
    elseif direction == 3 then
        x = 1500
        y = 200
        flip = true
        tweenX = 200
        tweenY = -300
    elseif direction == 4 then
        x = -800
        y = 200
        tweenX = 1600
        tweenY = -500
    else
        return
    end
    local name = 'Bird'..birdCount
    makeAnimatedLuaSprite(name,'mario/beatus/duck'..type,x,y)
    scaleObject(name,6.5,6.5)
    setProperty(name..'.antialiasing',false)
    if direction == 1 or direction == 4 then
        addAnimationByPrefix(name,'anim','duck up',12,true)
    else
        addAnimationByPrefix(name,'anim','duck fly',12,true)
    end

    setProperty(name..'.flipX',flip)
    setScrollFactor(name,0.9,0.9)
    addLuaSprite(name,false)
    if curNesStage == 1 then
        setObjectOrder(name,getObjectOrder('duckGrass'))
    end
    doTweenX('BirdFlyX'..birdCount,name,tweenX,tweenTime,'linear')
    doTweenY('BirdFlyY'..birdCount,name,tweenY,tweenTime,'linear')
    birdCount = birdCount + 1
end

function addBulletKoopa(flipX)
    bulletCount = bulletCount + 1
    local name = 'BulletKoopa'..bulletCount
    local x = -100
    if flipX then
        x = screenWidth + 100
    end
    makeLuaSprite(name,'mario/beatus/bullet',x,getRandomInt(0,650))
    scaleObject(name,6,6)
    setProperty(name..'.antialiasing',false)
    setProperty(name..'.flipX',not flipX)
    if flipX then
        doTweenX(name..'X',name,-100,2.5,'linear')
    else
        doTweenX(name..'X',name,screenWidth + 100,2.5,'linear')
    end
    setObjectCamera(name,'other')
    addLuaSprite(name,false)
end

function addFireBall(whoMuchBalls)
    local x = getRandomInt(100,600)
    for balls = 0,whoMuchBalls do
        local name = 'FireBall'..fireBallCount
        makeLuaSprite(name,'mario/beatus/fire',0 + x + (700*balls),720)
        setProperty(name..'.antialiasing',false)
        addLuaSprite(name,false)
        scaleObject(name,6,6)
        if luaSpriteExists('koopaLava') then
            setObjectOrder(name,getObjectOrder('koopaLava')-1)
        end
        doTweenY(name..'YGo',name,getProperty(name..'.y') - 300,stepCrochet*0.003,'quadOut')
        fireBallCount = (fireBallCount + 1)%10
    end
end

function onSongStart()
    if songName == 'Unbeatable' then
        doTweenAlpha('bgBlack','bgBlack',0,10,'expoIn')
    end
end

function addNesStage(stage,tween)
    if stage == 'nes' then
        cancelNesTweens('nes')
        curNesStage = 0
        makeLuaSprite('bgNes','bars',-1700,-1500)
        scaleObject('bgNes',3.2,6)
        setProperty('bgNes.antialiasing',false)
        addLuaSprite('bgNes',false)
        
        doTweenAngle('stageBG1','bgNes',-35,4,'linear')
        
    elseif stage == 'duck' then
        curNesStage = 1
        makeLuaSprite('duckBG',nil,-200,-200)
        makeGraphic('duckBG',screenWidth+300,screenHeight+300,'5595DA')
        setScrollFactor('duckBG',0,0)
        addLuaSprite('duckBG',false)

        
        makeLuaSprite('duckTree','mario/beatus/tree',0,-100)
        setProperty('duckTree.antialiasing',false)
        scaleObject('duckTree',7,7)
        setScrollFactor('duckTree',0.8,0.8)
        addLuaSprite('duckTree',false)

        makeLuaSprite('duckArbust','mario/beatus/arbust',900,410)
        setProperty('duckArbust.antialiasing',false)
        setScrollFactor('duckArbust',0.8,0.8)
        scaleObject('duckArbust',7,7)
        addLuaSprite('duckArbust',false)

        makeLuaSprite('duckGrass','mario/beatus/grass',-100,600)
        setProperty('duckGrass.antialiasing',false)
        scaleObject('duckGrass',7,7)
        addLuaSprite('duckGrass',false)

        if tween then
            setProperty('duckTree.x',getProperty('duckTree.x')-600)
            doTweenX('duckTreeX','duckTree',getProperty('duckTree.x')+600,3,'quintInOut')

            setProperty('duckArbust.x',getProperty('duckArbust.x')+600)
            doTweenX('duckArbustX','duckArbust',getProperty('duckArbust.x')-600,3,'quintInOut')
        end
    elseif stage == 'koopa' then
        curNesStage = 2
        makeLuaSprite('koopaBG',nil,-200,-200)
        makeGraphic('koopaBG',screenWidth+300,screenHeight+300,'FF0000')
        setProperty('koopaBG.color',0)
        setScrollFactor('koopaBG',0,0)
        addLuaSprite('koopaBG',false)

        makeLuaSprite('koopaGround','mario/beatus/castle',-600,-150)
        setProperty('koopaGround.antialiasing',false)
        scaleObject('koopaGround',5,5)
        addLuaSprite('koopaGround',false)

        makeLuaSprite('koopaTop','mario/beatus/castle2',-600,-150)
        setProperty('koopaTop.antialiasing',false)
        scaleObject('koopaTop',5,5)
        addLuaSprite('koopaTop',false)

        makeAnimatedLuaSprite('koopaLava','mario/beatus/neslava',-600,750)
        addAnimationByPrefix('koopaLava','anim','lava hot ow ow its too hot aaa',12,true)
        setProperty('koopaLava.antialiasing',false)
        scaleObject('koopaLava',5,5)
        addLuaSprite('koopaLava',false)

        makeAnimatedLuaSprite('koopaClownCar','mario/beatus/Clown_Car',-100,0)
        addAnimationByPrefix('koopaClownCar','anim','clown car anim',12,true)
        setProperty('koopaClownCar.antialiasing',false)
        scaleObject('koopaClownCar',45,45)
        setScrollFactor('koopaClownCar',0,0)
        setProperty('koopaClownCar.alpha',0.001)
        addLuaSprite('koopaClownCar',false)
        if tween then
            setProperty('koopaTop.y',getProperty('koopaTop.y') - 700)
            setProperty('koopaGround.y',getProperty('koopaGround.y') + 3000)
            setProperty('koopaBG.alpha',0.001)
            doTweenAlpha('koopaBGAlpha','koopaBG',1,3,'cubeInOut')
            doTweenY('koopaTopY','koopaTop',getProperty('koopaTop.y') + 700,3,'cubeOut')
            doTweenY('koopaGroundY','koopaGround',getProperty('koopaGround.y') - 3000,3,'linear')
            setProperty('koopaLava.y',getProperty('koopaLava.y') + 100)
        end
    elseif stage == 'duckGlitch' then

        makeAnimatedLuaSprite('duckGlitch','mario/beatus/staticbg',-100,0)
        addAnimationByPrefix('duckGlitch','anim','staticbg duck',12,true)
        setProperty('duckGlitch.antialiasing',false)
        addLuaSprite('duckGlitch',false)
        scaleObject('duckGlitch',2.5,2.5)

        curNesStage = 3
    elseif stage == 'koopaGlitch' then
        makeAnimatedLuaSprite('koopaGlitch','mario/beatus/staticbg',-100,0)
        addAnimationByPrefix('koopaGlitch','anim','staticbg castle',12,true)
        setProperty('koopaGlitch.antialiasing',false)
        addLuaSprite('koopaGlitch',false)
        scaleObject('koopaGlitch',2.5,2.5)

        curNesStage = 4
    end

    if (stage == 'duckGlitch' or stage == 'koopaGlitch') then
        if not luaSpriteExists('nesGlitchStatic') then
            makeAnimatedLuaSprite('nesGlitchStatic','mario/beatus/static',-120,0)
            addAnimationByPrefix('nesGlitchStatic','anim','static idle',24,true)
            scaleObject('nesGlitchStatic',1.25,1.25)
            addLuaSprite('nesGlitchStatic',false)
        else
            removeLuaSprite('nesGlitchStatic',false)
            addLuaSprite('nesGlitchStatic',false)
        end
    end

    --Put black on front
    removeLuaSprite('bgBlack',false)
    addLuaSprite('bgBlack',false)
end

function removeNesStage(stage,tween)
    local luas = getNesStage(stage,tween)
    if #luas > 0 then
        if not tween or tween and stage == 'koopa' then
            cancelNesTweens(stage)
        end
        for i, stageLua in pairs(luas) do
            if luaSpriteExists(stageLua) then
                if tween then
                    if stage == 'duck' then
                        if stageLua == 'duckBG' then
                            doTweenColor(stageLua..'Exit',stageLua,'000000',2,'cubeInOut')
                        else
                            doTweenY(stageLua..'Exit',stageLua,getProperty(stageLua..'.y') + 1200,2,'cubeIn')
                        end
                    elseif stage == 'koopa' then
                        if stageLua == 'koopaClownCar' then
                            doTweenAlpha('koopaClownCarAlpha','koopaClownCar',1,0.5,'cubeIn')
                            doTweenY('clowCarY','koopaClownCar',-1200,2,'cubeIn')
                            doTweenX('clowCarScaleX','koopaClownCar.scale',5,2,'linear')
                            doTweenY('clowCarScaleY','koopaClownCar.scale',5,2,'linear')
                        else
                            removeLuaSprite(stageLua)
                        end
                    elseif stage == 'nes' then
                        doTweenAlpha(stageLua..'Alpha',stageLua,0,1.5,'quintIn')
                    end
                else
                    removeLuaSprite(stageLua,true)
                end
            end
        end
    end
end
function setNesStageFront(stage)
    local stageLua = getNesStage(stage,true)
    if #stageLua > 0 then
        for i, luas in pairs(stageLua) do
            removeLuaSprite(luas,false)
            addLuaSprite(luas,false)
        end
    end

    cancelTween('bgBlack')
    --Put black on front
    removeLuaSprite('bgBlack',false)
    addLuaSprite('bgBlack',false)
    if stage == 'koopa' then
        setObjectOrder('koopaClownCar',getObjectOrder('bgBlack'))
    end
end

function getNesStage(stage,asTween)
    local luas = {}
    if stage == 'nes' then
        luas = {'bgNes'}
    elseif stage == 'duck' then
        luas = {'duckBG','duckTree','duckArbust','duckGrass'}
    elseif stage == 'koopa' then
        if asTween then
            luas = {'koopaBG','koopaTop','koopaGround','koopaLava','koopaClownCar'}
        else
            luas = {'koopaBG','koopaTop','koopaGround','koopaLava'}
        end
    elseif stage == 'duckGlitch' then
        luas = {'duckGlitch'}
    elseif stage == 'koopaGlitch' then
        luas = {'koopaGlitch'}
    end
    return luas
end

function cancelNesTweens(stage)-- if don't cancel, the game crashes.
    if stage == 'nes' then
        cancelTween('bgNesAlpha')
        for tweens = 1,11 do
            cancelTween('stageBG'..tweens)
        end
        

    elseif stage == 'duck' then
        cancelTween('duckTreeX')
        cancelTween('duckArbustX')
        cancelTween('duckBGExit')
        cancelTween('duckTreeExit')
        cancelTween('duckGrassExit')
        cancelTween('duckArbustExit')
    elseif stage == 'koopa' then
        cancelTween('koopaBGColor')
        cancelTween('lavaYGo')
        cancelTween('lavaYDown')
        cancelTween('lavaY')
        cancelTween('koopaBGAlpha')
        cancelTween('koopaTopY')
        cancelTween('koopaGroundY')
        cancelTween('koopaLavaY')
        cancelTween('koopaClownCarY')
        cancelTween('clowCarScaleX')
        cancelTween('clowCarScaleY')
        cancelTween('koopaClownCarAlpha')
    end
end

function nesStageBump()
    if curNesStage == 1 then
        cancelTimer('resetDuckBGColor')
        cameraShake('game',0.007,stepCrochet*0.001)
        makeGraphic('duckBG',screenWidth + 400,screenHeight + 400,'DAB2AC')
        runTimer('resetDuckBGColor',stepCrochet*0.002)
    elseif curNesStage == 2 then
        setProperty('koopaBG.color',getColorFromHex('FFFFFF'))
        doTweenColor('koopaBGColor','koopaBG','000000',stepCrochet*0.002,'sineOut')
    end
end

function onTweenCompleted(tag)
    local stageBGDefaultX = -1700
    if tag == 'stageBG1' then
        doTweenAngle('stageBG2','bgNes',0,2)
    elseif tag == 'stageBG2' then
        doTweenAngle('stageBG3','bgNes',-20,3)
    elseif tag == 'stageBG3' then
        doTweenAngle('stageBG4','bgNes',20,6)
    elseif tag == 'stageBG4' then
        doTweenAngle('stageBG5','bgNes',-30,6)
        doTweenX('stageBGX','bg',stageBGDefaultX - 200,6)
        
    elseif tag == 'stageBG5' then
        doTweenAngle('stageBG6','bgNes',0,3)
    elseif tag == 'stageBG6' then
        doTweenAngle('stageBG7','bgNes',-30,4)
        doTweenX('stageBGX','bg',stageBGDefaultX + 400,4)
    elseif tag == 'stageBG7' then
        doTweenAngle('stageBG8','bgNes',30,3)
        
    elseif tag == 'stageBG8' then
        doTweenAngle('stageBG9','bgNes',60,3)
    elseif tag == 'stageBG9' then
        doTweenAngle('stageBG10','bgNes',0,3)
    elseif tag == 'stageBG10' then
        doTweenAngle('stageBG11','bgNes',-20,4)
    elseif tag == 'stageBG11' then
        doTweenAngle('stageBG4','bgNes',10,2)
    elseif tag == 'duckTreeExit' then
        removeNesStage('duck',false)
    elseif tag == 'bgAlpha' then
        removeNesStage('nes',false)
    
    elseif string.find(tag,'BirdFlyX',0,true) then
        removeLuaSprite(string.gsub(tag,'FlyX',''),true)
        --birdRemoved = birdRemoved + 1
    elseif string.find(tag,'FireBall',0,true) then
        if string.find(tag,'YGo',0,true) then
            local name = string.gsub(tag,'YGo','')
            doTweenY(name..'YExit',name,800,stepCrochet*0.0035,'quadIn')
            if getRandomBool(50) then
                doTweenAngle(name..'Angle',name,180,0.2,'cubeInOut')
            else
                doTweenAngle(name..'Angle',name,-180,0.2,'cubeInOut')
            end
        else
            local name = string.gsub(tag,'YExit','')
            cancelTween(name..'Angle')
            removeLuaSprite(name,true)
        end
    elseif string.find(tag,'BulletKoopa',0,true) then
        removeLuaSprite(string.gsub(tag,'X',''),true)
    
    elseif tag == 'koopaClownCarY' then
        cancelTween('clowCarScaleX')
        cancelTween('clowCarScaleY')
        cancelTween('koopaClownCarAlpha')
        removeLuaSprite('koopaClownCar',true)

    elseif tag == 'lavaYGo' then
        doTweenY('lavaYDown','koopaLava',770,1,'quadInOut')
    elseif tag == 'lavaYDown' then
        doTweenY('lavaY','koopaLava',740,1,'quadInOut')
    end
end

function onTimerCompleted(tag)
    if tag == 'resetDuckBGColor' then
        makeGraphic('duckBG',screenWidth + 400,screenHeight + 400,'5595DA')
    end
end

function onMoveCamera(focus)
    if curFocus ~= focus then
        if(songName == 'Unbeatable' and (curStep > 127 and curStep < 4704 or curStep > 4760) or songName ~= 'Unbeatable') then
            cancelTween('bgBlack')
            doScreenGlitch()
            setProperty('dad.visible',focus == 'dad')
            if focus == 'dad' then
                setProperty('bgBlack.alpha',0)
            else
                setProperty('bgBlack.alpha',0.4)
            end
            setProperty('boyfriend.visible',focus == 'boyfriend' or focus == 'gf')
            setProperty('gf.visible',focus == 'boyfriend' or focus == 'gf')
            curFocus = focus
        end
    end
end
