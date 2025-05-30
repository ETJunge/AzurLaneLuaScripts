ChargeConst = {}
slot0 = ChargeConst

slot0.getBuyCount = function(slot0, slot1)
	if not slot0 then
		return 0
	end

	return slot0[slot1] and slot2.buyCount or 0
end

slot0.getGroupLimit = function(slot0, slot1)
	if not slot0 then
		return 0
	end

	for slot5, slot6 in ipairs(slot0) do
		if slot6.shop_id == slot1 then
			return slot6.pay_count
		end
	end

	return 0
end

slot0.getGoodsLimitInfo = function(slot0)
	slot1, slot2, slot3 = nil

	if pg.shop_template[slot0] then
		if type(slot5.limit_args[1]) == "table" then
			for slot10, slot11 in ipairs(slot5.limit_args) do
				if slot11[1] == "level" then
					slot1 = slot11[2]
				elseif slot12 == "count" then
					slot2 = slot11[2]
					slot3 = slot11[3]
				end
			end
		elseif type(slot6) == "string" then
			if slot6 == "level" then
				slot1 = slot5.limit_args[2]
			elseif slot6 == "count" then
				slot2 = slot5.limit_args[2]
				slot3 = slot5.limit_args[3]
			end
		end
	end

	return slot1, slot2, slot3
end

slot0.isNeedSetBirth = function()
	return false
end

return slot0
