--startmenu = true
local apps_folder = game.Players:FindFirstChildWhichIsA("Player").PlayerGui.LimeOS.UIs.Apps
local app = apps_folder.Template.Template:Clone()
app.AppCode:Destroy()
app.Parent = apps_folder
app.Name = "com.XG009.SS_Terminal"
app.TextLabel.Text = "SS Terminal"
app.TextLabel.ZIndex = 2
app.SysAppName.Value = "SS Terminal"
local input = Instance.new("TextBox", app.MainFrame)
input.Size = UDim2.fromScale(1,0.5)
input.Position = UDim2.fromScale(0,0)
input.ClearTextOnFocus = false
input.Text = ""
local execute = Instance.new("TextButton", app.MainFrame)
execute.Size = UDim2.fromScale(1,0.5)
execute.Position = UDim2.fromScale(0,0.5)
execute.Text = "Execute!"

loadstring(input.Text)()