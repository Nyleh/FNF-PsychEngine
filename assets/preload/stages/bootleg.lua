local runners = {}
function onCreate()
    makeLuaSprite('bg',nil,-1000,-1000)
    makeGraphic('bg',screenWidth,screenHeight,'155FD9')
    scaleObject('bg',10,10)
    setScrollFactor('bg',0,0)
    addLuaSprite('bg',false)


    makeLuaSprite('pressStart','mario/dad7/start',-750,1200)
    scaleObject('pressStart',4,4)
    setProperty('pressStart.antialiasing',false)
    addLuaSprite('pressStart',false)
    if songName == 'Nourishing Blood' then
        makeLuaSprite('flintBG','mario/dad7/flint',-1680,-955)
        scaleObject('flintBG',12,12)
        updateHitbox('flintBG')

        setProperty('flintBG.antialiasing',false)
        setProperty('flintBG.alpha',0.001)
        addLuaSprite('flintBG',false)

        makeAnimatedLuaSprite('flintWater','mario/dad7/Water',-1500,1350)
        addAnimationByPrefix('flintWater','anim','Water idle',24,true)
        setScrollFactor('flintWater',1.4,1)
        scaleObject('flintWater',12,12)
        setProperty('flintWater.antialiasing',false)
        setProperty('flintWater.alpha',0.001)
        addLuaSprite('flintWater',true)


        makeAnimatedLuaSprite('garfield','mario/dad7/GrandDad_BGCameo_Assets',3300,150)
        scaleObject('garfield',0.4,0.4)
        addAnimationByIndicesLoop('garfield','walk','garfield stuff','0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22',24)
        local indices = ''
        for garfieldIndices = 21,131 do
            indices = indices..garfieldIndices
            if garfieldIndices < 131 then
                indices = indices..','
            end
        end
        addAnimationByIndices('garfield','anim','garfield stuff0',indices,24)
        playAnim('garfield','walk')
        addLuaSprite('garfield',false)

        makeAnimatedLuaSprite('skeletor','mario/dad7/GrandDad_BGCameo_Assets',3700,-150)
        scaleObject('skeletor',0.7,0.7)
        addAnimationByPrefix('skeletor','anim','skeletor run',24,true)
        addLuaSprite('skeletor',false)

        makeAnimatedLuaSprite('bogan','mario/dad7/GrandDad_BGCameo_Assets',3300,60)
        scaleObject('bogan',0.5,0.5)
        addAnimationByPrefix('bogan','anim','bulk bogan run',24,true)
        addLuaSprite('bogan',false)

        makeAnimatedLuaSprite('pantherk','mario/dad7/GrandDad_BGCameo_Assets',-1850,50)
        scaleObject('pantherk',0.5,0.5)
        addAnimationByPrefix('pantherk','anim','pantherk walk',24,true)
        addLuaSprite('pantherk',false)

        
        makeAnimatedLuaSprite('fella','mario/dad7/GrandDad_BGCameo_Assets',-1600,50)
        scaleObject('fella',0.5,0.5)
        addAnimationByPrefix('fella','anim','fella and nozomi',24,true)
        addLuaSprite('fella',false)


        makeAnimatedLuaSprite('marcianito','mario/dad7/GrandDad_BGCameo_Assets',-1800,-300)
        scaleObject('marcianito',0.3,0.3)
        addAnimationByPrefix('marcianito','anim','marcianito',24,true)
        addLuaSprite('marcianito',false)


        makeAnimatedLuaSprite('lg','mario/dad7/GrandDad_BGCameo_Assets',3400,-50)
        scaleObject('lg',0.8,0.8)
        addAnimationByPrefix('lg','anim','buff luigi run',24,true)
        addLuaSprite('lg',false)

        makeAnimatedLuaSprite('picture','mario/dad7/GrandDad_BGCameo_Assets',300,100)
        addAnimationByPrefix('picture','pic','bob ross easel0000',0,false)
        --setProperty('picture.visible',false)
        setProperty('picture.alpha',0.001)
        addLuaSprite('picture',false)


        makeAnimatedLuaSprite('pacman','mario/dad7/GrandDad_BGCameo_Assets',-2000,520)
        addAnimationByPrefix('pacman','pac','pacman run',24,true)
        addLuaSprite('pacman',false)




        makeAnimatedLuaSprite('bob','mario/dad7/GrandDad_BGCameo_Assets',3400,50)
        addAnimationByIndicesLoop('bob','running','bob ross stuff','0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15',24)
        
        indices = ''
        for runningIndices = 17,80 do
            indices = indices..runningIndices
            if runningIndices < 80 then
                indices = indices..','
            end
        end 
        addAnimationByIndices('bob','painting','bob ross stuff',indices,24)
        addOffset('bob','running',0,0)
        addOffset('bob','painting',150,150)

        playAnim('bob','painting',false)
        
        addLuaSprite('bob',false)

        makeAnimatedLuaSprite('protegent','mario/dad7/GrandDad_BGCameo_Assets',3400,-150)
        addAnimationByPrefix('protegent','anim','protegent',24,true)
        addLuaSprite('protegent',false)

        makeAnimatedLuaSprite('gang','mario/dad7/Grand_Dad_Girlfriend_Assets_gang',430,360)
        addAnimationByPrefix('gang','idle','funnygangIdle',24,false)
        setProperty('gang.scale.x',0.1)
        setProperty('gang.scale.y',0.5)
        addLuaSprite('gang',false)


    end
