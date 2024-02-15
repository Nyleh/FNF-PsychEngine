local playState = 'states.PlayState'

local gameOverStarted = false
function onCreate()
    if version <= '0.6.3' then
        playState = 'PlayState'
    end
    makeLuaSprite('gbCountdown','pixelUI/countdown',0,0)
    loadGraphic('gbCountdown','pixelUI/countdown',33,34)
    addAnimation('gbCountdown','anim',{0,1,2,3})
    addLuaSprite('gbCountdown',false)

    makeLuaSprite('gbPortatil','mario/Somari/gbalay',-15,0)
    setScrollFactor('gbPortatil',0,0)
    scaleObject('gbPortatil',1.7,1.7)
    setObjectCamera('gbPortatil','other')
    addLuaSprite('gbPortatil',false)

    makeLuaSprite('bg','mario/Somari/somari_stag1',370,322)
    setProperty('bg.antialiasing',false)
    scaleObject('bg',4,4)
    addLuaSprite('bg')

    makeAnimatedLuaSprite('bgstars','mario/Somari/bgstars',370,322)
    addAnimationByPrefix('bgstars','stars','bgstars flash',5,true)
    setProperty('bgstars.velocity.x',-20)
    setProperty('bgstars.antialiasing',false)
    scaleObject('bgstars',4,4)
    addLuaSprite('bgstars')


    makeAnimatedLuaSprite('bgCity','mario/Somari/buildings_papu',370,320)
    addAnimationByPrefix('bgCity','anim','buildings papu color',1,true)
    setProperty('bgCity.antialiasing',false)
    scaleObject('bgCity',4,4)
    addLuaSprite('bgCity')

    makeLuaSprite('platform','mario/Somari/platform',923,593)
    setProperty('platform.antialiasing',false)
    scaleObject('platform',4,4)
    addLuaSprite('platform')

    setPropertyFromClass(playState,'SONG.arrowSkin','noteSkins/NES_NOTE_assets')
    setPropertyFromClass(playState,'SONG.splashSkin','noteSplashes/splash-NES')
end
function onUpdatePost()
    setProperty('camHUD.zoom',0.7)
    if getProperty('bgstars.x') <= 370 - (getProperty('bgstars.width')/3) then
        setProperty('bgstars.x',getProperty('bgstars.x') + getProperty('bgstars.width')/3)
    end
end

function onGameOver()
    if not gameOverStarted then
        gameOverStarted = true
        setProperty('generatedMusic',false)
        setProperty('vocals.volume',0)

        runTimer('resetSong',1.5)
        playAnim('boyfriend','hit',true)
        setProperty('boyfriend.specialAnim',true)
        setProperty('boyfriend.velocity.y',-400)
        setProperty('boyfriend.acceleration.y',1000)
        for notes = 0,getProperty('notes.length')-1 do
            setPropertyFromGroup('notes',notes,'visible',false)
        end

    end
    return Function_Stop;
end
function onTimerCompleted(tag)
    if tag == 'resetSong' then
        loadSong(songName,difficulty)
    end
end
local lastScore = 0
function onUpdateScore()
    local text = ''
    local score = getProperty('songScore')
    if lastScore ~= score then
        if lastScore < score then
            createCombo(score - lastScore,'FFFFFF')
        else
            createCombo(lastScore - score,'FF0000')
        end
        lastScore = score
    end
    if score < 0 then
        text = '-'
    end
    score = math.abs(score)
    for i = 0,6 - string.len(tostring(score)) do
        text = text..'0'
    end
    setTextString('scoreTxt',text..tostring(score))

end
function onDestroy()
    setPropertyFromClass(playState,'SONG.arrowSkin','')
    setPropertyFromClass(playState,'SONG.splashSkin','')
end

local combos = 0
function createCombo(combo,color)
    local name = 'somariCombo'..combos
    local text = ''

    if string.len(combo) < 3 then

        for i = 0,2 - string.len(combo) do
            text = text..'0'
        end
        text = text..combo
    else
        text = text..combo
    end
    makeLuaText(name,text,500,600,400)
    setTextSize(name,30)
    setProperty(name..'.color',getColorFromHex(color))
    setTextBorder(name,0,color)
    setTextFont(name,'mariones.ttf')
    doTweenY(name..'Y',name,getProperty(name..'.y')-50,0.5,'linear')
    addLuaText(name,true)
    combos = combos + 1
end
function onTweenCompleted(tag)
    if stringStartsWith(tag,'somariCombo') then
        removeLuaText(string.gsub(tag,'Y',''),true)
    end
end
function goodNoteHit(id,data,type,sus)
    if not sus and math.abs(getPropertyFromGroup('notes',id,'strumTime') - getSongPosition()) < getPropertyFromClass(version <= '0.6.3' and 'ClientPrefs' or 'backend.ClientPrefs',(version >= '0.7' and 'data.' or '')..'sickWindow') then
        for splashes = 0,getProperty('grpNoteSplashes.length')-1 do
            if version <= '0.6.3' then
                setPropertyFromGroup('grpNoteSplashes',splashes,'offset.x',-150)
                setPropertyFromGroup('grpNoteSplashes',splashes,'offset.y',-170)
            end
            setPropertyFromGroup('grpNoteSplashes',splashes,'scale.x',6)
            setPropertyFromGroup('grpNoteSplashes',splashes,'scale.y',6)
        end
    end
end
function onCreatePost()
    setProperty('isCameraOnForcedPos',true)
    setProperty('camFollow.x',770)
    setProperty('camFollow.y',470)

    --setProperty('scoreTxt.x',150)
    --setTextAlignment('scoreTxt','left')

    setProperty('scoreTxt.x',-20)
    setTextAlignment('scoreTxt','right')
    setTextWidth('scoreTxt',500)
    setProperty('scoreTxt.y',not downscroll and 670 or 650)
    setTextFont('scoreTxt','mariones.ttf')
    setTextSize('scoreTxt',50)

    makeLuaSprite('blackBar',nil,0,downscroll and 0 or screenHeight-62)
    makeGraphic('blackBar',screenWidth,100,'000000')
    setObjectCamera('blackBar','hud')
    addLuaSprite('blackBar',true)

    setObjectOrder('scoreTxt',getObjectOrder('blackBar')+1)

    setProperty('scoreTxt.antialiasing',false)
    callScript('scripts/global_functions','hudVisible',{false})
    setProperty('scoreTxt.visible',true)

    setObjectOrder('ringImage',getObjectOrder('blackBar')+1)--Ring image from data/mario bla bla bla/script
    setObjectOrder('ringText',getObjectOrder('blackBar')+1)--Ring image from data/mario bla bla bla/script
end