function onCreate()
    makeLuaSprite('tressThirdBG','mario/Turmoil/ThirdBGTrees',-1300,-750)
    setScrollFactor('tressThirdBG',0.6,0.6)
    addLuaSprite('tressThirdBG',false)

    makeLuaSprite('tressBG','mario/Turmoil/SecondBGTrees',-1300,-750)
    setScrollFactor('tressBG',0.8,0.8)
    addLuaSprite('tressBG',false)


    makeLuaSprite('floor','mario/Turmoil/MainFloorAndTrees',-1300,-750)
    addLuaSprite('floor',false)


    makeLuaSprite('vignette','modstuff/126',0,0)
    setObjectCamera('vignette','hud')
    addLuaSprite('vignette',false)

end
function onCreatePost()
    setObjectOrder('dad',getObjectOrder('boyfriendGroup')+1)
end
