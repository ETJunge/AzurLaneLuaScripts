slot0 = class("EquipUpgradeMediator", import("..base.ContextMediator"))
slot0.EQUIPMENT_UPGRDE = "EquipUpgradeMediator:EQUIPMENT_UPGRDE"
slot0.REPLACE_EQUIP = "EquipUpgradeMediator:REPLACE_EQUIP"
slot0.ON_ITEM = "EquipUpgradeMediator:ON_ITEM"

slot0.register = function(slot0)
	slot0.bagProxy = getProxy(BagProxy)
	slot1 = slot0.bagProxy
	slot2 = slot0.viewComponent

	slot2:setItems(slot1:getData())

	slot2 = getProxy(PlayerProxy)
	slot3 = slot0.viewComponent

	slot3:updateRes(slot2:getData())
	slot0:bind(uv0.EQUIPMENT_UPGRDE, function (slot0)
		pg.UIMgr.GetInstance():LoadingOn()
		uv0:sendNotification(GAME.UPGRADE_EQUIPMENTS, {
			shipId = uv0.contextData.shipId,
			pos = uv0.contextData.pos,
			equipmentId = uv0.contextData.equipmentId
		})
	end)
	slot0:bind(uv0.ON_ITEM, function (slot0, slot1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_confirm",
			hideNo = true,
			content = "",
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = {
				type = DROP_TYPE_ITEM,
				id = slot1,
				cfg = Item.getConfigData(slot1)
			},
			weight = LayerWeightConst.TOP_LAYER
		})
	end)

	if slot0.contextData.shipId ~= nil then
		slot5 = getProxy(BayProxy):getShipById(slot3)
		slot0.contextData.shipVO = slot5
		slot0.contextData.equipmentVO = slot5:getEquip(slot0.contextData.pos)
	elseif slot0.contextData.equipmentId ~= nil then
		slot0.contextData.equipmentVO = getProxy(EquipmentProxy):getEquipmentById(slot4)
	end
end

slot0.listNotificationInterests = function(slot0)
	return {
		GAME.UPGRADE_EQUIPMENTS_DONE,
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED
	}
end

slot0.handleNotification = function(slot0, slot1)
	slot3 = slot1:getBody()

	if slot1:getName() == GAME.UPGRADE_EQUIPMENTS_DONE then
		slot6 = slot3.newEquip
		slot0.contextData.shipVO = slot3.ship
		slot0.contextData.equipmentVO = slot6

		slot0.viewComponent:updateAll()
		slot0.viewComponent:upgradeFinish(slot3.equip, slot6)
		pg.UIMgr.GetInstance():LoadingOff()
	elseif slot2 == BagProxy.ITEM_UPDATED then
		slot0.viewComponent:setItems(slot0.bagProxy:getData())
	elseif slot2 == PlayerProxy.UPDATED then
		slot0.viewComponent:updateRes(getProxy(PlayerProxy):getData())
	end
end

return slot0
