slot0 = class("SpineRole")
slot0.STATE_EMPTY = 0
slot0.STATE_LOADING = 1
slot0.STATE_INITED = 2
slot0.STATE_DISPOSE = 3

slot0.Ctor = function(slot0, slot1)
	slot0.state = uv0.STATE_EMPTY

	if slot1 then
		slot0.ship = slot1
		slot0.prefabName = slot0.ship:getPrefab()
	end
end

slot0.SetData = function(slot0, slot1, slot2)
	slot0.prefabName = slot1
	slot0.attachmentData = slot2
end

slot0.ORBIT_KEY_UI = "orbit_ui"
slot0.ORBIT_KEY_SLG = "orbit_slg"

slot0.Load = function(slot0, slot1, slot2, slot3)
	if slot2 == nil then
		slot2 = true
	end

	slot4 = PoolMgr.GetInstance()

	slot4:GetSpineChar(slot0.prefabName, slot2, function (slot0)
		assert(slot0, "没有这个角色的模型  " .. uv0.prefabName)

		if uv0.state == uv1.STATE_DISPOSE then
			PoolMgr.GetInstance():ReturnSpineChar(uv0.prefabName, slot0)
		else
			uv0.modelRoot = GameObject.New(uv0.prefabName .. "_root")

			uv0.modelRoot:AddComponent(typeof(RectTransform))

			uv0.model = slot0
			uv0.model.transform.localScale = Vector3.one

			uv0.model.transform:SetParent(uv0.modelRoot.transform, false)

			uv0.model.transform.localPosition = Vector3.zero

			uv0:Init()

			if uv2 then
				uv2()
			end

			uv0:AttachOrbit(uv3)
			uv0:sortAttachmentGO()
		end
	end)
end

slot0.Init = function(slot0)
	slot0.state = uv0.STATE_INITED
	slot0._modleGraphic = slot0.model:GetComponent("SkeletonGraphic")
	slot0._modleAnim = slot0.model:GetComponent("SpineAnimUI")
	slot0._attachmentList = {}
	slot0._visible = true
end

slot0.AttachOrbit = function(slot0, slot1)
	slot2 = slot1 or uv0.ORBIT_KEY_UI

	for slot7, slot8 in pairs(slot0:GetAttachmentList()) do
		slot10 = slot8.index
		slot11 = slot8.config[slot2]

		if slot2 ~= uv0.ORBIT_KEY_UI and slot11 == "" then
			slot11 = slot9.orbit_ui
			slot2 = uv0.ORBIT_KEY_UI
		end

		if slot11 ~= "" then
			slot13 = ResourceMgr.Inst

			slot13:getAssetAsync(ys.Battle.BattleResourceManager.GetOrbitPath(slot11), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function (slot0)
				if uv0.state ~= uv1.STATE_DISPOSE then
					slot1 = uv2 .. "_bound"
					slot2 = uv3[slot1][1]
					slot3 = uv3[slot1][2]

					for slot9, slot10 in ipairs(Object.Instantiate(slot0):GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic)):ToTable()) do
						slot10.raycastTarget = false
					end

					slot4.transform.localPosition = Vector2(slot3[1], slot3[2])
					slot6 = SpineAnimUI.AddFollower(slot2, uv0.model.transform, slot4.transform)
					slot4.transform.localScale = Vector3.one
					uv0._attachmentList[slot6] = {
						p = uv4,
						hiddenActionList = uv3.orbit_hidden_action,
						index = uv5,
						back = uv3.orbit_ui_back
					}
					slot7 = slot6:GetComponent("Spine.Unity.BoneFollowerGraphic")

					if uv3.orbit_rotate then
						slot7.followBoneRotation = true
						slot8 = slot4.transform.localEulerAngles
						slot4.transform.localEulerAngles = Vector3(slot8.x, slot8.y, slot8.z - 90)
					else
						slot7.followBoneRotation = false
					end

					if uv3.orbit_ui_back == 1 then
						slot6:SetParent(uv0.modelRoot.transform, false)
						slot6:SetAsFirstSibling()
					else
						slot6:SetParent(uv0.modelRoot.transform, false)
						slot6:SetAsLastSibling()
					end

					SetActive(slot6, uv0._visible)
					uv0:sortAttachmentGO()
				end
			end), true, true)
		end
	end
