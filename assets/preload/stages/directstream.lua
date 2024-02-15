local names = {
    'Duende',
    'fishlips97',
    'fredick',
    'johnsonVMUleaker',
    'Soup',
    'lordbossmaster',
    'ChurgneyGurgney',
    'Dave',
    'Raptw',
    'BootMunde',
    'NotesGlory',
    'Joe_Biden',
    'fnaffreedy',
    'Walter_White',
    'AwesomeHuggyWuggy',
    'Lythero',
    'anderson043',
    'DanceRocker',
    'Sowf',
    'Magik',
    'Tallyda',
    'WakeboardBox',
    'mark',
    'Zendraynix',
    'Zippoix',
    'MetalFingers',
    'CasualCaden',
    'Ellie',
    'doug',
    'ConvertsCombatant',
    'Specism',
    'Ellacens',
    'Ney',
    'parasiteEvan',
    'Griog',
    'Sistergy',
    'MXgaming'
}
local dialogues = {
    'WTF Chris Pratt?',
    'is the guy from marvel!',
    'wtf',
    'is that christian bale from star wars?',
    'Dude, i know this is unrelated, but i need your help right now.',
    'what about charles',
    'what about gd',
    'someone gift me a sub please',
    'My Mario?!? THEY TOOK HIM!!!',
    'PISS FAT???',
    'hippopotomonstrosesquippedaliophobia',
    "bro think he's mario",
    'thats cool',
    'bring on tha thunda',
    'Just one good jelq sesh... Can change a man...',
    'alr',
    'what the fuck',
    'SODA!!!!!!',
    'can you play GD?',
    'ITS MARIO OMG',
    'this movie gonna suck',
    'want robux? Visit FREEROBUX.COM and become a MILLIONE!',
    'If its you or the worms I pick the worms every time',
    'mid',
    'let me tell you a sad story',
    'You dare bring light to my lair!? YOU MUST DIE!',
    "THATS'S a technical fouul...",
    'so no smash?',
    'Yeaaaa',
    'ca n i be in the chat....',
    'w',
    'hdjkhasdsa',
    '[message deleted by moderator]',
    'hi',
    'how',
    'vaya mierda',
    'what happenned to midyamoto',
    'are we getting a Chris Pratt amiibo?',
    'They should add chris pratt to fortnite',
    'YOU BROKE MY GRILL?!?',
    'Galápagos Tortoise',
    'can you play desertbus next?',
    'unfortunately, ratio',
    'is chris pratt a duende?',
    'mark you next time',
    'no ve er nota este',
    'midlicious',
    'i got hairy legs.',
    'there should be a fnf mod of this',
    'the jurassic park guy???',
    'Wanna become famous? Buy followers, at bigfollows.com!',
    "This isn't the video to get free V-Bucks",
    'is that your gf in the bg?',
    'This sucks, next song',
    'mid march?',
    'can you play oddyssey?',
    'PILGRIM SPONGEBOB???',
    'what is nintendo thinking',
    'WHAAAAA',
    'XD'
}
local chatStarted = false
local dialogueCount = 0
local minDialogePos = 0

local personsAppears = {}
function onCreate()
    makeLuaSprite('bg','mario/real/direct bg grey',0,0)
    addLuaSprite('bg',false)
    if songName == 'So Cool' then
        setProperty('skipCountdown',true)
        makeLuaSprite('bgred','mario/real/direct bg red',0,0)
        addLuaSprite('bgred',false)
        setProperty('camGame.alpha',0.001)
        setProperty('camHUD.alpha',0.001)
        makeAnimatedLuaSprite('miyamoto','mario/real/miyamoto',350,300)
        addAnimationByPrefix('miyamoto','talking','miyamoto talking',24,true)
        addAnimationByPrefix('miyamoto','motion','miyamoto hand motion',24,false)
        addAnimationByPrefix('miyamoto','still','miyamoto still',0,false)
        playAnim('miyamoto','still')
        addLuaSprite('miyamoto',true)
    else
        setProperty('dadGroup.x',500)
    end
    makeAnimatedLuaSprite('facecambg','mario/real/facecam bg',1340,not downscroll and 645 or 50)
    addAnimationByPrefix('facecambg','0','facecam bg left',0,false)
    addAnimationByPrefix('facecambg','1','facecam bg down',0,false)
    addAnimationByPrefix('facecambg','2','facecam bg up',0,false)
    addAnimationByPrefix('facecambg','3','facecam bg right',0,false)
    addLuaSprite('facecambg',false)
    setProperty('facecam bg.flipY',true)
    addLuaSprite('facecam bg',false)
    makeLuaSprite('bgcam','mario/real/facecam border',1340,50)
    setProperty('bgcam.flipY',not downscroll)
    addLuaSprite('bgcam',false)

    if downscroll then
        setProperty('boyfriendGroup.y',-252)
        setProperty('gfGroup.y',-175)
    end

    makeLuaSprite('chrisBox','mario/real/nametag',-570,790)
    addLuaSprite('chrisBox',true)
    --createDialogue()
end
function onSongStart()
    if songName == 'So Cool' then
        setProperty('camGame.alpha',1)
        cameraFlash('game','000000',10)
    end
