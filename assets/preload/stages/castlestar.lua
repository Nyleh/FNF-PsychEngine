function onCreate()
    makeLuaSprite('bg','mario/star/Cielo',-900,-930)
    setScrollFactor('bg',0.1,0.1)




    makeLuaSprite('castle3','mario/star/castillos delanteros',-1200,-930)
    setScrollFactor('castle3',0.4,0.4)
   

    makeLuaSprite('floor','mario/star/pUENTE',-900,-930)


    makeAnimatedLuaSprite('lgDead','mario/star/Powerstar_Mario_BG_Assets',-850,650)
    addAnimationByPrefix('lgDead','anim','Luigi',24,true)


    makeAnimatedLuaSprite('peachDead','mario/star/Powerstar_Mario_BG_Assets',1600,600)
    addAnimationByPrefix('peachDead','anim','Peach',24,true)


    addLuaSprite('bg',false)

    if not lowQuality then
        makeLuaSprite('castle','mario/star/castillos traseros',-1200,-930)
        setScrollFactor('castle',0.1,0.1)
        addLuaSprite('castle',false)
    
        makeLuaSprite('castle2','mario/star/castillos medio',-1200,-930)
        setScrollFactor('castle2',0.25,0.25)
        addLuaSprite('castle2',false)

            
        makeLuaSprite('front','mario/star/LADRILLOS',-1300,-1150)
        scaleObject('front',1.2,1.2)
        updateHitbox('front')
        setScrollFactor('front',1.5,1.5)
        addLuaSprite('front',true)
        
    end
    addLuaSprite('castle3',false)
    addLuaSprite('floor',false)

    addLuaSprite('lgDead',false)
    addLuaSprite('peachDead',false)
end