end

slot0.sortAttachmentGO = function(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._attachmentList) do
		table.insert(slot1, {
			tf = slot5,
			index = slot6.index,
			back = slot6.back,
			p = slot6.p
		})
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.index < slot1.index
	end)

	for slot5, slot6 in ipairs(slot1) do
		if slot6.back ~= 1 then
			slot6.tf:SetAsLastSibling()

			break
		end
	end
end

slot0.GetAttachmentList = function(slot0)
	if slot0.ship then
		return slot0.ship:getAttachmentPrefab()
	else
		return slot0.attachmentData or {}
	end
end

slot0.CheckInited = function(slot0)
	return slot0.state == uv0.STATE_INITED
end

slot0.GetName = function(slot0)
	return slot0.modelRoot.name
end

slot0.SetParent = function(slot0, slot1)
	if slot0:CheckInited() then
		SetParent(slot0.modelRoot, slot1, false)
	end
end

slot0.SetRaycastTarget = function(slot0, slot1)
	if slot0:CheckInited() then
		slot0._modleGraphic.raycastTarget = slot1
	end
end

slot0.ModifyName = function(slot0, slot1)
	if slot0:CheckInited() then
		slot0.modelRoot.name = slot1
	end
end

slot0.SetVisible = function(slot0, slot1)
	if slot0:CheckInited() then
		slot0._visible = slot1
		slot0._modleGraphic.color = Color.New(1, 1, 1, slot1 and 1 or 0)

		for slot5, slot6 in pairs(slot0._attachmentList) do
			SetActive(slot5, slot1)
		end
	end
end

slot0.SetAction = function(slot0, slot1)
	if not slot0:CheckInited() then
		return
	end

	slot0._modleAnim:SetAction(slot1, 0)
	slot0:HiddenAttachmentByAction(slot1)
end

slot0.SetActionOnce = function(slot0, slot1)
	if not slot0:CheckInited() then
		return
	end

	slot0._modleGraphic.AnimationState:SetAnimation(0, slot1, false)
	slot0:HiddenAttachmentByAction(slot1)
end

slot0.SetActionCallBack = function(slot0, slot1)
	if not slot0:CheckInited() then
		return
	end

	slot0._modleAnim:SetActionCallBack(slot1)
end

slot0.HiddenAttachmentByAction = function(slot0, slot1)
	for slot5, slot6 in pairs(slot0._attachmentList) do
		SetActive(slot5, not table.contains(slot6.hiddenActionList, slot1))
	end
end

slot0.SetSizeDelta = function(slot0, slot1)
	if slot0:CheckInited() then
		rtf(slot0.modelRoot).sizeDelta = slot1
	end
end

slot0.SetLocalScale = function(slot0, slot1)
	if slot0:CheckInited() then
		slot0.modelRoot.transform.localScale = slot1
	end
end

slot0.SetLocalPos = function(slot0, slot1)
	if slot0:CheckInited() then
		slot0.modelRoot.transform.localPosition = slot1
	end
end

slot0.SetLayer = function(slot0, slot1)
	if slot0:CheckInited() then
		pg.ViewUtils.SetLayer(slot0.modelRoot.transform, slot1)
	end
end

