slot0 = class("MonopolyCar2Game")
slot1 = 100
slot2 = 50
slot3 = "xinnongpaoche"
slot4 = {
	"baerdimo_6"
}
slot5 = {
	"xinnong_3"
}
slot6 = {}
slot7 = {
	xinnong_3 = "stand2",
	baerdimo_6 = "stand2"
}
slot8 = 0.6
slot9 = "ui/activityuipage/monopolycar2_atlas"
slot10 = "B-stand"
slot11 = "F-stand"
slot12 = "B-walk"
slot13 = "F-walk"
slot14 = "typeMoveUp"
slot15 = "typeMoveDown"
slot16 = "typeMoveLeft"
slot17 = "typeMoveRight"
slot18 = {
	{
		5006,
		5007,
		5008,
		5009,
		5010
	},
	{
		5005,
		0,
		0,
		0,
		5011
	},
	{
		5004,
		0,
		0,
		0,
		5012
	},
	{
		5003,
		0,
		0,
		0,
		5013
	},
	{
		5002,
		0,
		0,
		0,
		5014
	},
	{
		2001,
		5018,
		5017,
		5016,
		5015
	}
}

slot0.Ctor = function(slot0, slot1, slot2, slot3)
	slot0._binder = slot1
	slot0._tf = slot2
	slot0._event = slot3

	slot0:initData()
	slot0:initUI()
	slot0:initEvent()
end

