local curState = nil

local precacheStages = true

local act4objects = 10
local act4objectsCreated = false

local isAllStars = false
function onCreate()

    if songName == 'All-Stars' then
        --precacheStages = true
        isAllStars = true
    end
    if isAllStars then
        if not not precacheStages then
            addLuaScript('extra_scripts/loadingStage')
        else
            for stages = 1,5 do
                precacheStages(stages)
            end
            
        end
    end
    createStage(0)
end
function precacheStage(stage)
    if stage == 1 then
        precacheImage('mario/allfinal/act2/act2_static')
        if not lowQuality then
            precacheImage('mario/allfinal/act2/act2_scroll1')
        end
        precacheImage('mario/allfinal/act2/act2_pipes_far')
        precacheImage('mario/allfinal/act2/act2_abyss_gradient')
        precacheImage('mario/allfinal/act2/act2_pipes_middle')
        precacheImage('mario/allfinal/act2/act2_pipes_close')
        precacheImage('mario/allfinal/act2/act2_pipes_waryosh')
        precacheImage('mario/allfinal/act2/act2_pipes_lgbf')
        precacheImage('mario/allfinal/act2/act2_pipes_waryosh')
        precacheImage('mario/allfinal/act2/act2')
    elseif stage == 2 then
        precacheImage('mario/allfinal/act3/Act3_Hills')
        precacheImage('mario/allfinal/act3/Act3_Static')
        precacheImage('mario/allfinal/act3/Act3_Ultra_M')
        precacheImage('mario/allfinal/act3/Act3_Ultra_M_Head')
        precacheImage('mario/allfinal/act3/Act3_Ultra_M_Head2')
        precacheImage('mario/allfinal/act3/Act3_Ultra_Pupils')
        precacheImage('mario/allfinal/act3/Act3_bfpipe')
        precacheImage('mario/allfinal/act3/act3Spotlight')
        precacheImage('mario/allfinal/act3/act3')
    elseif stage == 3 then
        precacheImage('mario/allfinal/act4/gray static')
        precacheImage('mario/allfinal/act4/bg ripple')
        precacheImage('mario/allfinal/act4/bf pipe final')
        precacheImage('mario/allfinal/act3/Act3_Ultra_M_Head2')
        precacheImage('mario/allfinal/act3/Act3_Ultra_Pupils')
        precacheImage('mario/allfinal/act3/Act3_bfpipe')
        precacheImage('mario/allfinal/act3/act3Spotlight')
        precacheImage('mario/allfinal/act3/act3')
        precacheImage('mario/allfinal/act4/floating objects')
    elseif stage == 4 then
        precacheImage('mario/allfinal/act4/spotlight')
    elseif stage == 5 then
        precacheImage('mario/allfinal/act4/Act_4_FINALE_Lightingmcqueen')
    end
