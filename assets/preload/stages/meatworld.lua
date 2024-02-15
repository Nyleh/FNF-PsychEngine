local precacheStage = true
local haveTransition = false
local curStage = 0

local luigiMax = 12

function onCreate()
    if songName == 'Overdue' then
        haveTransition = true
        if precacheStage then
            swapStage(1,true)
            swapStage(2,true)
        end
    end
    if haveTransition and not precacheStage then
        addLuaScript('extra_scripts/loadingStage')
    end
    swapStage(0)

    makeLuaSprite('vigFog','modstuff/126',0,0)
    setObjectCamera('vigFog','hud')
    addLuaSprite('vigFog',false)

    addLuaScript('extra_scripts/extraCam')
    callScript('extra_scripts/extraCam','insertObjectOnCam',{'vigFog'})
    removeLuaScript('extra_scripts/extraCam')
end
function onCreatePost()
    setProperty('gf.alpha',0.001)
end



function swapStage(stage,precache)
    cancelTween('dadX')
    if stage == 0 then
        makeLuaSprite('backTress','mario/TooLateBG/street/BackTrees',-1400,-550)
        setScrollFactor('backTress',0.95,0.95)
        addLuaSprite('backTress',false)
    
        makeLuaSprite('tress','mario/TooLateBG/street/Front Trees',-1400,-550)
        setScrollFactor('tress',1.05,1.05)
        addLuaSprite('tress',false)
    
        makeLuaSprite('Road','mario/TooLateBG/street/RoadWithCar',-1400,-550)
        addLuaSprite('Road',false)

        makeLuaSprite('FrontTress','mario/TooLateBG/street/Foreground Trees',-1600,-550)
        setScrollFactor('FrontTress',1.2,1)
        addLuaSprite('FrontTress',true)

        if haveTransition then
            makeLuaSprite('meatBottomTeeth','mario/TooLateBG/meat/TL_Meat_FG_bottomteeth',-2350 + 1045,-1350 + 2820)
            setProperty('meatBottomTeeth.alpha',0.001)
            setScrollFactor('meatBottomTeeth',1.2,1.2)
            scaleObject('meatBottomTeeth',1.1,1.1)
            addLuaSprite('meatBottomTeeth',true)
    
            makeLuaSprite('meatTopTeeth','mario/TooLateBG/meat/TL_Meat_FG_topteeth',-2350 + 680,-1350)
            setProperty('meatTopTeeth.alpha',0.001)
            setScrollFactor('meatTopTeeth',1.2,1.2)
            scaleObject('meatTopTeeth',1.1,1.1)
            addLuaSprite('meatTopTeeth',true)
        end
    elseif stage == 1 then
        local x = -2350
        local y = -1350

        if not precache then
            setProperty('boyfriendGroup.x',1000)
            setProperty('boyfriendGroup.y',160)

            setProperty('gfGroup.x',950)
            setProperty('gfGroup.y',160)

            setProperty('dadGroup.x',-380)
            setProperty('dadGroup.y',140)

            setProperty('defaultCamZoom',0.4)
        end

        makeLuaSprite('meatSky','mario/TooLateBG/meat/TL_Meat_Sky',x,y)
        setScrollFactor('meatSky',0.2,0.2)
        addLuaSprite('meatSky',false)

        if not haveTransition then
            makeLuaSprite('meatBottomTeeth','mario/TooLateBG/meat/TL_Meat_FG_bottomteeth',-2350 + 1045,-1350 + 2100)
            setScrollFactor('meatBottomTeeth',1.2,1.2)
            scaleObject('meatBottomTeeth',1.1,1.1)
            addLuaSprite('meatBottomTeeth',true)
    
            makeLuaSprite('meatTopTeeth','mario/TooLateBG/meat/TL_Meat_FG_topteeth',-2350 + 680,-1350 - 200)
            setScrollFactor('meatTopTeeth',1.2,1.2)
            scaleObject('meatTopTeeth',1.1,1.1)
            addLuaSprite('meatTopTeeth',true)
        else
            makeAnimatedLuaSprite('castleFloor','mario/TooLateBG/feet/Overdue_Final_BG_floorfixed',-1300,650)
            addAnimationByPrefix('castleFloor','anim','Floor',0,true)
            setProperty('castleFloor.alpha',0.001)
            addLuaSprite('castleFloor',false)

            if not lowQuality then
                makeAnimatedLuaSprite('castleTop','mario/TooLateBG/feet/Overdue_Final_BG_topfixed',-1300,-1000)
                addAnimationByPrefix('castleTop','anim','Top',0,true)
                setProperty('castleTop.alpha',0.001)
                addLuaSprite('castleTop',false)
            end
        end

        


        if not lowQuality then
            
            makeLuaSprite('meatHands','mario/TooLateBG/meat/TL_Meat_BG',x,y)
            setScrollFactor('meatHands',0.8,0.8)
            addLuaSprite('meatHands',false)

            makeLuaSprite('meatMed','mario/TooLateBG/meat/TL_Meat_MedBG',x,y)
            setScrollFactor('meatMed',0.6,0.6)
            addLuaSprite('meatMed',false)

            makeLuaSprite('meatFog','mario/TooLateBG/meat/TL_Meat_Fog',0,0)
            setObjectCamera('meatFog','hud')
            setProperty('meatFog.alpha',0.001)
            addLuaSprite('meatFog',false)

 

            makeLuaSprite('meatClose','mario/TooLateBG/meat/TL_Meat_CloseFG',x-70,y)
            setScrollFactor('meatClose',1.35,1.35)
            scaleObject('meatClose',1.05,1.05)
            addLuaSprite('meatClose',true)
        end
        if precache then
            setProperty('meatSky.alpha',0.001)
            if not lowQuality then
                setProperty('meatHands.alpha',0.001)
                setProperty('meatClose.alpha',0.001)
                setProperty('meatMedBG.alpha',0.001)
            end
            setProperty('meatEye.alpha',0.001)
        else
            if not lowQuality then
                doTweenAlpha('meatFogAlpha','meatFog',0.6,0.4,'quadIn')
            end
        end

        makeLuaSprite('meatFloor','mario/TooLateBG/meat/TL_Meat_Ground',x,y)
        makeLuaSprite('meatEye','mario/TooLateBG/meat/TL_Meat_Pupil',x + 2820,y + 1230)
        addLuaSprite('meatFloor',false)
        addLuaSprite('meatEye',false)
        --[[makeLuaSprite('meatFarBG','mario/TooLateBG/meat/TL_Meat_FarBG',-2350,-1350)
        setScrollFactor('meatFarBG',0.4,0.4)
        addLuaSprite('meatFarBG',false)

        makeLuaSprite('meatBG','mario/TooLateBG/meat/TL_Meat_FarBG',-2350,-1350)
        setScrollFactor('meatBG',0.4,0.4)
        addLuaSprite('meatBG',false)]]--

    elseif stage == 2 then
        if not precache then
            setProperty('defaultCamZoom',0.4)
            setProperty('boyfriendGroup.x',850)
            setProperty('boyfriendGroup.y',160)

            setProperty('gfGroup.x',950)
            setProperty('gfGroup.y',160)

            setProperty('dadGroup.x',-380)
            setProperty('dadGroup.y',140)

            callScript('scripts/cameraMoviment','setCamPos',{675,600,'bf'})
        end

        makeAnimatedLuaSprite('castleFloor','mario/TooLateBG/feet/Overdue_Final_BG_floorfixed',-1300,650)
        addAnimationByPrefix('castleFloor','anim','Floor',24,true)
        addLuaSprite('castleFloor',false)

        if not lowQuality then
            makeAnimatedLuaSprite('castleTop','mario/TooLateBG/feet/Overdue_Final_BG_topfixed',-1300,-1000)
            addAnimationByPrefix('castleTop','anim','Top',24,true)
            addLuaSprite('castleTop',false)
            if precache then
                setProperty('castleFloor.alpha',0.001)
                setProperty('castleTop.alpha',0.001)
             end

             for luigiFarBG = 0,luigiMax do
                makeAnimatedLuaSprite('LuigiFarBG'..luigiFarBG,'mario/TooLateBG/feet/Too_Late_Luigi_Hallway',-250 + (300*luigiFarBG),-550)
                addAnimationByPrefix('LuigiFarBG'..luigiFarBG,'idle','tll idle',0,false)
                setProperty('LuigiFarBG'..luigiFarBG..'.velocity.x',-2500)
                setScrollFactor('LuigiFarBG'..luigiFarBG,0.7,1)
                scaleObject('LuigiFarBG'..luigiFarBG,0.55,0.55)
                setProperty('LuigiFarBG'..luigiFarBG..'.color',getColorFromHex('404040'))
                addLuaSprite('LuigiFarBG'..luigiFarBG,false)
             end
             for luigiBG = 0,luigiMax do
                makeAnimatedLuaSprite('LuigiBG'..luigiBG,'mario/TooLateBG/feet/Too_Late_Luigi_Hallway',-200 + (300*luigiBG),-750)
                addAnimationByPrefix('LuigiBG'..luigiBG,'idle','tll idle',0,false)
                setProperty('LuigiBG'..luigiBG..'.velocity.x',-2500)
                setScrollFactor('LuigiBG'..luigiBG,0.8,1)
                scaleObject('LuigiBG'..luigiBG,0.7,0.7)
                setProperty('LuigiBG'..luigiBG..'.color',getColorFromHex('808080'))
                addLuaSprite('LuigiBG'..luigiBG,false)

                makeLuaSprite('LuigiFG'..luigiBG,'mario/TooLateBG/feet/FG_Too_Late_Luigi',-100 + (2000*luigiBG),-800)
                setProperty('LuigiFG'..luigiBG..'.velocity.x',-3500)
                addLuaSprite('LuigiFG'..luigiBG,true)
             end
             
        else
            if precache then
                setProperty('castleFloor.alpha',0.001)
             end
        end
        doTweenX('dadX','dadGroup',getProperty('dadGroup.x')-1650,0.4,'linear')
        for luigis = 0,luigiMax do
            makeAnimatedLuaSprite('LuigiHallWay'..luigis,'mario/TooLateBG/feet/Too_Late_Luigi_Hallway',-100 + (375*luigis),-1000)
            addAnimationByPrefix('LuigiHallWay'..luigis,'idle','tll idle',0,false)
            addAnimationByPrefix('LuigiHallWay'..luigis,'singLEFT','tll left',24,false)
            addAnimationByPrefix('LuigiHallWay'..luigis,'singDOWN','tll down',24,false)
            addAnimationByPrefix('LuigiHallWay'..luigis,'singUP','tll up',24,false)
            addAnimationByPrefix('LuigiHallWay'..luigis,'singRIGHT','tll right',24,false)
            addLuaSprite('LuigiHallWay'..luigis,false)
            scaleObject('LuigiHallWay'..luigis,0.9,0.9)
            setProperty('LuigiHallWay'..luigis..'.velocity.x',-2700)
            addLuaSprite('LuigiBG'..luigis,true)

            setProperty('LuigiHallWay'..luigis..'.alpha',0.001)
            if not precache then
                doTweenAlpha('LuigiHallWay'..luigis..'Alpha','LuigiHallWay'..luigis,1,0.2)
            end
            if not lowQuality then
                setProperty('LuigiFG'..luigis..'.alpha',0.001)
                setProperty('LuigiFarBG'..luigis..'.alpha',0.001)
                setProperty('LuigiBG'..luigis..'.alpha',0.001)
                if not precache then
                    doTweenAlpha('LuigiBG'..luigis..'Alpha','LuigiBG'..luigis,1,0.3)
                    doTweenAlpha('LuigiFG'..luigis..'Alpha','LuigiFG'..luigis,1,0.3)
                    doTweenAlpha('LuigiFarBG'..luigis..'Alpha','LuigiFarBG'..luigis,1,0.3)
                end
            end
        end
    end

    --Move vig to front
    removeLuaSprite('vigFog',false)
    addLuaSprite('vigFog',false)

    curStage = stage
