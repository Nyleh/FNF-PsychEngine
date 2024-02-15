local allowBeat = false
local haveCave = false
local allowZoom = true

local enableMove = true
local curStage = 0
function onCreate()
    if shadersEnabled then
        addLuaScript('extra_scripts/createShader')
        callScript('extra_scripts/createShader','createShader',{'tvShader','TvEffect'})
        callScript('extra_scripts/createShader','runShader',{{'game','hud'},'tvShader'})
    end
    if songName == 'Demise' then
        haveCave = true
    end
    makeLuaSprite('flashBG',nil,-3000,-3000)
    setScrollFactor('flashBG',0,0)
    makeGraphic('flashBG',screenWidth,screenHeight)
    setProperty('flashBG.color',0)
    scaleObject('flashBG',10,10)
    addLuaSprite('flashBG')
    
    if not lowQuality then
        for bgs = 0,1 do
            makeLuaSprite('bg'..bgs,'mario/MX/demise/1/Demise_BG_BG2',-2893*bgs,-500)
            setScrollFactor('bg'..bgs,0.3,0.3)
            setProperty('bg'..bgs..'.velocity.x',100)
            addLuaSprite('bg'..bgs)
            if haveCave then

                makeLuaSprite('bgCave'..bgs,'mario/MX/demise/2/Demise_BG2_Mountains',-5128*bgs,-800)
                setScrollFactor('bgCave'..bgs,0.3,0.3)
                setProperty('bgCave'..bgs..'.velocity.x',100)
                addLuaSprite('bgCave'..bgs)
            end
        end
    end
    for castle = 0,1 do
        makeLuaSprite('foreground'..castle,'mario/MX/demise/1/Demise_BG_BGCaca',-4642*castle,-400)
        setScrollFactor('foreground'..castle,0.5,0.5)
        setProperty('foreground'..castle..'.velocity.x',500)
        addLuaSprite('foreground'..castle)
        if haveCave then
            precacheImage('mario/MX/demise/2/Demise_BG2_BGLower')
            makeLuaSprite('foregroundCave'..castle,'mario/MX/demise/2/Demise_BG2_BGLower',-4304*castle,-1400)
            setScrollFactor('foregroundCave'..castle,0.5,0.5)
            setProperty('foregroundCave'..castle..'.velocity.x',300)
            addLuaSprite('foregroundCave'..castle)
        end
    end

    makeAnimatedLuaSprite('floor','mario/MX/demise/1/Demise_BG_suelo',-1000,300)
    addAnimationByPrefix('floor','anim','Floor',60,true)
    setScrollFactor('floor',0,1)
    addLuaSprite('floor')

    if haveCave then
        precacheImage('mario/MX/demise/2/Demise_BG2_Mountains')
        precacheImage('mario/MX/demise/2/Demise_BG2_suelo')
        
        makeAnimatedLuaSprite('floorCave','mario/MX/demise/2/Demise_BG2_suelo',-1000,300)
        addAnimationByPrefix('floorCave','anim','Floor',60,true)
        setScrollFactor('floorCave',0,1)
        addLuaSprite('floorCave')

  
        makeAnimatedLuaSprite('topCave','mario/MX/demise/2/Demise_BG2_techo',-1000,-1050)
        addAnimationByPrefix('topCave','anim','Celling',60,true)
        setScrollFactor('topCave',0,1)
        addLuaSprite('topCave')

        precacheImage('mario/MX/demise/2/Demise_BG2_techo')
        
        precacheImage('mario/MX/demise/1/transition')
        makeLuaSprite('caveTransition','mario/MX/demise/1/transition',-2500,0)
        scaleObject('caveTransition',3,1)
        setObjectCamera('caveTransition','hud')
        addLuaSprite('caveTransition',false)
    end
    for arbusts = 0,1 do
        makeLuaSprite('arbusts'..arbusts,'mario/MX/demise/1/Demise_BG_BG1',-3100*arbusts - 500,0)
        setProperty('arbusts'..arbusts..'.velocity.x',3200)
        addLuaSprite('arbusts'..arbusts)
        if haveCave then
            precacheImage('mario/MX/demise/2/Demise_BG2_BG'..(arbusts+1))
        end
    end
    if not lowQuality then
        for front = 0,1 do
            makeLuaSprite('front'..front,'mario/MX/demise/1/Demise_BG_Foreground'..(front+1),-3100*front - 500,300)
            setProperty('front'..front..'.velocity.x',5000)
            setScrollFactor('front'..front,1.2,1)
            addLuaSprite('front'..front,true)
            if haveCave then
                precacheImage('mario/MX/demise/2/Demise_BG2_Foreground'..(front+1))
            end
        end
    end
    if haveCave then
        swapStage(1)
    else
        swapStage(0)
    end
end
function onStartCountdown()
    if haveCave then
        swapStage(0)
    end
