local startWidth = 0
local startHeight = 0

local windowWidth = 0

local playstate = 'states.PlayState'
local clientState = 'backend.ClientPrefs'
local enableResize = false

local scoreZoomEnabled = false
function onCreate()
    if version < '0.7' then
        playstate = 'PlayState'
        clientState = 'ClientPrefs'
    end
    scoreZoomEnabled = getPropertyFromClass(clientState,'scoreZoom')

    setPropertyFromClass(clientState,'scoreZoom',false)
    setPropertyFromClass(playstate,'SONG.arrowSkin','noteSkins/DS_NOTE_assets')
    setPropertyFromClass(playstate,'SONG.splashSkin','noteSplashes/noteSplashes-piracy')

    precacheImage('noteSplashes/noteSplashes-piracy')
    
    if enableResize then
        windowWidth = math.floor(screenHeight/1.44)

        addHaxeLibrary('Lib','openfl')
        startWidth = getPropertyFromClass('openfl.Lib','application.window.width')
        startHeight = getPropertyFromClass('openfl.Lib','application.window.height')

        runHaxeCode(
            [[ 
                var setWidth = ]]..windowWidth..[[;
                FlxG.width = setWidth;
                Lib.application.window.width = setWidth;
                FlxG.stage.stageWidth = setWidth;
                return;
            ]]
        )
    end
    for bgs = 0,1 do
        makeLuaSprite('bgbottom'..bgs,'mario/piracy/bgbottom',120 - (248*2*bgs),not downscroll and 0 or screenHeight/2)
        scaleObject('bgbottom'..bgs,1.95,1.95)
        addLuaSprite('bgbottom'..bgs,false)
        setObjectCamera('bgbottom'..bgs,'hud')
        setProperty('bgbottom'..bgs..'.velocity.x',100)

        makeLuaSprite('bfBG'..bgs,'mario/piracy/HallyBG4',0,-296*1.4*bgs)
        scaleObject('bfBG'..bgs,1.4,1.4)
        setProperty('bfBG'..bgs..'.velocity.y',50)
        addLuaSprite('bfBG'..bgs,false)
    end

    makeLuaSprite('dadBG','mario/piracy/HallyBG2',0,0)
    setObjectCamera('dadBG','hud')
    scaleObject('dadBG',1.6,1.6)
    updateHitbox('dadBG')
    setScrollFactor('dadBG',0,0)
    addLuaSprite('dadBG',false)




    if not lowQuality then
        makeLuaSprite('bgGradiant','mario/piracy/HallyBG3')
        scaleObject('bgGradiant',1,2)
        setProperty('bgGradiant.alpha',0.9)
        addLuaSprite('bgGradiant',false)
    end

    if songName == 'No Party' then
        makeLuaSprite('bfSpotLight','mario/piracy/bfspotlight',-250,0)
        scaleObject('bfSpotLight',1,1.5)
        setProperty('bfSpotLight.alpha',0.001)
        addLuaSprite('bfSpotLight',true)
    end
    
    makeLuaSprite('bgGrad','mario/piracy/HallyBG1',-270,0)
    scaleObject('bgGrad',1.5,1.5)

    addLuaSprite('bgGrad',false)

    makeLuaSprite('bfBar','mario/piracy/bar',10,300)
    scaleObject('bfBar',1.95,1.95)
    addLuaSprite('bfBar',true)
    setObjectCamera('bfBar','hud')

    makeLuaSprite('dadBar','mario/piracy/bar',10,300)
    scaleObject('dadBar',1.95,1.95)
    addLuaSprite('dadBar',true)
    setObjectCamera('dadBar','hud')
    

    --loadGraphic('dadBar','mario/piracy/bar',getProperty('bfBar.width'),getProperty('bfBar.height'))

    --Unused, is recrated on runHaxeCode.
    setProperty('dadBar.y',screenHeight/2 + (not downscroll and -35 or 25))
    setProperty('bfBar.y',getProperty('dadBar.y'))




