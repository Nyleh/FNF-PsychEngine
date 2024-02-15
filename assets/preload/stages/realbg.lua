function onCreate()

    addLuaScript('extra_scripts/extraCam')
    makeLuaSprite('sky','mario/lisfalse/Skybox',-400,-150)
    addLuaSprite('sky',false)

    

    makeLuaSprite('water','mario/lisfalse/Water',-400,-150)
    addLuaSprite('water',false)

    makeLuaSprite('eel','mario/lisfalse/Shaded_Mario_64_Eel',-8500,900)
    setScrollFactor('eel',0.8,0.8)
    addLuaSprite('eel',false)

    makeLuaSprite('bg','mario/lisfalse/Encima',-400,-150)
    addLuaSprite('bg',false)

    


    makeLuaSprite('aguaEstrella','mario/lisfalse/AguaEstrella',-450,-150)
    addLuaSprite('aguaEstrella',true)
    setObjectOrder('boyfriendGroup',getObjectOrder('aguaEstrella')+1)
    
    setObjectOrder('dadGroup',getObjectOrder('aguaEstrella')-1)

    makeLuaSprite('fog','modstuff/126')
    setObjectCamera('fog','other')
    addLuaSprite('fog',false)
end
function onCreatePost()
    callScript('extra_scripts/extraCam','insertObjectOnCam',{'fog'})
end
function onDestroy()
    runHaxeCode(
        [[
            FlxG.cameras.remove(game.camOther,false);
            FlxG.cameras.add(game.camOther,false);
            return;
        ]]
    )
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        if v1 == '1' or v1 == 'dad' then
            setProperty('dad.color',getColorFromHex('617A55'))
        end
    end
end
function onCreatePost()
    setProperty('dad.color',getColorFromHex('617A55'))

end
function onEvent(name,v1,v2)
    if name == 'Triggers Thalassophobia' then
        if v1 == '8' then
            doTweenX('eelX','eel',2000,10)
        end
    end
end

local curFocus = ''
function onMoveCamera(focus)
    if curFocus ~= focus then
        if focus == 'dad' then
            setProperty('defaultCamZoom',0.5)
        else
            setProperty('defaultCamZoom',0.6)
        end
        curFocus = focus
    end
end