end
function createStage(stage)
    if curState ~= stage then
        setProperty('dadGroup.visible',true)
        setProperty('dad.visible',true)
        if stage > 0 then
            setProperty('gf.visible',false)
            setProperty('gfGroup.visible',false)
        else
            setProperty('gf.visible',true)
            setProperty('gfGroup.visible',true)
        end

        if stage == 0 then
            makeLuaSprite('act1sky','mario/allfinal/act1/act1_sky',-1600,-860)
            setScrollFactor('act1sky',0.4,0.4)
            addLuaSprite('act1sky',false)

            if not lowQuality then
                makeAnimatedLuaSprite('act1static','mario/allfinal/act1/act1_stat',-2300,-660)
                addAnimationByPrefix('act1static','anim','act1_static',24,true)
                setProperty('act1static.alpha',0.3)
                setScrollFactor('act1static',0.3,0.3)
                --setBlendMode('act1static','multiply')
                scaleObject('act1static',4,4)
                addLuaSprite('act1static',false)

                makeLuaSprite('act1skyline','mario/allfinal/act1/act1_skyline',-2000,-660)
                setScrollFactor('act1skyline',0.6,0.6)
                addLuaSprite('act1skyline',false)

                makeLuaSprite('act1gradiant','mario/allfinal/act1/act1_gradient',-2300,-850)
                addLuaSprite('act1gradiant',true)
            end

            makeLuaSprite('act1buildings','mario/allfinal/act1/act1_bgbuildings',-2100,-660)
            setScrollFactor('act1buildings',0.8,0.8)
            addLuaSprite('act1buildings',false)

            makeLuaSprite('act1floor','mario/allfinal/act1/act1_floor',-2300,-660)
            --scaleObject('act1floor',1.05,1.05)
            addLuaSprite('act1floor',false)

            makeLuaSprite('act1floor','mario/allfinal/act1/act1_floor',-2300,-660)
            --scaleObject('act1floor',1.05,1.05)
            addLuaSprite('act1floor',false)


            makeLuaSprite('act1front','mario/allfinal/act1/act1',0,0)
            setObjectCamera('act1front','hud')
            addLuaSprite('act1front',true)


            setProperty('dadGroup.x',-1170)
            setProperty('dadGroup.y',430)
            setProperty('boyfriendGroup.x',270)
            setProperty('boyfriendGroup.y',120)

            setProperty('gfGroup.x',580)
            setProperty('gfGroup.y',150)
        elseif stage == 1 then

            makeAnimatedLuaSprite('act2bg','mario/allfinal/act2/act2_static',-700,-360)
            addAnimationByPrefix('act2bg','anim','act2stat',24,true)
            setScrollFactor('act2bg',0.2,0.2)
            scaleObject('act2bg',1.75,1.75)
            addLuaSprite('act2bg',false)

            makeLuaSprite('act2Flash',nil,-500,-500)
            setScrollFactor('act2Flash',0,0)
            makeGraphic('act2Flash',screenWidth*3,screenHeight*3)
            addLuaSprite('act2Flash',false)
            setProperty('act2Flash.alpha',0.001)
            setObjectOrder('act2Flash',getObjectOrder('act2bg')+1)
            for scroll = 0,1 do
                makeLuaSprite('act2Scroll'..scroll,'mario/allfinal/act2/act2_scroll1',-500 - (2240*scroll),-250)
                setScrollFactor('act2Scroll'..scroll,0.3,0.3)
                setProperty('act2Scroll'..scroll..'.velocity.x',500)
                setProperty('act2Scroll'..scroll..'.maxVelocity.x',500)
                setProperty('act2Scroll'..scroll..'.acceleration.x',1000)
                addLuaSprite('act2Scroll'..scroll,false)
            end

            makeLuaSprite('act2abyss','mario/allfinal/act2/act2_abyss_gradient',-1000,-1650)
            scaleObject('act2abyss',3,3)
            setScrollFactor('act2abyss',0,1)

            if not lowQuality then
                makeLuaSprite('act2pipefar','mario/allfinal/act2/act2_pipes_far',-1250,0)
                setScrollFactor('act2pipefar',0.7,0.7)
                addLuaSprite('act2pipefar',false)


                addLuaSprite('act2abyss',false)
                
                makeLuaSprite('act2pipemiddle','mario/allfinal/act2/act2_pipes_middle',-1500,200)
                addLuaSprite('act2pipemiddle',false)

                makeLuaSprite('act2front','mario/allfinal/act2/act2',0,0)
                setProperty('act2front.alpha',0.5)
                setObjectCamera('act2front','other')
                addLuaSprite('act2front',false)
            else
                addLuaSprite('act2abyss',false)
            end

            makeLuaSprite('act2pipeclose','mario/allfinal/act2/act2_pipes_close',-1300,200)
            setScrollFactor('act2pipeclose',0.8,0.8)
            addLuaSprite('act2pipeclose',false)

            makeLuaSprite('act2dadPipe','mario/allfinal/act2/act2_pipes_waryosh',-1790,200)
            addLuaSprite('act2dadPipe',false)
            setProperty('act2dadPipe.scale.x',1.05)
            setProperty('act2dadPipe.scale.y',1.05)

            makeLuaSprite('act2gfPipe','mario/allfinal/act2/act2_pipes_lgbf',-1600,100)
            setProperty('act2gfPipe.scale.x',1.05)
            setProperty('act2gfPipe.scale.y',1.05)
            addLuaSprite('act2gfPipe',false)

            makeLuaSprite('act2yoshiPipe','mario/allfinal/act2/act2_pipes_waryosh',-1410,300)
            setProperty('act2yoshiPipe.flipX',true)
            setProperty('act2yoshiPipe.scale.x',1.05)
            setProperty('act2yoshiPipe.scale.y',1.05)
            addLuaSprite('act2yoshiPipe',false)

            if isAllStars then
                setProperty('act2yoshiPipe.y',1110)
                setProperty('act2dadPipe.y',1110)
                setProperty('act2gfPipe.y',1100)
            end
            makeLuaSprite('act2bfPipe','mario/allfinal/act2/act2_pipes_lgbf',-1620,460)
            setProperty('act2bfPipe.scale.x',1.2)
            setProperty('act2bfPipe.scale.y',1.2)
            
            addLuaSprite('act2bfPipe',false)
            setObjectOrder('act2bfPipe',getObjectOrder('boyfriendGroup')-1)



            setProperty('dadGroup.x',-690)
            setProperty('boyfriendGroup.x',-710)
            setProperty('boyfriendGroup.y',650)

            setProperty('gfGroup.x',-750)
            setProperty('gfGroup.y',400)
            setProperty('gf.y',4000)
            setObjectOrder('dad',getObjectOrder('act2abyss'))
            setObjectOrder('dadGroup',getObjectOrder('act2abyss'))

        elseif stage == 2 then
            if not lowQuality then
                makeAnimatedLuaSprite('act3static','mario/allfinal/act3/Act3_Static',-1500,-300)
                addAnimationByPrefix('act3static','anim','act3stat',24,true )
                setScrollFactor('act3static',0.6,0.6)
                setProperty('act3static.alpha',0.6)
                scaleObject('act3static',1.1,1.1)
                addLuaSprite('act3static',false)

                makeAnimatedLuaSprite('act3hills','mario/allfinal/act3/Act3_Hills',-1600,400)
                setScrollFactor('act3hills',0.7,0.7)
                scaleObject('act3hills',1.2,1.2)
                addAnimationByPrefix('act3hills','anim','hills',24,true)
                addLuaSprite('act3hills',false)

                makeLuaSprite('act3smoke','mario/allfinal/act3/act3Spotlight',-1700,-200)
                setProperty('act3smoke.alpha',0.5)
                addLuaSprite('act3smoke',true)

                makeLuaSprite('act3front','mario/allfinal/act3/act3',0,0)
                setObjectCamera('act3front','other')
                setProperty('act3front.alpha',0.8)
                addLuaSprite('act3front',true)
            end

            makeAnimatedLuaSprite('act3body','mario/allfinal/act3/Act3_Ultra_M',-1540,-200)
            addAnimationByPrefix('act3body','idle1','torso idle 1',24,false)
            addAnimationByPrefix('act3body','changePose','torso change pose',24,false)
            addAnimationByPrefix('act3body','idle2','torso idle 2',24,false)
            scaleObject('act3body',1.3,1.3)
            playAnim('act3body','idle1')
            addLuaSprite('act3body',false)

            makeAnimatedLuaSprite('act3head','mario/allfinal/act3/Act3_Ultra_M_Head',-500,-200)
            addAnimationByPrefix('act3head','idle','ultra m static head',0,false)
            setProperty('act3head.maxVelocity.y',250)
            addAnimationByPrefix('act3head','lyrics','ultra m lyrics 10',24,false)
            addLuaSprite('act3head',false)
            playAnim('act3head','idle')

            
            makeAnimatedLuaSprite('act3eyes','mario/allfinal/act3/Act3_Ultra_Pupils',0,0)
            addAnimationByPrefix('act3eyes','anim','ultra pupils',24,true)
            scaleObject('act3eyes',0.9,0.9)
            addLuaSprite('act3eyes',false)
            
            makeAnimatedLuaSprite('act3headtalk','mario/allfinal/act3/Act3_Ultra_M_Head2',-500,-200)
            addAnimationByPrefix('act3headtalk','laugh','ultra m head laugh',24,true)
            addAnimationByPrefix('act3headtalk','lyrics','ultra m lyrics 2',24,false)
            addLuaSprite('act3headtalk',false)
            setProperty('act3headtalk.alpha',0.001)
            setProperty('act3headtalk.maxVelocity.y',250)
            playAnim('act3headtalk','idle')



            makeLuaSprite('act3pipe','mario/allfinal/act3/Act3_bfpipe',100,600)
            addLuaSprite('act3pipe',false)





            setObjectOrder('dad',getObjectOrder('boyfriendGroup'))
            setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup'))
            setProperty('dadGroup.x',-950)
            setProperty('dadGroup.y',0)
            setProperty('boyfriendGroup.x',270)
            setProperty('boyfriendGroup.y',120)

            setProperty('gfGroup.x',580)
            setProperty('gfGroup.y',150)

            setProperty('defaultCamZoom',0.6)


        elseif stage == 3 or stage == 5 then

            if isAllStars then
                precacheImage('mario/allfinal/act4/Act_4_FINALE_Lightingmcqueen')
                precacheImage('mario/allfinal/act4/spotlight')
            end

            setObjectOrder('dad',getObjectOrder('boyfriendGroup')-1)
            setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup')-1)


            makeAnimatedLuaSprite('act4bg','mario/allfinal/act4/gray static',-500,-500)
            addAnimationByPrefix('act4bg','anim','static',24,true)
            scaleObject('act4bg',1.1,1.1)
            addLuaSprite('act4bg',false)

            makeAnimatedLuaSprite('act4ripple','mario/allfinal/act4/bg ripple',-700,-200)
            scaleObject('act4ripple',1.2,1.2)
            addAnimationByPrefix('act4ripple','anim','bg ripple',24,true)
            --scaleObject('act4bg',3,3)
            addLuaSprite('act4ripple',false)
            
            if not act4objectsCreated then
                createAct4objects()
            else
                reOrderAct4Objects()
            end
            if stage == 3 then
                setProperty('defaultCamZoom',1)
                setProperty('dadGroup.x',-300)
                setProperty('dadGroup.y',0)

                setProperty('boyfriendGroup.x',420)
                setProperty('boyfriendGroup.y',-200)

                makeLuaSprite('act4pipe','mario/allfinal/act4/bf pipe final',500,500)
                setObjectOrder('act4pipe',getObjectOrder('boyfriendGroup'))
                addLuaSprite('act4pipe',false)
            elseif stage == 5 then
                setProperty('defaultCamZoom',1.1)
                setProperty('dadGroup.x',-200)
                setProperty('dadGroup.y',0)

                setProperty('boyfriendGroup.x',560)
                setProperty('boyfriendGroup.y',50)
                setProperty('camGame.zoom',1)
                makeAnimatedLuaSprite('act4line','mario/allfinal/act4/Act_4_FINALE_Lightingmcqueen',60,-100)
                addAnimationByPrefix('act4line','anim','line',24,true)
                addLuaSprite('act4line',true)
            end
            
        elseif stage == 4 then
            setProperty('dadGroup.visible',false)
            setProperty('dad.visible',false)

            setProperty('defaultCamZoom',0.7)
            
            makeLuaSprite('act4spotlight','mario/allfinal/act4/spotlight',-800,-800)
            scaleObject('act4spotlight',2.3,2.5)
            setProperty('act4spotlight.alpha',0.3)
            addLuaSprite('act4spotlight',true)
            
            makeAnimatedLuaSprite('act4BfPipe','characters/Act_4_secondperspective',280,450)
            addAnimationByPrefix('act4BfPipe','pipe','pipe',0,false)
            addLuaSprite('act4BfPipe')
        end
        curState = stage
    end
