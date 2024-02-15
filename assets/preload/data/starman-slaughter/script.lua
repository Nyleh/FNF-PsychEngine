local koopaY = 1000

function onCreate()
    addLuaScript('extra_scripts/camLerp')
    addLuaScript('extra_scripts/extraCharacter')
    addLuaScript('extra_scripts/extraIcon')

    addCharacterToList('yoshi-exe','gf')



    makeAnimatedLuaSprite('PeachCutscene','characters/Peach_EXE_Cuts_New',getProperty('dadGroup.x') - 260,getProperty('dadGroup.y') - 300)
    addAnimationByPrefix('PeachCutscene','fly','PeachFalling1',24,true)
    addAnimationByPrefix('PeachCutscene','land','PeachFalling2',24,false)
    addAnimationByPrefix('PeachCutscene','dies','PeachDIES',24,false)
    addOffset('PeachCutscene','dies',150,50)
    playAnim('PeachCutscene','fly',true)
    setProperty('PeachCutscene.alpha',0.001)
    addLuaSprite('PeachCutscene',false)

end
function onCreatePost()
    extraIcon('addExtraIcon',{'gfIcon'})
    setProperty('gfIcon.offset.y',not downscroll and -500 or 500)

    setProperty('gf.x',810)
    setProperty('gf.y',1500)
    setObjectOrder('PeachCutscene',getObjectOrder('dadGroup')+2)
end
function extraCharacter(func,vars)
    callScript('extra_scripts/extraCharacter',func,vars)
end
function extraIcon(func,vars)
    callScript('extra_scripts/extraIcon',func,vars)
end
function onUpdate()
    if getSongPosition() > 61000 and getSongPosition() < 120000 then
        koopaY = koopaY + ((-200-koopaY)*0.1)
        setProperty('gf.x',700 - (100 * math.sin(getSongPosition()/700)),0.05)
        setProperty('gf.y',koopaY - (100 * math.cos(getSongPosition()/500)),0.05)
    end
    if getProperty('gf.curCharacter') == 'yoshi-exe' and getProperty('gf.animation.curAnim.name') == 'death' and getProperty('gf.animation.curAnim.finished') == true then
        callScript('scripts/global_functions','deleteGF',{true})
    end

end
function onUpdatePost()
    if getSongPosition() > 124000 then
        if luaSpriteExists('PeachCutscene') then
            if getProperty('PeachCutscene.animation.curAnim.finished') == true then
                setProperty('dad.visible',true)
                setProperty('PeachCutscene.visible',false)
            else
                setProperty('dad.visible',false)
            end
            if getProperty('PeachCutscene.animation.curAnim.name') == 'dies' and getProperty('PeachCutscene.animation.curAnim.curFrame') >= 65 then
                setProperty('PeachCutscene.visible',curStep % 4 <= 1)
                if getProperty('PeachCutscene.animation.curAnim.finished') == true then
                    removeLuaSprite('PeachCutscene',true)
                    setProperty('dad.visible',false)
                    removeFromMemory('characters/Peach_EXE_Cuts_New')
                end
            end
        end
    end
end
function onSectionHit()
    if curSection == 33 then
        doTweenY('gfIconY','gfIcon.offset',0,2,'cubeOut')
    end
end
function camLerp(a,b,c)
    callScript('extra_scripts/camLerp','setLerp',{a,b,c})