end
function onStepHit()
    if curStep >= 128 and not chatStarted then
        chatStarted = true
        createDialogue()
        doTweenAlpha('hudAlpha','camHUD',1,0.5,'cubeOut')
    end
end
function createDialogue()
    local personRandom = getRandomInt(1,#names)
    local foundedPerson =false
    
    local colors = {
        'FF0000',
        '0FF0FF',
        '00FFFF',
        '0000FF',
        'FF00FF',
        'F0FF0F',
        'FFFF00',
        'FF7000',
        'FF006E'
    }
    local colorRandom = getRandomInt(1,#colors)
    local chatDialogue = dialogues[getRandomInt(1,#dialogues)]
    repeat
        foundedPerson = false
        for i, persons in pairs(personsAppears) do
            if personRandom == persons then
                personRandom = getRandomInt(1,#names)
                foundedPerson = true
                break
            end
        end
    until foundedPerson == false


    local person = 'dialoguePerson'..dialogueCount
    local chat = 'dialogueChat'..dialogueCount
    local personChat = names[personRandom]..": "
    local barWidth = getProperty('bgcam.width')
    
    local personDialogue = ''
    local newLines = 0
    local foundedNewLine = false

    --[[repeat
        foundedNewLine = false
        local dialogueLine = string.sub(personChat..chatDialogue,23*newLines)

        if #dialogueLine >= 35 then
            newLines = newLines + 1
            personDialogue = personDialogue..string.sub(dialogueLine,0,22)..'-\n'
            foundedNewLine = true
        else
            personDialogue = personDialogue..dialogueLine
        end
    until foundedNewLine == false
    local offset = 36 * (newLines + 1)
    makeLuaText(chat,personDialogue,barWidth,1350,(not downscroll and 610 or screenHeight+330) - offset)]]--
    makeLuaText(chat,personChat..chatDialogue,barWidth,1350,(not downscroll and 610 or screenHeight+330))
    setTextSize(chat,24)
    setTextFont(chat,'pixel.otf')
    setTextBorder(chat,1,'000000')
    setTextAlignment(chat,'left')

    local offset = 36 * getProperty(chat..'.textField.numLines')
    debugPrint(getProperty(chat..'.textField.numLines'))
    setProperty(chat..'.y',getProperty(chat..'.y')-offset)

    

    makeLuaText(person,personChat,barWidth,1350,getProperty(chat..'.y'))
    setProperty(person..'.color',getColorFromHex(colors[colorRandom]))
    setScrollFactor(person,1,1)
    setTextAlignment(person,'left')
    setTextFont(person,'pixel.otf')
    setTextBorder(person,1,'000000')
    setTextSize(person,24)
    --addLuaText(chat,false)
    --addLuaText(person,false)

    table.insert(personsAppears,personRandom)

    --Chat go up
    if dialogueCount > 0 then
        for d = minDialogePos,dialogueCount-1 do
            local di = 'dialoguePerson'..d
            local ch = 'dialogueChat'..d
            if luaTextExists(di) then
                setProperty(di..'.y', getProperty(di..'.y') - offset)
                setProperty(ch..'.y',getProperty(di..'.y'))
                if getProperty(di..'.y') < (not downscroll and 50 or 500) then
                    removeLuaText(di,true)
                    removeLuaText(ch,true)
                    minDialogePos = minDialogePos + 1
                    for i = 1,#personsAppears do
                        if i ~= nil then
                            table.remove(personsAppears,1)
                            break
                        end
                    end
                end
            
            end
            if luaSpriteExists(ch) then
                if getProperty(ch..'.y') < (not downscroll and 50 or 500) then
                    removeLuaText(ch,true)
                    minDialogePos = minDialogePos + 1
                end
            end
        end
    end
    runHaxeCode(
        [[
            var dialogue = game.modchartTexts.get("]]..chat..[[");
            var person = game.modchartTexts.get("]]..person..[[");
            dialogue.scrollFactor.set(1,1);
            game.insert(game.members.indexOf(game.getLuaObject('bgcam'))+1,dialogue);
            dialogue.cameras = [game.camGame];
            
            person.scrollFactor.set(1,1);
            game.insert(game.members.indexOf(game.getLuaObject('bgcam'))+2,person);
            person.cameras = [game.camGame];
            return; 
        ]]
    )
    dialogueCount = dialogueCount + 1
    runTimer('startAnotherDialogue',getRandomFloat(1,2))
end
function goodNoteHit(id,data,type,sus)
    playAnim('facecambg',data,false)
end
function onTimerCompleted(tag)
    if tag == 'startAnotherDialogue' then
        createDialogue()
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Universal' then
        if v1 == '0' then
            playAnim('miyamoto','talking',true)
        elseif v1 == '1' then
            playAnim('miyamoto','motion',true)
        elseif v1 == '2' then
            doTweenX('miyamotoX','miyamoto',-1200,1.2,'cubeOut')
            doTweenX('dadX','dad',500,1.2,'cubeOut')
            doTweenAlpha('bgRedAlpha','bgred',0,1.2,'cubeInOut')
        elseif v1 == '3'then
            doTweenX('chrisBoxX','chrisBox',200,1,'quadOut')
        end
    end
end