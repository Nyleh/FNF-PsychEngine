function getHud()
    local hud = {}
    if hideHud then
        if timeBarType ~= 'Disabled' then
            if version >= '0.7' then
                hud = {'timeBar','timeTxt'}
            else
                hud = {'timeBar','timeBarBG','timeTxt'}
            end
        end
    else
        if timeBarType ~= 'Disabled' then
            if version >= '0.7' then
                hud = {'timeBar','timeTxt','scoreTxt','iconP1','iconP2','healthBar'}
            else
                hud = {'timeBar','timeBarBG','timeTxt','scoreTxt','iconP1','iconP2','healthBar','healthBarBG'}
            end
        else
            if version >= '0.7' then
                hud = {'scoreTxt','iconP1','iconP2','healthBar'}
            else
                hud = {'scoreTxt','iconP1','iconP2','healthBar','healthBarBG'}
            end
        end
    end
    return hud
end

function hudAlpha(alpha,speed,easing,alsoNotes)
    for i, hud in pairs(getHud()) do
        cancelTween(hud..'Alpha')
        if speed ~= 0 then
            doTweenAlpha(hud..'Alpha',hud,alpha,speed,easing)
        else
            setProperty(hud..'.alpha',alpha)
        end
    end
    if alsoNotes then
        for strums = 0,7 do
            cancelTween('noteUniAlpha'..strums)
            if speed ~= 0 then
                noteTweenAlpha('noteUniAlpha'..strums,strums,alpha,speed,easing)
            else
                cancelTween('noteUniAlpha'..strums)
                setPropertyFromGroup('strumLineNotes',strums,'alpha',0)
            end
        end
    end
end

function hudVisible(visible,alsoNotes)
    for i, hud in pairs(getHud()) do
        setProperty(hud..'.visible',visible)
    end
    if alsoNotes then
        for strums = 0,7 do
            setPropertyFromGroup('strumLineNotes',strums,'visible',visible)
        end
    end
end

function setMiddleScroll(middle,speed,visibleOpponentNotes)
    if speed == nil then
        speed = 2
    end
    for strums = 0,7 do
        if strums < 4 then
            cancelTween('noteUniAlpha'..strums)
            if middle then
                if speed ~= 0 then
                    if not visibleOpponentNotes then
                        noteTweenAlpha('noteUniAlpha'..strums,strums,0,speed,'expoOut')
                    end
                else
                    setPropertyFromGroup('strumLineNotes',strums,'alpha',0)
                end
            else
                if speed ~= 0 then
                    if middlescroll then
                        noteTweenAlpha('noteUniAlpha'..strums,strums,0.35,speed,'expoOut')
                    else
                        noteTweenAlpha('noteUniAlpha'..strums,strums,1,speed,'expoOut')
                    end
                    
                else
                    if middlescroll then
                        setPropertyFromGroup('strumLineNotes',strums,'alpha',0.35)
                    else
                        setPropertyFromGroup('strumLineNotes',strums,'alpha',1)
                    end
                end
                --setPropertyFromGroup('strumLineNotes',strums,'x',92 + (112*strums))
            end
        else
            cancelTween('noteUniX'..strums)
            if not middlescroll then
                if middle then
                    if speed ~= 0 then
                        noteTweenX('noteUniX'..strums,strums,412 + (112*(strums-4)),speed,'expoInOut')
                    else
                        setPropertyFromGroup('strumLineNotes',strums,'x',412 + (112*(strums-4)))
                    end
                else
                    if speed ~= 0 then
                        noteTweenX('noteUniX'..strums,strums,732 + (112*(strums-4)),stepCrochet*0.003,'expoOut')
                    else
                        setPropertyFromGroup('strumLineNotes',strums,'x',732 + (112*(strums-4)))
                    end
                end
            end
        end
    end
end

function deleteGF(removeFromMemory)
    if removeFromMemory then
        local gfImage = runHaxeCode(
            [[
                var gfImage = null;
                if(game.gf != null){
                    gfImage = game.gf.imageFile;
                    game.gf.kill();
                    game.gf.destroy();
                    game.gf = null;
                    game.gfGroup.clear();
                    game.gfMap.clear();
                }
                return gfImage;
            ]]
        )
        callScript('scripts/optimization','removeFromMemory',{gfImage})
    else
        runHaxeCode(
            [[
                game.gf.kill();
                game.gf.destroy();
                game.gf = null;
                game.gfGroup.clear();
                game.gfMap.clear();
                return;
            ]]
        )
    end
end

--[[function table.split(text,argument)
    local array = {}
    local founded = false
    local pos = 0
    repeat
        founded = false
        local split,_ = string.find(text,argument,pos,true)
        if split then
            founded = true
            table.insert(array,string.sub(text,pos,split-1))
            pos = _+1
        else
            table.insert(array,string.sub(text,pos))
        end
    until founded == false
    if array == {} then
        array = {text}
    end
    return array
end]]--