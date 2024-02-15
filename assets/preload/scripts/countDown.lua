local countDownStyle = ''
function onCreate()
    setProperty('introSoundsSuffix','-silence')
    if curStage == 'hatebg' or curStage == 'forest' then
        countDownStyle = 'world'
    end
end
function onCreatePost()
    if countDownStyle == 'world' then
        makeLuaSprite('marioWorldBlack',nil,0,0)
        makeGraphic('marioWorldBlack',screenWidth+300,screenHeight+300,'000000')
        setObjectCamera('marioWorldBlack','other')
        addLuaSprite('marioWorldBlack',true)

        if string.find(getProperty('boyfriend.curCharacter'),'mario',0,true) then
            makeLuaSprite('worldStart','modstuff/hatestartM',0,0)
        else
            makeLuaSprite('worldStart','modstuff/hatestart',0,0)
        end
        setObjectCamera('worldStart','other')
        scaleObject('worldStart',3,3)
        setProperty('worldStart.antialiasing',false)
        setProperty('worldStart.alpha',0.001)
        addLuaSprite('worldStart',true)
        screenCenter('worldStart')
        runTimer('worldStart',stepCrochet*0.016)
    end
end
function startWorldCount()
    if countDownStyle == 'world' then
        setProperty('worldStart.alpha',1)
        
        playSound('smw_coin')
        countDownStyle = ''
        runTimer('startIntroExit',stepCrochet*0.016)
    end
end
function onStartCountdown()
    if getProperty('skipCountdown') then
        runTimer('startWorldCount',stepCrochet*0.001)
    end
end
function onCountdownTick(tick)
    if tick == 0 and countDownStyle == 'world' then
        startWorldCount()
    elseif tick == 1 then
        setProperty('countdownReady.visible',false)
    elseif tick == 2 then
        setProperty('countdownSet.visible',false)
    elseif tick == 3 then
        setProperty('countdownGo.visible',false)
    end
    --end
end
function onTimerCompleted(tag)
    if tag == 'startIntroExit' then
        removeLuaSprite('worldStart',true)
        doTweenAlpha('marioBlackAlpha','marioWorldBlack',0,stepCrochet*0.003,'linear')
    elseif tag == 'startWorldCount' then
        startWorldCount()
    end
end
function onTweenCompleted(tag)
    if tag == 'marioBlackAlpha' then
        removeLuaSprite('marioWorldBlack',true)
    end
end
function onSongStart()
    if countDownStyle == 'world' then
        removeLuaSprite('worldStart',true)
        doTweenAlpha('marioBlackAlpha','marioWorldBlack',0,stepCrochet*0.002,'linear')
    end
end