end
function onBeatHit()
    setProperty('pressStart.visible',not getProperty('pressStart.visible'))
    playAnim('gang','idle',true)
end
function spawnPeople()
    setProperty('bob.velocity.x',-500)
    playAnim('bob','running')

    setProperty('garfield.velocity.x',-130)
    playAnim('garfield','walk')

    setProperty('protegent.velocity.x',-550)
    setProperty('skeletor.velocity.x',-400)
    setProperty('lg.velocity.x',-400)

    
    setProperty('bogan.velocity.x',-180)


    setProperty('pacman.velocity.x',500)
    setProperty('pantherk.velocity.x',250)
    setProperty('fella.velocity.x',250)
    
    setProperty('marcianito.velocity.x',200)
    
    runners = {'bob','pacman','garfield','fella','pantherk','skeletor','marcianito','bogan','lg','protegent'}
    --setProperty('pacman.x',-2000)
    --setProperty('bob.x',3000)
end
function removePeople()
    for i, runner in pairs(runners) do
        removeLuaSprite(runner,true)
    end
end
function onUpdate()
    if songName == 'Nourishing Blood' then
        if #runners > 0 then
            for i, runner in pairs(runners) do
                if luaSpriteExists(runner) then
                    local runnerX = getProperty(runner..'.x')
                    local runnerVelocity = getProperty(runner..'.velocity.x')
                    if runner == 'bob' then
                        if getProperty('picture.alpha') ~= 1 and runnerVelocity < 0 and runnerX <= 450 then
                            playAnim('bob','painting',true)
                            setProperty('bob.velocity.x',0)
                            setProperty('bob.x',350)
                        end
                        if getProperty('bob.animation.curAnim.finished') and runnerX <= 350 then
                            --setProperty('picture.visible',true)
                            setProperty('picture.alpha',1)
                            playAnim('bob','running',true)
                            setProperty('bob.velocity.x',-500)
                        end
                    elseif runner == 'garfield' then
                        if runnerX <= 1000 and runnerVelocity == -130 then
                            playAnim('garfield','anim')
                            setProperty('garfield.velocity.x',0)
                        end
                        if getProperty('garfield.animation.curAnim.finished') then
                            setProperty('garfield.velocity.x',-131)
                            playAnim('garfield','walk')
                        end
                    end
                    if runnerX <= -2000 and runnerVelocity < 0 or runnerX >= 3400 and runnerVelocity > 0 then
                        removeLuaSprite(runner,true)
                    end
                else
                    table.remove(runners,i)
                end
            end
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Nourishing Blood' then
        if v1 == '0' then
            
            cameraFlash('game','FFFFFF',1)
            setProperty('flintWater.alpha',1)
            setProperty('flintBG.alpha',1)
            setProperty('boyfriendGroup.x',1260)
            setProperty('boyfriendGroup.y',480)
            setProperty('dadGroup.x',0)
            setProperty('dadGroup.y',555)
            setProperty('gfGroup.x',590)
            setProperty('gfGroup.y',395)

            setProperty('gang.visible',false)
            removeLuaSprite('picture',true)

            removePeople()
        elseif v1 == '1' then
            removeLuaSprite('flintBG',true)
            removeLuaSprite('flintWater',true)
            setProperty('boyfriendGroup.x',1270)
            setProperty('boyfriendGroup.y',310)
            setProperty('dadGroup.x',-200)
            setProperty('dadGroup.y',330)
            setProperty('gfGroup.x',500)
            setProperty('gfGroup.y',250)

            setProperty('gang.visible',true)
        elseif v1 == '2' then
            doTweenX('gangScaleX','gang.scale',1,0.25,'backOut')
            doTweenY('gangScaleY','gang.scale',1,0.25,'backOut')
            spawnPeople()
        end
    end
end