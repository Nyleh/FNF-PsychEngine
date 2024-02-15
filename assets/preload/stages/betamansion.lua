function onCreate()

    if not lowQuality then
        makeLuaSprite('sky','mario/LuigiBeta/BackBG',-1200,-850)
        setScrollFactor('sky',0.2,0.2)
        addLuaSprite('sky',false)
    end

    makeLuaSprite('bg','mario/LuigiBeta/BackBG',-1200,-850)
    setScrollFactor('bg',0.8,0.8)
    addLuaSprite('bg',false)

        
    makeAnimatedLuaSprite('fireLeft','mario/LuigiBeta/Alone_Fire',-320,-625)
    addAnimationByPrefix('fireLeft','anim','fire',24,true)
    addLuaSprite('fireLeft',false)

    makeAnimatedLuaSprite('fireRight','mario/LuigiBeta/Alone_Fire',1270,-625)
    addAnimationByPrefix('fireRight','anim','fire',24,true)
    addLuaSprite('fireRight',false)
    
    makeLuaSprite('bgFront','mario/LuigiBeta/FrontBG',-1200,-850)
    addLuaSprite('bgFront',false)



    makeAnimatedLuaSprite('rain','mario/LuigiBeta/old/Beta_Luigi_Rain_V1',-600,-400)
    addAnimationByPrefix('rain','anim','RainLuigi',24,true)
    setScrollFactor('rain',0,0)
    scaleObject('rain',2,2.2)
    addLuaSprite('rain',true)



    makeLuaSprite('blackBarThingie',nil,-250,-250)
    makeGraphic('blackBarThingie',screenWidth+500,screenHeight+500,'000000')
    setObjectCamera('blackBarThingie','hud')
    setProperty('blackBarThingie.alpha',0.5)
    addLuaSprite('blackBarThingie',false)

    makeLuaSprite('vignette','modstuff/126',0,0)
    setScrollFactor('vignette',0,0)
    setObjectCamera("vignette",'hud')
    addLuaSprite('vignette',true)

    addLuaScript('extra_scripts/extraCam')
    callScript('extra_scripts/extraCam','insertObjectOnCam',{'vignette'})
    removeLuaScript('extra_scripts/extraCam')
end