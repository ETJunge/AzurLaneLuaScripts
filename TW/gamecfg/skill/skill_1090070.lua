return {
	uiEffect = "",
	name = "炮术指挥·SIMS",
	cd = 0,
	picture = "0",
	desc = "提高舰队中所有驱逐舰的炮击属性",
	painting = 1,
	id = 1090070,
	castCV = "skill",
	aniEffect = {
		effect = "jineng",
		offset = {
			0,
			-2,
			0
		}
	},
	effect_list = {
		{
			targetAniEffect = "",
			casterAniEffect = "",
			type = "BattleSkillAddBuff",
			target_choise = {
				"TargetAllHelp",
				"TargetShipType"
			},
			arg_list = {
				buff_id = 1000,
				ship_type_list = {
					1,
					20,
					21
				}
			}
		}
	}
}
