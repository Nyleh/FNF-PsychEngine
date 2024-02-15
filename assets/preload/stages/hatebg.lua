local lavaParticles = 0
local enableLava = true

function onCreate()
    addLuaScript('extra_scripts/spriteScroll')
    makeLuaSprite('bg','mario/IHY/Ladrillos y ventanas',-1500,-800)
    addLuaSprite('bg',false)
    setScrollFactor('bg',0.8,0.8)

    if songName == 'Oh God No' then
        addLuaScript('extra_scripts/flipHealthBar')
        makeLuaSprite('ground','mario/IHY/PuenteCompleto',-1500,-700)

        for fires = 0,3 do
            makeAnimatedLuaSprite('fireBG'..fires,'mario/IHY/OGN_Fireball',0,-1200)
            addAnimationByPrefix('fireBG'..fires,'anim','flame',24,true)
            if fires >= 2 then
                setScrollFactor('fireBG'..fires,0.6,0.6)
                scaleObject('fireBG'..fires,0.5,0.5)
                addLuaSprite('fireBG'..fires,false)
            else
                setScrollFactor('fireBG'..fires,1.5,1.5)
                addLuaSprite('fireBG'..fires,true)
            end
        end
        
    else
        makeLuaSprite('ground','mario/IHY/Puente Roto',-1500,-700)
    end
    addLuaSprite('ground',false)

    if songName == 'I Hate You' then
        local ghostPos = {{-200,233},{1200,133},{1150,333}}
        for ghosts = 0,2 do
            makeAnimatedLuaSprite('ghostHy'..ghosts,'mario/IHY/Luigi_HY_BG_Assetss',100 + ghostPos[ghosts+1][1],ghostPos[ghosts+1][2])
            addAnimationByPrefix('ghostHy'..ghosts,'idle','GhostIdle',24,true)
            setProperty('ghostHy'..ghosts..'.alpha',0.001)
            addLuaSprite('ghostHy'..ghosts,false)
        end
        for marios = 0,1 do
            makeAnimatedLuaSprite('blueMario'..marios,'mario/IHY/Luigi_HY_BG_Assetss',100 + (1260*marios),352)
            addAnimationByPrefix('blueMario'..marios,'intro','MarioIntro',24,false)
            addAnimationByPrefix('blueMario'..marios,'idle','MarioIdle',24,false)
            setProperty('blueMario'..marios..'.alpha',0.001)
            addLuaSprite('blueMario'..marios,false)
        end
    end

    makeLuaSprite('lavaLight','mario/IHY/asset_deg',0,0)
    scaleObject('lavaLight',1.8,2.3)
    setScrollFactor('lavaLight',0,0)
    addLuaSprite('lavaLight',true)
    if not lowQuality then
        lavaParticles = 25
        for particles = 0,lavaParticles do
            local name = 'lavaParticle'..particles
            makeLuaSprite(name,'modstuff/lavaparticle',0,0)
            --setObjectCamera(name,'hud')
            scaleObject(name,1.2,1.2)
            setScrollFactor(name,0,0)
            setBlendMode(name,'add')
            addLuaSprite(name,true)
            setLavaParticle(particles)
        end
    end
end
function onCreatePost()
    if songName == 'Oh God No' then
        callScript('extra_scripts/flipHealthBar','setFlip',{true})
    end
    if songName == 'Oh God No' then
        local dadX = getProperty('dadGroup.x')
        setProperty('dadGroup.x',getProperty('boyfriendGroup.x') - 100)
        setProperty('boyfriendGroup.x',dadX + 250)
    end
end
function onBeatHit()
    if curBeat % 2 == 0 then
        for marios = 0,1 do
            if luaSpriteExists('blueMario'..marios) and getProperty('blueMario'..marios..'.animation.curAnim.finished') or getProperty('blueMario'..marios..'.animation.curAnim.name') == 'idle' then
                playAnim('blueMario'..marios,'idle',true)
            end
        end
    end
end
function onUpdate(elap)
    if enableLava then
        setProperty('lavaLight.alpha',0.7 - (math.cos(getSongPosition()/200)*0.2))
        local scale = math.max(1,2 - (getProperty('camGame.zoom'))/2)

        setProperty('lavaLight.x',-400*scale)
        setProperty('lavaLight.y',-200*scale - 100)
        scaleObject('lavaLight',scale*2.5,scale*3)
    end
