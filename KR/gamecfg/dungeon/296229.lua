return {
	id = 296229,
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
							monsterTemplateID = 296249,
							sickness = 0.1,
							delay = 0.1,
							score = 0,
							corrdinate = {
								-43,
								0,
								53
							},
							buffList = {
								200493
							}
						},
						{
							monsterTemplateID = 296234,
							sickness = 0.1,
							delay = 0.1,
							score = 0,
							corrdinate = {
								-43,
								0,
								78
							},
							buffList = {
								200493
							}
						},
						{
							monsterTemplateID = 296234,
							sickness = 0.1,
							delay = 0.1,
							score = 0,
							corrdinate = {
								-43,
								0,
								28
							},
							buffList = {
								200493
							}
						},
						{
							monsterTemplateID = 295229,
							sickness = 0.1,
							delay = 0,
							score = 0,
							corrdinate = {
								-10,
								0,
								53
							},
							buffList = {
								201062
							},
							bossData = {
								hpBarNum = 100,
								icon = ""
							},
							phase = {
								{
									switchType = 1,
									switchTo = 1,
									index = 0,
									switchParam = 1.5,
									setAI = 20006
								},
								{
									switchParam = 4,
									switchTo = 2,
									index = 1,
									switchType = 1,
									setAI = 70252,
									addWeapon = {
										2978011,
										2978016
									}
								},
								{
									switchParam = 4,
									switchTo = 3,
									index = 2,
									switchType = 1,
									setAI = 20006,
									addWeapon = {
										2978001,
										2978006,
										2978021
									},
									removeWeapon = {}
								},
								{
									switchType = 1,
									switchTo = 4,
									index = 3,
									switchParam = 1,
									removeWeapon = {
										2978011,
										2978016
									}
								},
								{
									switchParam = 4,
									switchTo = 5,
									index = 4,
									switchType = 1,
									setAI = 70252,
									addWeapon = {
										2978011,
										2978016
									},
									removeWeapon = {
										2978001,
										2978006,
										2978021
									}
								},
								{
									switchParam = 4,
									switchTo = 6,
									index = 5,
									switchType = 1,
									setAI = 70125,
									addWeapon = {
										2978001,
										2978006,
										2978026
									},
									removeWeapon = {}
								},
								{
									switchType = 1,
									switchTo = 7,
									index = 6,
									switchParam = 1.5,
									removeWeapon = {
										2978011,
										2978016
									}
								},
								{
									switchParam = 18,
									switchTo = 8,
									index = 7,
									switchType = 1,
									addWeapon = {
										2978031,
										2978036,
										2978041
									},
									removeWeapon = {
										2978001,
										2978006,
										2978026
									}
								},
								{
									switchType = 1,
									switchTo = 9,
									index = 8,
									switchParam = 2,
									addWeapon = {
										2978026
									}
								},
								{
									switchType = 1,
									switchTo = 10,
									index = 9,
									switchParam = 4,
									addWeapon = {
										2978001,
										2978006
									}
								},
								{
									switchType = 1,
									switchTo = 11,
									index = 10,
									switchParam = 2.5,
									removeWeapon = {
										2978001,
										2978006,
										2978026,
										2978031,
										2978036,
										2978041
									}
								},
								{
									switchType = 1,
									switchTo = 12,
									index = 11,
									switchParam = 2.5,
									addWeapon = {
										2978046,
										2978056
									}
								},
								{
									switchParam = 7,
									switchTo = 13,
									index = 12,
									switchType = 1,
									setAI = 70252,
									addWeapon = {
										2978051
									}
								},
								{
									switchType = 1,
									switchTo = 1,
									index = 13,
									switchParam = 300,
									addWeapon = {
										2978001,
										2978006
									}
								}
							}
						}
					}
				},
				{
					triggerType = 11,
					waveIndex = 4001,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParams = {
						key = "warning",
						op = 0
					}
				},
				{
					triggerType = 8,
					waveIndex = 900,
					preWaves = {
						203
					},
					triggerParams = {}
				}
			}
		}
	},
	fleet_prefab = {}
}