end
function removeStage(stage,destroy)
    if destroy ~= false then
        destroy = true
    end
    if stage == 0 then
        removeLuaSprite('act1sky',destroy)
        removeLuaSprite('act1static',destroy)
        removeLuaSprite('act1skyline',destroy)
        removeLuaSprite('act1gradiant',destroy)
        removeLuaSprite('act1buildings',destroy)
        removeLuaSprite('act1floor',destroy)
        removeLuaSprite('act1front',destroy)
    elseif stage == 1 then
        removeLuaSprite('act2bg',destroy)
        removeLuaSprite('act2Scroll0',destroy)
        removeLuaSprite('act2Scroll1',destroy)
        if not lowQuality then
            removeLuaSprite('act2pipefar',destroy)
        end
        removeLuaSprite('act2pipemiddle',destroy)
        removeLuaSprite('act2pipeclose',destroy)
        removeLuaSprite('act2abyss',destroy)
        removeLuaSprite('act2bfPipe',destroy)

        cancelTween('act2frontalpha')
        removeLuaSprite('act2front',destroy)

        cancelTween('act2dadPipeY')
        removeLuaSprite('act2dadPipe',destroy)
        cancelTween('act2gfPipeY')
        removeLuaSprite('act2gfPipe',destroy)

        cancelTween('act2yoshiPipeY')
        removeLuaSprite('act2yoshiPipe',destroy)


    elseif stage == 2 then
        cancelTween('act3smokeAlpha')
        cancelTween('act3frontAlpha')
        removeLuaSprite('act3smoke',destroy)
        
        removeLuaSprite('act3front',destroy)
        removeLuaSprite('act3pipe',destroy)
        removeLuaSprite('act3head',destroy)
        removeLuaSprite('act3headtalk',destroy)
        removeLuaSprite('act3body',destroy)
        if not lowQuality then
            removeLuaSprite('act3hills',destroy)
            removeLuaSprite('act3static',destroy)
        end
        removeLuaSprite('act3eyes',destroy)
    elseif stage == 3 or stage == 5 then
        removeLuaSprite('act4ripple',destroy)
        removeLuaSprite('act4bg',destroy)
        if stage == 3 then
            removeLuaSprite('act4pipe',destroy)
        elseif stage == 5 then
            removeLuaSprite('act4line',destroy)
        end
    elseif stage == 4 then
        cancelTween('act4spotlightAlpha')
        removeLuaSprite('act4BfPipe',true)
        removeLuaSprite('act4spotlight',true)
    end
    callScript('scripts/optimization','optimizeStage',{'allfinal',stage})