slot0.initData = function(slot0)
	slot0.leftCount = 0
	slot0.inAnimatedFlag = false
	slot0.mapCells = {}
	slot0.showCharNames = {}

	if uv0 and #uv0 > 0 then
		table.insert(slot0.showCharNames, Clone(uv0[math.random(1, #uv0)]))
	end

	if uv1 and #uv1 > 0 then
		table.insert(slot0.showCharNames, Clone(uv1[math.random(1, #uv1)]))
	end

	if uv2 and #uv2 > 0 then
		table.insert(slot0.showCharNames, Clone(uv2[math.random(1, #uv2)]))
	end
end

slot0.initUI = function(slot0)
	slot0.tplMapCell = findTF(slot0._tf, "tplMapCell")
	slot0.mapContainer = findTF(slot0._tf, "mapContainer")
	slot0.char = findTF(slot0._tf, "mapContainer/char")
	slot0.showChars = {}

	for slot4 = 1, 3 do
		table.insert(slot0.showChars, findTF(slot0._tf, "showChar" .. slot4))
	end

	setActive(slot0.char, false)

	slot0.btnStart = findTF(slot0._tf, "btnStart")
	slot0.btnHelp = findTF(slot0._tf, "btnHelp")
	slot0.btnRp = findTF(slot0._tf, "btnRp")
	slot0.commonAnim = findTF(slot0.btnRp, "rpAni"):GetComponent(typeof(Animator))
	slot0.labelLeftCountTip = findTF(slot0.btnStart, "labelLeftCountTip")

	setActive(slot0.labelLeftCountTip, false)

	slot0.labelLeftCount = findTF(slot0.btnStart, "labelLeftCount")
	slot0.labelDropShip = findTF(slot0._tf, "labelDropShip")
	slot0.labelLeftRpCount = findTF(slot0._tf, "labelLeftRpCount")
	slot0.rollStep = findTF(slot0._tf, "step")

	setActive(slot0.rollStep, false)
	slot0:initMap()
	slot0:initChar()
end

slot0.initEvent = function(slot0)
	onButton(slot0._binder, slot0.btnStart, function ()
		if uv0.inAnimatedFlag then
			return
		end

		if uv0.leftCount and uv0.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		slot0 = uv0

		slot0:changeAnimeState(true)
		setActive(uv0.btnStart, true)

		slot0 = uv0._event

		slot0:emit(MonopolyCar2Page.ON_START, uv0.activity.id, function (slot0)
			if slot0 and slot0 > 0 then
				uv0:showRollAnimated(slot0)
			end
		end)
	end, SFX_PANEL)

	slot4 = function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_car_2.tip
		})
	end

	onButton(slot0._binder, slot0.btnHelp, slot4, SFX_PANEL)

	for slot4 = 1, #slot0.showChars do
		onButton(slot0._binder, slot0.showChars[slot4], function ()
			uv0._event:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)
		end, SFX_PANEL)
	end

	onButton(slot0._binder, slot0.btnRp, function ()
		if uv0.leftAwardCnt > 0 then
			uv0._event:emit(MonopolyCar2Page.ON_AWARD)
		end
	end, SFX_PANEL)
end

slot0.showRollAnimated = function(slot0, slot1)
	findTF(slot0.rollStep, "stepArrow").localEulerAngles = Vector3(0, 0, 0)
	slot3 = findTF(slot0.rollStep, "progress/bg")
	slot3:GetComponent(typeof(Image)).fillAmount = 0.1
	slot3 = findTF(slot0.rollStep, "select/bg")
	slot3:GetComponent(typeof(Image)).fillAmount = 0.1

	setText(findTF(slot0.rollStep, "labelRoll"), "0")
	seriesAsync({
		function (slot0)
			slot1 = LeanTween.value(go(uv0._tf), 1, 0, 0.2)
			slot1 = slot1:setOnUpdate(System.Action_float(function (slot0)
				uv0.btnStart:GetComponent(typeof(CanvasGroup)).alpha = slot0
			end))

			slot1:setOnComplete(System.Action(function ()
				setActive(uv0.btnStart, false)

				uv0.btnStart:GetComponent(typeof(CanvasGroup)).alpha = 1

				uv1()
			end))
		end,
		function (slot0)
			slot1 = LeanTween.value(go(uv0._tf), 0, 1, 0.2)
			slot1 = slot1:setOnUpdate(System.Action_float(function (slot0)
				uv0.rollStep:GetComponent(typeof(CanvasGroup)).alpha = slot0

				setActive(uv0.rollStep, true)
			end))

			slot1:setOnComplete(System.Action(function ()
				uv0()
			end))
		end,
		function (slot0)
			slot2 = uv0 / 6 * 0.62 / uv0
			slot3 = -uv0 * 31
			slot4 = LeanTween.value(go(uv1._tf), 0, 1, 0.7 + uv0 / 5)
			slot4 = slot4:setEase(LeanTweenType.easeOutCirc)
			slot4 = slot4:setOnUpdate(System.Action_float(function (slot0)
				findTF(uv0.rollStep, "progress/bg"):GetComponent(typeof(Image)).fillAmount = uv1 * slot0 + 0.13
				findTF(uv0.rollStep, "select/bg"):GetComponent(typeof(Image)).fillAmount = uv2 * math.floor(slot0 / (1 / uv3)) + 0.17

				setText(findTF(uv0.rollStep, "labelRoll"), math.floor(slot0 / (1 / uv3)))

				uv5.localEulerAngles = Vector3(0, 0, uv4 * slot0 - 13)
			end))

			slot4:setOnComplete(System.Action(function ()
				uv0()
			end))
		end,
		function (slot0)
			slot1 = LeanTween.value(go(uv0._tf), 1, 0, 0.3)

			slot1:setOnComplete(System.Action(function ()
				uv0()
			end))
		end,
		function (slot0)
			slot1 = LeanTween.value(go(uv0._tf), 1, 0, 0.3)
			slot1 = slot1:setOnUpdate(System.Action_float(function (slot0)
				uv0.rollStep:GetComponent(typeof(CanvasGroup)).alpha = slot0
			end))

			slot1:setOnComplete(System.Action(function ()
				setActive(uv0.rollStep, false)

				uv0.rollStep:GetComponent(typeof(CanvasGroup)).alpha = 1

				uv1()
			end))
		end
	}, function ()
		uv0.useCount = uv0.useCount + 1
		uv0.step = uv1

		if uv0.step > 0 then
			slot0 = GetSpriteFromAtlas(uv2, uv0.step)
		end

		uv0:updataUI()
		uv0:checkCharActive()
	end)
end

slot0.checkCountStory = function(slot0, slot1)
	slot2 = slot0.useCount

	if _.detect(slot0.activity:getDataConfig("story") or {}, function (slot0)
		return slot0[1] == uv0
	end) then
		pg.NewStoryMgr.GetInstance():Play(slot5[2], slot1)
	else
		slot1()
	end
end

slot0.changeAnimeState = function(slot0, slot1)
	if slot1 then
		slot0.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		slot0.inAnimatedFlag = true

		slot0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
	else
		slot0.inAnimatedFlag = false
		slot0.btnStart:GetComponent(typeof(Image)).raycastTarget = true

		slot0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
	end

	setActive(slot0.btnStart, not slot1)
end

slot0.initMap = function(slot0)
	slot0.mapCells = {}

	for slot5 = 1, #uv0 do
		slot6 = slot5 - 1
		slot7 = {
			x = -slot6 * uv1,
			y = -slot6 * uv2
		}

		for slot12 = 1, #slot1[slot5] do
			slot13 = slot12 - 1

			if slot8[slot12] > 0 then
				slot15 = cloneTplTo(slot0.tplMapCell, slot0.mapContainer, tostring(slot14))
				slot16 = Vector2(uv1 * slot13 + slot7.x, -uv2 * slot13 + slot7.y)
				slot15.localPosition = slot16
				slot17 = pg.activity_event_monopoly_map[slot14].icon
				findTF(slot15, "image"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas(uv3, slot17)
				slot19 = findTF(slot15, "image"):GetComponent(typeof(Image))

				slot19:SetNativeSize()
				table.insert(slot0.mapCells, {
					col = slot13,
					row = slot6,
					mapId = slot14,
					tf = slot15,
					icon = slot17,
					position = slot16
				})
			end
		end
	end

	table.sort(slot0.mapCells, function (slot0, slot1)
		return slot0.mapId < slot1.mapId
	end)
end

slot0.initChar = function(slot0)
	slot1 = PoolMgr.GetInstance()
	slot4 = true

	slot1:GetSpineChar(uv0, slot4, function (slot0)
		uv0.model = slot0
		uv0.model.transform.localScale = Vector3.one
		uv0.model.transform.localPosition = Vector3.zero

		uv0.model.transform:SetParent(uv0.char, false)

		uv0.anim = uv0.model:GetComponent(typeof(SpineAnimUI))

		uv0:checkCharActive()

		if uv0.pos then
			uv0:updataCharDirect(uv0.pos, false)
		end
	end)

	slot0.showCharMods = {}

	for slot4 = 1, #slot0.showCharNames do
		slot6 = PoolMgr.GetInstance()

		slot6:GetSpineChar(slot0.showCharNames[slot4], true, function (slot0)
			slot0.transform.localScale = Vector3.one
			slot0.transform.localPosition = Vector3.zero

			slot0.transform:SetParent(uv0.showChars[uv1], false)

			slot1 = slot0:GetComponent(typeof(SpineAnimUI))

			if uv2[uv3] then
				slot1:SetAction(uv2[uv3], 0)
			else
				slot1:SetAction("stand", 0)
			end

			table.insert(uv0.showCharMods, slot0)
		end)
	end
end

slot0.updataCharDirect = function(slot0, slot1, slot2)
	if slot0.model then
		slot3 = slot0.mapCells[slot1].position
		slot4 = slot1 + 1 > #slot0.mapCells and 1 or slot1 + 1
		slot5 = slot0.mapCells[slot4]
		slot6, slot7 = slot0:getMoveType(slot0.mapCells[slot1].mapId, slot0.mapCells[slot4].mapId, slot2)
		slot0.char.localScale = Vector3(slot7, slot0.char.localScale.y, slot0.char.localScale.z)

		slot0.anim:SetActionCallBack(nil)
		slot0.anim:SetAction(slot6, 0)
	end
end

slot0.getMoveType = function(slot0, slot1, slot2, slot3)
	slot5 = {}
	slot6 = {}

	for slot10 = 1, #uv0 do
		for slot15 = 1, #slot4[slot10] do
			if slot11[slot15] == slot1 then
				slot5 = {
					x = slot15,
					y = slot10
				}
			end

			if slot16 == slot2 then
				slot6 = {
					x = slot15,
					y = slot10
				}
			end
		end
	end

	slot7, slot8 = nil

	if slot5.y < slot6.y then
		slot7 = slot3 and uv1 or uv2
		slot8 = uv3
	elseif slot6.y < slot5.y then
		slot7 = slot3 and uv4 or uv5
		slot8 = uv3
	elseif slot5.x < slot6.x then
		slot7 = slot3 and uv1 or uv2
		slot8 = -uv3
	elseif slot6.x < slot5.x then
		slot7 = slot3 and uv4 or uv5
		slot8 = -uv3
	end

	return slot7, slot8
end

slot0.checkCharActive = function(slot0)
	if slot0.anim then
		if slot0.effectId and slot0.effectId > 0 then
			slot0:changeAnimeState(true)
			slot0:checkEffect(function ()
				uv0:changeAnimeState(false)
				uv0:checkCharActive()
			end)
		elseif slot0.step and slot0.step > 0 then
			slot0:changeAnimeState(true)
			slot0:checkStep(function ()
				uv0:changeAnimeState(false)
				uv0:checkCharActive()
			end)
		end
	end
end

slot0.firstUpdata = function(slot0, slot1)
	slot0:activityDataUpdata(slot1)
	slot0:updataUI()
	slot0:updataChar()
	slot0:checkCharActive()
end

slot0.updataActivity = function(slot0, slot1)
	slot0:activityDataUpdata(slot1)
	slot0:updataUI()
end

slot0.activityDataUpdata = function(slot0, slot1)
	slot0.activity = slot1
	slot0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - slot0.activity.data1) / 86400) * slot0.activity:getDataConfig("daily_time") + slot0.activity.data1_list[1]
	slot0.useCount = slot0.activity.data1_list[2]
	slot0.leftCount = slot0.totalCnt - slot0.useCount
	slot0.turnCnt = slot0.activity.data1_list[3] - 1
	slot0.leftDropShipCnt = 8 - slot0.turnCnt
	slot0.advanceTotalCnt = #slot1:getDataConfig("reward")
	slot0.isAdvanceRp = slot0.advanceTotalCnt - slot0.activity.data2_list[2] > 0
	slot9 = slot0.activity.data2_list[1]
	slot0.leftAwardCnt = slot9 - slot8
	slot0.advanceRpCount = math.max(0, math.min(slot9, slot0.advanceTotalCnt) - slot8)
	slot0.commonRpCount = math.max(0, slot9 - slot0.advanceTotalCnt) - math.max(0, slot8 - slot0.advanceTotalCnt)
	slot10 = slot1:getDataConfig("reward_time")
	slot0.nextredPacketStep = slot10 - slot0.useCount % slot10
	slot0.pos = slot0.activity.data2
	slot0.step = slot0.activity.data3
	slot0.effectId = slot0.activity.data4
end

slot0.checkStep = function(slot0, slot1)
	if slot0.step > 0 then
		slot2 = slot0._event

		slot2:emit(MonopolyCar2Page.ON_MOVE, slot0.activity.id, function (slot0, slot1, slot2)
			uv0.step = slot0
			uv0.pos = slot1[#slot1]
			uv0.effectId = slot2

			seriesAsync({
				function (slot0)
					uv0:moveCharWithPaths(uv1, nil, slot0)
				end,
				function (slot0)
					uv0:checkEffect(slot0)
				end
			}, function ()
				if uv0 then
					uv0()
				end
			end)
		end)
	elseif slot1 then
		slot1()
	end
end

slot0.updataUI = function(slot0)
	setText(slot0.labelLeftRpCount, "" .. slot0.leftAwardCnt)
	slot0.commonAnim:SetInteger("count", slot0.leftAwardCnt)
	setText(slot0.labelDropShip, "" .. slot0.turnCnt + 1)
	setText(slot0.labelLeftCountTip, i18n("monopoly_left_count"))
	setText(slot0.labelLeftCount, slot0.leftCount)
end

slot0.updataChar = function(slot0)
	slot0.char.localPosition = slot0.mapCells[slot0.pos].position

	if not isActive(slot0.char) then
		SetActive(slot0.char, true)
		slot0.char:SetAsLastSibling()
	end

	if slot0.model then
		slot0:updataCharDirect(slot0.pos, false)
	end
end

slot0.checkEffect = function(slot0, slot1)
	if slot0.effectId > 0 then
		slot2 = slot0.mapCells[slot0.pos]
		slot3 = pg.activity_event_monopoly_event[slot0.effectId].story

		seriesAsync({
			function (slot0)
				if uv0 and tonumber(uv0) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(uv0, slot0, true, true)
				else
					slot0()
				end
			end,
			function (slot0)
				uv0:triggerEfeect(slot0)
			end,
			function (slot0)
				uv0:checkCountStory(slot0)
			end
		}, slot1)

		return
	end

	if slot1 then
		slot1()
	end
end

slot0.triggerEfeect = function(slot0, slot1)
	slot2 = slot0._event

	slot2:emit(MonopolyCar2Page.ON_TRIGGER, slot0.activity.id, function (slot0, slot1)
		if slot0 and #slot0 >= 0 then
			uv0.effectId = slot1
			uv0.pos = slot0[#slot0]

			seriesAsync({
				function (slot0)
					uv0:moveCharWithPaths(uv1, nil, slot0)
				end
			}, function ()
				uv0()
			end)
		end
	end)
end

slot0.moveCarWithPaths = function(slot0, slot1, slot2, slot3)
	if not slot1 or #slot1 <= 0 then
		if slot3 then
			slot3()
		end

		return
	end

	slot4 = {}
	slot5 = slot0.char.localPosition
	slot6 = {}
	slot7 = {}

	for slot11 = 1, #slot1 do
		if slot0:checkPathTurn(slot1[slot11]) then
			table.insert(slot6, slot0.mapCells[slot1[slot11]].position)
			table.insert(slot7, slot1[slot11])
		elseif slot11 == #slot1 then
			table.insert(slot6, slot0.mapCells[slot1[slot11]].position)
			table.insert(slot7, slot1[slot11])
		end
	end

	slot0.speedX = 0
	slot0.speedY = 0
	slot0.baseSpeed = 6
	slot0.baseASpeed = 0.1

	if not slot0.timer then
		slot0.timer = Timer.New(function ()
			uv0:toMoveCar()
		end, 0.016666666666666666, -1)

		slot0.timer:Start()
	end

	for slot11 = 1, #slot6 do
		table.insert(slot4, function (slot0)
			uv0.moveComplete = slot0
			uv0.stopOnEnd = false
			uv0.targetPosition = uv1[uv2]
			uv0.targetPosIndex = uv3[uv2]
			uv0.moveX = uv0.targetPosition.x - uv0.char.localPosition.x
			uv0.moveY = uv0.targetPosition.y - uv0.char.localPosition.y
			uv0.baseSpeedX = uv0.baseSpeed * uv0.moveX / math.abs(uv0.moveX)
			uv0.baseASpeedX = uv0.baseASpeed * uv0.moveX / math.abs(uv0.moveX)
			uv0.baseSpeedY = math.abs(uv0.baseSpeedX) / (math.abs(uv0.moveX) / uv0.moveY)
			uv0.baseASpeedY = math.abs(uv0.baseASpeedX) / (math.abs(uv0.moveX) / uv0.moveY)

			if uv2 == 1 then
				uv0.speedX = 0
				uv0.speedY = 0
			else
				uv0.speedX = uv0.baseSpeedX
				uv0.speedY = uv0.baseSpeedY
			end
		end)
	end

	table.insert(slot4, function (slot0)
		uv0.moveComplete = nil

		uv0:updataCharDirect(uv1[#uv1], false)
		slot0()
	end)
	table.insert(slot4, function (slot0)
		slot1 = LeanTween.value(go(uv0._tf), 1, 0, 0.1)

		slot1:setOnComplete(System.Action(function ()
			uv0()
		end))
	end)
	seriesAsync(slot4, slot3)
end

slot0.toMoveCar = function(slot0)
	if not slot0.targetPosition then
		return
	end

	slot2 = math.abs(slot0.targetPosition.y - slot0.char.localPosition.y)

	if math.abs(slot0.targetPosition.x - slot0.char.localPosition.x) <= 6.5 and slot2 <= 6.5 then
		slot0.targetPosition = nil

		if slot0.moveComplete then
			slot0:updataCharDirect(slot0.targetPosIndex, true)
			slot0.moveComplete()
		end
	end

	slot0.speedX = math.abs(slot0.baseSpeedX) < math.abs(slot0.speedX + slot0.baseASpeedX) and slot0.baseSpeedX or slot0.speedX + slot0.baseASpeedX
	slot0.speedY = math.abs(slot0.baseSpeedY) < math.abs(slot0.speedY + slot0.baseASpeedY) and slot0.baseSpeedY or slot0.speedY + slot0.baseASpeedY
	slot3 = slot0.char.localPosition
	slot0.char.localPosition = Vector3(slot3.x + slot0.speedX, slot3.y + slot0.speedY, 0)
end

slot0.checkPathTurn = function(slot0, slot1)
	if slot0.mapCells[slot1 + 1 > #slot0.mapCells and 1 or slot1 + 1].col == slot0.mapCells[slot1 - 1 < 1 and #slot0.mapCells or slot1 - 1].col or slot0.mapCells[slot2].row == slot0.mapCells[slot3].row then
		return false
	end

	return true
end

slot0.moveCharWithPaths = function(slot0, slot1, slot2, slot3)
	slot0:moveCarWithPaths(slot1, slot2, slot3)

	return

	if not slot1 or #slot1 <= 0 then
		if slot3 then
			slot3()
		end

		return
	end

	slot4 = {}
	slot5 = slot1[1] - 1 < 1 and #slot0.mapCells or slot1[1] - 1

	for slot9 = 1, #slot1 do
		slot10 = slot0.mapCells[slot1[slot9]]

		table.insert(slot4, function (slot0)
			slot1 = uv0

			slot1:updataCharDirect(uv1, true)

			uv1 = uv2[uv3]
			slot2 = LeanTween.moveLocal(go(uv0.char), uv4.tf.localPosition, 0.35)
			slot2 = slot2:setEase(LeanTweenType.linear)

			slot2:setOnComplete(System.Action(function ()
				uv0()
			end))
		end)

		if slot9 == #slot1 then
			table.insert(slot4, function (slot0)
				uv0:updataCharDirect(uv1[uv2], false)
				slot0()
			end)
		end
	end

	seriesAsync(slot4, slot3)
end

slot0.dispose = function(slot0)
	slot4 = slot0.showModel

	PoolMgr.GetInstance():ReturnSpineChar(uv0, slot4)

	for slot4 = 1, 3 do
		if slot0.showCharNames[slot4] then
			PoolMgr.GetInstance():ReturnSpineChar(slot0.showCharNames[slot4], slot0.showCharMods[slot4])
		end
	end
end

return slot0
