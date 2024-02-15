function onCreate()
    if shadersEnabled then
        addLuaScript('extra_scripts/createShader')
        callScript('extra_scripts/createShader','createShader',{'tvShader','TvEffect'})
        callScript('extra_scripts/createShader','runShader',{{'game','hud'},'tvShader'})
        setShaderFloat('tvShader','multiply',1.3)
        setShaderFloat('tvShader','contrast',-0.05)
        setShaderBool('tvShader','lineTv',true)
        setShaderBool('tvShader','whiteSpotches',true)
    end
    makeLuaSprite('bg','mario/costume/PedacitoDeGris',-1200,-770)
    setScrollFactor('bg',0.5,1)
    addLuaSprite('bg',false)

    makeLuaSprite('floor','mario/costume/Floor and Courtains',-1200,-770)
    addLuaSprite('floor',false)

    makeLuaSprite('table','mario/costume/mesa mesa mesa que mas aplauda',-1200,-770)
    addLuaSprite('table',false)

    makeLuaSprite('lamp','mario/costume/Lamp',-1200,-770)
    addLuaSprite('lamp',true)

    
    makeLuaSprite('front','mario/costume/Foreground',-1400,-300)
    setScrollFactor('front',1.4,1.4)
    addLuaSprite('front',true)

    if version > '0.6.3' then
        setPropertyFromClass('states.PlayState','SONG.arrowSkin','noteSkins/NoteEND_assets')
        setPropertyFromClass('states.PlayState','SONG.splashSkin','noteSplashes/noteSplashes-END')
    else
        setPropertyFromClass('PlayState','SONG.arrowSkin','noteSkins/NoteEND_assets')
        setPropertyFromClass('PlayState','SONG.splashSkin','noteSplashes/noteSplashes-END')
    end
    precacheImage('noteSplashes/noteSplashes-END')
end
function onDestroy()
    if version > '0.6.3' then
        setPropertyFromClass('states.PlayState','SONG.arrowSkin','')
        setPropertyFromClass('states.PlayState','SONG.splashSkin','')
        setPropertyFromClass('states.PlayState','SONG.disableNoteRGB',false)
    else
        setPropertyFromClass('PlayState','SONG.arrowSkin','')
        setPropertyFromClass('PlayState','SONG.splashSkin','')
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers The End' and v1 == '9' then
        removeLuaSprite('bg',true)
        removeLuaSprite('floor',true)
        removeLuaSprite('table',true)
        removeLuaSprite('lamp',true)
        removeLuaSprite('front',true)
    end
end