end
function onDestroy()
    if curState == 4 then
        setProperty('camGame.bgColor',getColorFromHex('000000'))
    end
end
function createAct4objects()
    if not act4objectsCreated then
        if lowQuality then
            act4objects = 5
        else
            act4objects = 10
        end
        for objects = 0,act4objects do
            makeAnimatedLuaSprite('act4object'..objects,'mario/allfinal/act4/floating objects',getRandomInt(-100,600),getRandomInt(-300,200))
            addAnimationByPrefix('act4object'..objects,'anim','floating objects0',0,false)
            setScrollFactor('act4object'..objects,0.8,0.8)
            addLuaSprite('act4object'..objects,false)
            setAct3FloatingObject(objects)
            setProperty('act4object'..objects..'.animation.curAnim.curFrame',objects%10)
        end
        act4objectsCreated = true
    end
end
function reOrderAct4Objects()
    for objects = 0,act4objects do
        removeLuaSprite('act4object'..objects,false)
        addLuaSprite('act4object'..objects,false)
    end
end
function setAct3FloatingObject(id,pos)
    local name = 'act4object'..id
    if pos then
        if curState ~= 4 then
            setProperty(name..'.x',screenWidth + getRandomInt(0,500))
        else
            setProperty(name..'.x',screenWidth + getRandomInt(500,1000))
        end
        if curState == 3 then
            setProperty(name..'.y',getRandomInt(-300,500))
        elseif curState == 4 then
            setProperty(name..'.y',getRandomInt(-300,500))
        elseif curState == 5 then
            setProperty(name..'.y',getRandomInt(0,500))
        end
    end
    setProperty(name..'.velocity.x',getRandomInt(-150,-500))
    setProperty(name..'.animation.curAnim.curFrame',getRandomInt(0,9))
    local scale = getRandomFloat(0.9,1.2)
    scaleObject(name,scale,scale)
