return {
	id = 296182,
	stages = {
		{
			stageIndex = 1,
			failCondition = 1,
			timeCount = 80,
			backGroundStageID = 1,
			passCondition = 1,
			totalArea = {
				-70,
				20,
				90,
				70
			},
			playerArea = {
				-70,
				20,
				37,
				68
			},
			enemyArea = {},
			fleetCorrdinate = {
				-80,
				0,
				75
			},
			waves = {
				{
					triggerType = 1,
					waveIndex = 100,
					preWaves = {},
					triggerParams = {
						timeout = 0.5
					}
				},
				{
					triggerType = 1,
					key = true,
					waveIndex = 203,
					preWaves = {
						101
					},
					triggerParams = {
						timeout = 0.1
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 101,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParam = {},
					spawn = {
						{
							score = 0,
							delay = 0,
							moveCast = true,
							affix = true,
							monsterTemplateID = 295182,
							corrdinate = {
								-10,
								0,
								50
							},
							buffList = {},
							bossData = {
								hpBarNum = 100,
								icon = ""
							},
							phase = {
								{
									switchType = 1,
									switchTo = 1,
									index = 0,
									switchParam = 2.5,
									setAI = 20006,
									addWeapon = {}
								},
								{
									switchParam = 4,
									switchTo = 2,
									index = 1,
									switchType = 1,
									setAI = 10001,
									addWeapon = {
										2975030
									},
									removeWeapon = {}
								},
								{
									switchParam = 1,
									switchTo = 3,
									index = 2,
									switchType = 1,
									setAI = 70125,
									addWeapon = {},
									removeWeapon = {}
								},
								{
									switchParam = 3.5,
									switchTo = 4,
									index = 3,
									switchType = 1,
									addWeapon = {
										2975035
									},
									removeWeapon = {}
								},
								{
									switchParam = 6,
									switchTo = 5,
									index = 4,
									switchType = 1,
									addWeapon = {
										2975040
									},
									removeWeapon = {}
								},
								{
									switchParam = 1,
									switchTo = 6,
									index = 5,
									switchType = 1,
									addWeapon = {
										2975045,
										2975050
									},
									removeWeapon = {
										2975030,
										2975035,
										2975040
									}
								},
								{
									switchType = 1,
									switchTo = 7,
									index = 6,
									switchParam = 15,
									setAI = 10001
								},
								{
									switchParam = 10,
									switchTo = 8,
									index = 7,
									switchType = 1,
									addWeapon = {
										2975055
									},
									removeWeapon = {
										2975045,
										2975050
									}
								},
								{
									switchParam = 8,
									switchTo = 9,
									index = 8,
									switchType = 1,
									setAI = 10001,
									addWeapon = {
										2975030,
										2975060
									},
									removeWeapon = {
										2975055
									}
								},
								{
									switchParam = 5,
									switchTo = 10,
									index = 9,
									switchType = 1,
									addWeapon = {
										2975065
									},
									removeWeapon = {}
								},
								{
									switchParam = 2,
									switchTo = 11,
									index = 10,
									switchType = 1,
									setAI = 70125,
									addWeapon = {},
									removeWeapon = {
										2975030,
										2975060,
										2975065
									}
								},
								{
									switchParam = 2,
									switchTo = 12,
									index = 11,
									switchType = 1,
									addWeapon = {
										2975070,
										2975075
									},
									removeWeapon = {}
								},
								{
									switchParam = 300,
									switchTo = 1,
									index = 12,
									switchType = 1,
									addWeapon = {
										2975080,
										2975085
									},
									removeWeapon = {}
								}
							}
						}
					}
				},
				{
					triggerType = 8,
					waveIndex = 900,
					preWaves = {
						201
					},
					triggerParams = {}
				}
			}
		}
	},
	fleet_prefab = {}
}
