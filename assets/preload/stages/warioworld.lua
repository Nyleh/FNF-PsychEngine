function onCreate()
    if shadersEnabled then
        addLuaScript('extra_scripts/createShader')
        callScript('extra_scripts/createShader','createShader',{'tvShader','TvEffect'})
        callScript('extra_scripts/createShader','runShader',{{'game','hud'},'tvShader'})
        setShaderFloat('tvShader','multiply',1.3)
        setShaderFloat('tvShader','contrast',-0.05)
        setShaderBool('tvShader','lineTv',true)
    end

    makeAnimatedLuaSprite('bg','mario/Wario/wea_mala_ctm',180,100)
    addAnimationByPrefix('bg','anim','fondo instancia 1',24,true)
    setProperty('bg.scale.x',2.4)
    setProperty('bg.scale.y',2.4)
    addLuaSprite('bg',false)
end