end
function removeAct4Objects()
    if act4objectsCreated then
        for objects = 0,act4objects do
            removeLuaSprite('act4object'..objects,true)
        end
        act4objectsCreated = false
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers All Stars' then
        if v1 == '2' then
            if v2 == '1' then
                removeStage(0)
                callScript('extra_scripts/loadingStage','startLoading')
                createStage(1)
                cameraFlash('game','000000',1)
            elseif v2 == '2' then
                removeStage(1)
                callScript('extra_scripts/loadingStage','startLoading')
                createStage(2)
                setProperty('act3smoke.alpha',0.001)
                --cameraFlash('game','000000',1)
            elseif v2 == '2.5' then
                setProperty('act3smoke.alpha',0.5)
            elseif v2 == '3' then
                removeStage(2)
                callScript('extra_scripts/loadingStage','startLoading')
                createStage(3)
            elseif v2 == '4' then
                removeStage(3)
                createStage(4)
            elseif v2 == '5' then
                removeStage(4)
                createStage(5)
                cameraFlash('game','FFFFFF',1)
            end

        elseif v1 == '4' then
            if v2 == '0' then
                doTweenY('gfPipe','act2gfPipe',200,1,'sineOut')
            elseif v2 == '1.5' then
                setProperty('dadGroup.x',-1450)
                setProperty('dadGroup.y',410)
                setObjectOrder('dadGroup',getObjectOrder('gfGroup'))
                setObjectOrder('dad',getObjectOrder('dadGroup'))
            elseif v2 == '2' then
                doTweenY('dadPipe','act2dadPipe',200,1,'sineOut')
            elseif v2 == '3' then
                doTweenY('yoshiPipe','act2yoshiPipe',200,1,'sineOut')
  
            elseif v2 == '5' then
                setProperty('act2Flash.alpha',1)
                doTweenAlpha('act2FlashAlpha','act2Flash',0,0.35,'quadInOut')
                for scroll = 0,1 do
                    setProperty('act2Scroll'..scroll..'.velocity.x',-750)
                end
            elseif v2 == '6' then
                for scroll = 0,1 do
                    doTweenX('act2Scroll'..scroll..'X','act2Scroll'..scroll..'.velocity',-700,1.6,'cubeOut')
                    setProperty('act2Scroll'..scroll..'.acceleration.x',0)
                end
                cancelTween('act2FlashAlpha')
                removeLuaSprite('act2Flash',true)
            end
        elseif v1 == '5' then
            doTweenAlpha('act2frontalpha','act2front',0,0.3,'expoIn')
        elseif v1 == '6' then
            if v2 == '2' then
                doTweenAlpha('act3smokeAlpha','act3smoke',0,2,'linear')
            elseif v2 == '4' then
                playAnim('act3head','lyrics',true)
            elseif v2 == '4.25' then
                cancelTween('act3eyesX')
                removeLuaSprite('act3eyes',true)
            elseif v2 == '4.5' then
                playAnim('act3body','changePose',true)
                setProperty('act3headtalk.velocity.y',getProperty('act3head.velocity.y'))
                setProperty('act3headtalk.acceleration.y',getProperty('act3head.acceleration.y'))
                setProperty('act3headtalk.y',getProperty('act3head.y'))
                setProperty('act3headtalk.alpha',1)
                playAnim('act3headtalk','lyrics',true)
                removeLuaSprite('act3head',true)
                curState = 2.5
            elseif v2 == '4.7' then
                playAnim('act3headtalk','laugh',true)
                doTweenAlpha('act3frontAlpha','act3front',0,2,'expoIn')
            end
        elseif v1 == '7' then
            if v2 == '1' then
                doTweenAlpha('act4spotlightAlpha','act4spotlight',0.8,10,'sineInOut')
            end
        elseif v1 == '8' then
            if v2 == '1' then
                removeStage(curState)
                removeAct4Objects()
                setProperty('camGame.bgColor',getColorFromHex('FF0000'))
            end
        end
    end