end
function onEvent(name,v1,v2)
    if name == 'Triggers No Party' then
        if(v1 == '0') then
            runHaxeCode(
                [[
                    getVar('dadCamera').fade(0xFF000000,4);
                    return;
                ]]
            )
            doTweenZoom('dadCameraZoom','dadCamera',1.3,10,'quadInOut')

            doTweenX('bfCamX','boyfriendCamera.scroll',0,10,'quadInOut')
            doTweenZoom('bfCamZoom','boyfriendCamera',1.2,10,'quadInOut')
            doTweenAlpha('bfSpotAlpha','bfSpotLight',1,10,'quadInOut')
        elseif(v1 == "1") then
            runHaxeCode(
                [[
                    getVar('boyfriendCamera').fade(0xFF000000,1.5);
                    return;
                ]]
            )
        elseif (v1 == '2') then
            cancelTween('dadCameraZoom');
            cancelTween('dadCameraAlpha');
            cancelTween('bfLight');
            cancelTween('bfSpotLight');
            cancelTween('bfCamAlpha');

            setProperty('dadCamera.x',getProperty('camHUD.x'))
            doTweenX('bfCamX','boyfriendCamera.scroll',0,1,'quadOut')
            doTweenZoom('bfCamZoom','boyfriendCamera',1,1,'quadOut')

            removeLuaSprite('bfSpotLight',true)
            runHaxeCode(
                [[
                    game.modchartTweens.set('dadCameraZoom',FlxTween.tween(getVar('dadCamera'),{zoom: 1},1,{ease: FlxEase.quadInOut}));
                    game.modchartTweens.set('bfCameraTween',FlxTween.tween(getVar('boyfriendCamera'),{zoom: 1},1,{ease: FlxEase.quadOut}));
                    game.modchartTweens.set('bfCameraScrollTween',FlxTween.tween(getVar('boyfriendCamera').scroll,{x: 0},1,{ease: FlxEase.quadOut}));
        
                    getVar('boyfriendCamera').fade(0xFFFFFFFF,0.5,true,null,true);
                    getVar('dadCamera').fade(0xFFFFFFFF,0.5,true,null,true);
                ]]
            )

        end
    end
end

local hp = 0
function updateDadBar()
    loadGraphic('dadBar','mario/piracy/bar',math.max(1,256*(1 - (hp/2))));
    updateHitbox('dadBar')
end
 
function lerp(a,b,c)
    return a + ((b-a)*c)
end

function onUpdatePost()
    if hp ~= getHealth() then
        hp = math.min(2,getHealth())
        updateDadBar()
    end
    local anim = getProperty('dad.animation.curAnim.name')
    local ofsX = 0
    local ofsY = 0
    if stringStartsWith(anim,'singLEFT') then
        ofsX = -15
    elseif stringStartsWith(anim,'singDOWN') then
        ofsY = 15
    elseif stringStartsWith(anim,'singUP') then
        ofsY = -15
    elseif stringStartsWith(anim,'singRIGHT') then
        ofsX = 15
    end
    setProperty('dadCamera.scroll.x',lerp(getProperty('dadCamera.scroll.x'),ofsX,0.05))
    setProperty('dadCamera.scroll.y',lerp(getProperty('dadCamera.scroll.y'),ofsY,0.05))

    if getProperty('bfBG0.y') >= 400 then
        setProperty('bfBG0.y',getProperty('bfBG0.y')-(getProperty('bfBG0.height')))
        setProperty('bfBG1.y',getProperty('bfBG0.y')-(getProperty('bfBG1.height')))
    end
    if getProperty('bgbottom0.x') >= getProperty('bgbottom0.width') then
        setProperty('bgbottom0.x',getProperty('bgbottom0.x')-(getProperty('bgbottom0.width')))
        setProperty('bgbottom1.x',getProperty('bgbottom0.x')-(getProperty('bgbottom1.width')))
    end
    if enableResize and (getPropertyFromClass('flixel.FlxG','width') ~= windowWidth or getPropertyFromClass('flixel.FlxG','height') ~= startHeight) then
        runHaxeCode(
            [[
                FlxG.width = 490;
                FlxG.height = 720;
                FlxG.scaleMode.gameSize.x = 1280;
                FlxG.scaleMode.gameSize.y = 720;
                FlxG.scaleMode.deviceSize = FlxG.scaleMode.gameSize;
                return;
            ]]
        )
    end
end

function updateBarColor()
    setProperty('dadBar.color',rgbToHex(getProperty('dad.healthColorArray')))
    setProperty('bfBar.color',rgbToHex(getProperty('boyfriend.healthColorArray')))
end

function rgbToHex(array)
	return getColorFromHex(string.format('%.2x%.2x%.2x', array[1], array[2], array[3]))
end

function resizeWindow()
    runHaxeCode(
        [[
            
            FlxG.resizeGame(]]..screenWidth..','..screenHeight..[[);
            ]]..enableResize and 'FlxG.resizeWindow('..startWidth..','..startHeight..');' or ''..[[

            FlxG.width = ]]..screenWidth..[[;
            return;
        ]]
    )
end

function onDestroy()
    if enableResize then
        resizeWindow()
    end
    setPropertyFromClass(clientState,'scoreZoom',scoreZoomEnabled)
    setPropertyFromClass(playstate,'SONG.arrowSkin','')
    setPropertyFromClass(playstate,'SONG.splashSkin','')
end

