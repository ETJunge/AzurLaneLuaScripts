return {
	time = 0,
	name = "活动buff-建筑效果-战斗伤害提高",
	init_effect = "",
	id = 504,
	picture = "",
	desc = "舰队伤害提高",
	stack = 1,
	color = "yellow",
	icon = 504,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				buff_id = 505,
				target = "TargetAllHelp"
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onSubmarineAid"
			},
			arg_list = {
				buff_id = 505,
				target = "TargetAllHelp"
			}
		}
	}
}
