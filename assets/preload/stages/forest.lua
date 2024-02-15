local particleCount = 0
local glitchCount = 0
local enableGlitch = true
local isTweeingColor = false
function onCreate()
    makeLuaSprite('bg','mario/Coronation/firstpart/FondoFondo',-800,-500)
    setScrollFactor('bg',0.2,0.2)
    scaleObject('bg',0.8,0.8)
    addLuaSprite('bg',false)

    makeLuaSprite('arboles','mario/Coronation/firstpart/Arboles',-1200,-500)
    addLuaSprite('arboles',false)

    makeLuaSprite('treesBehind','mario/Coronation/firstpart/AtrasArboles',-1200,-500)
    addLuaSprite('treesBehind',false)

    makeLuaSprite('treesFront','mario/Coronation/firstpart/asdas',-1200,-500)
    addLuaSprite('treesFront',false)

    makeLuaSprite('bridge','mario/Coronation/firstpart/Stage',-1200,-500)
    addLuaSprite('bridge',false)


    makeLuaSprite('treesTop','mario/Coronation/secondpart/TransitionBottom',-1300,-2500)
    scaleObject('treesTop',1.2,1.2)
    setScrollFactor('treesTop',1.2,1.2)
    addLuaSprite('treesTop',true)

    makeAnimatedLuaSprite('rain','mario/LuigiBeta/old/Beta_Luigi_Rain_V1',-800,-400)
    addAnimationByPrefix('rain','anim','RainLuigi',24,true)
    setScrollFactor('rain',0,0)
    setProperty('rain.alpha',0.7)
    scaleObject('rain',2.2,2.2)
    addLuaSprite('rain',true)

    if songName == 'Dark Forest' then
        addLuaScript('custom_events/flash')
        setProperty('rain.alpha',0.001)

        makeLuaSprite('bgPart2','mario/Coronation/secondpart/BGforBG',-600,-2500)
        scaleObject('bgPart2',0.8,0.8)
        addLuaSprite('bgPart2',false)
        setScrollFactor('bgPart2',0.2,0.5)

        makeLuaSprite('TreeHouse','mario/Coronation/secondpart/TreeHouse',-1250,-4700)
        addLuaSprite('TreeHouse',false)

        makeAnimatedLuaSprite('marioDead','mario/Coronation/secondpart/CoroDay_DeadMario',300,-3550)
        addAnimationByPrefix('marioDead','anim','DeadMario',24,true)
        scaleObject('marioDead',1.2,1.2)
        addLuaSprite('marioDead',false)

        makeLuaSprite('treesTopPart2','mario/Coronation/secondpart/TransitionTop',-1200,-4150)
        setScrollFactor('treesTopPart2',1.2,1.2)
        addLuaSprite('treesTopPart2',true)
        setObjectOrder('treesTopPart2',getObjectOrder('treesTop')-1)

        precacheImage('mario/Coronation/secondpart/thenerve')
        precacheImage('mario/Coronation/thirdpart/thenerve')
        precacheImage('mario/Coronation/thirdpart/Coronation_Peach_misc_Assets')

        makeLuaSprite('vignetteFire','modstuff/232',0,0)
        setObjectCamera('vignetteFire','hud')
        setProperty('vignetteFire.alpha',0.001)
        addLuaSprite('vignetteFire',false)
    end


    makeLuaSprite('ambientEffect',nil,-1200,-720)
    setScrollFactor('ambientEffect',0,0)
    setProperty('ambientEffect.alpha',0.3)
    makeGraphic('ambientEffect',screenWidth*3,screenHeight*3,'FFFFFF')
    setProperty('ambientEffect.color',getColorFromHex('000E19'))
    setBlendMode('ambientEffect','multiply')
    addLuaSprite('ambientEffect',true)
end
function createGlitchs(id)
    local name = 'forestGlitch'..id
    makeAnimatedLuaSprite(name,'mario/Coronation/thirdpart/Coronation_Peach_misc_Assets',0,300)
    addAnimationByPrefix(name,'anim','glitch',24,true)
    scaleObject(name,1.5,1.5)
    addLuaSprite(name,true)
    setGlitchPos(name)
end
function setGlitchPos(id)
    setProperty('forestGlitch'..id..'.x',-500 + (getRandomInt(0,3000)))
    setProperty('forestGlitch'..id..'.y',0 + (getRandomInt(0,1000)))
    setProperty('forestGlitch'..id..'.scale.x',getRandomFloat(2,3.5))
    setProperty('forestGlitch'..id..'.scale.y',getRandomFloat(2,3.5))
    if getRandomBool() then
        setProperty('forestGlitch'..id..'.angle',90)
    else
        setProperty('forestGlitch'..id..'.angle',0)
    end
end
function changeForestState(state)
    if state == 2 then
        doTweenAlpha('vignnete','vignetteFire',1,1,'cubeInOut')
        doTweenColor('ambientEffectColor','ambientEffect','FF0000',1,'cubeInOut')
        isTweeingColor = true

        glitchCount = 6
        for id = 0,glitchCount do
            createGlitchs(id)
        end
        makeAnimatedLuaSprite('har','mario/Coronation/thirdpart/Coronation_Peach_misc_Assets',1700,500)
        addAnimationByPrefix('har','anim','har',24,true)
        setScrollFactor('har',1.2,1.2)
        scaleObject('har',2.5,2.5)
        addLuaSprite('har',true)

        makeAnimatedLuaSprite('har','mario/Coronation/thirdpart/Coronation_Peach_misc_Assets',1700,500)
        addAnimationByPrefix('har','anim','har',24,true)
        setScrollFactor('har',1.2,1.2)
        scaleObject('har',2.5,2.5)
        addLuaSprite('har',true)

        for coro = 0,2 do
            local posX = {520,820,1450}
            local posY = {-100,320,-200}
            makeAnimatedLuaSprite('coro'..coro,'mario/Coronation/thirdpart/Coronation_Peach_misc_Assets',posX[coro+1],posY[coro+1])
            addAnimationByPrefix('coro'..coro,'anim','Leave0',24,true)
            addLuaSprite('coro'..coro,false)
            if coro == 1 then
                setObjectOrder('coro'..coro,getObjectOrder('bridge'))
            else
                setObjectOrder('coro'..coro,getObjectOrder('treesFront')-1)
            end
            
            scaleObject('coro'..coro,1.2,1.2)
        end
    end
end
function onBeatHit()
    if enableGlitch and glitchCount > 0 then
        for glitchs = 0,glitchCount do
            setGlitchPos(glitchs)
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Dark Forest' then
        if v1 == '2' then
            removeLuaSprite('TreeHouse',true)
            removeLuaSprite('bgPart2',true)
            removeLuaSprite('marioDead',true)
            removeLuaSprite('treesTopPart2',true)
            callOnHScript('optimizeStage',{'forest',1})

        elseif v1 == '3' then
            callScript('custom_events/flash','doFlash',{'FFFFFF','game',1})
            setProperty('ambientEffect.alpha',0.4)
            setProperty('rain.alpha',0.6)

        elseif v1 == '5' then
            doTweenAlpha('rainAlpha','rain',0.7,0.2,'linear')
            changeForestState(2)
        elseif v1 == '13' then
            doTweenAlpha('rainAlpha','rain',0,1,'linear')
        end
    end
end
function onUpdatePost()
    if isTweeingColor then
        setProperty('ambientEffect.alpha',0.3)
    end
end
function makeParticle(id,cosMoviment)
    
end