function onCreatePost()
    updateBarColor()
    setupCamera()

    setProperty('healthBar.visible',false)
    setProperty('timeBar.visible',false)
    setProperty('timeTxt.visible',false)
    setProperty('iconP1.visible',false)
    setProperty('iconP2.visible',false)

    setTextAlignment('scoreTxt','left')
    setProperty('scoreTxt.x',0)
    setProperty('scoreTxt.y',screenHeight/2 + (not downscroll and -15 or -5))
    setProperty('scoreTxt.color',0)
    setTextBorder('scoreTxt',0,'000000')
    setTextSize('scoreTxt',30)
    scaleObject('scoreTxt',1,1.25)
    setTextFont('scoreTxt','BIOSNormal.ttf')
    if version >= '0.7' then
        setProperty('healthBar.bg.visible',false)
        setProperty('timeBar.bg.visible',false)
    else
        setProperty('healthBarBG.visible',false)
        setProperty('timeBarBG.visible',false)
    end
    for strums = 0,7 do
        setPropertyFromGroup('strumLineNotes',strums,'scale.x',1.8)
        setPropertyFromGroup('strumLineNotes',strums,'scale.y',1.8)
        if strums < 4 then
            setPropertyFromGroup('strumLineNotes',strums,'visible',false)
        else
            setPropertyFromGroup('strumLineNotes',strums,'x',30 + (112*(strums-4)))
        end
        updateHitboxFromGroup('strumLineNotes',strums)
        setPropertyFromGroup('strumLineNotes',strums,'y',screenHeight/2 + (not downscroll and -160 or 48));
    end
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'texture') == nil or getPropertyFromGroup('unspawnNotes',notes,'texture') == '' then
            setPropertyFromGroup('unspawnNotes',notes,'scale.x',1.8)
            if not getPropertyFromGroup('unspawnNotes',notes,'isSustainNote') then
                setPropertyFromGroup('unspawnNotes',notes,'scale.y',1.8)
 
            else
                setPropertyFromGroup('unspawnNotes',notes,'offsetX',30)
                if version >= '0.7' then
                    if not downscroll then
                        setPropertyFromGroup('unspawnNotes',notes,'strumTime',getPropertyFromGroup('unspawnNotes',notes,'strumTime') - 100)
                    else
                        setPropertyFromGroup('unspawnNotes',notes,'strumTime',getPropertyFromGroup('unspawnNotes',notes,'strumTime') + 100)
                    end
                end
            end
            if not getPropertyFromGroup('unspawnNotes',notes,'mustPress') then
                setPropertyFromGroup('unspawnNotes',notes,'visible',false)
            end
            updateHitboxFromGroup('unspawnNotes',notes)
        end
    end
end

function setupCamera()
    runHaxeCode(
        [[
            var bfCamera = new FlxCamera();
            var dadCamera = new FlxCamera();

            bfCamera.width = 500/2;
            bfCamera.height = FlxG.height/2;
            bfCamera.x = FlxG.width/2.0;
            dadCamera.width = 505/2;
            dadCamera.height = FlxG.height/2;
            dadCamera.x = FlxG.width/2.0 - 250;

            bfCamera.bgColor = 0x00000000;
            dadCamera.bgColor = 0x00000000;

            game.camHUD.width = 500;
            game.camHUD.x = FlxG.width/2.0 - 250;

            game.camGame.x = game.camHUD.x;
            game.camOther.x = game.camHUD.x;

            game.camGame.width = 500;
            game.camOther.width = 500;
        
            game.boyfriend.cameras = [bfCamera];
            game.dad.cameras = [dadCamera];

            setVar('dadCamera',dadCamera);
            setVar('boyfriendCamera',bfCamera);

            game.getLuaObject('dadBG').cameras = [dadCamera];

            game.getLuaObject('bfBG0').cameras = [bfCamera];
            game.getLuaObject('bfBG1').cameras = [bfCamera];
            
            game.getLuaObject('bgGrad').cameras = [bfCamera];
            if(game.getLuaObject('bfSpotLight') != null){
                game.getLuaObject('bfSpotLight').cameras = [bfCamera];
            }
            

            ]]..(not lowQuality and "game.getLuaObject('bgGradiant').cameras = [bfCamera];" or '')..[[

            if(!]]..tostring(downscroll)..[[){
                dadCamera.y = FlxG.height/2.0 + 10;
                bfCamera.y = FlxG.height/2.0 + 10;
            }
            FlxG.cameras.add(dadCamera);
            FlxG.cameras.add(bfCamera);
            FlxG.cameras.add(game.camOther);
            FlxG.cameras.add(game.camHUD);

            game.dadGroup.x = -30;
            game.dadGroup.y = -150;
            game.boyfriendGroup.x = 50;
            game.boyfriendGroup.y = -110;
            return;
        ]]
    )
end