function onCreate()
    if curStage ~= 'somari' then
        if curStage ~= 'warioworld' and curStage ~= 'endstage' then
            addLuaScript('extra_scripts/MarioHUD')
        else
            addLuaScript('extra_scripts/TvHUD')
        end
    end
end