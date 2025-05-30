slot0 = class("LaunchBallEnemy")
slot1 = {}
slot2 = 0.35
slot3 = 70
slot4 = 100
slot5 = 80
slot6 = 80
slot7 = 50
slot8 = {
	{
		0,
		60
	},
	{
		60,
		70
	},
	{
		120,
		80
	},
	{
		180,
		90
	},
	{
		240,
		100
	}
}
slot9 = -300
slot10 = -150
slot11 = 0.5
slot12 = 500
slot13 = -500
slot14 = 10
slot15 = {
	{
		anim_name = "01_Yellow"
	},
	{
		anim_name = "02_Green"
	},
	{
		anim_name = "03_White"
	},
	{
		anim_name = "04_Red"
	},
	{
		anim_name = "05_Blue"
	},
	{
		anim_name = "06_Black"
	},
	{
		anim_name = "07_Purple"
	}
}

slot16 = function(slot0, slot1)
	slot2 = {
		ctor = function (slot0)
			slot0._tf = uv0
			slot0._animator = GetComponent(findTF(slot0._tf, "ad/anim"), typeof(Animator))
			slot0.angleTf = findTF(slot0._tf, "ad/angle")
			slot0.leftBoundPoints = GetComponent(findTF(slot0._tf, "ad/angle/left"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			slot0.rightBoundPoints = GetComponent(findTF(slot0._tf, "ad/angle/right"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			slot0.localRotation = Vector3(0, 0, 0)
			slot0.circlePos = findTF(slot0._tf, "ad/angle/circle").anchoredPosition

			if not slot0.buffIcon then
				slot0.buffIcon = findTF(slot0._tf, "ad/iconEffect")
			end

			slot0._effectTf = findTF(slot0._tf, "ad/effect")
			slot0._playEffects = {}
		end,
		setData = function (slot0, slot1, slot2)
			slot0:clear()

			slot0.enemyIndex = slot1
			slot0._animator.runtimeAnimatorController = slot2.animator
			slot0.data = slot2
			slot0.hp = slot2.data.hp
			slot0.overSplitFlag = false

			for slot6 = 0, slot0.buffIcon.childCount - 1 do
				setActive(slot0.buffIcon:GetChild(slot6), false)
			end

			for slot6 = #slot0._playEffects, 1, -1 do
				setActive(slot0._playEffects[slot6].tf, false)
				table.remove(slot0._playEffects, slot6)
			end

			slot0:stopAnim(false)
		end,
		setBuff = function (slot0, slot1)
			slot0.buffType = slot1

			if slot0.buffType then
				slot2 = LaunchBallGameConst.enemy_buff_data[slot0.buffType].tpl

				for slot6 = 0, slot0.buffIcon.childCount - 1 do
					slot7 = slot0.buffIcon:GetChild(slot6)

					setActive(slot7, slot7.name == slot2)
				end
			else
				for slot5 = 0, slot0.buffIcon.childCount - 1 do
					setActive(slot0.buffIcon:GetChild(slot5), false)
				end
			end
		end,
		getBuff = function (slot0)
			return slot0.buffType
		end,
		setPoints = function (slot0, slot1)
			slot0.points = slot1
		end,
		hit = function (slot0)
			if slot0.buffType and slot0.buffType == LaunchBallGameConst.enemy_buff_streng then
				slot0:setBuff(nil)

				return
			end

			slot0.hp = slot0.hp - 1

			if slot0.hp <= 0 then
				slot0:setTimeRemove()
			end
		end,
		getTf = function (slot0)
			return slot0._tf
		end,
		playAnimation = function (slot0, slot1)
			slot0._animator:Play(slot1)
		end,
		setActive = function (slot0, slot1)
			setActive(slot0._tf, slot1)
		end,
		getColor = function (slot0)
			return slot0.data.data.color
		end,
		getSplitFlag = function (slot0)
			return slot0.splitFlag
		end,
		setSplitFlag = function (slot0, slot1)
			slot0.splitFlag = slot1
		end,
		step = function (slot0)
			if slot0.timeToRemove and slot0.timeToRemove > 0 then
				slot0.timeToRemove = slot0.timeToRemove - LaunchBallGameVo.deltaTime

				if slot0.timeToRemove <= 0 then
					slot0.timeToRemove = nil
					slot0.removeFlag = true
				end
			end

			if #slot0._playEffects > 0 then
				for slot4 = #slot0._playEffects, 1, -1 do
					if slot0._playEffects[slot4].time then
						slot5.time = slot5.time - LaunchBallGameVo.deltaTime
					end

					if slot5.time and slot5.time <= 0 then
						setActive(slot5.tf, false)
						table.remove(slot0._playEffects, slot4)
					end
				end
			end
		end,
		move = function (slot0, slot1, slot2, slot3, slot4)
			if slot1 == 0 then
				return
			end

			uv0.moveCount = uv0.moveCount + 1
			slot0.distance = slot0.distance + slot1

			if slot0.distance < 0 then
				slot0.distance = 0
			end

			if slot2 and slot3 and slot4 then
				slot0._tf.anchoredPosition = slot2
				slot0.pointIndex = slot3
				slot0.localRotation = slot4
				slot0.angleTf.localEulerAngles = slot0.localRotation
			else
				slot5 = slot0:getPosByDistance(slot0.distance)
				slot6 = slot0._tf.anchoredPosition
				slot6.x = slot5.x
				slot6.y = slot5.y
				slot0._tf.anchoredPosition = slot6
				slot0.pointIndex = slot5.index
				slot0.localRotation.z = slot0.points[slot0.pointIndex].angle
				slot0.angleTf.localEulerAngles = slot0.localRotation
			end
		end,
		getPosition = function (slot0)
			return slot0._tf.anchoredPosition
		end,
		getPointIndex = function (slot0)
			return slot0.pointIndex
		end,
		getLocalRotation = function (slot0)
			return slot0.localRotation
		end,
		stopAnim = function (slot0, slot1)
			if slot1 then
				slot0._animator.speed = 0
			else
				slot0._animator.speed = 1
			end
		end,
		checkWorldInCircle = function (slot0, slot1)
			if math.abs(slot0.angleTf:InverseTransformPoint(slot1).x - slot0.circlePos.x) >= 150 or math.abs(slot2.y - slot0.circlePos.y) >= uv0 * 2 then
				return false
			end

			slot3 = 0

			if math.sqrt(math.pow(slot2.x - slot0.circlePos.x, 2) + math.pow(slot2.y - slot0.circlePos.y, 2)) < uv0 then
				return true
			end

			return false
		end,
		checkWorldInRect = function (slot0, slot1)
			slot2 = slot0.angleTf:InverseTransformPoint(slot1)
			slot3 = 0

			if uv0 < math.sqrt(math.pow(slot2.x - slot0.circlePos.x, 2) + math.pow(slot2.y - slot0.circlePos.y, 2)) then
				return slot3, nil
			end

			if LaunchBallGameVo.PointInRect(slot2, slot0.leftBoundPoints[1], slot0.leftBoundPoints[2], slot0.leftBoundPoints[3], slot0.leftBoundPoints[4]) then
				slot3 = -1
			elseif LaunchBallGameVo.PointInRect(slot2, slot0.rightBoundPoints[1], slot0.rightBoundPoints[2], slot0.rightBoundPoints[3], slot0.rightBoundPoints[4]) then
				slot3 = 1
			end

			return slot3, slot4
		end,
		getPosByDistance = function (slot0, slot1)
			if uv0.EnemyDistanceData[slot0.enemyIndex][math.floor(slot1 * 2)] then
				return uv0.EnemyDistanceData[slot0.enemyIndex][slot2]
			end

			slot3 = slot2 / 2

			if not slot0.distancePosResult then
				slot0.distancePosResult = Vector2(0, 0)
			end

			slot4 = 1
			slot5 = 0

			for slot9 = 1, #slot0.points do
				if slot0.points[slot9].distance <= slot3 then
					slot4 = slot9

					if slot9 < #slot0.points then
						slot5 = slot3 - slot10.distance
						slot0.distancePosResult.x = slot10.pos.x
						slot0.distancePosResult.y = slot10.pos.y
					else
						slot0.distancePosResult.x = slot10.pos.x
						slot0.distancePosResult.y = slot10.pos.y
						slot5 = 0
					end
				else
					break
				end
			end

			if slot5 ~= 0 then
				slot7 = slot0.points[slot4].move
				slot0.distancePosResult.x = slot0.distancePosResult.x + slot7.x * slot5
				slot0.distancePosResult.y = slot0.distancePosResult.y + slot7.y * slot5
			end

			slot6 = {
				x = slot0.distancePosResult.x,
				y = slot0.distancePosResult.y,
				index = slot4
			}
			uv0.EnemyDistanceData[slot0.enemyIndex][slot2] = slot6

			return slot6
		end,
		setTimeRemove = function (slot0)
			if slot0.hp > 0 then
				slot0.hp = 0
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_ENEMY_REMOVE)

			if slot0:getBuff(LaunchBallGameConst.enemy_buff_boom) then
				slot0:playEffectAnim("Bomb", uv0[slot0:getColor()].anim_name, 0.2)
			end

			slot0:stopAnim(false)
			slot0:playAnimation("Remove")

			slot0.timeToRemove = uv1
		end,
		playEffectAnim = function (slot0, slot1, slot2, slot3)
			slot4 = findTF(slot0._effectTf, slot1)

			setActive(slot4, true)
			GetComponent(slot4, typeof(Animator)):Play(slot2)
			table.insert(slot0._playEffects, {
				tf = slot4,
				time = slot3
			})
		end,
		getTimeRemove = function (slot0)
			return slot0.timeToRemove
		end,
		setPosIndex = function (slot0, slot1)
			slot0._tf.anchoredPosition = slot0.points[slot1].pos
			slot0.pointIndex = slot1
			slot0.distance = slot0.points[slot1].distance
		end,
		setDistance = function (slot0, slot1)
			slot0.distance = slot1
			slot0._tf.anchoredPosition = slot0:getPosByDistance(slot0.distance)
		end,
		getDistance = function (slot0)
			return slot0.distance
		end,
		getRemoveFlag = function (slot0)
			return slot0.removeFlag
		end,
		setLastLayer = function (slot0, slot1)
			return slot0._tf:SetSiblingIndex(slot1)
		end,
		getFinish = function (slot0)
			return slot0.points[#slot0.points].distance <= slot0.distance
		end,
		clear = function (slot0)
			slot0.finalFlag = false
			slot0.removeFlag = false
			slot0.timeToRemove = nil
			slot0.buffType = nil
		end
	}

	slot2:ctor()

	return slot2
end

slot0.EnemyDistanceData = {}

slot0.Ctor = function(slot0, slot1, slot2, slot3, slot4)
	slot0._enemyContent = slot1
	slot0._lineContent = slot2
	slot0._tpl = slot3
	slot0._eventCall = slot4
	slot0._enemyTpl = findTF(slot0._tpl, "Enemy")
	slot0.enemyDatas = {}

	for slot8, slot9 in pairs(LaunchBallGameConst.enemy_data) do
		table.insert(slot0.enemyDatas, {
			animator = LoadAny(LaunchBallGameVo.ui_atlas, slot9.name, typeof(RuntimeAnimatorController)),
			data = slot9
		})
	end

	slot0.enemyRule = Clone(LaunchBallGameConst.enemy_create_rule)
	slot0.enemysList = {}
	slot0.enemyPool = {}
	slot0.colliderTestTf = findTF(slot0._enemyContent, "colliderTest")

	setActive(slot0.colliderTestTf, false)
end

slot0.start = function(slot0)
	slot0.moveSpeed = LaunchBallGameVo.gameRoundData.speed
	uv0.EnemyDistanceData = {}
	slot0.gameRoundData = LaunchBallGameVo.gameRoundData
	slot0._enemyContent.sizeDelta = LaunchBallGameConst.enemy_round_bound[slot0.gameRoundData.round_bound]
	slot0.roundDatas = Clone(LaunchBallGameConst.round_enemy[slot0.gameRoundData.round_enemy])
	slot0.lineData = Clone(LaunchBallGameConst.map_data[slot0.gameRoundData.map])
	slot0.enemyBuffs = Clone(LaunchBallGameConst.enemy_round_buff[slot0.gameRoundData.enemy_buff])

	slot0:createRoundData()

	slot0.currentEnemyRule = slot0:getEnemyRule()

	if slot0.lineTf then
		setActive(slot0.lineTf, false)
	end

	slot0.lineTf = findTF(slot0._lineContent, slot0.lineData.line)

	setActive(slot0.lineTf, true)

	for slot4, slot5 in ipairs(slot0.enemysList) do
		for slot9 = #slot5, 1, -1 do
			slot0:returnEnemy(table.remove(slot5, slot9))
		end
	end

	slot0.pointsList = {}
	slot0.enemysList = {}

	if findTF(slot0.lineTf, "ad/points") then
		table.insert(slot0.pointsList, slot0:createPoints(slot1))
		table.insert(slot0.enemysList, {})

		uv0.EnemyDistanceData[1] = {}
	end

	if findTF(slot0.lineTf, "ad/points1") then
		table.insert(slot0.pointsList, slot0:createPoints(slot2))
		table.insert(slot0.enemysList, {})

		uv0.EnemyDistanceData[2] = {}
	end

	for slot6 = 1, #slot0.pointsList do
		slot0:createRandomEnemy(slot6, slot0.pointsList[slot6], slot0.enemysList[slot6], 1, 0, true)
	end

	slot0.backEnemyFlag = false
	slot0.backEnemyTime = nil
	slot0.seriesCount = 1
	slot0.lastPointDistance = nil
end

slot0.moveCount = 0

slot0.step = function(slot0)
	uv0.moveCount = 0

	slot0:checkEnemyRuleUpdate()
	slot0:checkEnemyDataUpdate()
	slot0:checkCreateEnemy()
	slot0:checkRemoveEnemy()
	slot0:moveEnmey()
	slot0:checkEnemyQuick()
	slot0:checkEnemyBack()
	slot0:updateEnemyRemoveFlag()
	slot0:checkEnemySplit()
	slot0:updateEnemyVo()
	slot0:checkEnemyFinal()
	slot0:updateEnemyData()
end

slot0.updateEnemyData = function(slot0)
	if not slot0.lastPointDistance then
		slot0.lastPointDistance = {}

		for slot4 = 1, #slot0.pointsList do
			slot5 = slot0.pointsList[slot4]

			table.insert(slot0.lastPointDistance, slot5[#slot5].distance)
		end
	end

	slot1 = {}
	slot2 = 0

	for slot6 = 1, #slot0.enemysList do
		if slot0.enemysList[slot6] and #slot7 > 0 then
			table.insert(slot1, math.floor(slot7[#slot7]:getDistance() / slot0.lastPointDistance[slot6] * 10))
		end
	end

	LaunchBallGameVo.enemyToEndRate = slot1
end

slot0.checkEnemyDataUpdate = function(slot0)
	if slot0.currentEnemyRule == nil then
		slot0.currentEnemyRule = slot0:getEnemyRule()
	end
end

slot0.checkTargetScore = function(slot0)
	if LaunchBallGameVo.gameRoundData.target and LaunchBallGameVo.gameRoundData.target <= LaunchBallGameVo.scoreNum then
		return true
	end

	return false
end

slot0.checkCreateEnemy = function(slot0)
	if slot0:checkTargetScore() then
		return
	end

	slot1 = 1

	for slot5 = 1, #slot0.enemysList do
		slot7 = slot0.pointsList[slot5]

		if #slot0.enemysList[slot5] > 0 then
			if uv0 < slot6[1]:getDistance() then
				slot0:createRandomEnemy(slot5, slot7, slot6, 1, 0, true)

				break
			end
		else
			slot0:createRandomEnemy(slot5, slot7, slot6, 1, 0, true)

			break
		end
	end
end

slot0.checkRemoveEnemy = function(slot0)
	for slot4, slot5 in ipairs(slot0.enemysList) do
		slot6 = false

		for slot10 = #slot5, 1, -1 do
			slot5[slot10]:step()

			if slot5[slot10]:getRemoveFlag() then
				if slot5[slot10]:getBuff() then
					slot0:appearEnemyBuff(slot11, slot10, slot5[slot10], slot5)
				end

				slot0:returnEnemy(table.remove(slot5, slot10))

				slot6 = true
			end
		end
	end

	if slot0.timeRemoveAll and slot0.timeRemoveAll > 0 then
		slot0.timeRemoveAll = slot0.timeRemoveAll - LaunchBallGameVo.deltaTime

		if slot0.timeRemoveAll <= 0 then
			slot1 = 0

			for slot5, slot6 in ipairs(slot0.enemysList) do
				for slot10 = #slot6, 1, -1 do
					if not slot6[slot10]:getRemoveFlag() then
						slot11:setTimeRemove()

						slot1 = slot1 + 1

						slot0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
							num = LaunchBallGameVo.GetScore(1, 1)
						})
					end
				end
			end

			LaunchBallGameVo.UpdateGameResultData(LaunchBallGameVo.result_skill_count, slot1)

			slot0.timeRemoveAll = nil
		end
	end
end

slot0.appearEnemyBuff = function(slot0, slot1, slot2, slot3, slot4)
	slot5 = LaunchBallGameConst.enemy_buff_data[slot1]

	if slot1 == LaunchBallGameConst.enemy_buff_slow then
		slot0.slowTime = slot5.time

		if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
			slot0.slowTime = slot0.slowTime * 1.5

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_pass_skill, 1)

			if slot0.enemyStopTime and slot0.enemyStopTime > 0 then
				slot0.enemyStopTime = slot0.enemyStopTime + 3
			end
		end
	elseif slot1 == LaunchBallGameConst.enemy_buff_back then
		slot0.backEnemyTime = slot5.time
		slot0.backSpeed = uv0
		slot0.moveBackIndex = #slot4

		if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
			slot0.backEnemyTime = slot0.backEnemyTime * 1.3

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_pass_skill, 1)
		end
	elseif slot1 == LaunchBallGameConst.enemy_buff_boom then
		slot6 = slot3:getDistance()
		slot7 = slot5.distance

		for slot11 = 1, #slot4 do
			if not slot4[slot11]:getRemoveFlag() and math.abs(slot4[slot11]:getDistance() - slot6) <= slot7 then
				slot4[slot11]:setTimeRemove()
				slot0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
					num = LaunchBallGameVo.GetScore(1, 1)
				})
			end
		end
	elseif slot1 == LaunchBallGameConst.enemy_buff_concentrate then
		slot0._eventCall(LaunchBallGameScene.CONCENTRATE_TRIGGER, slot5)
	end
end

slot0.moveEnmey = function(slot0)
	slot1 = nil

	if slot0.enemyStopTime and slot0.enemyStopTime > 0 then
		slot0.enemyStopTime = slot0.enemyStopTime - LaunchBallGameVo.deltaTime

		if slot0.enemyStopTime <= 0 then
			slot0.enemyStopTime = nil

			slot0:stopEnemysAnim(false)
		end

		LaunchBallGameVo.enemyStopTime = slot0.enemyStopTime
	end

	if slot0.enemyStopTime and slot0.enemyStopTime > 0 then
		return
	end

	if slot0.backEnemyTime and slot0.backEnemyTime > 0 then
		slot0.backEnemyTime = slot0.backEnemyTime - LaunchBallGameVo.deltaTime

		if slot0.backEnemyTime <= 0 then
			slot0.backEnemyTime = nil
		end

		slot1 = slot0.backSpeed * LaunchBallGameVo.deltaTime
	else
		slot1 = slot0.moveSpeed * LaunchBallGameVo.deltaTime
	end

	if slot0.slowTime and slot0.slowTime > 0 then
		slot1 = slot1 / 3
		slot0.slowTime = slot0.slowTime - LaunchBallGameVo.deltaTime

		if slot0.slowTime < 0 then
			slot0.slowTime = nil
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot0.enemysList) do
		slot8 = 0

		if slot1 > 0 then
			for slot12 = 1, #slot7 do
				slot13 = false

				if slot12 < #slot7 and slot7[slot12]:getDistance() < uv0 and slot7[slot12 + 1]:getDistance() < uv0 then
					slot13 = true
				end

				if slot12 > 1 and slot8 == 0 then
					if uv0 < slot7[slot12]:getDistance() - slot7[slot12 - 1]:getDistance() then
						slot8 = slot12
						slot13 = true
					elseif slot7[slot12]:getRemoveFlag() then
						slot8 = slot12
						slot13 = true
					end
				elseif slot8 ~= 0 and slot8 <= slot12 then
					slot13 = true
				end

				if not slot13 then
					slot7[slot12]:move(slot1)
				end
			end
		end

		if slot1 < 0 then
			for slot12 = #slot7, 1, -1 do
				slot13 = false

				if slot12 <= slot0.moveBackIndex and slot8 == 0 then
					if slot12 > 1 and slot7[slot12]:getDistance() - slot7[slot12 - 1]:getDistance() > uv0 + uv1 then
						slot8 = slot12 - 1
					end
				else
					slot13 = slot8 ~= 0 and slot12 <= slot8 and true or true
				end

				if not slot13 then
					slot7[slot12]:move(slot1)
				end
			end
		end
	end
end

slot0.checkEnemyQuick = function(slot0)
	if slot0.backFlag then
		return
	end

	slot0.quickFlag = false

	for slot4, slot5 in ipairs(slot0.enemysList) do
		slot6 = 0

		for slot10 = 1, #slot5 do
			slot11 = slot5[slot10]

			if slot10 <= #slot5 - 1 and uv0 < slot5[slot10 + 1]:getDistance() and slot12:getDistance() - slot11:getDistance() < uv0 - uv1 then
				slot6 = slot10 + 1
				slot0.quickFlag = true

				break
			end
		end

		if slot6 ~= 0 then
			for slot10 = 1, #slot5 do
				if slot6 <= slot10 then
					if slot5[slot10]:getDistance() - slot5[slot10 - 1]:getDistance() < uv0 - uv1 then
						slot5[slot10]:move(uv2 * LaunchBallGameVo.deltaTime)
					else
						break
					end
				end
			end
		end
	end
end

slot0.checkEnemyBack = function(slot0)
	slot0.backFlag = false

	if not slot0.quickFlag then
		for slot4, slot5 in ipairs(slot0.enemysList) do
			slot6 = 0

			for slot10 = 1, #slot5 do
				if slot10 > 1 and slot6 == 0 and slot5[slot10]:getDistance() - slot5[slot10 - 1]:getDistance() > uv0 + uv1 and slot5[slot10]:getSplitFlag() and slot5[slot10]:getColor() == slot5[slot10 - 1]:getColor() then
					slot6 = slot10

					if not slot0.backEnemyFlag then
						slot0.backEnemyFlag = true
					end
				end
			end

			if slot6 ~= 0 then
				slot0.backFlag = true
				slot0.moveBackIndex = 0

				for slot10 = 1, #slot5 do
					if slot10 == slot6 then
						slot0.moveBackIndex = slot10

						slot5[slot10]:move(uv2 * LaunchBallGameVo.deltaTime)
					elseif slot6 < slot10 then
						if slot5[slot10]:getDistance() - slot5[slot10 - 1]:getDistance() < uv0 + uv1 then
							slot5[slot10]:move(uv2 * LaunchBallGameVo.deltaTime)

							slot0.moveBackIndex = slot10
						else
							break
						end
					end
				end
			end
		end
	end

	if slot0.backFlag and slot0.backEnemyFlag then
		slot0.backEnemyFlag = false
		slot0.backEnemyTime = uv3
		slot0.backSpeed = uv4
	end
end

slot0.updateEnemyRemoveFlag = function(slot0)
	slot0.enemyTimeRemoveFlag = false

	for slot4, slot5 in ipairs(slot0.enemysList) do
		slot6 = 0

		for slot10 = 1, #slot5 do
			if slot5[slot10]:getTimeRemove() then
				slot0.enemyTimeRemoveFlag = true
			end
		end
	end
end

slot0.checkEnemySplit = function(slot0)
	if not slot0.enemyTimeRemoveFlag and not slot0.backFlag and not slot0.quickFlag and not slot0.backEnemyFlag then
		for slot5, slot6 in ipairs(slot0.enemysList) do
			slot7 = 0

			for slot11 = 1, #slot6 do
				if slot6[slot11]:getSplitFlag() then
					slot14, slot15, slot16 = slot0:checkSplit(slot11, slot6)

					slot12:setSplitFlag(false)

					if slot14 >= 3 or slot15 then
						slot0.seriesCount = slot0.seriesCount + 1

						if slot0.splitFireIndex and slot0.fireIndex <= slot0.splitFireIndex + 1 then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_series_count, 1)

							if not slot0.seriesCombat then
								slot0.seriesCombat = 1
							else
								slot0.seriesCombat = slot0.seriesCombat + 1
							end
						else
							slot0.seriesCombat = 0
						end

						if slot0.amuletOverFlag then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_over_count, 1)
						end

						slot0.splitFireIndex = slot0.fireIndex

						break
					end

					slot0.seriesCount = 1
					slot0.seriesCombat = 0

					break
				end
			end
		end
	end