end
function swapStage(stage,removeStage)
    if stage == 0 then
        --setProperty('floor.visible',true)
        setProperty('floor.alpha',1)
        if removeStage then
            removeLuaSprite('topCave',true)
            removeLuaSprite('floorCave',true)
        else
            --setProperty('topCave.visible',false)
            --setProperty('floorCave.visible',false)
            setProperty('topCave.alpha',0.001)
            setProperty('floorCave.alpha',0.001)
        end
    else
        --setProperty('topCave.visible',true)
        --setProperty('floorCave.visible',true)
        setProperty('topCave.alpha',1)
        setProperty('floorCave.alpha',1)
        if removeStage then
            removeLuaSprite('floor',true)
        else
            --setProperty('floor.visible',false)
            setProperty('floor.alpha',0.001)
        end
    end
    for bgs = 0,1 do
        if stage == 0 then
            setProperty('foreground'..bgs..'.alpha',1)
            if not lowQuality then
                setProperty('bg'..bgs..'.alpha',1)
                if removeStage then
                    removeLuaSprite('bgCave'..bgs,true)
                    removeLuaSprite('foregroundCave'..bgs,true)
                else
                    --setProperty('bgCave'..bgs..'.visible',false)
                    --setProperty('foregroundCave'..bgs..'.visible',false)
                    setProperty('bgCave'..bgs..'.alpha',0.001)
                    setProperty('foregroundCave'..bgs..'.alpha',0.001)
                end

                loadGraphic('front'..bgs,'mario/MX/demise/1/Demise_BG_Foreground'..(bgs+1))
            else
                if removeStage then
                    removeLuaSprite('foregroundCave'..bgs,true)
                else
                    --setProperty('foregroundCave'..bgs..'.visible',false)
                    setProperty('foregroundCave'..bgs..'.alpha',0.001)
                end
            end


            --setProperty('foreground'..bgs..'.visible',true)
            --setProperty('bg'..bgs..'.visible',true)

            loadGraphic('arbusts'..bgs,'mario/MX/demise/1/Demise_BG_BG1')
            setObjectOrder('arbusts'..bgs,getObjectOrder('floor')+1)
            setProperty('arbusts'..bgs..'.y',0)

        elseif stage == 1 then
            if not lowQuality then
                if removeStage then
                    removeLuaSprite('foreground'..bgs,true)
                    removeLuaSprite('bg'..bgs,true)
                else
                    --setProperty('foreground'..bgs..'.visible',false)
                    --setProperty('bg'..bgs..'.visible',false)

                    setProperty('foreground'..bgs..'.alpha',0.001)
                    setProperty('bg'..bgs..'.alpha',0.001)
                end
                setProperty('bgCave'..bgs..'.alpha',1)
                loadGraphic('front'..bgs,'mario/MX/demise/2/Demise_BG2_Foreground'..(bgs+1))
            else
                if removeStage then
                    removeLuaSprite('foreground'..bgs,true)
                else
                    --setProperty('foreground'..bgs..'.visible',false)
                    setProperty('foreground'..bgs..'.alpha',0.001)
                end
            end
            setProperty('foregroundCave'..bgs..'.alpha',1)
            --setProperty('foregroundCave'..bgs..'.visible',true)

            loadGraphic('arbusts'..bgs,'mario/MX/demise/2/Demise_BG2_BG'..(bgs+1))
            setObjectOrder('arbusts'..bgs,getObjectOrder('floorCave')-1)
            setProperty('arbusts'..bgs..'.y',-1000)
        end
    end
    curStage = stage
end
function onCreatePost()
    setProperty('iconP2.flipX',true)
    setProperty('iconP1.flipX',true)
    setProperty('healthBar.flipX',false)
end
function onUpdate()
    if enableMove then
        setProperty('boyfriendGroup.x',(50*math.sin(getSongPosition()/bpm/2)))
        setProperty('dadGroup.x',1900 + (200*math.sin(getSongPosition()/bpm/4)))
    end
    for bgs = 0,1 do
        if getProperty('front'..bgs..'.x') >= 2600 then
            setProperty('front'..bgs..'.x',getProperty('front'..bgs..'.x') - (math.random(5000,5500)*2) + 5)
        end
        if getProperty('arbusts'..bgs..'.x') >= 2600 then
            setProperty('arbusts'..bgs..'.x',getProperty('arbusts'..bgs..'.x') - (3100*2) - 400)
        end
        if curStage == 0 then
            if getProperty('bg'..bgs..'.x') >= 2400 then
                setProperty('bg'..bgs..'.x',getProperty('bg'..bgs..'.x') - (2893*2) - 400)
            end
            if getProperty('foreground'..bgs..'.x') >= 2400 then
                setProperty('foreground'..bgs..'.x',getProperty('foreground'..bgs..'.x') - (4642*2) + 5)
            end
        elseif curStage == 1 then
            if getProperty('bgCave'..bgs..'.x') >= 2400 then
                setProperty('bgCave'..bgs..'.x',getProperty('bgCave'..bgs..'.x') - (5128*2) - 400)
            end
            if getProperty('foregroundCave'..bgs..'.x') >= 2600 then
                setProperty('foregroundCave'..bgs..'.x',getProperty('foregroundCave'..bgs..'.x') - (4304*2))
            end
        end

    end
