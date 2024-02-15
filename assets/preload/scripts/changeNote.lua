local playState = 'states.PlayState'
function onCreate()
    if version < '0.7' then
        playState = 'PlayState'
    else
        setPropertyFromClass(playState,'SONG.disableNoteRGB',true)
    end
    local noteSkin = getPropertyFromClass(playState,'SONG.arrowSkin')
    if noteSkin == nil or noteSkin == '' or noteSkin == 'NOTE_assets' then
        setPropertyFromClass(playState,'SONG.arrowSkin','noteSkins/NOTE_assets')
    end
    local splashSkin = getPropertyFromClass(playState,'SONG.splashSkin')
    if splashSkin == nil or splashSkin == '' or splashSkin == 'noteSplashes' then
        splashSkin = 'noteSplashes/noteSplashes'
        setPropertyFromClass(playState,'SONG.splashSkin','noteSplashes/noteSplashes')
    end
    precacheImage(splashSkin)
end
function onDestroy()
    setPropertyFromClass(playState,'SONG.arrowSkin','')
    setPropertyFromClass(playState,'SONG.splashSkin','')
    if version > '0.6.3' then
        setPropertyFromClass('states.PlayState','SONG.disableNoteRGB',false)
    end
end
function goodNoteHit(id,data,type,sus)
    if not sus and math.abs(getPropertyFromGroup('notes',id,'strumTime') - getSongPosition()) < (version > '0.6.3' and getPropertyFromClass('backend.ClientPrefs','data.sickWindow') or getPropertyFromClass('ClientPrefs','sickWindow')) then
        for splashes = 0,getProperty('grpNoteSplashes.length')-1 do
            setPropertyFromGroup('grpNoteSplashes',splashes,'scale.x',0.8)
            setPropertyFromGroup('grpNoteSplashes',splashes,'scale.y',0.8)
            if version >= '0.7' then
                setPropertyFromGroup('grpNoteSplashes',splashes,'shader',nil)
                setPropertyFromGroup('grpNoteSplashes',splashes,'alpha',getPropertyFromClass('backend.ClientPrefs','data.splashAlpha')  * getPropertyFromGroup('playerStrums',data,'alpha'))
            else
                local offsetX = nil
                local offsetY = nil
                if getPropertyFromClass('PlayState','SONG.splashSkin') == 'noteSplashes/noteSplashes-Virtual' then
                    offsetX = -40
                    offsetY = -35
                elseif getPropertyFromClass('PlayState','SONG.splashSkin') == 'noteSplashes/noteSplashes' then
                    offsetX = 0
                    offsetY = 0
                elseif getPropertyFromClass('PlayState','SONG.splashSkin') == 'noteSplashes/noteSplashes-END' then
                    offsetX = -30
                    offsetY = -30
                end
                if offsetX ~= nil then
                    setPropertyFromGroup('grpNoteSplashes',splashes,'offset.x',offsetX)
                end
                if offsetY ~= nil then
                    setPropertyFromGroup('grpNoteSplashes',splashes,'offset.y',offsetY)
                end
                setPropertyFromGroup('grpNoteSplashes',splashes,'alpha',0.8 * getPropertyFromGroup('playerStrums',data,'alpha'))
            end
        end
    end
end
--[[function onCreatePost()
    for strum = 0,7 do
        setPropertyFromGroup('strumLineNotes',strum,'texture','Mario_NOTE_assets')
        setPropertyFromGroup('strumLineNotes',strum,'useRGBShader',false)
    end
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'texture') == "" then
            setPropertyFromGroup('unspawnNotes',notes,'texture','Mario_NOTE_assets')
            setPropertyFromGroup('unspawnNotes',notes,'rgbShader.enabled',false)
        end
    end
end]]--