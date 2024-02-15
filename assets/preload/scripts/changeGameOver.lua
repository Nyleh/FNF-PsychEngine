local curGameOver = ''
local gameOverState = 0
local bfGameOver = 'bf-dead'
local music = 'mario_gameover'
local deathSound = ''
local substate = 'substates.GameOverSubstate'
function onCreatePost()
    detectGameOver(true)
end

function onEvent(name,v1,v2)
    if name == 'Change Character' then
        if curGameOver ~= 'custom' then
            detectGameOver()
        end
    end
end


function detectGameOver(onStart)
    curGameOver = 'custom'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    if songName == 'All-Stars' then
        addLuaScript('extra_scripts/game_overs/AllStars')
    end
    if songName ~= 'I Hate You' and curStage == 'hatebg' then
        addLuaScript('extra_scripts/game_overs/OGN')
    elseif curStage == 'superbad' then
        addLuaScript('extra_scripts/game_overs/badMarioGO')

    elseif curStage == 'landstage' then
        addLuaScript('extra_scripts/game_overs/GoldenLand')

    elseif curStage == 'virtual' then
        addLuaScript('extra_scripts/game_overs/Paranoia')
    elseif curStage == 'nesbeat' then
        addLuaScript('extra_scripts/game_overs/nesbeat')

    elseif curStage == 'directstream' then
        addLuaScript('extra_scripts/game_overs/stremOff')

    elseif curStage == 'piracy' then
        addLuaScript('extra_scripts/game_overs/NoParty')

    elseif curStage == 'promoshow' or curStage == 'wetworld' or curStage == 'endstage' then
        addLuaScript('extra_scripts/game_overs/abandoned')

    elseif curStage == 'racing' then
        addLuaScript('extra_scripts/game_overs/race')

    elseif curStage == 'realbg' then
        addLuaScript('extra_scripts/game_overs/Real')

    else
        local dad = getProperty('dad.curCharacter')
        local bf = getProperty('boyfriend.curCharacter')

        curGameOver = ''

        local restartSound = 'mario_retry'
        if string.find(dad,'mariohorror',0,true) and string.find(bf,'bfexe',0,true) then
            bfGameOver = 'bfexenewdeath'

        elseif bf == 'bf-goomba' then
            bfGameOver = 'bf-goomba'
            deathSound = 'turmoil_death1'
            music = 'gameOverNew'
            restartSound = 'gameOverEndNew'
            addLuaScript('extra_scripts/game_overs/lastCourse')
        elseif bf == 'bfrunv2' and dad == 'wariov2' then
            curGameOver = 'Wario'
            addLuaScript('extra_scripts/game_overs/apparition')


        elseif bf == 'bfihy' and curStage == 'hatebg' then
            bfGameOver = 'bfihydeath'
            restartSound = 'gameOverEndNew'

        elseif bf  == 'bfGD' then
            bfGameOver = 'bfGDDIES'
            deathSound = 'gran_gag_sounddesign'
            music = 'GD/ghost_'..getRandomInt(1,24)

        elseif bf == 'bf-ldo' then
            bfGameOver = 'bf-ldo'

        elseif bf == 'bfsecret' then
            bfGameOver = 'bfsecretgameover'
            deathSound = 'goodbye_old_friend_sh_mario'
            --restartSound = 'gameOverEndNew'
            --music = 'SHgameover'
            addLuaScript('extra_scripts/game_overs/secretGO')

        elseif dad == 'devilmario' and string.find(bf,'bf',0,true) then
            bfGameOver = 'bfPowerdeath'
            deathSound = 'POWERSTARDEATH'
            music = 'POWERSTARDEATH_LOOP_60BPM'
            restartSound = 'POWERSTARDEATH_RETRY'

        
        elseif curStage == 'exeport' and string.find(bf,'bf',0,true) then
            bfGameOver = 'bf_PDdeath'
            music = 'MXgameover'
            deathSound = 'MXdeathpowerdown'
            restartSound = 'MXconfirm'
        elseif curStage == 'demiseport' and string.find(bf,'bf',0,true) then
            bfGameOver = 'bf_demisedeath'
            music = 'MXgameover'
            deathSound = 'MXdeathdemise'
            restartSound = 'MXconfirm'
            
        elseif dad == string.find(dad,'luigi',0,true) and string.find(bf,'pico',0,true) then
            bfGameOver = 'picodeath'
            deathSound = 'TOOPOOP_LUIGI'
            music = 'overdueGameover'
        end
        if bfGameOver ~= '' then
            setPropertyFromClass(substate,'characterName',bfGameOver)
        end

        if deathSound ~= '' then
            setPropertyFromClass(substate,'deathSoundName',deathSound)
        end

        if restartSound ~= '' then
            setPropertyFromClass(substate,'endSoundName',restartSound)
        end

        if music ~= '' then
            setPropertyFromClass(substate,'loopSoundName',music)
        end

        --[[if precache then
            if bfGameOver ~= '' then
                addCharacterToList(bfGameOver,'boyfriend')
            end
            if deathSound ~= '' then
                precacheSound(deathSound)
            end
            if precache then
                precacheMusic(music)
            end
        end]]--
    end
end