end

function removeFromMemory(image)
    callScript('scripts/optimization','removeFromMemory',{image})
end

function getMeatStages(stage)
    if stage == 0 then
        if not lowQuality then
            return {'backTress','tress','FrontTress','Road'}
        else
            return {'backTress','tress','Road'}
        end
    elseif stage == 1 then
        if not lowQuality then
            return {'meatBottomTeeth','meatTopTeeth','meatSky','meatHands','meatMed','meatFloor','meatEye','meatFog'}
        else
            return {'meatBottomTeeth','meatTopTeeth','meatSky','meatFloor','meatEye'}
        end
    elseif stage == 2 then
        return {'castleFloor','castleTop'}
    end
    return {}
end

function removeStage(stage,fromMemory)
    if stage == 0 then
        for i, lua in pairs(getMeatStages(0)) do
            removeLuaSprite(lua,true)
        end
        if fromMemory then
            removeFromMemory('mario/TooLateBG/street/BackTrees')
            removeFromMemory('mario/TooLateBG/street/Front Trees')
            removeFromMemory('mario/TooLateBG/street/Foreground Trees')
            removeFromMemory('mario/TooLateBG/street/RoadWithCar')
        end
    elseif stage == 1 then
        cancelTween('meatEyeX')
        for i, lua in pairs(getMeatStages(1)) do
            cancelTween(lua..'Alpha')
            removeLuaSprite(lua,true)
        end
        if fromMemory then
            removeFromMemory('mario/TooLateBG/meat/TL_Meat_Sky')
            removeFromMemory('mario/TooLateBG/meat/TL_Meat_BG')
            removeFromMemory('mario/TooLateBG/meat/TL_Meat_Ground')
            removeFromMemory('mario/TooLateBG/meat/TL_Meat_FG_bottomteeth')
            removeFromMemory('mario/TooLateBG/meat/TL_Meat_FG_topteeth')
            removeFromMemory('mario/TooLateBG/meat/TL_Meat_Pupilc')
            removeFromMemory('mario/TooLateBG/meat/TL_Meat_Fog')
        end
    end
