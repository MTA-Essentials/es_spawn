addEventHandler(
    'onResourceStart',
    resourceRoot,
    function()
        local list = {
            {'position', 'json', toJSON({x = 0, y = 0, z = 4, r = 0, i = 0, d = 0})},
        }
        for i, v in ipairs(list) do
            triggerEvent('onElementDataRegister', resourceRoot, v[1], v[2], v[3], v[4])
        end
    end
)

addEventHandler(
    'onPlayerLoaded',
    root,
    function(player)
        local pos = getElementData(player, 'position')
        if pos then
            pos = fromJSON(pos)
        else
            pos = {x = 0, y = 0, z = 4, r = 0, i = 0, d = 0}
        end
        spawnPlayer(player, pos.x, pos.y, pos.z, pos.r)
        setCameraTarget(player, player)
        setElementInterior(player, pos.i)
        setElementDimension(player, pos.d)
        setTimer(
            function()
                fadeCamera(player, true)
                triggerClientEvent(player, 'onPlayerLoginClose', resourceRoot)
            end,
            1000,
            1
        )
    end
)

addEventHandler(
    'onPlayerQuit',
    root,
    function()
        local player = source
        local px, py, pz = getElementPosition(player)
        local rx, ry, rz = getElementRotation(player)
        local pi, pd = getElementInterior(player), getElementDimension(player)
        setElementData(player, 'position', toJSON({x = px, y = py, z = pz, r = rz, i = pi, d = pd}))
    end
)

addEventHandler(
    'onPlayerWasted',
    root,
    function()
        local player = source

        if getElementData(player, 'disableAutoRespawn') then
            return
        end

        local px, py, pz = getElementPosition(player)
        local result = {}
        for i, v in ipairs(config.spawns) do
            result[#result + 1] = getDistanceBetweenPoints3D(px, py, pz, v.x, v.y, v.z)
        end

        local lowestIndex = 0
        local lowestValue = false
        for i, v in ipairs(result) do
            if not lowestValue or v < lowestValue then
                lowestIndex = i
                lowestValue = v
            end
        end

        local pos = config.spawns[lowestIndex]
        fadeCamera(player, false)
        setTimer(
            function()
                spawnPlayer(player, pos.x, pos.y, pos.z, pos.r)
                setCameraTarget(player, player)
                setElementInterior(player, pos.i)
                setElementDimension(player, pos.d)
            end,
            1100,
            1
        )
        setTimer(
            function()
                fadeCamera(player, true)
            end,
            2100,
            1
        )
    end
)

addEvent('onPlayerRespawn')
addEventHandler(
    'onPlayerRespawn',
    root,
    function(player)
        local px, py, pz = getElementPosition(player)
        local result = {}
        for i, v in ipairs(config.spawns) do
            result[#result + 1] = getDistanceBetweenPoints3D(px, py, pz, v.x, v.y, v.z)
        end

        local lowestIndex = 0
        local lowestValue = false
        for i, v in ipairs(result) do
            if not lowestValue or v < lowestValue then
                lowestIndex = i
                lowestValue = v
            end
        end

        local pos = config.spawns[lowestIndex]
        fadeCamera(player, false)
        setTimer(
            function()
                spawnPlayer(player, pos.x, pos.y, pos.z, pos.r)
                setCameraTarget(player, player)
                setElementInterior(player, pos.i)
                setElementDimension(player, pos.d)
            end,
            1100,
            1
        )
        setTimer(
            function()
                fadeCamera(player, true)
            end,
            2100,
            1
        )
    end
)
