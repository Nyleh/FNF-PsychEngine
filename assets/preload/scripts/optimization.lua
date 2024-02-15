function onCreate()
    addHaxeLibrary('Assets','openfl.utils');
end
function removeFromMemory(path,removeImageInstantly)
    if(path ~= nil) then
        if removeImageInstantly == nil then
            removeImageInstantly = true
        end
        runHaxeCode(
            [[
                var foundPath = Paths.getPath("images/]]..path..[[.png");
                if(Assets.cache.hasBitmapData(foundPath)){
                    Assets.cache.removeBitmapData(foundPath);
                }
                if(!FlxG.bitmap._cache.exists(foundPath)){
                    foundPath = Paths.modsImages("]]..path..[[");
                }
                if(!FlxG.bitmap._cache.exists(foundPath)){
                    foundPath = '';
                }

                if(foundPath == ''){
                    return;
                }
        
                var modGraphic = FlxG.bitmap._cache.get(foundPath);
                if(modGraphic != null){
                    FlxG.bitmap.removeByKey(foundPath);
                    if(Paths.currentTrackedAssets.exists(foundPath)){
                        Paths.currentTrackedAssets.remove(foundPath);
                    }
                    if(Paths.localTrackedAssets.contains(foundPath)){
                        Paths.localTrackedAssets.remove(Paths.localTrackedAssets.indexOf(foundPath));
                    }
                    modGraphic.persist = false;
                    modGraphic.destroyOnNoUse = true;
                    if(]]..tostring(removeImageInstantly)..[[){
                        modGraphic.destroy();
                    }
                }
            ]]
        )
    end
end

function removeCharacterFromMemory(character,removeImageInstantly)
    local foundedImage = runHaxeCode(
        [[
            var imageFile = '';
            var charName = "]]..character..[[";
            var char = null;

            if(game.boyfriendMap.exists(charName)){
                char = game.boyfriendMap.get(charName);
                game.boyfriendGroup.remove(char,true);
                game.boyfriendMap.remove(charName);
            }
            if(game.dadMap.exists(charName)){
                char = game.dadMap.get(charName);
                game.dadGroup.remove(char,true);
                game.dadMap.remove(charName);
            }
            if(game.gfMap.exists(charName)){
                char = game.gfMap.get(charName);
                game.gfGroup.members.remove(char,true);
                game.gfGroup.remove(char,true);
                game.gfMap.remove(charName);
            }
            
            if(char != null){
                imageFile = char.imageFile;
                char.kill();
                char.destroy();
            }

            if(imageFile != null && imageFile != ''){
                return imageFile;
            }
            return false;
        ]]
    )

    if foundedImage ~= false then
        removeFromMemory(foundedImage,removeImageInstantly ~= false)
    end
end

function onCreatePost()
    removeCharacterFromMemory('bf-dead')
    removeFromMemory('logo');
    runHaxeCode(
        [[
            if(!game.isPixelStage){
                Assets.cache.clear('assets/shared/images/pixelUI');
            }
            return;
        ]]
    )
end

function optimizeStage(name,stage)
    --This will try to remove the images from Memory, reducing your consumption.

    if name == 'allfinal' then
        --local images = {};
        local stages = {};
        if(stage == 0)then
            stages = {'act1','act1_bgbuildings','act1_floor','act1_sky','act1_skyline','act1_stat','Act_2_Intro','act1_gradient'};

        elseif(stage == 1)then
            stages = {'act2','act2_abyss_gradient','act2_pipes_close','act2_pipes_far','act2_pipes_lgbf','act2_pipes_middle','act2_pipes_waryosh','act2_scroll1','act2_static'};

        elseif(stage == 2)then
            stages = {'act3','Act3_bfpipe','Act3_Hills','Act3_Static','Act3_Ultra_M','Act3_Ultra_M_Head','Act3_Ultra_M_Head2','Act3_Ultra_Pupils','act3Spotlight'};
        elseif(stage == 3)then
            stages = {'Act_4_Voiceline','bf pipe final'};
        elseif(stage == 4)then
            stages = {'spotlight'};
        else
            return;
        end

        for i,image in pairs(stages) do
            removeFromMemory('mario/allfinal/act'..(stage+1)..'/'..image);
        end
    elseif name == 'virtual' then
        if(stage == 1) then
            removeFromMemory('mario/virtual/Main Platform');
            removeFromMemory('mario/virtual/Back Platform');
            removeFromMemory('mario/virtual/Back Pipes');
            removeFromMemory('mario/virtual/Front Pipes');
            removeFromMemory('mario/virtual/v_koopa_thorny');
            removeFromMemory('mario/virtual/Wall Bg');
            --removeFromMemory('mario/virtual/Back Pipes')
        elseif(stage == 2)then
            removeFromMemory('mario/virtual/toolateBG');
            removeFromMemory('mario/virtual/Platform');
        end
    elseif name == 'nesbeat' then
        if (stage == '1') then
            removeFromMemory('mario/beatus/duck0',false);
            removeFromMemory('mario/beatus/duck1',false);
            removeFromMemory('mario/beatus/duck2',false);
            removeFromMemory('mario/beatus/arbust',false);
            removeFromMemory('mario/beatus/grass',false);
            removeFromMemory('mario/beatus/tree',false);
        end
    end
end