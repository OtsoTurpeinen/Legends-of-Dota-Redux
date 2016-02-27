-- Imports
local constants = require('constants')

-- A store for all the net table stuff
local Network = class({})

-- Init network stuff
function Network:init()

end

-- Updates which phase we are currently in
function Network:setPhase(newPhaseNumber)
    CustomNetTables:SetTableValue('phase_pregame', 'phase', {v = newPhaseNumber})
end

-- Sets when this phase will end
function Network:setEndOfPhase(endTime)
    CustomNetTables:SetTableValue('phase_pregame', 'endOfTimer', {v = endTime})
end

-- Freezes the timer on a given number
function Network:freezeTimer(freezeTimer)
    CustomNetTables:SetTableValue('phase_pregame', 'freezeTimer', {v = freezeTimer})
end

-- Sets the active tab
function Network:setActiveOptionsTab(newActiveTab)
    CustomNetTables:SetTableValue('phase_pregame', 'activeTab', {v = newActiveTab})
end

-- Set an option
function Network:setOption(optionName, optionValue)
    CustomNetTables:SetTableValue('options', optionName, {v = optionValue})
end

-- Sets the network hero data
function Network:setHeroData(heroName, heroData)
    CustomNetTables:SetTableValue('heroes', heroName, heroData)
end

-- Networks flag info
function Network:setFlagData(abilityName, flagData)
    CustomNetTables:SetTableValue('flags', abilityName, flagData)
end

-- Sets a player's selected hero
function Network:setSelectedHero(playerID, heroName)
    CustomNetTables:SetTableValue('selected_heroes', tostring(playerID), {
        heroName = heroName,
        playerID = playerID
    })
end

-- Sets a player's selected primary attribute
function Network:setSelectedAttr(playerID, newAttr)
    CustomNetTables:SetTableValue('selected_attr', tostring(playerID), {
        newAttr = newAttr,
        playerID = playerID
    })
end

-- Puts a skill into a slot, NO VALIDATION
function Network:setSelectedAbilities(playerID, skills)
    -- Push to everyone
    CustomNetTables:SetTableValue('selected_skills', tostring(playerID), {
        playerID = playerID,
        skills = skills
    })
end

-- Sends a player's potential builds
function Network:setAllRandomBuild(playerID, builds)
    -- Push to everyone
    CustomNetTables:SetTableValue('random_builds', tostring(playerID), {
        playerID = playerID,
        builds = builds
    })
end

-- Sends a notification to a player
function Network:sendNotification(ply, options)
    -- Ensure we have an options table
    options = options or {}

    -- Ensure we have a valid player
    if not IsValidEntity(ply) then return end

    -- Push it
    CustomGameEventManager:Send_ServerToPlayer(ply, 'lodNotification', options)
end

-- Pushes that a skill is banned
function Network:banAbility(abilityName)
    -- Push to everyone
    CustomNetTables:SetTableValue('banned', abilityName, {
        abilityName = abilityName
    })
end

-- Pushes that a hero is banned
function Network:banHero(heroName)
    -- Push to everyone
    CustomNetTables:SetTableValue('bannedHero', heroName, {
        heroName = heroName
    })
end

-- Pushes the ready state
function Network:sendReadyState(readyState)
    -- Push to everyone
    CustomNetTables:SetTableValue('ready', 'ready', readyState)
end

-- Return an instance of it
return Network()