function onCreate()
    createLand('normal')
    addLuaScript('extra_scripts/createShader')
    callScript('extra_scripts/createShader','createShader',{'tvShader','TvEffect'})
    callScript('extra_scripts/createShader','runShader',{{'game','hud'},'tvShader'})
    setShaderFloat('tvShader','chromIntensity',0)
    setShaderFloat('tvShader','tvIntensity',0)
    setShaderFloat('tvShader','contrast',-0.15)
    if songName == 'Golden Land' then
        for land = 1,4 do
            precacheImage('mario/EXE2/bad/'..land)
        end
    end
    if version > '0.6.3' then
        setPropertyFromClass('states.PlayState','SONG.arrowSkin','noteSkins/GB_NOTE_assets')
        setPropertyFromClass('states.PlayState','SONG.splashSkin','noteSplashes/noteSplashes-land')
    else
        setPropertyFromClass('PlayState','SONG.arrowSkin','noteSkins/GB_NOTE_assets')
        setPropertyFromClass('PlayState','SONG.splashSkin','noteSplashes/noteSplashes-land')
    end
    precacheImage('noteSplashes/noteSplashes-land')
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
function onSectionHit()
    if songName == 'Golden Land' and curSection == 28 then
        createLand('bad')
    end
end
function createLand(from)
    makeLuaSprite('bg','mario/EXE2/'..from..'/4',-500,-220)
    setScrollFactor('bg',0.5,0.5)
    scaleObject('bg',6,6)
    setProperty('bg.antialiasing',false)
    addLuaSprite('bg',false)

    makeLuaSprite('dirt','mario/EXE2/'..from..'/3',-500,-220)
    setScrollFactor('dirt',0.6,0.6)
    scaleObject('dirt',6,6)
    setProperty('dirt.antialiasing',false)
    addLuaSprite('dirt',false)

    makeLuaSprite('landground','mario/EXE2/'..from..'/2',-470,-220)
    scaleObject('landground',6,6)
    setProperty('landground.antialiasing',false)
    addLuaSprite('landground',false)
    if songName == 'Golden Land' then
        setObjectOrder('landground',getObjectOrder('gfGroup'))
    end

    makeLuaSprite('platform','mario/EXE2/'..from..'/1',-500,-450)
    scaleObject('platform',6,6)
    setScrollFactor('platform',1.1,1.1)
    setProperty('platform.antialiasing',false)
    addLuaSprite('platform',true)
end