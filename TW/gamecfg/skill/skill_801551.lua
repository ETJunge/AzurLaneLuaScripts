return {
	uiEffect = "",
	name = "重点防护",
	cd = 0,
	picture = "0",
	desc = "重点防护",
	painting = 1,
	id = 801551,
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
			target_choise = "TargetSelf",
			arg_list = {
				buff_id = 801552
			}
		}
	}
}
