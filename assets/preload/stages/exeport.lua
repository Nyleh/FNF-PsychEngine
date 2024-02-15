function onCreate()
    if shadersEnabled then
        addLuaScript('extra_scripts/createShader')
        callScript('extra_scripts/createShader','createShader',{'tvShader','TvEffect'})
        callScript('extra_scripts/createShader','runShader',{{'game','hud'},'tvShader'})
    end

    createExeStage(1)
    if songName == 'Powerdown' then
        createExeStage(0)
        setProperty('bg2.alpha',0.001)
        setProperty('floor.alpha',0.001)
        setProperty('arbust.alpha',0.001)
        setProperty('clould.alpha',0.001)
        setProperty('lgHead.alpha',0.001)
        setProperty('lgBody.alpha',0.001)
        setProperty('lgHead.alpha',0.001)
        setProperty('toad.alpha',0.001)
    end
end
--[[function onCreatePost()
    if songName == 'Powerdown' then
        removeLuaSprite('bg2',true)
        removeLuaSprite('floor',true)
        removeLuaSprite('lgHead',true)
        removeLuaSprite('lgBody',true)
    end
end]]--
function createExeStage(stage)
    if stage == 0 then
        --makeLuaSprite('bg','mario/MX/MXBG1_2_original',-1250,-1100)
        makeLuaSprite('bg','mario/MX/MXBG1_2',-500,630)
        addLuaSprite('bg')
    
        makeLuaSprite('light','mario/MX/MXBG1_3', -485, -1100)
        addLuaSprite('light',true)

        setProperty('dadGroup.x',100)
        setProperty('gfGroup.y',100)



    else
        makeLuaSprite('bg2','mario/MX/1',-1920,-1680)
        addLuaSprite('bg2')

        makeLuaSprite('floor','mario/MX/2',-1920,-1680)
        

        setProperty('dadGroup.x',-375)
        setProperty('gfGroup.y',-70)
        if not lowQuality then
            makeAnimatedLuaSprite('arbust','mario/MX/MX_BG_Assets_2',300,-320)
            setScrollFactor('arbust',0.8,0.8)
            addAnimationByPrefix('arbust','idle','BushIdle',24,true)
            addAnimationByPrefix('arbust','blink','BushBlink',24,true)
            addLuaSprite('arbust',false)

            makeAnimatedLuaSprite('clould','mario/MX/MX_BG_Assets_2',-400,-1230)
            setScrollFactor('clould',0.8,0.8)
            addAnimationByPrefix('clould','idle','Cloud')
            addLuaSprite('clould',false)

            addLuaSprite('floor')

            makeAnimatedLuaSprite('lgHead','mario/MX/MX_BG_Assets_1',1763,-170)
            addAnimationByPrefix('lgHead','static','LucasHead',24,false)
            addLuaSprite('lgHead',false)

            makeAnimatedLuaSprite('lgBody','mario/MX/MX_BG_Assets_1',1383,360)
            addAnimationByPrefix('lgBody','static','Lucasody',24,false)
            addLuaSprite('lgBody',false)

            makeAnimatedLuaSprite('toad','mario/MX/MX_BG_Assets_1',180,370)
            addAnimationByPrefix('toad','static','ToadBody',24,false)
            addLuaSprite('toad',false)
        else
            addLuaSprite('floor')
        end

        makeAnimatedLuaSprite('gfdead','mario/MX/MX_v2_Assets_gfdiesepico',-1700,700)
        addAnimationByPrefix('gfdead','dead','GFDieLoop',32,true)
        updateHitbox('gfdead')
        addLuaSprite('gfdead',true)
        if songName == 'Powerdown' then
            setProperty('gfdead.alpha',0.001)
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Powerdown' then
        if v1 == '4' and v2 == '1' then
            removeLuaSprite('bg',true)
            removeLuaSprite('light',true)
        elseif v1 == '5' then
            --createExeStage(1)
            setProperty('bg2.alpha',1)
            setProperty('floor.alpha',1)
            setProperty('arbust.alpha',1)
            setProperty('clould.alpha',1)
            setProperty('lgHead.alpha',1)
            setProperty('lgBody.alpha',1)
            setProperty('lgHead.alpha',1)
            setProperty('toad.alpha',1)
        end
    end
end
function onSectionHit()
    if songName == 'Powerdown' and curSection == 123 then
        setProperty('gfdead.alpha',1)
    end
end
function onBeatHit()
    if not lowQuality then
        playAnim('cloud','idle',true)
    end
end