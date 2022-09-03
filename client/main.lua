
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
 	end
	createNpc()
end)

-- Creating the ped function
function createNpc()
	RequestModel(GetHashKey(Config.RequestModel))
	while (not HasModelLoaded(GetHashKey(Config.RequestModel))) do
		Citizen.Wait(1)
	end
	for k,v in pairs(Config.PedLocations) do
		local npc = CreatePed(5, Config.PedModel, v.x, v.y, v.z-0.95, v.h, false, true)
		FreezeEntityPosition(npc, true)
		SetEntityInvincible(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
	end
end

-- CREATE 3D TEXT
function DrawText3D(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	local color = Config.Text.Color
	SetTextScale(Config.Text.Scale, Config.Text.Scale)
	SetTextFont(Config.Text.Font)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 500
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

Citizen.CreateThread(function()
	local letSleep = true
	local wait = 5
	while true do
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		for k,v in pairs(Config.PedLocations) do
			local dist = #(playerCoords - vector3(v.x, v.y, v.z))
			if dist <= Config.Text.Distance then
				letSleep = false
				DrawText3D(v.x, v.y, v.z, Locales[Config.Language]['press_to_heal'])
				wait = 0
				if IsControlJustReleased(0, 38) then
					wait = 500
					ESX.TriggerServerCallback('lsrp_hos:checkEMS', function(emsRequired)
						if not emsRequired then
							ESX.TriggerServerCallback('lsrp_hos:isDead', function(shouldDie)
								print("dwq")
								if shouldDie then                                             
									ESX.TriggerServerCallback('lsrp_hos:canPay', function(canPay)
										if canPay then
												SetEntityVisible(PlayerPedId(), false)
												SetEntityInvincible(PlayerPedId(), true)
												fdeath()
												ESX.ShowNotification(Locales[Config.Language]['successfully_paid'])
												Citizen.Wait(500)
												SetEntityVisible(PlayerPedId(), true)
												SetEntityInvincible(PlayerPedId(), false)
										else
											ESX.ShowNotification(Locales[Config.Language]['not_enough_money'])
										end
									end, Config.ReviveInvoice)
								else
									if Config.HealPlayer then
										local health = GetEntityHealth(PlayerPedId())
										if health <= 199 then
											ESX.TriggerServerCallback('lsrp_hos:canPay', function(canPay)
													if canPay then
															print(health)
															SetEntityHealth(playerPed, 200)
															ESX.ShowNotification(Locales[Config.Language]['successfully_paid2'])
													else
														print('1')
														ESX.ShowNotification(Locales[Config.Language]['not_enough_money'])
													end
											end, Config.HealInvoice)
										else 
											ESX.ShowNotification('Jsi plně zdravý a ošetřit nepotřebuješ..') 
										end
									else
										ESX.ShowNotification(Locales[Config.Language]['player_is_not_dead'])
									end
								end
							end)
						else
							ESX.ShowNotification(Locales[Config.Language]['enough_ems'])
						end
					end, ems)
				end
			end
		end

		if letSleep then
			Citizen.Wait(2500)
		end

		Citizen.Wait(wait)
	end
end)


maleScene = 'MP_INT_MCS_18_A1'
femaleScene = 'MP_INT_MCS_18_A2'

function fdeath()
	TriggerEvent('esx_ambulancejob:revive')
	Citizen.Wait(800)
	SetCutsceneTriggerArea(0.0, 0.0, 0.0, 0.0, 121.6249, 0.0);
	x = AddNavmeshBlockingObject(-1314.997, -1721.084, 1.1493, 100.0, 100.0, 100.0, 0.0, false, 7)
	SetPedNonCreationArea(-1324.736, -1756.909, -10.0, -1299.695, -1688.181, 10.0)
	SetOverrideWeather('CLEARING')
	SetTransitionTimecycleModifier("Kifflom", 1.0)
	NetworkOverrideClockTime(18, 0, 0)
	N_0xfb680d403909dc70(1, PlayerId() + 32)
	SetRainLevel(0.0)
	PlayCutscene(maleScene, vector3(-1314.997, -1721.084, 1.1493))
	ClearTimecycleModifier()
	ClearPedNonCreationArea()
	RemoveNavmeshBlockingObject(x)
end

function PlayCutscene(cut, coords)
	while not HasThisCutsceneLoaded(cut) do 
		RequestCutsceneWithPlaybackList(cut, 29, 8)
		Wait(0) 
	end
	CreateCutscene(coords)
	Finish()
	RemoveCutscene()
	DoScreenFadeIn(500)
end

function CreateCutscene(coords)
	StartCutsceneAtCoords(coords, 0)
	DoScreenFadeIn(250)
end

function Finish()
	local tripped = false
	repeat
		Wait(0)
		if (GetCutsceneTotalDuration() - GetCutsceneTime() <= 250) then
		DoScreenFadeOut(250)
		tripped = true
		end
	until not IsCutscenePlaying()
	if (not tripped) then
		DoScreenFadeOut(100)
		Wait(150)
	end
	return
end