slot0.TweenShining = function(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10)
	if slot0:CheckInited() then
		slot0:StopTweenShining()

		slot11 = slot0._modleGraphic.material
		slot12 = LeanTween.value(slot0.modelRoot, slot3, slot4, slot1)
		slot12 = slot12:setEase(LeanTweenType.easeInOutSine)
		slot12 = slot12:setOnUpdate(System.Action_float(function (slot0)
			if uv0 then
				uv1:SetColor("_Color", Color.Lerp(uv2, uv3, slot0))
			else
				uv4._modleGraphic.color = Color.Lerp(uv2, uv3, slot0)
			end

			existCall(uv5, slot0)
		end))
		slot12 = slot12:setOnComplete(System.Action(function ()
			uv0._tweenShiningId = nil

			if uv1 then
				if uv2 then
					uv3:SetColor("_Color", uv4)
				else
					uv0._modleGraphic.color = uv4
				end
			end

			existCall(uv5)
		end))

		if slot2 then
			slot12:setLoopPingPong(slot2)
		end

		slot0._tweenShiningId = slot12.uniqueId
	end
end

slot0.StopTweenShining = function(slot0)
	if slot0:CheckInited() and slot0._tweenShiningId then
		LeanTween.cancel(slot0._tweenShiningId, true)

		slot0._tweenShiningId = nil
	end
end

slot0.ChangeMaterial = function(slot0, slot1)
	if not slot0:CheckInited() then
		return
	end

	if not slot0._stageMaterial then
		slot0._stageMaterial = slot0._modleGraphic.material
	end

	slot0._modleGraphic.material = slot1
end

slot0.RevertMaterial = function(slot0)
	if not slot0:CheckInited() then
		return
	end

	if not slot0._stageMaterial then
		return
	end

	slot0._modleGraphic.material = slot0._stageMaterial
end

slot0.CreateInterface = function(slot0)
	slot0._mouseChild = GameObject("mouseChild")

	slot0._mouseChild.transform:SetParent(slot0.modelRoot.transform, false)

	slot0._mouseChild.transform.localPosition = Vector3.zero
	slot0._modelClick = GetOrAddComponent(slot0._mouseChild, "ModelDrag")
	slot0._modelPress = GetOrAddComponent(slot0._mouseChild, "UILongPressTrigger")
	slot0._dragDelegate = GetOrAddComponent(slot0._mouseChild, "EventTriggerListener")

	slot0._modelClick:Init()

	slot1 = GetOrAddComponent(slot0._mouseChild, typeof(RectTransform))
	slot1.pivot = Vector2(0.5, 0)
	slot1.anchoredPosition = Vector2(0, 0)
	slot1.localScale = Vector2(100, 100)
	slot1.sizeDelta = Vector2(3, 3)

	return slot0._modelClick, slot0._modelPress, slot0._dragDelegate
end

slot0.resumeRole = function(slot0)
	if slot0._modleAnim and slot0._modleAnim:GetAnimationState() then
		slot0._modleAnim:Resume()
	end
end

slot0.GetInterface = function(slot0)
	return slot0._modelClick, slot0._modelPress, slot0._dragDelegate
end

slot0.EnableInterface = function(slot0)
	slot0._mouseChild:GetComponent(typeof(Image)).enabled = true
end

slot0.DisableInterface = function(slot0)
	slot0._mouseChild:GetComponent(typeof(Image)).enabled = false
end

slot0.Dispose = function(slot0)
	if slot0.state == uv0.STATE_INITED then
		slot0:StopTweenShining()
		slot0:RevertMaterial()
		PoolMgr.GetInstance():ReturnSpineChar(slot0.prefabName, slot0.model)
		slot0:SetVisible(true)
		slot0._modleGraphic.material:SetColor("_Color", Color.New(0, 0, 0, 0))

		slot4 = 1
		slot5 = 1
		slot0._modleGraphic.color = Color.New(1, slot4, slot5, 1)

		for slot4, slot5 in pairs(slot0._attachmentList) do
			Object.Destroy(slot4.gameObject)
		end

		slot0.model = nil
		slot0.prefabName = nil
		slot0.ship = nil
		slot0.attachmentData = nil
		slot0._modleGraphic = nil
		slot0._modleAnim = nil
		slot0._attachmentList = nil
	end

	slot0.state = uv0.STATE_DISPOSE
end

return slot0
