return {
	id = "NG0031",
	events = {
		{
			alpha = 0.3,
			code = {
				1
			},
			ui = {
				dynamicPath = function ()
					if getProxy(SettingsProxy):IsMellowStyle() then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/right/MainActDelegationBtn(Clone)"
					else
						return "OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/eventPanel/MainActDelegationBtn(Clone)"
					end
				end,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -60.31,
					posX = 113.1
				}
			},
			style = {
				text = "Fulfill people's requests and you'll receive a few alchemy ingredients.",
				mode = 1,
				dir = 1,
				posY = 197.47,
				posX = 293.8
			}
		},
		{
			alpha = 0.128,
			waitScene = "RyzaTaskScene",
			code = {
				2
			},
			ui = {
				path = "OverlayCamera/Overlay/UIMain/Msgbox(Clone)",
				triggerType = {
					1
				},
				fingerPos = {
					posY = -158.3,
					posX = 756.2
				}
			}
		},
		{
			waitScene = "RyzaTaskScene",
			alpha = 0.2,
			code = {
				1
			},
			ui = {
				path = "UICamera/Canvas/UIMain/RyzaTaskUI(Clone)/ad/btnGetAll",
				triggerType = {
					1
				},
				fingerPos = {
					posY = -6.36,
					posX = 16.41
				}
			},
			style = {
				text = "For this one, you just have to clear stage T5!",
				mode = 1,
				dir = 1,
				posY = -212.73,
				posX = 462.68
			}
		},
		{
			waitScene = "AwardInfoLayer",
			code = {
				1
			},
			ui = {
				path = "OverlayCamera/Overlay/UIMain/AwardInfoUI(Clone)/items/close",
				triggerType = {
					1
				},
				fingerPos = {
					posY = -43.62,
					posX = 114.51
				}
			}
		},
		{
			alpha = 0.3,
			code = {
				1
			},
			ui = {
				path = "UICamera/Canvas/UIMain/RyzaTaskUI(Clone)/ad/btnMain",
				triggerType = {
					1
				},
				fingerPos = {
					posY = -54.16,
					posX = 33.9
				}
			},
			style = {
				text = "Now go back to the main screen.",
				mode = 1,
				dir = 1,
				posY = 311.92,
				posX = 495.66
			}
		}
	}
}
