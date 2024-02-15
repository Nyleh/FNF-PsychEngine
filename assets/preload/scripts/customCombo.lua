local comboCount = 0
local comboDestroyed = 0

local enableCombo = true
local numbersCount = 0
local numbersDestroyed = 0

local comboImage = 'num'
local ratingImage = ''
local comboScale = 0.8
local comboColor = 'FFFFFF'

local comboNumOffset = 300
--local maxNumbers = 2

function onCreate()
    if version <= '0.6.3' and not getPropertyFromClass('ClientPrefs','comboStacking') or version >= '0.7' and not getPropertyFromClass('backend.ClientPrefs','data.comboStacking') then
        enableCombo = false
        return
    else
        if curStage == 'virtual' then
            comboColor = 'FF0000'
        elseif curStage == 'landstage' then
            ratingImage = 'rating/gb'
            comboImage = 'numbers/gbnum'
        elseif curStage == 'piracy' or curStage == 'warioworld' or curStage == 'endstage' or curStage == 'somari' then
            enableCombo = false
        end
    end
    setProperty('showCombo',false)
    setProperty('showComboNum',false)
    setProperty('showRating',false)
end
function createCombo(image,x,y,color,order)
    local name = 'customCombo'..comboCount
    --local name = 'customCombo'
    makeLuaSprite(name,image,x,y)
    setProperty(name..'.velocity.y',-200)
    setProperty(name..'.acceleration.y',800)
    addLuaSprite(name,true)
    scaleObject(name,comboScale,comboScale)
    setObjectOrder(name,getObjectOrder('boyfriendGroup')+1)
    if color ~= nil then
        setProperty(name..'.color',getColorFromHex(color))
    end
    if order ~= nil then
        setObjectOrder(name,order)
    end
    comboCount = comboCount + 1
end

function createNumbers(x,y,image,color,order)
    local detectPotence = math.max(2,#tostring(getProperty('combo')) - 1)
    if image == nil then
        image = 'num'
    end
    --maxNumbers = detectPotence
    for numbers = 0,detectPotence do
        local numberSprite = tostring(getProperty('combo'))
        if #numberSprite - numbers > 0 then
            numberSprite = string.sub(numberSprite,#numberSprite - numbers,#numberSprite - numbers)
            
        else
            numberSprite = '0'
        end
        local numberScale = comboScale - 0.2
        numbersCount = numbersCount + 1
        local number = 'customNumber'..numbersCount
        --local number = 'customNumber'..numbers
        makeLuaSprite(number,image..numberSprite,x,y)
        
        setProperty(number..'.velocity.y',-200 - (50*numbers))
        setProperty(number..'.acceleration.y',800)
        setProperty(number..'.alpha',1)
        scaleObject(number,numberScale,numberScale)
        setProperty(number..'.x',x - (getProperty(number..'.width')*numbers))
        addLuaSprite(number,true)
        setObjectOrder(number,getObjectOrder('boyfriendGroup')+1)
        
        if color ~= nil then
            setProperty(number..'.color',getColorFromHex(color));
        end
        if order ~= nil then
            setObjectOrder(number,order)
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if not sus and enableCombo then
        local comboOrder = getObjectOrder('boyfriendGroup')+1
        local comboX = getProperty('boyfriend.x') - 200
        local comboY = getProperty('boyfriend.y') - 200
        if curStage == 'virtual' then
            comboX = getProperty('dadGroup.x') + 550
            comboY = getProperty('dadGroup.y') + 100
        elseif curStage == 'nesbeat' then
            comboX = getProperty('gfGroup.x') + 550
            comboY = getProperty('gfGroup.y') + 100
        elseif curStage == 'landstage' then
            comboY = comboY - 200
        elseif curStage == 'secretbg' then
            comboX = getProperty('gfGroup.x')
            comboY = getProperty('gfGroup.y') - 50
        end

        createCombo(ratingImage..detectRating(getPropertyFromGroup('notes',id,'strumTime')-getSongPosition()),comboX,comboY,comboColor,comboOrder)
        if getProperty('combo') >= 10 then
            createNumbers(comboX + (comboNumOffset*comboScale),comboY + ((comboNumOffset-100)*comboScale),comboImage,comboColor,comboOrder)
        end
    end
end
function detectRating(time)
    time = math.abs(time)
    if version <= '0.6.3' then
        if time < getPropertyFromClass('ClientPrefs','sickWindow') then
            return 'sick'
        elseif time < getPropertyFromClass('ClientPrefs','goodWindow') then
            return 'good'
        elseif time < getPropertyFromClass('ClientPrefs','badWindow') then
            return 'bad'
        else
            return 'shit'
        end
    else
        if time < getPropertyFromClass('backend.ClientPrefs','data.sickWindow') then
            return 'sick'
        elseif time < getPropertyFromClass('backend.ClientPrefs','data.goodWindow') then
            return 'good'
        elseif time < getPropertyFromClass('backend.ClientPrefs','data.badWindow') then
            return 'bad'
        else
            return 'shit'
        end
    end
    return ''
end

function onUpdate(el)
    --[[if luaSpriteExists('customCombo') then
        if getProperty('customCombo.alpha') <= 0 then
            removeLuaSprite('customCombo',true)
        else
            if getProperty('customCombo.velocity.y') > 0 then
                setProperty('customCombo.alpha',getProperty('customCombo.alpha')-el)
            end
        end
    end
    for numbers = 0,maxNumbers do
        local name = 'customNumber'..numbers
        if luaSpriteExists(name) then
            if getProperty(name..'.velocity.y') > 0 then
                setProperty(name..'.alpha',getProperty(name..'.alpha')-el)
            end
            if getProperty(name..'.alpha') <= 0 then
                --numbersDestroyed = numbersDestroyed + 1
                removeLuaSprite(name,true)
            end
        end
    end]]--
    if comboCount > comboDestroyed then
        for combos = comboDestroyed,comboCount do
            local name = 'customCombo'..combos
            if luaSpriteExists(name) then
                if getProperty(name..'.velocity.y') > 0 then
                    setProperty(name..'.alpha',getProperty(name..'.alpha')-(el*2))
                end
                if getProperty(name..'.alpha') <= 0 then
                    removeLuaSprite(name,true)
                    comboDestroyed = comboDestroyed + 1
                end
            end
        end
    end
    if numbersCount > numbersDestroyed then
        for numbers = numbersDestroyed+1,numbersCount do
            local name = 'customNumber'..numbers
            if luaSpriteExists(name) then
                if getProperty(name..'.velocity.y') > 0 then
                    setProperty(name..'.alpha',getProperty(name..'.alpha')-(el*2))
                end
                if getProperty(name..'.alpha') <= 0 then
                    removeLuaSprite(name,true)
                    numbersDestroyed = numbersDestroyed + 1
                end
            end
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers All Stars' then
        if v1 == '2' then
            if v2 == '3' then
                comboScale = 0.5
            elseif v2 == '4' then
                comboScale = 0.8
            end
        end
    end
end