end
function onTimerCompleted(tag)
    if tag == 'TransCave' then
        swapStage(1)
    elseif tag == 'TransWorld' then
        swapStage(0,true)
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Demise' then
        if v1 == '1' or v1 == '2' then
            setProperty('caveTransition.x',-2400)
            doTweenX('caveTrans','caveTransition',2400,1.4)
            if v1 == '1' then
                runTimer('TransCave',0.5)
            else
                runTimer('TransWorld',0.5)
            end
        elseif v1 == '3' then
            for bg = 0,1 do
                doTweenAlpha('arbusts'..bg..'Alpha','arbusts'..bg,0,1,'cubeOut')
                if not lowQuality then
                    doTweenAlpha('front'..bg..'Alpha','front'..bg,0,1,'cubeOut')
                end
                local bgs = ''
                if curStage == 1 then
                    bgs = 'Cave'..bg
                else
                    bgs = tostring(bg)
                end
                doTweenAlpha('bg'..bgs..'Alpha','bg'..bgs,0,0.25,'cubeOut')
                doTweenAlpha('foreground'..bgs..'Alpha','foreground'..bgs,0,0.25,'cubeOut')
            end
            if curStage == 0 then
                doTweenAlpha('floorAlpha','floor',0,0.25,'cubeOut')
            elseif curStage == 1 then
                doTweenAlpha('floorAlpha','floorCave',0,0.25,'cubeOut')
                doTweenAlpha('topAlpha','topCave',0,0.25,'cubeOut')
            end
            
            doTweenColor('flashColor','flashBG','FF0000',0.5,'cubeOut')
        elseif v1 == '4' then
            for bg = 0,1 do
                doTweenAlpha('arbusts'..bg..'Alpha','arbusts'..bg,1,1,'cubeOut')
                if not lowQuality then
                    doTweenAlpha('front'..bg..'Alpha','front'..bg,1,1,'cubeOut')
                end
                local bgs = ''
                if curStage == 1 then
                    bgs = 'Cave'..bg
                else
                    bgs = tostring(bg)
                end
                doTweenAlpha('bg'..bgs..'Alpha','bg'..bgs,1,1,'cubeOut')
                doTweenAlpha('foreground'..bgs..'Alpha','foreground'..bgs,1,1,'cubeOut')

            end
            
            if curStage == 0 then
                doTweenAlpha('floorAlpha','floor',1,1,'cubeOut')
            elseif curStage == 1 then
                doTweenAlpha('floorAlpha','floorCave',1,1,'cubeOut')
                doTweenAlpha('topAlpha','topCave',1,1,'cubeOut')
            end
            doTweenColor('flashColor','flashBG','000000',0.3,'cubeOut')
        elseif v1 == '5' then
            enableMove = false
            allowZoom = false
            doTweenAlpha('floorAlpha','floor',0,1,'cubeOut')
            for bg = 0,1 do
                doTweenAlpha('arbusts'..bg..'Alpha','arbusts'..bg,0,1,'cubeOut')
                doTweenAlpha('front'..bg..'Alpha','front'..bg,0,1,'cubeOut')
            end
        elseif v1 == '6' then
            doTweenAlpha('floorAlpha','floor',1,4,'cubeOut')
            for bg = 0,1 do
                doTweenAlpha('arbusts'..bg..'Alpha','arbusts'..bg,1,4,'cubeOut')
                doTweenAlpha('front'..bg..'Alpha','front'..bg,1,4,'cubeOut')
            end
        elseif v1 == '9' then
            allowZoom = true
            enableMove = true

        elseif v1 == '11' then
            allowBeat = not allowBeat
        end
    end
end
function onBeatHit()
    if allowBeat then
        setProperty('flashBG.color',getColorFromHex('660000'))
        doTweenColor('flashColor','flashBG','000000',stepCrochet*0.002,'cubeIn')
        triggerEvent('Add Camera Zoom','','')
    end
end
function onUpdatePost()
    setProperty('iconP1.offset.x',50)
    setProperty('iconP2.x',getProperty('healthBar.x') + getProperty('healthBar.width') - 150)
end
local curFocus = ''
function onMoveCamera(focus)
    if curFocus ~= focus and allowZoom then
        if focus == 'dad' then
            setProperty('defaultCamZoom',0.4)
        else
            setProperty('defaultCamZoom',0.7)
        end
        curFocus = focus
    end 
end
function onSongStart()
    if not middlescroll then
        for strums = 0,3 do
            setPropertyFromGroup('playerStrums',strums,'x',92 + (112*strums))
            setPropertyFromGroup('opponentStrums',strums,'x',732 + (112*strums))
        end
    end
end