end

slot0.checkEnemyFinal = function(slot0)
	if slot0:checkTargetScore() then
		slot1 = 0

		for slot5, slot6 in ipairs(slot0.enemysList) do
			slot1 = slot1 + #slot6
		end

		if slot1 == 0 then
			slot0._eventCall(LaunchBallGameScene.ENEMY_FINISH)

			return
		end
	end

	for slot4, slot5 in ipairs(slot0.enemysList) do
		if slot5 and #slot5 > 0 and slot5[#slot5]:getFinish() then
			slot0._eventCall(LaunchBallGameScene.ENEMY_FINISH)

			return
		end
	end
end

slot0.updateEnemyVo = function(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.enemysList) do
		for slot10 = 1, #slot6 do
			if not table.contains(slot1, slot6[slot10]:getColor()) then
				table.insert(slot1, slot11)

				if LaunchBallGameConst.color_total <= #slot1 then
					LaunchBallGameVo.enemyColors = slot1

					return
				end
			end
		end
	end

	LaunchBallGameVo.enemyColors = slot1
end

slot0.updateGameResultSplitCount = function(slot0, slot1, slot2)
	LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_split_count, 1)

	if slot2 > 1 then
		LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_series_count, 1)
		LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_mix_count, 1)
	end

	if slot1 > 3 then
		LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_many_count, 1)
	end
