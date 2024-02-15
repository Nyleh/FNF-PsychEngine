function onCreate()
    --[[makeLuaSprite('bg','mario/BadMario/lumpy',-155,-85)
    addLuaSprite('bg',false)
    scaleObject('bg',0.7,0.7)

    makeLuaSprite('couch','mario/BadMario/couch',-155,-85)
    addLuaSprite('couch',false)
    scaleObject('couch',0.7,0.7)

    makeLuaSprite('sideBar','mario/BadMario/sideBar',0,0)
    setScrollFactor('sideBar',0,0)
    setObjectCamera("sideBar",'hud')
    --addLuaSprite('sideBar',true)]]--
    
    makeLuaSprite('bg','mario/BadMario/lumpyCompleted',-155,-85)
    addLuaSprite('bg',false)
    scaleObject('bg',0.7,0.7)
    makeLuaSprite('poisonVG','mario/BadMario/poisonVG',0,0)
    setScrollFactor('poisonVG',0,0)
    setObjectCamera("poisonVG",'hud')
    --addLuaSprite('poisonVG',true)
end
local target = ''
function onMoveCamera(focus)
    if target~= focus then
        if focus == 'dad' then
            setProperty('defaultCamZoom',1.3)
        else
            setProperty('defaultCamZoom',1.1)
        end
        target = focus
    end
end