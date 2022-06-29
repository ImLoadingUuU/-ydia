local apps_folder = game.Players:FindFirstChildWhichIsA("Player").PlayerGui.LimeOS.UIs.Apps
local bydia = apps_folder.Template.Template:Clone()
bydia.AppCode:Destroy(); bydia.Parent = apps_folder
bydia.Name = "Bydia"; bydia.TextLabel.Text = "Bydia"
bydia.TextLabel.ZIndex = 2
bydia.SysAppName.Value = "Bydia"
local start_folder = apps_folder.Parent.HomeScreen.MainFrame.StartMenu.AppLists.Games
local start_icon = start_folder.AppStore:Clone()
start_icon.Parent = start_folder
start_icon.Name = "Bydia"
start_icon.AppTextLabel.Text = "🅱️ydia"
start_icon.AppName.Value = "Bydia"
start_icon.AppImage.Image = "http://www.roblox.com/asset/?id=954619039"
require(apps_folder.Parent.Parent.SystemFiles.DLLs.LimeExplorer).StartExplorer()
local banner = Instance.new("TextLabel", bydia.MainFrame)
banner.Size = UDim2.fromScale(1,0.2)
banner.Position = UDim2.fromScale(0,0)
banner.TextScaled = true
banner.Text = "🅱️ydia"
local apps = Instance.new("TextLabel", bydia.MainFrame)
apps.Size = UDim2.fromScale(1,0.2)
apps.Position = UDim2.fromScale(0,0.2)
apps.TextScaled = true
apps.Text = "Apps:"
local HttpService = game:GetService("HttpService")
local URL = "https://github.com/XG213/-ydia/raw/main/apps.json"
local response = HttpService:GetAsync(URL)
local data = HttpService:JSONDecode(response)
print(#data.apps)
local list_frame = Instance.new("Frame", bydia.MainFrame)
list_frame.Size = UDim2.fromScale(1,0.6)
list_frame.Position = UDim2.fromScale(0,0.4)
local list = Instance.new("UIListLayout", list_frame)
for i, app in ipairs(data.apps) do
  local button = Instance.new("TextButton", list_frame)
  button.Text = app.name
  button.Size = UDim2.fromScale(0.25,0.3)
  button.MouseButton1Click:Connect(function()
      local response = HttpService:GetAsync(app.downloadURL)
      if string.find(response, "--startmenu = true") then
        local start_folder = apps_folder.Parent.HomeScreen.MainFrame.StartMenu.AppLists.Games
        local start_icon = start_folder.AppStore:Clone()
        start_icon.Parent = start_folder
        start_icon.Name = app.name
        start_icon.AppTextLabel.Text = app.name
        start_icon.AppName.Value = app.bundleIdentifier
        require(apps_folder.Parent.Parent.SystemFiles.DLLs.LimeExplorer).StartExplorer()
      end
      loadstring(response)()
      local text = button.Text .. " (Installed)"; button:Destroy()
      local new_button = Instance.new("TextLabel", list_frame)
      new_button.Text = text
      new_button.Size = UDim2.fromScale(0.25,0.3)
    end)
end
