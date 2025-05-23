slot0 = class("NotificationMediator", import("..base.ContextMediator"))
slot0.ON_SEND_PUBLIC = "NotificationMediator:ON_SEND_PUBLIC"
slot0.CHANGE_ROOM = "NotificationMediator:CHANGE_ROOM"
slot0.OPEN_INFO = "NotificationMediator:OPEN_INFO"
slot0.OPEN_EMOJI = "NotificationMediator:OPEN_EMOJI"
slot0.BATTLE_CHAT_CLOSE = "NotificationMediator:BATTLE_CHAT_CLOSE"

slot0.register = function(slot0)
	slot0.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())

	slot4 = slot0.viewComponent

	slot4:setInGuild(getProxy(GuildProxy):getRawData() ~= nil)
	slot0.viewComponent:setMessages(slot0:getAllMessages())
	slot0:bind(uv0.ON_SEND_PUBLIC, function (slot0, slot1, slot2)
		if slot2 == "$ rndsec refresh" and Application.isEditor then
			MainRandomFlagShipSequence.ForceRandom()
		elseif slot2:match("$ rndskin print %d+") and Application.isEditor then
			MainRandomFlagShipSequence.CalcRatio(tonumber(string.gmatch(slot2, "%d+")()), function (slot0)
				getProxy(ChatProxy):addNewMsg(ChatMsg.New(ChatConst.ChannelWorld, {
					richText = true,
					player = getProxy(PlayerProxy):getData(),
					content = slot0,
					timestamp = pg.TimeMgr.GetInstance():GetServerTime()
				}))
			end)
		elseif slot2:match("^$ (%S+)") then
			slot3 = {}

			for slot7, slot8 in slot2:gmatch("%s+(%S+)") do
				table.insert(slot3, slot7)
			end

			uv0:sendNotification(GAME.SEND_CMD, {
				cmd = slot3[1],
				arg1 = slot3[2],
				arg2 = slot3[3],
				arg3 = slot3[4],
				arg4 = slot3[5]
			})
		elseif slot2 == "world battle skip" then
			switch_world_skip_battle()
		elseif slot2 == pg.gameset.code_switch.description then
			if getProxy(PlayerProxy):getRawData().level >= 9 then
				HXSet.switchCodeMode()
			end
		else
			slot4 = getProxy(PlayerProxy):getData()
			slot7 = 0

			for slot11 = #getProxy(ChatProxy):getData(), 1, -1 do
				if slot6[slot11].type == ChatConst.ChannelWorld and slot6[slot11].player.id == slot4.id then
					slot7 = slot6[slot11].timestamp

					break
				end
			end

			if pg.TimeMgr.GetInstance():GetServerTime() < slot4.chatMsgBanTime then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					content = i18n("chat_msg_ban", os.date("%Y/%m/%d %H:%M:%S", slot4.chatMsgBanTime))
				})
			elseif PLATFORM_CODE == PLATFORM_CH and LuaHelper.GetCHPackageType() ~= PACKAGE_TYPE_BILI and slot4.level < 70 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 70))
			elseif slot4.level < 10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("chat_level_not_enough", 10))
			elseif slot8 - slot7 < 10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dont_send_message_frequently", 10 - (slot8 - slot7)))
			else
				slot9, slot10 = wordVer(slot2, {
					isReplace = true
				})

				if slot1 == ChatConst.ChannelWorld then
					uv0:sendNotification(GAME.SEND_MSG, slot10)
				elseif slot1 == ChatConst.ChannelGuild then
					uv0:sendNotification(GAME.GUILD_SEND_MSG, slot10)
				end

				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildEmoji(slot10))
			end
		end
	end)
	slot0:bind(uv0.CHANGE_ROOM, function (slot0, slot1)
		if slot1 == getProxy(PlayerProxy):getRawData().chatRoomId then
			uv0:onChangeChatRoomDone()
		else
			uv0:sendNotification(GAME.CHANGE_CHAT_ROOM, slot1)
		end
	end)
	slot0:bind(uv0.BATTLE_CHAT_CLOSE, function (slot0)
		uv0:sendNotification(BattleMediator.CLOSE_CHAT)
	end)
	slot0:bind(uv0.OPEN_INFO, function (slot0, slot1, slot2, slot3)
		if slot1.id == uv0.id then
			return
		end

		uv1.contextData.pos = slot2
		uv1.contextData.msg = slot3

		uv1:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = slot1.id
		})
	end)
	slot0:bind(uv0.OPEN_EMOJI, function (slot0, slot1, slot2)
		uv0:addSubLayers(Context.New({
			viewComponent = EmojiLayer,
			mediator = EmojiMediator,
			data = {
				callback = slot1,
				pos = slot2,
				LayerWeightMgr_groupName = LayerWeightConst.GROUP_NOTIFICATION,
				emojiIconCallback = function (slot0)
					uv0.viewComponent:insertEmojiToInputText(slot0)
				end
			}
		}), true)
	end)
