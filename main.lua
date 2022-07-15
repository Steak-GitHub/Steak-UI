local Library = {
	Color = Color3.fromRGB(0, 170, 255),
	Colorable = {},
	TweenTable = {},
	Tabs = {},
	TabCount = 0,
}

-- services
local uis = game:GetService('UserInputService')
local ts = game:GetService('TweenService')
local rs = game:GetService("RunService")

-- function for normal dragging, bc roblox dragging is so shitty
local function MakeDraggable(ClickObject, Object) -- credits to idk, not mine
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil
	local UserInputService = game:GetService('UserInputService')

	ClickObject.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = Input.Position
			StartPosition = Object.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	ClickObject.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			DragInput = Input
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - DragStart
			Object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		end
	end)
end

--[[

config format example:

{
	Name = "Name",
	Parent = game.CoreGui,
	Settings = {
		DontEnterTextFields = true,
		UIColor = Color3.fromRGB(0, 170, 255),
		ImageBackground = false,
		ImageId = "6164011737",
		ImageTransparency = 20,
		Theme = 2
	}
}

]]

-- Main function

Library.new = function(config)
	-- check config format
	local libraryNew = {}
	if config then
		assert(typeof(config) == "table", "Steak UI: Wrong config format")
	else
		config = {}
	end
	if config.Name then
		assert(typeof(config.Name) == "string", "Steak UI: Wrong config format")
	else
		config.Name = "Untitled"
	end
	if config.Parent then
		assert(typeof(config.Parent) == "Instance", "Steak UI: Wrong config format")
	else
		config.Parent = game:GetService('CoreGui')
	end
	if config.Settings then
		assert(typeof(config.Settings) == "table", "Steak UI: Wrong config format")
	else
		config.Settings = {}
	end
	if config.Settings.DontEnterTextFields then
		assert(typeof(config.Settings.DontEnterTextFields) == "boolean", "Steak UI: Wrong config format")
	else
		config.Settings.DontEnterTextFields = true
	end
	if config.Settings.UIColor then
		assert(typeof(config.Settings.UIColor) == "Color3", "Steak UI: Wrong config format")
	else
		config.Settings.UIColor = Color3.fromRGB(0, 170, 255)
	end
	if config.Settings.ImageBackground then
		assert(typeof(config.Settings.ImageBackground) == "boolean", "Steak UI: Wrong config format")
	else
		config.Settings.ImageBackground = false
	end
	if config.Settings.ImageId then
		assert(typeof(config.Settings.ImageId) == "string", "Steak UI: Wrong config format")
	else
		config.Settings.ImageId = "6162182119"
	end
	if config.Settings.ImageTransparency then
		assert(typeof(config.Settings.ImageTransparency) == "number", "Steak UI: Wrong config format")
		config.Settings.ImageTransparency = math.clamp(config.Settings.ImageTransparency, 0, 100)
	else
		config.Settings.ImageTransparency = 20
	end
	if config.Settings.Theme then
		assert(typeof(config.Settings.Theme) == "number", "Steak UI: Wrong config format")
		config.Settings.Theme = math.clamp(config.Settings.Theme, 1, 2)
	else
		config.Settings.Theme = 2
	end

	-- main

	Library.Color = config.Settings.UIColor

	-- function create, for creating instances more easily
	local function create(class, props)
		local instance = Instance.new(class)
		for i,v in pairs(props) do
			if typeof(v) == "Instance" and i ~= "Parent" then
				v.Parent = instance
			else
				instance[i] = v
			end
		end
		return instance
	end

	-- function randomString, for generating random string
	local function randomString(len)
		local charspack = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!#$%^&*(){}[]|/<>.?'
		local split = charspack.split('')
		local randomized = ""
		for i = 1, len do
			randomized = randomized..split[math.random(#split)]
		end
		return randomized
	end

	-- Generate Functions --

	local generate = {}

	-- generate.shadow, function to generate shadow
	generate.shadow = function(transparency) --drop shadow feature credits to uhTeddy
		local Holder = create("Frame", {
			Name = "shadowDrop",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, -4),
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 1,
			create("ImageLabel", {
				Name = "Ambient",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 8),
				Size = UDim2.new(1, 10, 1, 10),
				ZIndex = 1,
				Image = "rbxassetid://1316045217",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = transparency or 0.88,
				SliceCenter = Rect.new(10, 10, 118, 118)
			}),
			create("ImageLabel", {
				Name = "Penumbra",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 8),
				Size = UDim2.new(1, 10, 1, 10),
				ZIndex = 1,
				Image = "rbxassetid://1316045217",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = transparency or 0.88,
				SliceCenter = Rect.new(10, 10, 118, 118)
			}),
			create("ImageLabel", {
				Name = "Umbra",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 8),
				Size = UDim2.new(1, 10, 1, 10),
				ZIndex = 1,
				Image = "rbxassetid://1316045217",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = transparency or 0.88,
				SliceCenter = Rect.new(10, 10, 118, 118)
			})
		})
		return Holder	
	end

	-- generate.main, generate main instances
	generate.main = function()
		local generated = create("ScreenGui", {
			Name = randomString(math.random(10, 30)),
			Parent = config.Parent,
			Enabled = false,
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Global,
			create("Frame", {
				Name = "MainWindow",
				BackgroundColor3 = Color3.fromRGB(35, 35, 35),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, -263, 0.5, -245),
				Size = UDim2.new(0, 527, 0, 490),
				ZIndex = 0,
				--[[create("Frame", {
					Name = "BlackSolid",
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 527, 0, 490),
					ZIndex = 1
				}),
				create("Frame", {
					Name = "Info",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(35, 35, 35),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.75, 0, 0.75, 0),
					ZIndex = 2,
					create("Frame", {
						Name = "Line",
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(100, 100, 100),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.499, 0, 0.327, 0),
						Size = UDim2.new(0.608, 0, 0, 1),
						ZIndex = 2
					}),
					create("Frame", {
						Name = "Top",
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(100, 100, 100),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.499, 0, 0.327, 0),
						Size = UDim2.new(0.608, 0, 0, 1),
						ZIndex = 2,
						create("TextLabel", {
							Name = "Label",
							BackgroundTransparency = 1,
							Position = UDim2.new(0.025, 0, 0, 0),
							Size = UDim2.new(0.9, 0, 1, 0),
							ZIndex = 2,
							Font = Enum.Font.Roboto,
							RichText = true,
							Text = "Info",
							TextColor3 = Color3.fromRGB(200, 200, 200),
							TextTransparency = 1,
							TextXAlignment = Enum.TextXAlignment.Left
						})
					}),
					create("TextLabel", {
						Name = "Content",
						BackgroundTransparency = 1,
						Position = UDim2.new(0.194, 0, 0.419, 0),
						Size = UDim2.new(0.608, 0, 0.581, 0),
						ZIndex = 2,
						Font = Enum.Font.Roboto,
						RichText = true,
						Text = "Unreleased

By steak#8439",
						TextColor3 = Color3.fromRGB(200, 200, 200),
						TextTransparency = 1,
						TextWrapped = true,
						TextYAlignment = Enum.TextYAlignment.Top
					}),
					create("TextLabel", {
						Name = "SteakUI",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 0, 0.133, 0),
						Size = UDim2.new(1, 0, 0.233, 0),
						ZIndex = 2,
						Font = Enum.Font.Roboto,
						RichText = true,
						Text = "Steak UI",
						TextColor3 = Color3.fromRGB(200, 200, 200),
						TextSize = 69,
						TextTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					generate.shadow(1)
				}),]]
				create("ScrollingFrame", {
					Name = "T",
					BackgroundTransparency = 1,
					Position = UDim2.new(0.028, 0, 0.157, 0),
					Size = UDim2.new(0, 496, 0, 400),
					ZIndex = 1,
					ScrollBarThickness = 0,
					ScrollingEnabled = false,
					create("UIListLayout", {
						Name = "ListLayout",
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder
					})
				}),
				create("ScrollingFrame", {
					Name = "TB",
					BackgroundTransparency = 1,
					Position = UDim2.new(0.028, 0, 0.063, 0),
					Size = UDim2.new(0, 495, 0, 32),
					ZIndex = 1,
					ScrollBarThickness = 0,
					ScrollingDirection = Enum.ScrollingDirection.X,
					create("Frame", {
						Name = "SelectedLine",
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Library.Color,
						BorderSizePixel = 0,
						Position = UDim2.new(0.052, 0, 1, -2),
						Size = UDim2.new(0, 52, 0, 2),
						ZIndex = 2
					}),
					create("Frame", {
						Name = "Container",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(0, 495, 0, 32),
						ZIndex = 2,
						create("UIListLayout", {
							Name = "ListLayout",
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder
						}),
						create("TextButton", {
							Name = "Init",
							Size = UDim2.new(0, 0, 0, 0),
							Visible = false,
							ZIndex = 1
						})
					})
				}),
				create("Frame", {
					Name = "TBLine",
					BackgroundColor3 = Color3.fromRGB(100, 100, 100),
					BorderSizePixel = 0,
					Position = UDim2.new(0.028, 0, 0.131, -2),
					Size = UDim2.new(0, 497, 0, 1),
					ZIndex = 1
				}),
				create("Frame", {
					Name = "Top",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 527, 0, 20),
					ZIndex = 1,
					create("ImageLabel", {
						Name = "Icon",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 5, 0, 2),
						Size = UDim2.new(0, 16, 0, 16),
						ZIndex = 1,
						Image = "rbxassetid://9901609256",
						ImageColor3 = Library.Color,
						ScaleType = Enum.ScaleType.Fit
					}),
					create("TextLabel", {
						Name = "Label",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(1, 0, 0, 20),
						ZIndex = 1,
						Font = Enum.Font.Roboto,
						RichText = true,
						Text = "Untitled",
						TextSize = 14,
						TextColor3 = Color3.fromRGB(200, 200, 200),
						TextXAlignment = Enum.TextXAlignment.Center
					})
				}),
				create("ImageLabel", {
					Name = "BG",
					BackgroundColor3 = Color3.fromRGB(27, 27, 27),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					Visible = false,
					ZIndex = 0,
					Image = "rbxassetid://"..config.Settings.ImageId,
					ScaleType = Enum.ScaleType.Crop
				})
			}),
			create("Frame", {
				Name = "Palette",
				BackgroundColor3 = Color3.fromRGB(35, 35, 35),
				BorderColor3 = Color3.fromRGB(15, 15, 15),
				BorderSizePixel = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(0, 154, 0, 116),
				Visible = false,
				ZIndex = 2,
				create("Frame", {
					Name = "ValImg",
					BackgroundColor3 = Color3.fromRGB(255, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 1,
					Position = UDim2.new(0, 131, 0, 5),
					Size = UDim2.new(0, 10, 0, 106),
					ZIndex = 2,
					create("UIGradient", {
						Name = "Gradient",
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
						},
						Rotation = 90
					}),
					create("TextLabel", {
						Name = "Arrow",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0, 0, 0),
						Rotation = 90,
						Size = UDim2.new(0, 8, 0, 10),
						ZIndex = 2,
						Font = Enum.Font.SourceSans,
						Text = utf8.char(9660),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 10,
						TextStrokeTransparency = 0
					})
				}),
				create("ImageLabel", {
					Name = "HueSatImg",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Position = UDim2.new(0, 5, 0, 5),
					Size = UDim2.new(0, 121, 0, 106),
					ZIndex = 2,
					Image = "rbxassetid://698052001",
					create("Frame", {
						Name = "Dot",
						AnchorPoint = Vector2.new(0.5, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderMode = Enum.BorderMode.Inset,
						BorderSizePixel = 2,
						Position = UDim2.new(0.5, 0, 0, 0),
						Rotation = 45,
						Size = UDim2.new(0, 8, 0, 8),
						ZIndex = 2
					})
				})
			}),
			create("ImageLabel", {
				Name = "ToolTip",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 41, 0, 24),
				Visible = false,
				ZIndex = 2,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(31, 31, 31),
				--ImageTransparency = 1,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.04,
				create("TextLabel", {
					Name = "Label",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 5, 0, 1),
					Size = UDim2.new(0.95, 0, 0.95, 0),
					ZIndex = 2,
					Font = Enum.Font.Roboto,
					Text = "",
					TextSize = 14,
					TextColor3 = Color3.fromRGB(200, 200, 200),
					--TextTransparency = 1,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top
				}),
				--generate.shadow(1)
			})
		})
		return generated
	end
	generate.tab = function()
		local generated = {}
		generated.Tab = create("ScrollingFrame", {
			Name = "Tab",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 496, 0, 400),
			ZIndex = 1,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollingEnabled = false,
			create("Frame", {
				Name = "Left",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 248, 1, 0),
				create("UIListLayout", {
					Name = "ListLayout",
					Padding = UDim.new(0, 8),
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				create("UIPadding", {
					Name = "Padding",
					PaddingTop = UDim.new(0, 8)
				})
			}),
			create("Frame", {
				Name = "Right",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 248, 0, 0),
				Size = UDim2.new(0, 248, 1, 0),
				create("UIListLayout", {
					Name = "ListLayout",
					Padding = UDim.new(0, 8),
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				create("UIPadding", {
					Name = "Padding",
					PaddingTop = UDim.new(0, 8)
				})
			})
		})
		generated.TabButton = create("TextButton", {
			Name = "TabButton",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 51, 0, 32),
			ZIndex = 1,
			Font = Enum.Font.Roboto,
			Text = "Tab",
			TextSize = 14,
			TextColor3 = Color3.fromRGB(200, 200, 200)
		})
		return generated
	end
	generate.section = function()
		return create("Frame", {
			Name = "Section",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 220, 0, 21),
			ZIndex = 1,
			create("TextLabel", {
				Name = "Title",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(35, 35, 35),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, 0, 0, 0),
				Size = UDim2.new(0, 63, 0, 20),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				Text = "Section",
				TextSize = 14,
				TextColor3 = Color3.fromRGB(200, 200, 200)
			}),
			--[[create("Frame", {
				Name = "BorderLine",
				BackgroundColor3 = Color3.fromRGB(100, 100, 100),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 20),
				Size = UDim2.new(0, 220, 0, 1),
				ZIndex = 1,
			}),]]
			create("Frame", {
				Name = "Border",
				BackgroundColor3 = Color3.fromRGB(35, 35, 35),
				BorderColor3 = Color3.fromRGB(55, 55, 55),
				Position = UDim2.new(0, -10, 0, 11),
				Size = UDim2.new(0, 240, 0, 20),
				ZIndex = 0
			}),
			create("Frame", {
				Name = "Container",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 21),
				Size = UDim2.new(0, 220, 0, 0),
				ZIndex = 1,
				create("UIListLayout", {
					Name = "ListLayout",
					Padding = UDim.new(0, 5),
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				create("UIPadding", {
					Name = "Padding",
					PaddingTop = UDim.new(0, 5)
				})
			})
		})
	end
	generate.label = function()
		return create("TextLabel", {
			Name = "Label",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 220, 0, 23),
			ZIndex = 1,
			Font = Enum.Font.Roboto,
			RichText = true,
			Text = "Label",
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center
		})
	end
	generate.button = function()
		return create("ImageButton", {
			Name = "Button",
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 220, 0, 26),
			ZIndex = 1,
			Image = "rbxassetid://9708372345",
			ImageColor3 = Library.Color,
			ScaleType = Enum.ScaleType.Stretch,
			create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 2,
				Font = Enum.Font.Roboto,
				Text = "Button",
				TextColor3 = Library.Color,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	end
	generate.field = function()
		return create("Frame", {
			Name = "Field",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 220, 0, 52),
			ZIndex = 1,
			create("Line", {
				Name = "Line",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(100, 100, 100),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, 0, 0, 50),
				Size = UDim2.new(1, 0, 0, 2),
				ZIndex = 1
			}),
			create("TextBox", {
				Name = "Input",
				BackgroundTransparency = 1,
				MultiLine = false,
				Position = UDim2.new(0, 0, 0, 24),
				Size = UDim2.new(0, 220, 0, 27),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				PlaceholderColor3 = Color3.fromRGB(145, 145, 145),
				PlaceholderText = "Placeholder",
				Text = "",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14
			}),
			create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 220, 0, 24),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				Text = "Field",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	end
	generate.toggle = function()
		return create("Frame", {
			Name = "Toggle",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 220, 0, 24),
			ZIndex = 1,
			create("ImageButton", {
				Name = "CheckBox",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.891, 0, 0, 0),
				Size = UDim2.new(0, 24, 0, 24),
				ZIndex = 1,
				Image = "rbxassetid://9660280370",
				ImageColor3 = Color3.fromRGB(175, 175, 175),
				create("ImageLabel", {
					Name = "Mark",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 24, 0, 24),
					ZIndex = 1,
					Image = "rbxassetid://9660280845",
					ImageColor3 = Library.Color,
					ImageTransparency = 1
				})
			}),
			create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 196, 0, 24),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				Text = "Toggle",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	end
	generate.slider = function()
		return create("Frame", {
			Name = "Slider",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 220, 0, 29),
			ZIndex = 1,
			create("ImageLabel", {
				Name = "Slider",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 23),
				Size = UDim2.new(0, 220, 0, 3),
				ZIndex = 1,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Library.Color,
				ImageTransparency = 0.8,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.12,
				create("ImageLabel", {
					Name = "Bar",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0.5, 0, 0, 3),
					ZIndex = 1,
					Image = "rbxassetid://3570695787",
					ImageColor3 = Library.Color,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.12
				})
			}),
			create("ImageLabel", {
				Name = "Stick",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0, 24),
				Size = UDim2.new(0, 10, 0, 10),
				ZIndex = 1,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Library.Color,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.12
			}),
			create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 220, 0, 23),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				Text = "Slider",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center
			}),
			create("TextLabel", {
				Name = "Value",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 220, 0, 23),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				Text = "50",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Right,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	end
	generate.dropdown = function()
		return create("ScrollingFrame", {
			Name = "Dropdown",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 224, 0, 44),
			ZIndex = 1,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 0,
			ScrollingEnabled = false,
			create("ScrollingFrame", {
				Name = "Container",
				BackgroundColor3 = Color3.fromRGB(5, 5, 5),
				BackgroundTransparency = 0.7,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 1,
				Position = UDim2.new(0, 2, 0, 50),
				Size = UDim2.new(0, 220, 0, 95),
				ZIndex = 1,
				CanvasSize = UDim2.new(0, 0, 0, 0),
				ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
				ScrollBarThickness = 2,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
				create("UIListLayout", {
					Name = "ListLayout",
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top
				}),
				create("TextBox", {
					Name = "SearchBox",
					BackgroundTransparency = 0.95,
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					MultiLine = false,
					Size = UDim2.new(0, 220, 0, 20),
					ZIndex = 1,
					Font = Enum.Font.Roboto,
					PlaceholderColor3 = Color3.fromRGB(145, 145, 145),
					PlaceholderText = "Search...",
					Text = "",
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextSize = 14
				})
			}),
			create("TextButton", {
				Name = "Toggle",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 198, 0, 24),
				Size = UDim2.new(0, 24, 0, 20),
				ZIndex = 2,
				Font = Enum.Font.Roboto,
				Text = utf8.char(9660),
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 9
			}),
			create("ImageLabel", {
				Name = "Value",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 2, 0, 24),
				Size = UDim2.new(0, 220, 0, 20),
				ZIndex = 1,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.75,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.04,
				create("TextLabel", {
					Name = "Value",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 1,
					Font = Enum.Font.Roboto,
					Text = "",
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center
				})
			}),
			create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 2, 0, 0),
				Size = UDim2.new(0, 220, 0, 24),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				Text = "Dropdown",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	end
	generate.option = function()
		return create("TextButton", {
			Name = "Option",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 224, 0, 25),
			Font = Enum.Font.Roboto,
			Text = "Option",
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			create("BoolValue",{
				Name = "Select"
			})
		})
	end
	generate.colorpicker = function()
		return create("Frame", {
			Name = "Colorpicker",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 220, 0, 24),
			ZIndex = 1,
			create("ImageButton", {
				Name = "Toggle",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.891, 0, 0, 0),
				Size = UDim2.new(0, 24, 0, 24),
				ZIndex = 1,
				Image = "rbxassetid://9708464590",
				ImageColor3 = Color3.fromRGB(175, 175, 175)
			}),
			create("TextLabel", {
				Name = "Title",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 196, 0, 24),
				ZIndex = 1,
				Font = Enum.Font.Roboto,
				Text = "Colorpicker",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	end
	generate.palette = function()
		return create("Frame", {
			Name = "Palette",
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
			BorderColor3 = Color3.fromRGB(15, 15, 15),
			BorderSizePixel = 1,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 154, 0, 116),
			Visible = false,
			ZIndex = 2,
			create("Frame", {
				Name = "ValImg",
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 1,
				Position = UDim2.new(0, 131, 0, 5),
				Size = UDim2.new(0, 10, 0, 106),
				ZIndex = 2,
				create("UIGradient", {
					Name = "Gradient",
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
					},
					Rotation = 90
				}),
				create("TextLabel", {
					Name = "Arrow",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0, 0),
					Rotation = 90,
					Size = UDim2.new(0, 8, 0, 10),
					ZIndex = 2,
					Font = Enum.Font.SourceSans,
					Text = utf8.char(9660),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 10,
					TextStrokeTransparency = 0
				})
			}),
			create("ImageLabel", {
				Name = "HueSatImg",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.new(0, 5, 0, 5),
				Size = UDim2.new(0, 121, 0, 106),
				ZIndex = 2,
				Image = "rbxassetid://698052001",
				create("Frame", {
					Name = "Dot",
					AnchorPoint = Vector2.new(0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderMode = Enum.BorderMode.Inset,
					BorderSizePixel = 2,
					Position = UDim2.new(0.5, 0, 0, 0),
					Rotation = 45,
					Size = UDim2.new(0, 8, 0, 8),
					ZIndex = 2
				})
			})
		})
	end

	local Screen = generate.main()
	local Main = Screen.MainWindow
	local T = Main.T
	local TB = Main.TB
	local Top = Main.Top
	local ToolTip = Screen.ToolTip
	local ttable = Library.TweenTable

	MakeDraggable(Top, Main)

	T.ListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		T.CanvasSize = UDim2.fromOffset(T.ListLayout.AbsoluteContentSize.X, 0)
	end)

	TB.Container.ListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		TB.CanvasSize = UDim2.fromOffset(TB.Container.ListLayout.AbsoluteContentSize.X, 0)
	end)
	
	--isOnObject, function for checking if mouse is hover object
	local function isOnObject(object)
		local mouse = uis:GetMouseLocation()
		local clampX = math.clamp((mouse.X - object.AbsolutePosition.X) / object.AbsoluteSize.X,0,1)
		local clampY = math.clamp(((mouse.Y - 36) - object.AbsolutePosition.Y),0,object.AbsoluteSize.Y) / object.AbsoluteSize.Y
		if clampX > 0 and clampX < 1 and clampY > 0 and clampY < 1 then
			return true
		else
			return false
		end
	end

	--mouse, function for getting mouse position
	local function mouse()
		return uis:GetMouseLocation()
	end

	--transparencyAnim, function for transparency tweening/animating
	local function transparencyAnim(obj, prop, endval, inval)
		if ttable[obj] ~= nil then ttable[obj]:Pause() end
		local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		if inval ~= nil then
			obj[prop] = inval
		end
		local t = ts:Create(obj, tinfo, {[prop] = endval})
		t:Play()
		ttable[obj] = t
	end

	--CircleClick, function for ripple click effect
	local function CircleClick(Button, X, Y, transp, mode, ff)
		if mode ~= 2 then
			Button.ClipsDescendants = true
		end

		local Circle = create("ImageLabel", {
			Name = "Circle",
			Parent = Button,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 0, 0, 0),
			ZIndex = 10,
			Image = "rbxassetid://266543268",
			ImageColor3 = Color3.fromRGB(176, 176, 176),
			ImageTransparency = 0.9
		})
		if mode == 1 then
			local h,s,v = Color3.toHSV(Button.ImageColor3)
			if h < .85 then h += .15 else h -= .15 end
			Circle.ImageColor3 = Color3.fromHSV(h,s,v)
		end
		if transp ~= nil then
			Circle.ImageTransparency = transp
		end
		local NewX = X - Circle.AbsolutePosition.X
		local NewY = Y - Circle.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)

		local Size = 0

		if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.X*1.5
		elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.Y*1.5
		elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then			
			Size = Button.AbsoluteSize.X*1.5
		end

		local Time = 0.4
		Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quart", Time)
		if not ff then
			local inputended = uis.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					for i=1,(1 - Circle.ImageTransparency) * 100 do
						Circle.ImageTransparency = Circle.ImageTransparency + 0.01
						wait(Time / ((1 - Circle.ImageTransparency) * 100))
					end
					Circle:Destroy()
				end
			end)
			Circle.Destroying:Connect(function()
				inputended:Disconnect()
			end)
		else
			for i=1,(1 - Circle.ImageTransparency) * 100 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time / ((1 - Circle.ImageTransparency) * 100))
			end
			Circle:Destroy()
		end
	end

	--[[
	
	types:
	
	1: BackgroundColor3
	2: TextColor3
	3: ImageColor3
	4: 1, 2
	5: 1, 3
	
	]]

	--insertColorable, function for inserting objects to colorable table
	local function insertColorable(target, Type)
		if typeof(target) == "table" then
			for i,v in pairs(target) do
				Library.Colorable[i] = v
			end
		elseif typeof(target) == "Instance" then
			Library.Colorable[target] = Type
		end
	end

	--lineMove, function for moving tab buttons line
	local function lineMove(button, b)
		if ttable[TB.SelectedLine] ~= nil then ttable[TB.SelectedLine]:Pause() end
		local contsize = math.clamp(TB.CanvasSize.X.Offset, 495, math.huge)
		local tinfo = TweenInfo.new(b and 0 or 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		local t = ts:Create(TB.SelectedLine, tinfo, {Position = UDim2.new((button.AbsoluteSize.X / 2 / contsize) + ((button.AbsolutePosition.X - TB.Container.Init.AbsolutePosition.X) / contsize), 0, 1, -2), Size = UDim2.new(0, button.AbsoluteSize.X, 0, 2)})
		t:Play()
		ttable[TB.SelectedLine] = t
	end

	insertColorable({
		[TB.SelectedLine] = 1,
		[Top.Icon] = 3
	})

	rs.RenderStepped:Connect(function()
		ToolTip.Position = UDim2.new(0,mouse().X + 5,0,mouse().Y - 60)
	end)

	ToolTip.Label:GetPropertyChangedSignal('TextBounds'):Connect(function()

	end)

	local function hideToolTip()
		--transparencyAnim(ToolTip, "ImageTransparency", 1)
		--transparencyAnim(ToolTip.Label, "TextTransparency", 1)
		--for i,v in pairs(ToolTip.shadowDrop:GetChildren()) do
		--	transparencyAnim(v, "ImageTransparency", 1)
		--end
		ToolTip.Visible = false
	end

	local function showToolTip(text)
		ToolTip.Label.Text = text
		ToolTip.Label.TextWrapped = true
		ToolTip.Label.Size = UDim2.new(0, 275, 0, 1000)
		--wait(0.1)
		ToolTip.Size = UDim2.new(0, math.clamp(ToolTip.Label.TextBounds.X + 10, 1, 275), 0, ToolTip.Label.TextBounds.Y + 6)
		--wait(0.1)
		ToolTip.Label.Size = UDim2.new(0.95, 0, 0.95, 0)
		ToolTip.Visible = true
		--transparencyAnim(ToolTip, "ImageTransparency", 0)
		--transparencyAnim(ToolTip.Label, "TextTransparency", 0)
		--for i,v in pairs(ToolTip.shadowDrop:GetChildren()) do
		--	transparencyAnim(v, "ImageTransparency", 0.88)
		--end
	end

	libraryNew.addTab = function(tabName)
		assert(typeof(tabName) == "string", ("Steak UI: Invalid name format, expected %s got %s"):format("string", typeof(tabName)))
		local addTab = {}
		local generated = generate.tab()
		local Tab = generated.Tab
		local TabButton = generated.TabButton

		local exist = false
		for i,v in pairs(Library.Tabs) do
			if v == tabName then
				exist = true
				break
			end
		end
		assert(not exist, "Steak UI: This tab name already exists")
		table.insert(Library.Tabs, tabName)

		Tab.Name = tabName
		Tab.Parent = T

		TabButton.Name = tabName
		TabButton.Parent = TB.Container
		TabButton.Text = tabName
		TabButton.Size = UDim2.new(0, TabButton.TextBounds.X + 20, 0, 32)

		Tab.LayoutOrder = Library.TabCount
		TabButton.LayoutOrder = Library.TabCount
		Library.TabCount += 1
		if Library.TabCount == 1 then
			lineMove(TabButton, true)
		end

		local function getSide(longest) --credits to bracket ui creator
			if longest then
				if Tab.Left.ListLayout.AbsoluteContentSize.Y > Tab.Right.ListLayout.AbsoluteContentSize.Y then
					return Tab.Left
				else
					return Tab.Right
				end
			else
				if Tab.Left.ListLayout.AbsoluteContentSize.Y > Tab.Right.ListLayout.AbsoluteContentSize.Y then
					return Tab.Right
				else
					return Tab.Left
				end
			end
		end

		Tab.Left.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if getSide(true).Name == 'Left' then
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Left.ListLayout.AbsoluteContentSize.Y + 15)
			else
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Right.ListLayout.AbsoluteContentSize.Y + 15)
			end
		end)

		Tab.Right.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if getSide(true).Name == 'Left' then
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Left.ListLayout.AbsoluteContentSize.Y + 15)
			else
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Right.ListLayout.AbsoluteContentSize.Y + 15)
			end
		end)

		TabButton.MouseButton1Down:Connect(function()
			CircleClick(TabButton, mouse().X + 10, mouse().Y - 30)
		end)

		TabButton.MouseButton1Click:Connect(function()
			lineMove(TabButton)
			local Position = Vector2.new(496 * Tab.LayoutOrder, 0)
			if ttable[T] ~= nil then ttable[T]:Pause() end
			local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local t = ts:Create(T, tinfo, {CanvasPosition = Position})
			t:Play()
			ttable[T] = t
		end)

		Tab.Left.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if getSide(true).Name == 'Left' then
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Left.ListLayout.AbsoluteContentSize.Y + 8)
			else
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Right.ListLayout.AbsoluteContentSize.Y + 8)
			end
		end)
		Tab.Right.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if getSide(true).Name == 'Left' then
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Left.ListLayout.AbsoluteContentSize.Y + 8)
			else
				Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.Right.ListLayout.AbsoluteContentSize.Y + 8)
			end
		end)

		addTab.addSection = function(sectionName)
			assert(typeof(sectionName) == "string", ("Steak UI: Invalid name format, expected %s got %s"):format("string", typeof(sectionName)))
			local addSection = {}
			local Section = generate.section()

			Section.Name = sectionName
			Section.Parent = getSide(false)
			Section.Title.Text = sectionName

			Section.Title.Size = UDim2.new(0, Section.Title.TextBounds.X + 20, 0, 20)

			Section.Container.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Section.Container.Size = UDim2.new(0, 220, 0, Section.Container.ListLayout.AbsoluteContentSize.Y + 5)
				Section.Border.Size = UDim2.new(0, 240, 0, Section.Container.ListLayout.AbsoluteContentSize.Y + 30)
				Section.Size = UDim2.new(0, 220, 0, Section.Border.Size.Y.Offset + 11)
			end)

			local function trim(str, len)
				local split = str:split("")
				local trim = ""
				if #split < len then
					for i,v in pairs(split) do
						trim = trim..v
						if i == #split then
							break
						end
					end
				elseif #split >= len then
					for i,v in pairs(split) do
						trim = trim..v
						if i == len then
							break
						end
					end
				end
				return trim
			end

			addSection.addLabel = function(labelText, labelAlignment)
				local addLabel = {}
				local Label = generate.label()

				Label.Name = labelText
				Label.Parent = Section.Container
				Label.Text = labelText
				Label.TextXAlignment = labelAlignment or Enum.TextXAlignment.Left

				Label:GetPropertyChangedSignal("TextBounds"):Connect(function()
					if Label.TextBounds.Y > 14 then
						Label.Size = UDim2.new(0, 220, 0, Label.TextBounds.Y + 9)
					end
				end)

				addLabel.addToolTip = function(tooltipText)
					Label.MouseEnter:Connect(function()
						showToolTip(tooltipText)
					end)
					Label.MouseLeave:Connect(function()
						hideToolTip()
					end)
				end

				addLabel.set = function(prop, value)
					assert(typeof(prop) == "string", "Steak UI: Invalid property type, expected string")
					if prop == nil then
						Label.Text = value
					elseif prop == "alignment" then
						Label.TextXAlignment = value
					end
				end

				addLabel.get = function()
					return Label.Text
				end

				addLabel.delete = function()
					Label:Destroy()
				end

				return addLabel
			end

			addSection.addButton = function(buttonText, callback)
				local addButton = {}
				local Button = generate.button()

				Button.Name = buttonText
				Button.Parent = Section.Container
				Button.Title.Text = buttonText

				Library.Colorable[Button] = 3
				Library.Colorable[Button.Title] = 2

				Button.MouseButton1Down:Connect(function()
					CircleClick(Button, mouse().X + 10, mouse().Y - 30)
				end)

				Button.MouseButton1Click:Connect(function()
					callback()
				end)

				addButton.addToolTip = function(tooltipText)
					Button.MouseEnter:Connect(function()
						showToolTip(tooltipText)
					end)
					Button.MouseLeave:Connect(function()
						hideToolTip()
					end)
				end

				addButton.set = function(prop, val)
					Button.Title.Text = val
				end

				addButton.get = function()
					return Button.Title.Text
				end

				addButton.delete = function()
					Library.Colorable[Button] = nil
					Library.Colorable[Button.Title] = nil
					Button:Destroy()
				end

				return addButton
			end


			addSection.addField = function(fieldName, fieldCallback, fieldPlaceholder, fieldInitText)
				local addField = {}
				local Field = generate.field()

				Field.Name = fieldName
				Field.Title.Text = fieldName
				Field.Input.PlaceholderText = fieldPlaceholder or ""
				Field.Input.Text = fieldInitText or ""

				Field.Input.Focused:Connect(function()
					Field.Line.BackgroundColor3 = Library.Color
					Library.Colorable[Field.Line] = 1
					Field.Title.TextColor3 = Library.Color
					Library.Colorable[Field.Title] = 2
				end)

				Field.Input.FocusLost:Connect(function(enter)
					if not config.Settings.DontEnterTextFields and enter then
						fieldCallback(Field.Input.Text)
					elseif config.Settings.DontEnterTextFields then
						fieldCallback(Field.Input.Text)
					end
					Field.Line.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
					Library.Colorable[Field.Line] = nil
					Field.Title.TextColor3 = Color3.fromRGB(200, 200, 200)
					Library.Colorable[Field.Title] = nil
				end)

				addField.addToolTip = function(tooltipText)
					Field.Title.MouseEnter:Connect(function()
						showToolTip(tooltipText)
					end)
					Field.Title.MouseLeave:Connect(function()
						hideToolTip()
					end)
				end

				addField.change = function(prop, val)
					if prop == "name" then
						Field.Title.Text = val
					elseif prop == "placeholder" then
						Field.Input.PlaceholderText = val
					elseif prop == nil then
						Field.Input.Text = val
						fieldCallback(Field.Input.Text)
					end
				end

				addField.get = function(prop)
					if prop == "name" then
						return Field.Title.Text
					elseif prop == "placeholder" then
						return Field.Input.PlaceholderText
					elseif prop == nil then
						return Field.Input.Text
					end
				end

				addField.delete = function()
					Library.Colorable[Field.Line] = nil
					Library.Colorable[Field.Title] = nil
					Field:Destroy()
				end

				return addField
			end

			addSection.addToggle = function(toggleName, callback, initVal)
				local addToggle = {}
				local ToggleBool = initVal or false
				local Toggle = generate.toggle()

				Toggle.Name = toggleName
				Toggle.Parent = Section.Container
				Toggle.Title.Text = toggleName
				if ToggleBool then
					Toggle.CheckBox.Mark.ImageTransparency = 0
				end

				Library.Colorable[Toggle.CheckBox.Mark] = 3

				local function setValue(boolvalue)
					if boolvalue == nil then
						ToggleBool = not ToggleBool
					else
						ToggleBool = boolvalue
					end
					if not ToggleBool then
						if ttable[Toggle.CheckBox.Mark] ~= nil then ttable[Toggle.CheckBox.Mark]:Pause() end
						local tinfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
						local t = ts:Create(Toggle.CheckBox.Mark, tinfo, {ImageTransparency = 1})
						t:Play()
						ttable[Toggle.CheckBox.Mark] = t
					else
						if ttable[Toggle.CheckBox.Mark] ~= nil then ttable[Toggle.CheckBox.Mark]:Pause() end
						local tinfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
						local t = ts:Create(Toggle.CheckBox.Mark, tinfo, {ImageTransparency = 0})
						t:Play()
						ttable[Toggle.CheckBox.Mark] = t
					end
					callback(ToggleBool)
				end

				Toggle.CheckBox.MouseButton1Down:Connect(function()
					CircleClick(Toggle.CheckBox, mouse().X + 10, mouse().Y - 30, nil, 2)
				end)

				Toggle.CheckBox.MouseButton1Click:Connect(function()
					setValue(nil)
				end)

				addToggle.addToolTip = function(tooltipText)
					Toggle.Title.MouseEnter:Connect(function()
						showToolTip(tooltipText)
					end)
					Toggle.Title.MouseLeave:Connect(function()
						hideToolTip()
					end)
				end

				addToggle.change = function(prop, value)
					if prop == "name" then
						Toggle.Title.Text = value
					elseif prop == nil then
						setValue(value)
					end
				end

				addToggle.get = function(prop)
					if prop == "name" then
						return Toggle.Title.Text
					elseif prop == nil then
						return ToggleBool
					end
				end

				addToggle.delete = function()
					Library.Colorable[Toggle.CheckBox.Mark] = nil
					Toggle:Destroy()
				end

				return addToggle
			end

			addSection.addSlider = function(sliderName, callback, min, max, initial, decimals, decimalsCount)
				local addSlider = {}
				local SliderMain = generate.slider()
				local Slider = SliderMain.Slider
				local SliderBar = Slider.Bar
				local GSliderValue = initial and math.clamp(initial, min, max) or (min + max) / 2

				SliderMain.Name = sliderName
				SliderMain.Parent = Section.Container
				SliderMain.Title.Text = sliderName

				insertColorable({
					[Slider] = 3,
					[SliderBar] = 3,
					[SliderMain.Stick] = 3
				})

				local Sliding = false

				local function round(num, numDecimalPlaces)
					local mult = 10^(numDecimalPlaces or 0)
					return math.floor(num * mult + 0.5) / mult
				end

				SliderMain.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						Sliding = true
						local Position = UDim2.new(math.clamp((i.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1), 0, 0, 3)
						if ttable[SliderBar] ~= nil then ttable[SliderBar]:Pause() end
						if ttable[SliderMain.Stick] ~= nil then ttable[SliderMain.Stick]:Pause() end
						local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
						local t = ts:Create(SliderBar, tinfo, {Size = Position})
						local t2 = ts:Create(SliderMain.Stick, tinfo, {Position = UDim2.new(Position.X.Scale, 0, 0, 24)})
						t:Play()
						t2:Play()
						local Percentage = Position.X.Scale
						local SliderValue = decimals and round(Percentage * (max - min) + min, decimalsCount) or math.floor(Percentage * (max - min) + min)
						GSliderValue = SliderValue
						callback(GSliderValue)
						SliderMain.Value.Text = tostring(SliderValue)
					end
				end)

				SliderMain.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						Sliding = false
					end
				end)

				uis.InputChanged:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseMovement then
						if Sliding then
							local Position = UDim2.new(math.clamp((i.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1), 0, 0, 3)
							if ttable[SliderBar] ~= nil then ttable[SliderBar]:Pause() end
							if ttable[SliderMain.Stick] ~= nil then ttable[SliderMain.Stick]:Pause() end
							local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
							local t = ts:Create(SliderBar, tinfo, {Size = Position})
							local t2 = ts:Create(SliderMain.Stick, tinfo, {Position = UDim2.new(Position.X.Scale, 0, 0, 24)})
							t:Play()
							t2:Play()
							local Percentage = Position.X.Scale
							local SliderValue = decimals and round(Percentage * (max - min) + min, decimalsCount) or math.floor(Percentage * (max - min) + min)
							GSliderValue = SliderValue
							callback(GSliderValue)
							SliderMain.Value.Text = tostring(SliderValue)
						end
					end
				end)

				local function SetValue(Value)
					Value = math.clamp(Value, min, max)
					local percent = 1 - ((max - Value) / (max - min))
					GSliderValue = Value
					SliderBar.Size = UDim2.new(math.clamp(percent, 0, 1), 0, 0, 3)
					SliderMain.Stick.Position = UDim2.new(math.clamp(percent, 0, 1), 0, 0, 24)
					SliderMain.Value.Text = decimals and round(Value, decimalsCount) or math.floor(Value)
					callback(Value)
				end

				SetValue(GSliderValue)

				addSlider.addToolTip = function(tooltipText)
					SliderMain.Title.MouseEnter:Connect(function()
						showToolTip(tooltipText)
					end)
					SliderMain.Title.MouseLeave:Connect(function()
						hideToolTip()
					end)
				end

				addSlider.change = function(prop, value)
					if prop == "name" then
						SliderMain.Title.Text = value
					elseif prop == nil then
						SetValue(value)
					end
				end
				
				addSlider.get = function()
					return GSliderValue
				end

				addSlider.delete = function()
					Library.Colorable[Slider] = nil
					Library.Colorable[SliderBar] = nil
					Library.Colorable[SliderMain.Stick] = nil
					SliderMain:Destroy()
				end

				return addSlider
			end

			addSection.addDropdown = function(dropName, callback, optionsTable, initial, multiSelect)
				local addDropdown = {}
				local Drop = generate.dropdown()
				local SearchBox = Drop.Container.SearchBox
				local CurrentValue = initial or multiSelect and {} or ""
				local ContainerStatus = false

				Drop.Name = dropName
				Drop.Parent = Section.Container
				Drop.Title.Text = dropName

				if initial ~= nil then
					if multiSelect then
						Drop.Value.Value.Text = "Multi-Selected ("..tostring(#CurrentValue)..")"
					else
						Drop.Value.Value.Text = CurrentValue
					end
				end

				Drop.Container.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					Drop.Container.CanvasSize = UDim2.new(0, 0, 0, Drop.Container.ListLayout.AbsoluteContentSize.Y)
					Drop.Container.Size = UDim2.new(0, 220, 0, math.clamp(Drop.Container.ListLayout.AbsoluteContentSize.Y, 0, 95))
					if ContainerStatus then
						Drop.Size = UDim2.new(0, 224, 0, 50 + Drop.Container.Size.Y.Offset + 1)
					end
				end)

				SearchBox.Changed:Connect(function(prop)
					if prop == "Text" and #SearchBox.Text > 0 then
						for i,v in pairs(Drop.Container:GetChildren()) do
							if v.Name ~= "SearchBox" and v.Name ~= "ListLayout" then
								if v.Text:find(SearchBox.Text) then
									v.Visible = true
								else
									v.Visible = false
								end
							end
						end
					elseif prop == "Text" and #SearchBox.Text <= 0 then
						for i,v in pairs(Drop.Container:GetChildren()) do
							if v.Name ~= "SearchBox" and v.Name ~= "ListLayout" then
								v.Visible = true
							end
						end
					end
				end)

				local function showContainer()
					if ttable[Drop] ~= nil then ttable[Drop]:Pause() end
					if ttable[Drop.Toggle] ~= nil then ttable[Drop.Toggle]:Pause() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
					local t = ts:Create(Drop, tinfo, {Size = UDim2.new(0, 224, 0, 50 + Drop.Container.Size.Y.Offset + 1)})
					local t2 = ts:Create(Drop.Toggle, tinfo, {Rotation = -180})
					t:Play()
					t2:Play()
					ContainerStatus = true
					ttable[Drop] = t
					ttable[Drop.Toggle] = t2
				end

				local function hideContainer()
					if ttable[Drop] ~= nil then ttable[Drop]:Pause() end
					if ttable[Drop.Toggle] ~= nil then ttable[Drop.Toggle]:Pause() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
					local t = ts:Create(Drop, tinfo, {Size = UDim2.new(0, 224, 0, 44)})
					local t2 = ts:Create(Drop.Toggle, tinfo, {Rotation = 0})
					t:Play()
					t2:Play()
					ContainerStatus = false
					ttable[Drop] = t
					ttable[Drop.Toggle] = t2
				end

				Drop.Toggle.MouseButton1Click:Connect(function()
					if ContainerStatus then
						hideContainer()
					else
						showContainer()
					end
				end)

				for i,v in pairs(optionsTable) do
					local Option = generate.option()

					Option.Name = v
					Option.Parent = Drop.Container
					Option.Text = v

					if multiSelect then
						Option.MouseButton1Click:Connect(function()
							if not Option.Select.Value then
								table.insert(CurrentValue, v)
								Option.TextColor3 = Library.Color
								Library.Colorable[Option] = 2
								Drop.Value.Value.Text = "Multi-Selected ("..tostring(#CurrentValue)..")"
								Option.Select.Value = true
							else
								table.remove(CurrentValue, table.find(CurrentValue, v))
								Option.TextColor3 = Color3.fromRGB(200, 200, 200)
								Library.Colorable[Option] = nil
								Drop.Value.Value.Text = "Multi-Selected ("..tostring(#CurrentValue)..")"
								Option.Select.Value = false
							end
							callback(CurrentValue)
						end)
					else
						Option.MouseButton1Click:Connect(function()
							CurrentValue = v
							Drop.Value.Value.Text = CurrentValue
							hideContainer()
							callback(CurrentValue)
						end)
					end
				end
				
				addDropdown.change = function(prop, value, init)
					if prop == "name" then
						Drop.Title.Text = value
					elseif prop == "options" then
						CurrentValue = init or multiSelect and {} or ""
						for i,v in pairs(Drop.Container:GetChildren()) do
							if v.Name ~= "SearchBox" and v.Name ~= "ListLayout" then
								v:Destroy()
							end
						end
						for i,v in pairs(value) do
							local Option = generate.option()

							Option.Name = v
							Option.Parent = Drop.Container
							Option.Text = v

							if multiSelect then
								Option.MouseButton1Click:Connect(function()
									if not Option.Select.Value then
										table.insert(CurrentValue, v)
										Option.TextColor3 = Library.Color
										Library.Colorable[Option] = 2
										Drop.Value.Value.Text = "Multi-Selected ("..tostring(#CurrentValue)..")"
										Option.Select.Value = true
									else
										table.remove(CurrentValue, table.find(CurrentValue, v))
										Option.TextColor3 = Color3.fromRGB(200, 200, 200)
										Library.Colorable[Option] = nil
										Drop.Value.Value.Text = "Multi-Selected ("..tostring(#CurrentValue)..")"
										Option.Select.Value = false
									end
								end)
							else
								Option.MouseButton1Click:Connect(function()
									CurrentValue = v
									Drop.Value.Value.Text = CurrentValue
									hideContainer()
								end)
							end
						end
					elseif prop == nil then
						CurrentValue = value
						if multiSelect then
							Drop.Value.Value.Text = "Multi-Selected ("..tostring(#CurrentValue)..")"
						else
							Drop.Value.Value.Text = CurrentValue
						end
					end
				end
				
				addDropdown.get = function()
					return CurrentValue
				end
				
				addDropdown.delete = function()
					Drop:Destroy()
					if multiSelect then
						for i,v in pairs(Drop.Container:GetChildren()) do
							if v.Name ~= "SearchBox" and v.Name ~= "ListLayout" then
								Library.Colorable[v] = nil
							end
						end
					end
				end

				return addDropdown
			end
			
			addSection.addColorpicker = function(colorpickerName, callback, defaultHSV)
				local addColorpicker = {}
				local Colorpicker = generate.colorpicker()
				local Palette = generate.palette()
				local ValImg = Palette.ValImg
				local HSImg = Palette.HueSatImg
				local HSV = {
					Hue = defaultHSV and defaultHSV.Hue and (defaultHSV.Hue / 360) or 0,
					Sat = defaultHSV and defaultHSV.Sat and (defaultHSV.Sat / 255) or 0,
					Val = defaultHSV and defaultHSV.Val and (defaultHSV.Val / 255) or 1
				}
				
				local function updateColor()
					ValImg.BackgroundColor3 = Color3.fromHSV(HSV.Hue, HSV.Sat, 1)
					Colorpicker.ImageColor3 = Color3.fromHSV(HSV.Hue, HSV.Sat, HSV.Val)
					callback(Color3.fromHSV(HSV.Hue, HSV.Sat, HSV.Val))
				end
				
				Colorpicker.Name = colorpickerName
				Colorpicker.Parent = Section.Container
				Colorpicker.Title.Text = colorpickerName
				
				Palette.Name = colorpickerName
				Palette.Parent = Screen
				
				local HSRender;
				local ValRender;
				
				HSImg.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HSRender ~= nil then if HSRender.Connected then HSRender:Disconnect() end end
						HSRender = rs.RenderStepped:Connect(function()
							local Mouse = uis:GetMouseLocation()
							local PosX = math.clamp((Mouse.X - 5 + (HSImg.Dot.AnchorPoint.X * HSImg.Dot.AbsoluteSize.X) - HSImg.AbsolutePosition.X) / HSImg.AbsoluteSize.X, 0, 1)
							local PosY = math.clamp((Mouse.Y - 40 + (HSImg.Dot.AnchorPoint.Y * HSImg.Dot.AbsoluteSize.Y) - HSImg.AbsolutePosition.Y) / HSImg.AbsoluteSize.Y, 0, 1)
							HSImg.Dot.Position = UDim2.fromScale(PosX, PosY)
							HSImg.Dot.AnchorPoint = Vector2.new(PosX, PosY)
							HSV.Hue = 1 - PosX
							HSV.Sat = 1 - PosY
							updateColor()
						end)
					end
				end)
				
				HSImg.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						HSRender:Disconnect()
					end
				end)
				
				local function valrenderbegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ValRender ~= nil then if ValRender.Connected then ValRender:Disconnect() end end
						ValRender = rs.RenderStepped:Connect(function()
							local Mouse = uis:GetMouseLocation()
							local PosY = math.clamp((Mouse.Y - 40 - HSImg.AbsolutePosition.Y) / HSImg.AbsoluteSize.Y, 0, 1)
							ValImg.Arrow.Position = UDim2.fromScale(1, PosY)
							HSV.Val = 1 - PosY
							updateColor(1)
						end)
					end
				end

				local function valrenderended(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						ValRender:Disconnect()
					end
				end

				ValImg.Arrow.InputBegan:Connect(valrenderbegan)
				ValImg.Arrow.InputEnded:Connect(valrenderended)
				ValImg.InputBegan:Connect(valrenderbegan)
				ValImg.InputEnded:Connect(valrenderended)
				
				local function setColor(hsvcolor)
					for i,v in pairs(hsvcolor) do
						hsvcolor[i] = math.clamp(v,0,1)
					end
					HSV.Hue = hsvcolor[1]
					HSV.Sat = hsvcolor[2]
					HSV.Val = hsvcolor[3]
					updateColor()
					HSImg.Dot.AnchorPoint = Vector2.new(1 - HSV.Hue, 1 - HSV.Sat)
					HSImg.Dot.Position = UDim2.fromScale(1 - HSV.Hue, 1 - HSV.Sat)
					ValImg.Arrow.Position = UDim2.fromScale(1, 1 - HSV.Val)
				end
				
				local paletteclose = false

				local function openPalette(obj)
					Palette.Position = UDim2.fromOffset(obj.AbsolutePosition.X - Palette.AbsoluteSize.X + obj.AbsoluteSize.X, obj.AbsolutePosition.Y)
					local h,s,v = Color3.toHSV(obj.ImageColor3)
					setColor({h,s,v})
					Palette.Visible = true
				end

				uis.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and paletteclose and not isOnObject(Palette) then
						local check = false
						if isOnObject(Colorpicker) then
							check = true
						end
						if not check then
							Palette.Position = UDim2.new(0,0,0,0)
							Palette.Visible = false
							paletteclose = false
						end
					end
				end)

				Colorpicker.Toggle.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						CircleClick(Colorpicker.Toggle, mouse().X + 10, mouse().Y - 30, nil, 2)
					end
				end)
				
				Colorpicker.Toggle.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if not paletteclose then
							openPalette(Colorpicker.Toggle)
							paletteclose = true
						else
							Palette.Position = UDim2.new(0,0,0,0)
							Palette.Visible = false
							paletteclose = false
						end
					end
				end)
				
				addColorpicker.change = function(prop, value)
					if prop == "name" then
						Colorpicker.Title.Text = value
					elseif prop == nil then
						setColor(value)
					end
				end
				
				addColorpicker.get = function()
					return Colorpicker.Toggle.ImageColor3
				end
				
				addColorpicker.delete = function()
					Colorpicker:Destroy()
					Palette:Destroy()
				end
				
				return addColorpicker
			end

			return addSection
		end

		return addTab
	end

	libraryNew.changeName = function(newName)
		assert(typeof(newName) == "string", ("Steak UI: Invalid name format, expected %s got %s"):format("string", typeof(newName)))
		Top.Label.Text = newName
	end

	libraryNew.Show = function()
		Screen.Enabled = true
	end

	libraryNew.Hide = function()
		Screen.Enabled = false
	end

	libraryNew.Destroy = function()
		Screen:Destroy()
	end

	libraryNew.ChangeColor = function(newColor)
		for i,v in pairs(Library.Colorable) do
			if v == 1 then
				i.BackgroundColor3 = newColor
			elseif v == 2 then
				i.TextColor3 = newColor
			elseif v == 3 then
				i.ImageColor3 = newColor
			elseif v == 4 then
				i.BackgroundColor3 = newColor
				i.TextColor3 = newColor
			elseif v == 5 then
				i.BackgroundColor3 = newColor
				i.ImageColor3 = newColor
			end
		end
		Library.Color = newColor
	end

	return libraryNew
end

return Library
