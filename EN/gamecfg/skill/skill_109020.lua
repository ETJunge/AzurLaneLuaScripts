return {
	uiEffect = "",
	name = "",
	cd = 0,
	picture = "0",
	desc = "",
	painting = 1,
	id = 109020,
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
			target_choise = "TargetNationalityFriendly",
			arg_list = {
				buff_id = 109021,
				nationality = 109
			}
		}
	}
}
