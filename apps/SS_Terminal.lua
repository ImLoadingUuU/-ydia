-- startmenu = true
local apps_folder = game.Players:FindFirstChildWhichIsA("Player").PlayerGui
                        .LimeOS.UIs.Apps
local app = apps_folder.Template.Template:Clone()
app.AppCode:Destroy()
app.Parent = apps_folder
app.Name = "com.XG009.SS_Terminal"
app.TextLabel.Text = "SS Terminal"
app.TextLabel.ZIndex = 2
app.SysAppName.Value = "SS Terminal"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = ReplicatedStorage:WaitForChild("HttpRequest")
remoteEvent:FireAllClients(
    [[local app = uisfolder().Apps["com.XG009.SS_Terminal"].MainFrame; local frame = new("Frame", app); local input = new("TextBox", app); input.Size = UDim2.fromScale(1,0.5); input.Position = UDim2.fromScale(0,0); input.ClearTextOnFocus = false; input.Text = ""; local execute = new("TextButton", app); execute.Size = UDim2.fromScale(1,0.5); execute.Position = UDim2.fromScale(0,0.5); execute.Text = "Execute!"; local remote_event = uisfolder().Parent.Parent.Parent.Parent.Parent.ReplicatedStorage.HttpRequest; remote_event:FireServer(true, '"); warn("Hello from the <insert name here> PoC","', false); execute.MouseButton1Click:Connect(function() remote_event:FireServer(true, '"); ' .. input.Text .. '; print("', false); end)]],
    true, false)
