function onCreate()
    makeLuaSprite('luigiJumpscare','mario/IHY/image',0,0)
    setObjectCamera('luigiJumpscare','other')
    setProperty('luigiJumpscare.alpha',0.001)
    addLuaSprite('luigiJumpscare',true)
    precacheSound('CAUSA')
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'jumpscareM' then
            setPropertyFromGroup('unspawnNotes',i,'texture','JMMario_NOTE_assets')
            --setPropertyFromGroup('unspawnNotes',i,'ignoreNote',true)
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'jumpscareM' then
        scaleObject('luigiJumpscare',1,1)
        doTweenX('jumpscareScaleX','luigiJumpscare.scale',1.3,0.3,'backOut')
        doTweenY('jumpscareScaleY','luigiJumpscare.scale',1.3,0.3,'backOut')
        setProperty('luigiJumpscare.alpha',1)
        --cameraShake('other',0.01,0.5)
        doTweenAlpha('luigiJumps','luigiJumpscare',0,2,'cubeOut')
        playSound('CAUSA',1)
    end
end