end

function onUpdate()
    if curStage == 2 then
        for luigis = 0,luigiMax do
            playAnim('LuigiHallWay'..luigis,getProperty('dad.animation.curAnim.name'),false)

            if getProperty('LuigiHallWay'..luigis..'.x') <= -1600 then
                setProperty('LuigiHallWay'..luigis..'.x',getProperty('LuigiHallWay'..luigis..'.x') + (375*10))
            end
            if not lowQuality then
                if getProperty('LuigiBG'..luigis..'.x') <= -1000 then
                    setProperty('LuigiBG'..luigis..'.x',getProperty('LuigiBG'..luigis..'.x') + (300*10))
                end
                if getProperty('LuigiFarBG'..luigis..'.x') <= -1000 then
                    setProperty('LuigiFarBG'..luigis..'.x',getProperty('LuigiFarBG'..luigis..'.x') + (300*10))
                end
                if getProperty('LuigiFG'..luigis..'.x') <= -1200 then
                    setProperty('LuigiFG'..luigis..'.x',getProperty('LuigiFG'..luigis..'.x') + (2000*10))
                end
            end
        end
    end
end

function onEvent(name,v1,v2)
    if name == 'Triggers Overdue' then
        if v1 == '3' then
            setProperty('camZooming',false)
            setProperty('isCameraOnForcedPos',true)
            doTweenZoom('gameZoom','camGame',0.75,0.4,'expoInOut')
            setProperty('meatTopTeeth.alpha',1)
            setProperty('meatBottomTeeth.alpha',1)
            doTweenY('topTeethY','meatTopTeeth',getProperty('meatTopTeeth.y')+1400,0.3,'cubeIn')
            doTweenY('bottomTeethY','meatBottomTeeth',getProperty('meatBottomTeeth.y')-1400,0.3,'cubeIn')

        elseif v1 == '4' then
            doTweenZoom('gameZoom','camGame',0.5,0.4,'cubeInOut')

            callScript('extra_scripts/loadingStage','startLoading')
            removeStage(0,true)
            swapStage(1)
            doTweenY('topTeethY','meatTopTeeth',getProperty('meatFloor.y') - 100,0.3,'cubeIn')
            doTweenY('bottomTeethY','meatBottomTeeth',getProperty('meatFloor.y')+2000,0.3,'cubeIn')
            runTimer('enableFollowPos',0.2)
        elseif v1 == '6' then
            for i, lua in pairs(getMeatStages(1)) do
                doTweenAlpha(lua..'Alpha',lua,0,10)
            end
            doTweenAlpha('castleFloorAlpha','castleFloor',1,10)
            doTweenAlpha('castleTopAlpha','castleTop',1,10)
        elseif v1 == '7' then
            callScript('extra_scripts/loadingStage','startLoading')
            removeStage(1,true)
            swapStage(2)
        elseif v1 == '8' then
            for luigis = 0,luigiMax do
                doTweenAlpha('LuigiHallWay'..luigis..'Alpha','LuigiHallWay'..luigis,0,1.5)
                if not lowQuality then
                    doTweenAlpha('LuigiBG'..luigis..'Alpha','LuigiBG'..luigis,0,1.5)
                    doTweenAlpha('LuigiFG'..luigis..'Alpha','LuigiFG'..luigis,0,1.5)
                    doTweenAlpha('LuigiFarBG'..luigis..'Alpha','LuigiFarBG'..luigis,0,1.5)
                end
            end
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'enableFollowPos' then
        setProperty('isCameraOnForcedPos',false)
    end
end
local curFocus = ''
function onMoveCamera(focus)
    if curStage == 1 and focus ~= curFocus then
        if focus == 'dad' then
            doTweenX('meatEyeX','meatEye',getProperty('meatFloor.x') + 2750,1.5,'quadInOut')
        elseif focus == 'boyfriend' then
            doTweenX('meatEyeX','meatEye',getProperty('meatFloor.x') + 2870,1.5,'quadInOut')
        end
        curFocus = focus
    end
end