function onCreate()

    if songName == 'Abandoned' then
        makeLuaSprite('bg64','mario/abandoned/fondo',-800,-600)
        scaleObject('bg64',1.5,1.5)
        addLuaSprite('bg64',false)

        
        makeLuaSprite('middle64','mario/abandoned/atras',-800,-600)
        scaleObject('middle64',1.5,1.5)
        addLuaSprite('middle64',false)

        makeLuaSprite('front64','mario/abandoned/adelante',-800,-600)
        scaleObject('front64',1.5,1.5)
        addLuaSprite('front64',false)
    end
    makeLuaSprite('bg','mario/abandoned/Wall and buildings',-800,-620)
    scaleObject('bg',0.75,0.75)
    updateHitbox('bg')
    addLuaSprite('bg',false)
    
    makeLuaSprite('middle','mario/abandoned/Middle',-800,-620)
    scaleObject('middle',0.75,0.75)
    updateHitbox('middle')
    addLuaSprite('middle',false)

    makeLuaSprite('front','mario/abandoned/Front BG',-800,-620)
    scaleObject('front',0.75,0.75)
    updateHitbox('front')
    addLuaSprite('front',false)

    addLuaScript('extra_scripts/createShader')
    callScript('extra_scripts/createShader','createShader',{'tvShader','TvEffect'})

    --Used on data/abandoned/script
    --callScript('extra_scripts/createShader','runShader',{{'game','hud'},'tvShader'})

    callScript('extra_scripts/createShader','runShader',{{'hud'},'tvShader'})

    setShaderFloat('tvShader','multiply',1.5)
    setShaderFloat('tvShader','contrast',-0.1)
    --setShaderFloat('tvShader','vignetteIntensity',0)
    setShaderBool('tvShader','lineTv',true)
    setShaderBool('tvShader','vignetteFollowAlpha',false)
end
local focusC = ''
local state = ''
function onEvent(name,v1,v2)
    if name == 'Triggers Universal' then
        if v1 == '10' then
            cancelTween('frontAlpha')
            removeLuaSprite('bg',true)
            removeLuaSprite('middle',true)
            removeLuaSprite('front',true)
            state = '64'
        end
    end
end
function onMoveCamera(focus)
    if focusC ~= focus then
        local zoom = 1.2
        local frontAlpha = 0
        if focus == 'boyfriend' then
            frontAlpha = 1
            zoom = 0.7
        end
        setProperty('defaultCamZoom',zoom)
        doTweenAlpha('frontAlpha',state ~= '64' and 'front' or 'front64',frontAlpha,stepCrochet*0.005,'cubeOut')
        doTweenAlpha('bfAlpha','boyfriend',frontAlpha,stepCrochet*0.005,'cubeOut')
        focusC = focus
    end
end