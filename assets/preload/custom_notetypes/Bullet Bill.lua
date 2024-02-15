
local bulletTime = 0
function onCreate()
    precacheSound('SHbullethit')
    precacheImage('BulletBillMario_NOTE_assets')
    runHaxeCode(
        [[
            var bullets = [];

            for(note in game.unspawnNotes.copy()){
                if(note.noteType == "Bullet Bill"){
                    bullets.push(note);
                    note.texture = 'BulletBillMario_NOTE_assets';
                    note.blockHit = true;
                    note.offsetX = -50;
                    note.missHealth = 1;
                    ]]..(version > '0.6.3' and 'note.noteSplashData.disabled = true;' or 'note.noteSplashDisabled = true;')..[[
                    for(bullet in bullets){
                        if(note.noteData != bullet.noteData && note.strumTime == bullet.strumTime && note.mustPress == bullet.mustPress ){
                            if(note.noteData >= bullet.noteData){
                                game.unspawnNotes.remove(note);
                            }
                            else{
                                game.unspawnNotes.remove(bullet);
                                bullets.remove(bullet);
                            }
                            break;
                        }
                    }
                }
            }
            return;
        ]]
    )
end
function onUpdatePost(el)
    local noteKeys = {'left','down','up','right'}
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'noteType') == 'Bullet Bill' and math.abs(getPropertyFromGroup('notes',notes,'strumTime') - getSongPosition()) < 400 then
            local mustPress = getPropertyFromGroup('notes',notes,'mustPress')
            local data = getPropertyFromGroup('notes',notes,'noteData')
            if mustPress and (not botplay and keyPressed(noteKeys[data+1]) and keyJustPressed(noteKeys[data+2]) or keyPressed(noteKeys[data+2]) and keyJustPressed(noteKeys[data+1])) or not mustPress then
                createBoom(mustPress,data)
                removeFromGroup('notes',notes)
                runHaxeCode(
                    [[
                        game.]]..(mustPress and 'playerStrums' or 'opponentStrums')..[[.members[]]..data..[[].playAnim('confirm');
                        game.]]..(mustPress and 'playerStrums' or 'opponentStrums')..[[.members[]]..(data+1)..[[].playAnim('confirm');
                        return;
                    ]]
                )
            end
        end
    end
    if bulletTime > 0 then
        bulletTime = bulletTime - el
    end
    for splash = 0,4 do
        if luaSpriteExists('BulletBoom'..splash) then
            setProperty('BulletBoom'..splash..'.visible',not getProperty('BulletBoom'..splash..'.animation.curAnim.finished'))
        else
            break
        end
    end
end
local splashCount = 0
function createSplashBoom(x,y)
    local name = 'BulletBoom'..splashCount
    makeAnimatedLuaSprite(name,'BulletBillMario_NOTE_assets',x-400,y-300)
    addAnimationByPrefix(name,'anim','noteSplash0',24,false)
    setObjectCamera(name,'hud')
    addLuaSprite(name,true)
    playSound('SHbullethit')
    splashCount = (splashCount + 1)%5
end
function createBoom(mustPress,data)
    if mustPress then
        createSplashBoom(getPropertyFromGroup('playerStrums',data,'x'),getPropertyFromGroup('playerStrums',data,'y'))
    else
        createSplashBoom(getPropertyFromGroup('opponentStrums',data,'x'),getPropertyFromGroup('opponentStrums',data,'y'))
    end
end