end
function onEvent(name,v1,v2)
    if name == 'Triggers Starman Slaughter' then
        if v1 == '0' then
            setCamPos('middlebfdadX','middlebfdadY-200')
        elseif v1 == '1' then
            setCamPos()
        elseif v1 == '4' then
            doTweenAlpha('gfIconAlpha','gfIcon',0,3,'cubeIn')
            doTweenX('gfX','gf',5000,3,'cubeIn')
        elseif v1 == '5' then
            setProperty('camZooming',false)
            setProperty('isCameraOnForcedPos',true)

            cancelTween('gfX')
            triggerEvent('Change Character','gf','yoshi-exe')
            setScrollFactor('gf',0.6,0.6)
            playAnim('gf','pow',true)

            setProperty('gf.specialAnim',true)

            callScript('scripts/cameraMoviment','doCamTween',{'dadX','dadY+500',1,'cubeOut'})
            characterPlayAnim('dad','xd',false)
            setProperty('dad.specialAnim',true)

            setProperty('defaultCamZoom',0.6)
            doTweenZoom('gameZoom','camGame',0.6,1.5,'cubeInOut')
            doTweenY('dadY','dad',getProperty('dad.y')+1500,1,'linear')
            
    
        elseif v1 == '6' then
            callScript('scripts/cameraMoviment','doCamTween',{nil,'bfY-300',2,'cubeInOut'})
            setProperty('dad.visible',false)
            setProperty('PeachCutscene.x',getProperty('PeachCutscene.x')-1200)
            setProperty('PeachCutscene.y',getProperty('PeachCutscene.y')-300)
            doTweenX('PeachX','PeachCutscene',getProperty('PeachCutscene.x')+1200,1.5,'backOut')
            doTweenY('PeachY','PeachCutscene',getProperty('PeachCutscene.y')+100,1.5,'sineOut')
            objectPlayAnimation('PeachCutscene','fly',true)
            setProperty('PeachCutscene.alpha',1)
            cancelTween('gfIconAlpha')
            setProperty('gfIcon.alpha',1)

            removeFromMemory('characters/SS_AltMario_Assets');
        elseif v1 == '7' then
            camLerp(0,1,0.0035)
            setProperty('isCameraOnForcedPos',false)
        
            
        elseif v1 == '10' then
            setProperty('isCameraOnForcedPos',true)
            callScript('scripts/cameraMoviment','doCamTween',{'dadX','dadY',3,'sineInOut'})
        elseif v1 == '11' then
            playAnim('PeachCutscene','dies',true)
            playAnim('gf','duro',true)
            setProperty('gf.specialAnim',true)
            setProperty('PeachCutscene.visible',true)

        elseif v1 == '11.5' then
            playAnim('gf','death',true)
            setProperty('gf.specialAnim',true)
            if not downscroll then
                doTweenY('gfIconY','gfIcon.offset',-400,2,'circIn')
            else
                doTweenY('gfIconY','gfIcon.offset',400,2,'circIn')
            end

        elseif v1 == '13' then
            cancelTween('gfIconY')
            extraIcon('removeExtraIcon',{'gfIcon',true})

            removeLuaScript('extra_scripts/extraCharacter')
            removeLuaScript('extra_scripts/extraIcon')
    
            setProperty('dad.x',getProperty('dad.x')-600)
            setProperty('dad.y',getProperty('dad.y')+300)
            doTweenX('marioJumpX','dad',getProperty('dad.x')+600,1,'linear')
            doTweenY('marioJumpY','dad',getProperty('dad.y')-1000,0.5,'sineOut')
            characterPlayAnim('dad','jump',true)
            setProperty('dad.specialAnim',true)
        elseif v1 == '14' then
            setProperty('isCameraOnForcedPos',false)

        elseif v1 == '16' then
            callScript('scripts/global_functions','hudAlpha',{0,stepCrochet*0.004,'cubeIn'})
            for strums = 0,3 do
                noteTweenAlpha('noteUniAlpha'..strums,strums,0,stepCrochet*0.004,'quintOut')
            end
        elseif v1 == '17' then
            cameraFlash('game','FF0000',2)
            cameraFade('game','000000',4)
            cameraFade('hud','000000',4)
        end
    end
end

function removeFromMemory(image)
    callOnHScript('removeFromMemory',{image})
end
function opponentNoteHit(id,data,type,sus)
    if type == 'GF Sing' then
        extraCharacter('extraCharacterAnim',{'koopa',getProperty('singAnimations['..data..']'),true})
        setProperty('koopa.holdTimer',0)
    end
    if type == 'Yoshi Note' or type == 'GF Duet' then
        playAnim('gf',getProperty('singAnimations['..data..']'),true)
        setProperty('gf.holdTimer',0)
    end
