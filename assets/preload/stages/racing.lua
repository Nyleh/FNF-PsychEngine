function onCreate()
    makeLuaSprite('bg','mario/Races/Race_Mario_BG2',-100,-50)
    setScrollFactor('bg',0.5,0.5)
    addLuaSprite('bg',false)

    makeLuaSprite('bgColuna','mario/Races/Race_Mario_BG3',-400,-150)
    setScrollFactor('bgColuna',0.9,0.9)
    addLuaSprite('bgColuna',false)

    makeAnimatedLuaSprite('race','mario/Races/Race_Mario_BG1',-160,-120)
    addAnimationByPrefix('race','anim','Ground',24,true)
    scaleObject('race',1.3,1.3)
    setProperty('race.offset.x',0)
    setProperty('race.offset.y',0)
    setScrollFactor('race',0.5,0.5)
    addLuaSprite('race',false)
end
function onUpdatePost()
    setProperty('dad.x',getProperty('dadGroup.x') + (50*math.sin(getSongPosition()/bpm/5)))
    setProperty('boyfriend.x',getProperty('boyfriendGroup.x') - 200 + (50*math.sin(getSongPosition()/bpm/4)))
    setProperty('gf.x',getProperty('gfGroup.x') + (50*math.sin(getSongPosition()/bpm/3)))
end
