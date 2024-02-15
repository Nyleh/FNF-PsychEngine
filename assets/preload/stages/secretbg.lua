function onCreate()
    makeLuaSprite('bg','mario/secret/SkyBox',-1300,-600)
    setScrollFactor('bg',0.4,0.4)
    addLuaSprite('bg',false)

    makeLuaSprite('trees','mario/secret/BackTrees',-1300,-600)
    setScrollFactor('trees',0.8,0.8)
    addLuaSprite('trees',false)

    
    makeLuaSprite('floor','mario/secret/WallAndFloor',-1300,-600)
    addLuaSprite('floor',false)
end