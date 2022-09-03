Config = {}

------------------------------------------------------------------------------------------------------
------------------------------------------ GENERAL STUFF ---------------------------------------------
------------------------------------------------------------------------------------------------------ 
Config.Language = 'en'
Config.ReviveInvoice = 3500 -- Invoice for Revive & Heal
Config.HealInvoice = 2000
Config.HealPlayer = true -- Allow player to heal if is not dead
Config.UseRprogress = false -- Disable if you want to revive instantly https://forum.cfx.re/t/release-standalone-rprogress-customisable-radial-progress-bars/1630655
Config.EMSJobName = 'ambulance'
Config.EMSRequired = 3

------------------------------------------------------------------------------------------------------
-------------------------------------------- PED STUFF -----------------------------------------------
------------------------------------------------------------------------------------------------------ 

Config.PedLocations = {
    {x = 319.20547485352, y = -588.57763671875, z = 43.284042358398, h = 149.54759216309} -- Needs heading
 -- {x = 111.13213213122, y = -333.32332455522, z = 43.414144222222, h = 322.32424455551} *Make sure to add a comma ^^^^
}

-- You can find PED MODEL and hash here: https://wiki.rage.mp/index.php?title=Peds
Config.RequestModel = 's_m_m_doctor_01'
-- ^^ (Hash)
Config.PedModel = 0xD47303AC 

------------------------------------------------------------------------------------------------------
------------------------------------------ 3D TEXT STUFF ---------------------------------------------
------------------------------------------------------------------------------------------------------ 
Config.Text = {
    Scale = 0.32,
    Font = 4,
    Distance = 3.5
}