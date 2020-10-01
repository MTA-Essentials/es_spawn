addEvent('onUserSpawn', true)
addEventHandler(
    'onUserSpawn',
    root,
    function()
        local player = client
        if config.spawn == 'static' then
            spawn = config.static
        elseif config.spawn == 'random' then
        elseif config.spawn == 'last' then
        end
        spawnPlayer(player, spawn.x, spawn.y, spawn.z, spawn.r)
        setCameraTarget(player, player)
        setElementInterior(player, spawn.i)
        setElementDimension(player, spawn.d)
        setTimer(
            function()
                fadeCamera(player, true)
            end,
            2100,
            1
        )
    end
)