end
function onTweenCompleted(tag)
    if tag == 'koopaX' then
        extraCharacter('removeCharacter',{'koopa'})
    elseif tag == 'PeachX' then
        cancelTween('PeachY')
        doTweenY('PeachYLand','PeachCutscene',getProperty('dadGroup.y')-320 ,1,'cubeIn')
    elseif tag == 'PeachYLand' then
        playAnim('PeachCutscene','land',false)
    elseif tag == 'marioJumpY' then
        doTweenY('marioFallY','dad',getProperty('dad.y')+700,0.4,'circIn')
        characterPlayAnim('dad','fall',true)
        setProperty('dad.specialAnim',true)
    end
end
function setCamPos(x,y,target)
    callScript('scripts/cameraMoviment','setCamPos',{x,y,target})
end
--[[
    

-- local xx = 550;
-- local yy = 250;
-- local yyh = 350;
-- local xx2 = 1550;
-- local yy2 = 500;
-- local ofs = 30;
-- local ofs2 = 120;
-- local followchars = true;
-- local zoomchars = false;
-- local del = 0;
-- local del2 = 0;
-- local bfzoom =  0.5;
-- local dadzoom = 0.5;
-- local whosdad = 'dad'
function onBeatHit()
    if curBeat >= 36 and curBeat <= 96 then
       triggerEvent('Add Camera Zoom','0.02','0.02')
    end
    if curBeat == 96 then
        xx2 = 1050
    end
    if curBeat == 100 then
        xx2 = 1550
    end

   if curBeat >= 100 and curBeat <= 132 then
        triggerEvent('Add Camera Zoom','0.02','0.02')
    end

    if curBeat >= 196 and curBeat <= 260 then
        if curBeat %2 == 0 then
        triggerEvent('Add Camera Zoom','0.02','0.02')
        end
    end
    if curBeat == 132 then
        zoomchars = true
        xx = 850
        dadzoom = 0.7
        whosdad = 'gf'
    end

    if curBeat == 196 then
        xx = 550
        dadzoom = 0.5
        whosdad = 'dad'
    end

    if curBeat == 262 then
        bfzoom = 0.7
        dadzoom = 0.7
        yy = 800
        setProperty('defaultCamZoom', 0.7)
        doTweenZoom('tag', 'camGame', 0.7, 1, 'expoOut')
    end
    if curBeat == 269 then
        followchars = false
        doTweenX('tag1', 'camFollowPos', 1550, 1.38, 'expoIn')
        doTweenY('tag2', 'camFollowPos', 800, 1.38, 'expoIn')
        bfzoom = 0.7

    end

    if curBeat == 272 then
        followchars = true
        dadzoom = 0.6
        yy = 250
    end

    if curBeat == 336 then
        dadzoom = 0.5
        bfzoom = 0.5
        setProperty('defaultCamZoom', 0.5)
    end

    if curBeat == 396 then
        dadzoom = 0.6
        bfzoom = 0.6
        xx2 = 1200
        setProperty('defaultCamZoom', 0.6)
        triggerEvent('Play Animation', 'death', 'gf');
    end

    if curBeat == 404 then
        bfzoom = 0.8
        xx2 = 1550
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 406 then
        bfzoom = 0.9
        xx2 = 1650
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 408 then
        bfzoom = 0.7
        xx2 = 1550
        setProperty('defaultCamZoom', 0.6)
    end

    if curBeat == 444 then
        bfzoom = 0.5
        dadzoom = 0.5
        setProperty('defaultCamZoom', 0.5)
    end

    if curBeat == 512 then
        doTweenX('tag1', 'camFollowPos', 550, 1, 'expoOut')
        doTweenY('tag2', 'camFollowPos', 250, 1, 'expoOut')
    end

    if curBeat == 514 then
        setProperty('defaultCamZoom', 0.7)
        doTweenZoom('tagend', 'camGame', 0.7, 3, 'linear')
    end
end]]