end

slot0.checkSplit = function(slot0, slot1, slot2)
	slot3 = slot2[slot1]:getColor()
	slot4 = 1
	slot5 = {
		slot2[slot1]
	}
	slot6 = false
	slot7 = 0
	slot8 = 0

	if slot1 > 1 then
		for slot12 = slot1 - 1, 1, -1 do
			if slot2[slot12]:getColor() == slot3 then
				table.insert(slot5, slot2[slot12])

				slot4 = slot4 + 1
				slot8 = slot8 + 1
			else
				break
			end
		end
	end

	slot9 = nil

	if slot1 < #slot2 then
		for slot13 = slot1 + 1, #slot2 do
			if slot2[slot13]:getColor() == slot3 then
				table.insert(slot5, slot2[slot13])

				slot4 = slot4 + 1
				slot7 = slot7 + 1
			else
				slot9 = slot2[slot13]

				break
			end
		end
	end

	if slot4 >= 3 then
		slot6 = true
	end

	if slot4 >= 3 and not slot6 then
		print("")
	end

	if slot6 and slot9 then
		slot9:setSplitFlag(true)
	end

	if slot6 then
		for slot13 = 1, #slot5 do
			slot5[slot13]:hit()
		end

		if slot0._eventCall then
			slot0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
				split = true,
				num = LaunchBallGameVo.GetScore(slot4, slot0.seriesCount, slot0.amuletOverFlag),
				count = slot4
			})

			if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) and slot0.enemyStopTime and slot0.enemyStopTime > 0 then
				LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, slot4)
			end
		end

		slot0:updateGameResultSplitCount(slot4, slot0.seriesCount)

		if not slot9 then
			slot0.seriesCount = 0
		end
	end

	return slot4, slot6