end
function onUpdate(el)
    if curState == 1 then
        for scroll = 0,1 do
            if getProperty('act2Scroll'..scroll..'.x') >= 1360 and getProperty('act2Scroll'..scroll..'.velocity.x') > 0 then
                setProperty('act2Scroll'..scroll..'.x',getProperty('act2Scroll'..scroll..'.x')-(getProperty('act2Scroll'..scroll..'.width')*2))
            elseif getProperty('act2Scroll'..scroll..'.x') <= -2900 and getProperty('act2Scroll'..scroll..'.velocity.x') < 0 then
                setProperty('act2Scroll'..scroll..'.x',getProperty('act2Scroll'..scroll..'.x')+ (getProperty('act2Scroll'..scroll..'.width')*2))
            end
        end
    elseif curState == 2 then
        setProperty('act3eyes.x',getProperty('act3head.x') + 280)
        setProperty('act3eyes.y',getProperty('act3head.y') + 350)

        if getProperty('act3head.velocity.y') < 0 then
            setProperty('act3head.maxVelocity.y',100)
            if getProperty('act3head.y') <= -180 then
                setProperty('act3head.y',-180)
                setProperty('act3head.acceleration.y',0)
            end
        end
    elseif curState == 2.5 then
        if getProperty('act3headtalk.velocity.y') < 0 then
            setProperty('act3headtalk.maxVelocity.y',100)
            if getProperty('act3headtalk.y') <= -180 then
                setProperty('act3headtalk.y',-180)
                setProperty('act3headtalk.acceleration.y',0)
            end
        end
    elseif curState >= 3 and curState <= 5 then
        for objects = 0,act4objects do
            local name = 'act4object'..objects
            if objects > act4objects/2 then
                setProperty(name..'.angle',getProperty(name..'.angle') + (50*el))
            else
                setProperty(name..'.angle',getProperty(name..'.angle') - (50*el))
            end
            if curState == 3 and getProperty(name..'.x') < -1000 or (curState == 4 or curState == 5) and getProperty(name..'.x') < -650 then
                setAct3FloatingObject(objects,true)
            end
        end
    end
end

function onBeatHit()
    if curBeat % 4 == 0 then
        if curState == 2 then
            playAnim('act3body','idle1',true)
            setProperty('act3head.y',-180)
            setProperty('act3head.velocity.y',250)
            setProperty('act3head.maxVelocity.y',300)
            setProperty('act3head.acceleration.y',-1400)
        elseif curState == 2.5 then
            playAnim('act3body','idle2',true)
            setProperty('act3headtalk.y',-180)
            setProperty('act3headtalk.velocity.y',250)
            setProperty('act3headtalk.acceleration.y',-1400)
        end
    end
end
local curTarget = ''
function onMoveCamera(focus)
    if curState == 2 and focus ~= curTarget and luaSpriteExists('act3eyes') then
        curTarget = focus
        if focus == 'dad' then
            doTweenX('act3eyesX','act3eyes.offset',15,1,'sineIn')
        else
            doTweenX('act3eyesX','act3eyes.offset',-15,1,'sineIn')
        end
    end
end