end

slot0.listNotificationInterests = function(slot0)
	return {
		GAME.SEND_CMD_DONE,
		ChatProxy.NEW_MSG,
		GAME.CHANGE_CHAT_ROOM_DONE,
		GAME.CHAT_ROOM_MAX_NUMBER,
		GAME.FRIEND_SEARCH_DONE,
		GAME.FINISH_STAGE,
		FriendProxy.FRIEND_NEW_MSG,
		GuildProxy.NEW_MSG_ADDED,
		GAME.GO_WORLD_BOSS_SCENE
	}
end

slot0.handleNotification = function(slot0, slot1)
	slot3 = slot1:getBody()

	if slot1:getName() == ChatProxy.NEW_MSG or slot2 == FriendProxy.FRIEND_NEW_MSG or slot2 == GuildProxy.NEW_MSG_ADDED then
		slot4 = slot0.viewComponent.messages

		table.insert(slot4, slot3)
		slot0.viewComponent:setMessages(slot4)

		slot6 = getProxy(PlayerProxy):getRawData()

		if NotificationLayer.ChannelBits.recv == bit.lshift(1, ChatConst.ChannelAll) or bit.band(slot7, bit.lshift(1, slot3.type)) > 0 then
			table.insert(slot0.viewComponent.filteredMessages, slot3)
			slot0.viewComponent:append(slot3, -1, true)
		elseif slot3.player and slot3.player.id == slot6.id then
			slot8 = slot0.viewComponent.recvTypes

			slot8:each(function (slot0, slot1)
				if ChatConst.RecvChannels[slot0 + 1] == uv0.type then
					triggerButton(slot1)
				end
			end)
		end
	elseif slot2 == GAME.SEND_CMD_DONE then
		if string.find(slot3, "CMD:into") then
			slot0.viewComponent:closeView()
		end
	elseif slot2 == GAME.CHANGE_CHAT_ROOM_DONE then
		slot0:onChangeChatRoomDone(slot3)
	elseif slot2 == GAME.CHAT_ROOM_MAX_NUMBER then
		pg.TipsMgr.GetInstance():ShowTips(i18n("main_notificationMediator_room_max_number"))
	elseif slot2 == GAME.FRIEND_SEARCH_DONE then
		if slot3.list[1] then
			slot0:addSubLayers(Context.New({
				viewComponent = FriendInfoLayer,
				mediator = FriendInfoMediator,
				data = {
					friend = slot3.list[1],
					pos = slot0.contextData.pos,
					msg = slot0.contextData.msg,
					form = slot0.contextData.form,
					parent = slot0.contextData.chatViewParent,
					LayerWeightMgr_groupName = LayerWeightConst.GROUP_NOTIFICATION
				}
			}))

			slot0.contextData.pos = nil
			slot0.contextData.msg = nil
		end
	elseif slot2 == GAME.FINISH_STAGE then
		slot0.viewComponent:closeView()
	elseif slot2 == GAME.GO_WORLD_BOSS_SCENE then
		slot0.viewComponent:closeView()
	end
end

slot0.getAllMessages = function(slot0)
	slot1 = {}

	_.each(getProxy(ChatProxy):getRawData(), function (slot0)
		table.insert(uv0, slot0)
	end)

	if getProxy(GuildProxy):getRawData() then
		_.each(slot3:getChatMsgs(), function (slot0)
			table.insert(uv0, slot0)
		end)
	end

	_.each(getProxy(FriendProxy):getCacheMsgList(), function (slot0)
		table.insert(uv0, slot0)
	end)

	return _(slot1):chain():filter(function (slot0)
		return not uv0:isInBlackList(slot0.playerId)
	end):sort(function (slot0, slot1)
		return slot0.timestamp < slot1.timestamp
	end):value()
end

slot0.onChangeChatRoomDone = function(slot0, slot1)
	if slot0.viewComponent.tempRoomSendBits then
		NotificationLayer.ChannelBits.send = slot0.viewComponent.tempRoomSendBits
	end

	if slot0.viewComponent.tempRoomRecvBits then
		NotificationLayer.ChannelBits.recv = slot0.viewComponent.tempRoomRecvBits
	end

	slot0.viewComponent:closeChangeRoomPanel()
	slot0.viewComponent:setMessages(slot0:getAllMessages())
	slot0.viewComponent:updateChatChannel()
	slot0.viewComponent:updateFilter()
	slot0.viewComponent:updateAll()

	if slot1 then
		slot0.viewComponent:setPlayer(slot1)
		slot0.viewComponent:updateRoom()
	end
end

return slot0