end

slot0.createPoints = function(slot0, slot1)
	slot2 = {}
	slot3 = 0

	for slot9, slot10 in ipairs(GetComponent(slot1, "EdgeCollider2D").points:ToTable()) do
		slot11 = Vector2(0, 0)
		slot12 = Vector2(0, 0)
		slot13 = 0
		slot14 = 0

		if slot9 > 1 then
			slot15 = slot5[slot9 - 1]
			slot16 = slot5[slot9]
			slot3 = slot3 + math.sqrt(math.pow(slot16.x - slot15.x, 2) + math.pow(slot16.y - slot15.y, 2))
		end

		if slot9 < #slot5 then
			slot15 = slot5[slot9]
			slot16 = slot5[slot9 + 1]
			slot13 = math.atan(math.abs(slot16.y - slot15.y) / math.abs(slot16.x - slot15.x))
			slot14 = math.atan2(slot16.y - slot15.y, slot16.x - slot15.x) * math.rad2Deg
			slot17 = slot15.x < slot16.x and 1 or -1
			slot18 = slot15.y < slot16.y and 1 or -1
			slot12.x = slot17
			slot12.y = slot18
			slot11.x = math.cos(slot13) * slot17
			slot11.y = math.sin(slot13) * slot18
		elseif slot9 == #slot5 then
			slot15 = slot5[slot9 - 1]
			slot16 = slot5[slot9]
			slot13 = math.atan(math.abs(slot16.y - slot15.y) / math.abs(slot16.x - slot15.x))
			slot14 = math.atan2(slot16.y - slot15.y, slot16.x - slot15.x) * math.rad2Deg
			slot17 = slot15.x < slot16.x and 1 or -1
			slot18 = slot15.y < slot16.y and 1 or -1
			slot12.x = slot17
			slot12.y = slot18
			slot11.x = math.cos(slot13) * slot17
			slot11.y = math.sin(slot13) * slot18
		end

		table.insert(slot2, {
			pos = slot10,
			distance = slot3,
			move = slot11,
			direct = slot12,
			angle = slot14
		})
	end

	return slot2