end

function setLavaParticle(id)
    local name = 'lavaParticle'..tostring(id)
    local scale = 4
    if scale < 1.1 then
        setObjectOrder(name,getObjectOrder('ground'))
    else
        setObjectOrder(name,getObjectOrder('boyfriendGroup')+5)
    end
    if enableLava then
        setProperty(name..'.alpha',1)
    end
    local offset = getProperty('camGame.zoom')*2/0.7
    --scaleObject(name,scale,scale)
    setProperty(name..'.x',getRandomInt(-200*offset*2,screenWidth + (200*offset*2)))
    setProperty(name..'.y',screenHeight + (200*offset) + getRandomInt(-50,100))
    setProperty(name..'.velocity.y',math.random(-100,-300))
    doTweenAlpha(name..'Alpha',name,0,math.random(2,5),'expoIn')
end

function onTweenCompleted(tag)
    if string.find(tag,'lavaParticle',0,true) then
        setLavaParticle(string.sub(tag,13,string.len(tag)-5))
    elseif string.find(tag,'fireBGY',0,true) then
        bigFireGoDown(string.gsub(tag,'fireBGY',''))
    end
end
function getIHstage()
    local stageObjects = {'bg','ground','lavaLight'}
    if not lowQuality and lavaParticles > 0 then
        for lava = 0,lavaParticles do
            cancelTween('lavaParticle'..lava..'.Alpha')
            table.insert(stageObjects,'lavaParticle'..lava)
        end
    end
    return stageObjects
end

function onEvent(name,v1,v2)
    if name == "Triggers Oh God No" then
        if v1 == '0' then
            doTweenX('fill','fillVar',0,1,'sineOut')
            enableLava = false
            for i, stages in pairs(getIHstage()) do
                doTweenAlpha(stages..'Alpha',stages,0,1,'sineOut')
            end
        elseif v1 == '1' then
            doTweenAlpha('gfAlpha','gf',0.4,10,'linear')
        elseif v1 == '2' then
            cancelTween('gfAlpha')
            enableLava = true
            doTweenX('fill','fillVar',1,1,'sineOut')
            for i, stages in pairs(getIHstage()) do
                doTweenAlpha(stages..'Alpha',stages,1,2,'expoOut')
            end
            doTweenAlpha('gfAlphaExit','gf',0,1,'linear')
        elseif v1 == '5' then
            runTimer('fireBGdown0',5)
            runTimer('fireBGdown1',7)
            runTimer('fireBGdown2',8)
            runTimer('fireBGdown3',1)
        end
    elseif name == 'Triggers I Hate You' then
        if v1 == '0' then
            local ghostsAlphaTime = {0.6,0.5,0.8}
            for ghosts = 0,2 do
                doTweenAlpha('ghostAlpha'..ghosts,'ghostHy'..ghosts,1,ghostsAlphaTime[ghosts+1],'quadOut')
                doTweenX('ghostX'..ghosts,'ghostHy'..ghosts,getProperty('ghostHy'..ghosts..'.x') + 100,ghostsAlphaTime[ghosts+1],'quadOut')
            end
        elseif v1 == '2' then
            setProperty('blueMario0.alpha',1)
            playAnim('blueMario0','intro',true)
        elseif v1 == '3' then
            setProperty('blueMario1.alpha',1)
            playAnim('blueMario1','intro',true)
        end
    end
end

function bigFireGoDown(id)

    id = tonumber(id)
    local firePos = {-900,230,-900,230}
    setProperty('fireBG'..id..'.x',getRandomInt(firePos[id+1],firePos[id+1]+1130))
    setProperty('fireBG'..id..'.y',-1200)
    if id >= 2 then
        doTweenY('fireBGY'..id,'fireBG'..id,1000,4)
    else
        doTweenY('fireBGY'..id,'fireBG'..id,1000,5)
    end
end

function onTimerCompleted(tag)
    if string.find(tag,'fireBG',0,true) then
        bigFireGoDown(string.gsub(tag,'fireBGdown',''))
    end
end