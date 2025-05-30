slot0 = class("WorldConst")
slot0.Debug = false

slot0.Print = function(...)
	if uv0.Debug then
		warning(...)
	end
end

slot0.DebugPrintAttachmentCell = function(slot0, slot1)
	if not uv0.Debug then
		return
	end

	warning(slot0)

	for slot5, slot6 in pairs(slot1) do
		warning(slot5, #slot6.attachmentList)

		for slot10, slot11 in ipairs(slot6.attachmentList) do
			warning(slot11:DebugPrint())
		end
	end
end

slot0.DefaultAtlas = 1

slot0.GetProgressAtlas = function(slot0)
	return uv0.DefaultAtlas
end

slot0.MaxRow = 30
slot0.MaxColumn = 30
slot0.LineCross = 2
slot0.ActionIdle = "normal"
slot0.ActionMove = "move"
slot0.ActionDrag = "tuozhuai"
slot0.ActionYun = "yun"
slot0.ActionVanish = "vanish"
slot0.ActionAppear = "appear"
slot0.AutoFightLoopCountLimit = 25
slot0.EnemySize = {
	1,
	2,
	3,
	1,
	2,
	3,
	1,
	2,
	3,
	1,
	2,
	3,
	3,
	[99.0] = 99
}
slot0.ResourceID = 3002
slot0.SwitchPlainingItemId = 120
slot0.ReqName = {
	"OpReqMoveFleet",
	"OpReqBox",
	nil,
	nil,
	nil,
	nil,
	nil,
	"OpReqRound",
	"OpReqSub",
	"OpReqEvent",
	nil,
	"OpReqDiscover",
	"OpReqTransport",
	"OpReqRetreat",
	nil,
	nil,
	nil,
	"OpReqTask",
	nil,
	"OpReqMaintenance",
	"OpReqVision",
	nil,
	"OpReqRedeploy",
	nil,
	"OpReqPressingMap",
	"OpReqJumpOut",
	"OpReqEnterPort",
	"OpReqCatSalvage",
	"OpReqSwitchFleet",
	[99.0] = "OpReqSkipBattle"
}

for slot4, slot5 in pairs(slot0.ReqName) do
	slot0[slot5] = slot4
end

slot0.OpActionFleetMove = -100
slot0.OpActionAttachmentMove = -101
slot0.OpActionAttachmentAnim = -102
slot0.OpActionNextRound = -103
slot0.OpActionEventOp = -104
slot0.OpActionMoveStep = -105
slot0.OpActionUpdate = -106
slot0.OpActionFleetAnim = -107
slot0.OpActionEventEffect = -108
slot0.OpActionTaskGoto = -109
slot0.OpActionCameraMove = -110
slot0.OpActionTrapGravityAnim = -111
slot0.RoundPlayer = 0
slot0.RoundElse = 1
slot0.DirNone = 0
slot0.DirUp = 1
slot0.DirRight = 2
slot0.DirDown = 3
slot0.DirLeft = 4

slot0.DirToLine = function(slot0)
	if slot0 == uv0.DirNone then
		return {
			row = 0,
			column = 0
		}
	elseif slot0 == uv0.DirUp then
		return {
			row = -1,
			column = 0
		}
	elseif slot0 == uv0.DirRight then
		return {
			row = 0,
			column = 1
		}
	elseif slot0 == uv0.DirDown then
		return {
			row = 1,
			column = 0
		}
	elseif slot0 == uv0.DirLeft then
		return {
			row = 0,
			column = -1
		}
	else
		assert(false, "without this dir " .. slot0)
	end
end

slot0.DefaultMapOffset = Vector3(0, -1000, -1000)

slot0.InFOVRange = function(slot0, slot1, slot2, slot3, slot4)
	slot4 = slot4 or uv0.GetFOVRadius()

	return (slot0 - slot2) * (slot0 - slot2) + (slot1 - slot3) * (slot1 - slot3) <= slot4 * slot4
end

slot0.GetFOVRadius = function()
	return pg.gameset.world_move_initial_view.key_value
end

slot0.IsRookieMap = function(slot0)
	return _.any(pg.gameset.world_guide_map_list.description, function (slot0)
		return uv0 == slot0
	end)
end

slot0.GetRealmRookieId = function(slot0)
	assert(slot0 and slot0 > 0)

	return unpack(pg.gameset.world_default_entrance.description[slot0])
end

slot0.ParseConfigDir = function(slot0, slot1)
	if slot0 == -1 then
		return WorldConst.DirUp
	elseif slot0 == 1 then
		return WorldConst.DirDown
	elseif slot1 == -1 then
		return WorldConst.DirLeft
	elseif slot1 == 1 then
		return WorldConst.DirRight
	end

	assert(false)
end

slot0.Pos2FogRes = function(slot0, slot1)
	return "miwu0" .. slot0 % 3 * 3 + slot1 % 3 + 1
end

slot0.TerrainStreamRes = {
	"yangliu_shang",
	"yangliu_you",
	"yangliu_xia",
	"yangliu_zuo"
}
slot0.TerrainWindRes = {
	"longjuanfeng_shang",
	"longjuanfeng_you",
	"longjuanfeng_xia",
	"longjuanfeng_zuo"
}
slot0.TerrainPoisonRes = {
	"poison01",
	"poison02"
}

slot0.GetTerrainEffectRes = function(slot0, slot1, slot2)
	if slot0 == WorldMapCell.TerrainStream then
		slot3 = uv0.TerrainStreamRes[slot1]

		return "world/object/" .. slot3, slot3
	elseif slot0 == WorldMapCell.TerrainWind then
		slot3 = uv0.TerrainWindRes[slot1]

		return "world/object/" .. slot3, slot3
	elseif slot0 == WorldMapCell.TerrainIce then
		return "world/object/ice", "ice"
	elseif slot0 == WorldMapCell.TerrainPoison then
		slot3 = uv0.TerrainPoisonRes[slot2]

		return "world/object/" .. slot3, slot3
	end

	assert(false)
end

slot0.GetWindEffect = function()
	return "world/object/longjuanfeng", "longjuanfeng"
end

slot0.GetBuffEffect = function(slot0)
	return "ui/" .. slot0, slot0
end

slot0.PoisonEffect = "san_low"

slot0.ArrayEffectOrder = function(slot0, slot1)
	slot2 = {}

	table.insertto(slot2, slot0:GetComponentsInChildren(typeof(Renderer), true):ToTable())
	table.insertto(slot2, slot0:GetComponentsInChildren(typeof(Canvas), true):ToTable())

	for slot8, slot9 in ipairs(slot2) do
		slot9.sortingOrder = slot9.sortingOrder + slot1
	end
end

slot0.Flag16Max = 65535
slot0.LOEffectA = 1
slot0.LOQuad = 1000
slot0.LOEffectB = 1001
slot0.LOItem = 2000
slot0.LOEffectC = 2001
slot0.LOCell = 3000
slot0.LOFleet = 3001
slot0.LOTop = 4000
slot0.WindScale = {
	0.5,
	0.5,
	0.75,
	0.75,
	1
}

slot0.GetWindScale = function(slot0)
	slot1 = slot0 and uv0.WindScale[slot0] or 1

	return Vector3(slot1, slot1, slot1)
end

slot0.BaseMoveDuration = 0.35

slot0.GetTerrainMoveStepDuration = function(slot0)
	uv0.MoveStepDuration = uv0.MoveStepDuration or {
		[WorldMapCell.TerrainNone] = uv0.BaseMoveDuration,
		[WorldMapCell.TerrainWind] = uv0.BaseMoveDuration / 2,
		[WorldMapCell.TerrainStream] = uv0.BaseMoveDuration / 2,
		[WorldMapCell.TerrainIce] = uv0.BaseMoveDuration / 2,
		[WorldMapCell.TerrainFog] = uv0.BaseMoveDuration,
		[WorldMapCell.TerrainFire] = uv0.BaseMoveDuration,
		[WorldMapCell.TerrainPoison] = uv0.BaseMoveDuration
	}

	return uv0.MoveStepDuration[slot0]
end

slot0.UIEaseDuration = 0.5
slot0.UIEaseFasterDuration = 0.3
slot0.ModelSpine = 1
slot0.ModelPrefab = 2
slot0.ResBoxPrefab = "boxprefab/"
slot0.ResChapterPrefab = "chapter/"
slot0.DirType1 = 1
slot0.DirType2 = 2
slot0.DirType4 = 4

slot0.CalcModelPosition = function(slot0, slot1)
	return Vector3((slot0.config.area_pos[1] - slot1.x / 2) / PIXEL_PER_UNIT, 0, (slot0.config.area_pos[2] - slot1.y / 2) / PIXEL_PER_UNIT)
end

slot0.BrokenBuffId = pg.gameset.world_death_buff.key_value
slot0.MoveLimitBuffId = pg.gameset.world_move_buff_desc.key_value
slot0.DamageBuffList = pg.gameset.world_buff_morale.description

slot0.ExtendPropertiesRatesFromBuffList = function(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		assert(slot6.class == WorldBuff)

		if slot6:IsValid() then
			for slot10, slot11 in ipairs(slot6.config.buff_attr) do
				assert(slot6.config.percent[slot10] == 1)

				slot0[slot11] = defaultValue(slot0[slot11], 1) * (10000 + slot6.config.buff_effect[slot10] * slot6:GetFloor()) / 10000
			end
		end
	end
end

slot0.AppendPropertiesFromBuffList = function(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		assert(slot7.class == WorldBuff)

		if slot7:IsValid() then
			for slot11, slot12 in ipairs(slot7.config.buff_attr) do
				if slot7.config.percent[slot11] == 1 then
					slot1[slot12] = defaultValue(slot1[slot12], 0) + slot7.config.buff_effect[slot11] * slot7:GetFloor()
				else
					slot0[slot12] = defaultValue(slot0[slot12], 0) + slot7.config.buff_effect[slot11] * slot7:GetFloor()
				end
			end
		end
	end

	for slot6, slot7 in pairs(slot1) do
		slot1[slot6] = 1 + slot7 / 10000
	end
end

slot0.TaskTypeSubmitItem = 2
slot0.TaskTypeArrivePort = 6
slot0.TaskTypeFleetExpansion = 7
slot0.TaskTypePressingMap = 12
slot0.FleetRedeploy = 1
slot0.FleetExpansion = 2
slot0.QuadBlinkDuration = 1
slot0.QuadSpriteWhite = "cell_white"
slot0.TransportDisplayNormal = 0
slot0.TransportDisplayGuideEnable = 1
slot0.TransportDisplayGuideDanger = 2
slot0.TransportDisplayGuideForbid = 3

slot0.CalcRelativeRectPos = function(slot0, slot1, slot2, slot3)
	slot4 = slot2.x + slot1.width / 2
	slot5 = slot2.x + slot2.width - slot1.width / 2
	slot6 = slot2.y + slot1.height / 2
	slot7 = slot2.y + slot2.height - slot1.height / 2

	slot8 = function(slot0)
		return uv0 <= slot0.x and slot0.x <= uv1 and uv2 <= slot0.y and slot0.y <= uv3
	end

	slot10 = Quaternion.Euler(0, 0, 10)

	for slot14 = slot3, 0, -50 do
		slot15 = Vector3(slot14, 0, 0)

		for slot19 = 360 / slot9, 1, -1 do
			if slot8(slot0 + slot10 * slot15) then
				return slot0 + slot15
			end
		end
	end

	return _.min({
		Vector2(slot4, slot6),
		Vector2(slot4, slot7),
		Vector2(slot5, slot7),
		Vector2(slot5, slot6)
	}, function (slot0)
		return Vector2.Distance(slot0, uv0)
	end)
end

slot0.GetMapIconState = function(slot0)
	if slot0 == 1 then
		return "normal"
	elseif slot0 == 2 then
		return "danger"
	elseif slot0 == 3 then
		return "danger"
	else
		assert(false, "config error:" .. slot0)
	end
end

slot0.HasDangerConfirm = function(slot0)
	if slot0 == 1 then
		return false
	elseif slot0 == 2 then
		return false
	elseif slot0 == 3 then
		return true
	else
		assert(false, "config error:" .. slot0)
	end
end

slot0.SystemCompass = 1
slot0.SystemMemo = 2
slot0.SystemInventory = 3
slot0.SystemWorldBoss = 4
slot0.SystemCollection = 5
slot0.SystemSubmarine = 6
slot0.SystemFleetDetail = 7
slot0.SystemWorldInfo = 8
slot0.SystemRedeploy = 9
slot0.SystemScanner = 10
slot0.SystemResource = 11
slot0.SystemOutMap = 12
slot0.SystemOrderRedeploy = slot0.SystemRedeploy
slot0.SystemOrderMaintenance = 13
slot0.SystemOrderFOV = 15
slot0.SystemOrderSubmarine = slot0.SystemSubmarine
slot0.SystemResetCountDown = 16
slot0.SystemResetExchange = 17
slot0.SystemResetShop = 18
slot0.SystemAutoFight_1 = 19
slot0.SystemAutoFight_2 = 20
slot0.SystemAutoSwitch = 21
slot0.SystemDailyTask = 22

slot0.BuildHelpTips = function(slot0)
	slot1 = i18n("world_stage_help")
	slot3 = 1

	for slot7, slot8 in ipairs(pg.gameset.world_stage_help.description) do
		if slot8[1] <= slot0 then
			table.insert(slot1, slot3, {
				icon = {
					path = "",
					atlas = slot8[2]
				}
			})

			slot3 = slot3 + 1
		end
	end

	return slot1
end

slot0.AnimRadar = "RadarEffectUI"

slot0.FindStageTemplates = function(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(pg.world_stage_template.all) do
		if pg.world_stage_template[slot6].stage_key == slot0 then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

slot0.GetRookieBattleLoseStory = function()
	return pg.gameset.world_story_special_2.description[1]
end

slot0.FOVMapSight = 1
slot0.FOVEventEffect = 2
slot0.GuideEnemyEnd = false

slot0.IsWorldGuideEnemyId = function(slot0)
	if uv0.GuideEnemyEnd then
		return false
	end

	return table.contains(pg.gameset.world_guide_enemy_id.description, slot0)
end

slot0.WorldLevelCorrect = function(slot0, slot1)
	for slot5, slot6 in ipairs(pg.gameset.world_expedition_level.description) do
		for slot10, slot11 in ipairs(slot6[1]) do
			if slot1 == slot11 then
				slot0 = slot0 + slot6[2]
			end
		end
	end

	return math.max(slot0, 1)
end

slot0.GetAreaFocusPos = function(slot0)
	slot1 = pg.world_regions_data[slot0].regions_pos

	return Vector2(slot1[1], slot1[2])
end

slot0.GetTransportBlockEvent = function()
	if not uv0.blockEventDic then
		uv0.blockEventDic = {}

		for slot3, slot4 in ipairs(pg.gameset.world_movelimit_event.description) do
			uv0.blockEventDic[slot4] = true
		end
	end

	return uv0.blockEventDic
end

slot0.GetTransportStoryEvent = function()
	if not uv0.blockStoryDic then
		uv0.blockStoryDic = {}

		for slot3, slot4 in ipairs(pg.gameset.world_transfer_eventlist.description) do
			uv0.blockStoryDic[slot4] = true
		end
	end

	return uv0.blockStoryDic
end

slot0.IsWorldHelpNew = function(slot0, slot1)
	if slot1 then
		PlayerPrefs.SetInt("world_help_progress", slot0)
		PlayerPrefs.Save()

		return false
	else
		if slot0 > (PlayerPrefs.HasKey("world_help_progress") and PlayerPrefs.GetInt("world_help_progress") or 0) then
			for slot6, slot7 in ipairs(pg.world_help_data.all) do
				if pg.world_help_data[slot7].stage <= slot0 then
					if slot2 < slot8.stage then
						return true
					else
						for slot12, slot13 in ipairs(slot8.stage_help) do
							if slot2 < slot13[1] and slot13[1] <= slot0 then
								return true
							end
						end
					end
				end
			end
		end

		return false
	end
end

slot0.ParsingBuffs = function(slot0)
	_.each(slot0, function (slot0)
		slot1 = WorldBuff.New()

		slot1:Setup({
			id = slot0.id,
			floor = slot0.stack,
			round = slot0.round,
			step = slot0.step
		})

		uv0[slot1.id] = slot1
	end)

	return {}
end

slot0.CompareBuffs = function(slot0, slot1)
	slot3 = {}
	slot4 = _.extend({}, slot1)

	for slot8, slot9 in pairs(_.extend({}, slot0)) do
		if slot4[slot8] then
			slot3[slot8] = slot2[slot8]
			slot2[slot8] = nil
			slot4[slot8] = nil
		end
	end

	return {
		remove = slot2,
		continue = slot3,
		add = slot4
	}
end

slot0.FetchWorldShip = function(slot0)
	slot1 = nowWorld():GetShip(slot0)

	assert(slot1, "world ship not exist: " .. slot0)

	return slot1
end

slot0.FetchShipVO = function(slot0)
	slot2 = getProxy(BayProxy):getShipById(slot0)

	assert(slot2, "ship not exist: " .. slot0)

	return slot2
end

slot0.FetchRawShipVO = function(slot0)
	slot2 = getProxy(BayProxy):getRawData()[slot0]

	assert(slot2, "ship not exist: " .. slot0)

	return slot2
end

slot0.ReqWorldCheck = function(slot0)
	slot1 = {}

	if nowWorld().type == World.TypeBase then
		table.insert(slot1, function (slot0)
			slot1 = pg.ConnectionMgr.GetInstance()

			slot1:Send(33000, {
				type = 0
			}, 33001, function (slot0)
				slot1 = getProxy(WorldProxy)

				slot1:BuildWorld(World.TypeFull)
				slot1:NetFullUpdate(slot0)
				uv0()
			end)
		end)
	end

	seriesAsync(slot1, slot0)
end

slot0.ReqWorldForServer = function()
	slot0 = pg.ConnectionMgr.GetInstance()

	slot0:Send(33000, {
		type = 1
	}, 33001, function (slot0)
	end)
end

slot0.ObstacleConfig = {
	[0] = 2,
	3,
	7,
	0,
	6,
	1,
	4,
	5
}
slot0.ObstacleType = {
	"leave",
	"arrive",
	"pass"
}

slot0.GetObstacleKey = function(slot0)
	return bit.lshift(1, #uv0.ObstacleType - table.indexof(uv0.ObstacleType, slot0))
end

slot0.GetObstacleConfig = function(slot0, slot1)
	return bit.band(uv0.ObstacleConfig[slot0], uv0.GetObstacleKey(slot1)) > 0
end

slot0.RangeCheck = function(slot0, slot1, slot2)
	for slot6 = slot0.row - slot1, slot0.row + slot1 do
		for slot10 = slot0.column - slot1, slot0.column + slot1 do
			if uv0.InFOVRange(slot0.row, slot0.column, slot6, slot10, slot1) then
				slot2(slot6, slot10)
			end
		end
	end
end

slot0.CheckWorldStorySkip = function(slot0)
	return table.contains(pg.gameset.world_quickmode_skiplua.description, slot0) and getProxy(SettingsProxy):GetWorldFlag("story_tips") and pg.NewStoryMgr.GetInstance():IsPlayed(slot0)
end

slot0.GetNShopTimeStamp = function()
	if not uv0.nShopTimestamp then
		slot1, slot2, slot3 = unpack(getGameset("world_newshop_date")[2])
		uv0.nShopTimestamp = pg.TimeMgr.GetInstance():Table2ServerTime({
			day = slot3,
			month = slot2,
			year = slot1,
			sec = 0,
			min = 0,
			hour = 0
		})
	end

	return uv0.nShopTimestamp
end

return slot0