end

slot0.createEnemy = function(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0:getOrCreateEnemy()

	slot6:setData(slot1, slot2)
	slot6:setPoints(slot3)
	slot6:setActive(true)
	slot6:setSplitFlag(false)

	if slot5 then
		slot6:setDistance(slot5)
	else
		slot6:setDistance(0)
	end

	table.insert(slot4, slot6)
	slot0:sortEnemys(slot4)

	return slot6
end

slot0.createRandomEnemy = function(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0:getEnemyDataByRule() then
		return
	end

	slot8 = slot0:getOrCreateEnemy()

	slot8:setData(slot1, slot7)
	slot8:setBuff(slot0:getEnemyBuff())
	slot8:setPoints(slot2)
	slot8:setActive(true)

	if slot4 and slot4 ~= 0 then
		slot8:setPosIndex(slot4)
	elseif slot5 then
		slot8:setDistance(slot5)
	end

	table.insert(slot3, slot8)
	slot0:sortEnemys(slot3)

	return slot8
end

slot0.getEnemyBuff = function(slot0)
	slot1 = {}

	for slot5 = 1, #slot0.enemyBuffs.buffs do
		slot7 = true

		if slot0.enemyBuffs.buffs[slot5].type == LaunchBallGameConst.enemy_buff_back then
			if slot0:getEnemyByBuff(LaunchBallGameConst.enemy_buff_slow) then
				slot7 = false
			end
		elseif slot6.type == LaunchBallGameConst.enemy_buff_slow and slot0:getEnemyByBuff(LaunchBallGameConst.enemy_buff_back) then
			slot7 = false
		end

		if slot7 then
			slot9 = slot6.rate[1]

			if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
				if slot6.type == LaunchBallGameConst.enemy_buff_slow then
					slot9 = slot9 + 2
				elseif slot6.type == LaunchBallGameConst.enemy_buff_back then
					slot9 = slot9 + 2
				end
			end

			if math.random(1, slot8[2]) <= slot9 then
				table.insert(slot1, slot6.type)
			end
		end
	end

	if #slot1 > 0 then
		return slot1[math.random(1, #slot1)]
	end

	return nil
end

slot0.getEnemyByBuff = function(slot0, slot1)
	for slot5 = 1, #slot0.enemysList do
		slot6 = slot0.pointsList[slot5]

		for slot11 = #slot0.enemysList[slot5], 1, -1 do
			if slot7[slot11]:getBuff() == slot1 then
				return slot12
			end
		end
	end

	return nil
end

slot0.getOrCreateEnemy = function(slot0)
	slot1 = nil

	if #slot0.enemyPool > 0 then
		slot1 = table.remove(slot0.enemyPool, 1)
	else
		slot2 = tf(instantiate(slot0._enemyTpl))

		setParent(slot2, slot0._enemyContent)

		slot1 = uv0(slot2)
	end

	return slot1
end

slot0.sortEnemys = function(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		return slot0:getDistance() < slot1:getDistance()
	end)

	for slot5 = 1, #slot1 do
		slot1[slot5]:setLastLayer(slot5 - 1)
	end
end

slot0.returnEnemy = function(slot0, slot1)
	slot1:setActive(false)
	table.insert(slot0.enemyPool, slot1)
end

slot0.getEnemyDataByRule = function(slot0)
	if not slot0.currentEnemyRule then
		slot0.currentEnemyRule = slot0:getEnemyRule()
	end

	if #uv0 > 0 then
		return slot0:getEnemyById(table.remove(uv0, 1))
	end

	if slot0.currentEnemyRule then
		slot1 = nil
		slot1 = (not slot0.currentEnemyRule.single or slot0.currentEnemyRule.singleId) and slot0.currentEnemyRule.enemys[math.random(1, #slot0.currentEnemyRule.enemys)]
		slot0.currentEnemyRule.count = slot0.currentEnemyRule.count - 1

		if slot0.currentEnemyRule.count <= 0 then
			slot0.currentEnemyRule = nil
		end

		return slot0:getEnemyById(slot1)
	end

	return nil
end

slot0.getEnemyById = function(slot0, slot1)
	for slot5 = 1, #slot0.enemyDatas do
		if slot0.enemyDatas[slot5].data.id == slot1 then
			return slot0.enemyDatas[slot5]
		end
	end

	print("找不到id = " .. slot1 .. "的怪物")

	return nil
end

slot0.checkEnemyRuleUpdate = function(slot0)
	slot1 = false

	for slot5 = 1, #slot0.rounds do
		if slot0.rounds[slot5].time[2] <= LaunchBallGameVo.gameStepTime then
			slot1 = true
		end
	end

	if slot1 then
		slot0:createRoundData()
	end
end

slot0.getEnemysInBounds = function(slot0, slot1, slot2)
	slot3 = slot0._enemyContent:InverseTransformPoint(slot1)
	slot0.colliderTestTf.anchoredPosition = slot0._enemyContent:InverseTransformPoint(slot2)
	slot5 = {}

	for slot9 = 1, #slot0.enemysList do
		slot10 = slot0.pointsList[slot9]

		for slot15 = #slot0.enemysList[slot9], 1, -1 do
			if slot3.x < slot11[slot15]:getTf().anchoredPosition.x and slot16.x < slot4.x and slot3.y < slot16.y and slot16.y < slot4.y then
				table.insert(slot5, slot11[slot15])
			end
		end
	end

	return slot5
end

slot0.getEnemyRule = function(slot0)
	slot1 = nil
	slot2 = math.random(0, slot0.maxWeight)
	slot3 = nil

	for slot7 = 1, #slot0.rounds do
		if not slot3 and slot2 <= slot0.rounds[slot7].maxWeight then
			slot3 = slot0.rounds[slot7].createId
		end
	end

	if slot3 then
		if not slot0.enemyRule[slot3] then
			print("create id not exit " .. slot3)
		end

		slot4 = slot0.enemyRule[slot3]
		slot5 = slot4.id
		slot6 = slot4.enemy_create.count
		slot7 = slot4.enemy_create.enemys
		slot9 = nil

		if slot4.enemy_create.single then
			slot9 = slot7[math.random(1, #slot7)]
		end

		slot1 = {
			id = slot5,
			count = slot6,
			enemys = slot7,
			single = slot8,
			singleId = slot9
		}
	end

	return slot1
end

slot0.createRoundData = function(slot0)
	slot1 = 0
	slot0.rounds = {}
	slot2 = LaunchBallGameVo.gameStepTime

	for slot6 = 1, #slot0.roundDatas do
		slot7 = slot0.roundDatas[slot6]
		slot8 = slot7.weight
		slot10 = slot7.create_id

		if slot7.time[1] <= slot2 and slot2 <= slot9[2] then
			table.insert(slot0.rounds, {
				time = slot9,
				weight = slot8,
				maxWeight = slot1 + slot8,
				createId = slot10
			})
		end
	end

	slot0.maxWeight = slot1
end

slot0.checkAmulet = function(slot0, slot1)
	slot2 = slot1.tf.position
	slot0.fireIndex = slot1.fireIndex
	slot3 = slot1.color

	for slot7 = 1, #slot0.enemysList do
		slot8 = slot0.pointsList[slot7]

		for slot13 = #slot0.enemysList[slot7], 1, -1 do
			slot14 = slot9[slot13]
			slot15, slot16 = slot9[slot13]:checkWorldInRect(slot2)

			if slot16 and slot16 < uv0 then
				slot1.overCount = slot1.overCount + 1
			end

			if slot15 ~= 0 then
				slot0.amuletOverFlag = false

				if slot1.concentrate then
					if not slot9[slot13]:getTimeRemove() then
						slot9[slot13]:setTimeRemove()

						if slot0._eventCall then
							slot0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
								num = LaunchBallGameVo.GetScore(1, 1)
							})
						end

						if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) and slot0.enemyStopTime and slot0.enemyStopTime > 0 then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, 1)
						end
					end

					return false
				else
					slot17 = slot14:getDistance()
					slot17 = slot15 == 1 and slot17 + uv1 or slot17 - uv1

					if slot1.overCount >= 2 then
						slot0.amuletOverFlag = true
					end

					slot19 = slot0:createEnemy(slot7, slot0:getEnemyByColor(slot1.color, true), slot0.pointsList[slot7], slot0.enemysList[slot7], slot17)

					slot19:setSplitFlag(true)
					slot19:playAnimation("Spawn")

					slot21 = slot1[LaunchBallGameConst.amulet_buff_back]

					if slot0:getBackBuff() or slot21 then
						slot0:setBackTime(LaunchBallPlayerControl.buff_amulet_back_time, #slot9, uv2)
					end

					return true
				end
			end
		end
	end

	return false
end

slot0.checkPositionIn = function(slot0, slot1)
	for slot5 = 1, #slot0.enemysList do
		slot6 = slot0.pointsList[slot5]

		for slot11 = #slot0.enemysList[slot5], 1, -1 do
			slot12 = slot7[slot11]

			if slot7[slot11]:checkWorldInRect(slot1) ~= 0 then
				return slot12
			end
		end
	end

	return false
end

slot0.checkWorldInEnemy = function(slot0, slot1)
	for slot5 = 1, #slot0.enemysList do
		slot6 = slot0.pointsList[slot5]

		for slot11 = #slot0.enemysList[slot5], 1, -1 do
			slot12 = slot7[slot11]

			if slot7[slot11]:checkWorldInCircle(slot1) then
				return true
			end
		end
	end

	return false
end

slot0.getBackBuff = function(slot0)
	for slot5 = 1, #LaunchBallGameVo.buffs do
		if slot1[slot5].data.type == LaunchBallPlayerControl.buff_amulet_back then
			return true
		end
	end

	return false
end

slot0.getEnemyByColor = function(slot0, slot1, slot2)
	for slot6 = 1, #slot0.enemyDatas do
		if slot0.enemyDatas[slot6].data.color == slot1 and slot0.enemyDatas[slot6].data.player == slot2 then
			return slot0.enemyDatas[slot6]
		end
	end
end

slot0.setBackTime = function(slot0, slot1, slot2, slot3)
	slot0.backEnemyTime = slot1
	slot0.moveBackIndex = slot2
	slot0.backSpeed = slot3 or uv0
end

slot0.eventCall = function(slot0, slot1, slot2)
	if slot1 == LaunchBallGameScene.PLAYING_CHANGE then
		-- Nothing
	elseif slot1 == LaunchBallGameScene.FIRE_AMULET then
		-- Nothing
	elseif slot1 == LaunchBallGameScene.SPLIT_ALL_ENEMYS then
		slot4 = slot2.effect
		slot0.timeRemoveAll = slot2.time
	elseif slot1 == LaunchBallGameScene.STOP_ENEMY_TIME then
		slot0.enemyStopTime = slot2.time

		slot0:stopEnemysAnim(true)
	elseif slot1 == LaunchBallGameScene.SLASH_ENEMY then
		slot3 = slot2.bound
	end
end

slot0.stopEnemysAnim = function(slot0, slot1)
	for slot5 = 1, #slot0.enemysList do
		slot6 = slot0.pointsList[slot5]

		for slot11 = #slot0.enemysList[slot5], 1, -1 do
			slot7[slot11]:stopAnim(slot1)
		end
	end
end

slot0.press = function(slot0, slot1)
	if slot1 == KeyCode.J then
		-- Nothing
	end
end

slot0.clear = function(slot0)
end

return slot0
