local startIntro = ''
local cutplayed = true
local endIntro = ''
function onCreate()
    if isStoryMode and not seenCutscene then
        if songName == 'Promotion' then
            startIntro = 'promocut'
            endIntro = 'abandoncut'
        elseif songName == "Its a me" then
            --startIntro = 'Itsame_cutscene'
            endIntro  = 'ss_cutscene'
        elseif songName == 'I Hate You' then
            startIntro = 'ihy_cutscene'
        elseif songName == 'Starman Slaughter' then
            endIntro = 'post_ss_cutscene'
        end
    end
    if startIntro ~= '' then
       cutplayed = false 
    end
end
function onStartCountdown()
    if not cutplayed then
        startVideo(startIntro)
        setProperty('camGame.alpha',0.001)
        startIntro = 'n'
        cutplayed = true
        return Function_Stop;
    else
        if startIntro == 'n' then
            cameraFlash('game','000000',1)
            setProperty('camGame.alpha',1)
        end
    end
end
function onEndSong()
    if endIntro ~= '' then
        startVideo(endIntro)
        endIntro = ''
        return Function_Stop;
    end
    return Function_Continue;
end