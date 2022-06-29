local DataStoreService = game:GetService("DataStoreService")
local bydia_datastore = DataStoreService:GetDataStore("bydia_datastore")
local dataStoreKey = game.Players:FindFirstChildWhichIsA("Player").Name
local apps_folder = game.Players:FindFirstChildWhichIsA("Player").PlayerGui
                        .LimeOS.UIs.Apps
local bydia = apps_folder.Template.Template:Clone()
bydia.AppCode:Destroy()
bydia.Parent = apps_folder
bydia.Name = "com.XG009.Bydia-Release"
bydia.TextLabel.Text = "🅱️ydia"
bydia.TextLabel.ZIndex = 2
bydia.SysAppName.Value = "🅱️ydia"
local installed_apps
local function saveData()
    local setSuccess, errorMessage = pcall(function()
        bydia_datastore:SetAsync(dataStoreKey, installed_apps)
    end)
    if not setSuccess then warn(errorMessage) end
end
local success, output = pcall(function()
    return bydia_datastore:GetAsync(dataStoreKey)
end)
if success then
    installed_apps = output or {"com.XG009.Bydia-Release"}
    print(installed_apps)
end
local start_folder = apps_folder.Parent.HomeScreen.MainFrame.StartMenu.AppLists
                         .Games
local start_icon = start_folder.AppStore:Clone()
start_icon.Parent = start_folder
start_icon.Name = "com.XG009.Bydia-Release"
start_icon.AppTextLabel.Text = "🅱️ydia"
start_icon.AppName.Value = "com.XG009.Bydia-Release"
start_icon.AppImage.Image = "http://www.roblox.com/asset/?id=954619039"
require(apps_folder.Parent.Parent.SystemFiles.DLLs.LimeExplorer).StartExplorer()
local banner = Instance.new("TextLabel", bydia.MainFrame)
banner.Size = UDim2.fromScale(1, 0.2)
banner.Position = UDim2.fromScale(0, 0)
banner.TextScaled = true
banner.Text = "🅱️ydia"
local apps = Instance.new("TextLabel", bydia.MainFrame)
apps.Size = UDim2.fromScale(1, 0.2)
apps.Position = UDim2.fromScale(0, 0.2)
apps.TextScaled = true
apps.Text = "Apps:"
local list_frame = Instance.new("Frame", bydia.MainFrame)
list_frame.Size = UDim2.fromScale(1, 0.6)
list_frame.Position = UDim2.fromScale(0, 0.4)
local list = Instance.new("UIListLayout", list_frame)
list.FillDirection = "Horizontal"
local HttpService = game:GetService("HttpService")
local URL = "https://github.com/XG213/-ydia/raw/main/apps.json"
local response = HttpService:GetAsync(URL)
local data = HttpService:JSONDecode(response)
print(#data.apps)
for i, v in ipairs(data.apps) do
    for i2, app in ipairs(installed_apps) do
        if v.bundleIdentifier == app then
            local new_button = Instance.new("TextLabel", list_frame)
            new_button.Text = v.name .. " (Installed)"
            new_button.Size = UDim2.fromScale(0.25, 0.3)
            new_button.TextScaled = true
            if v.bundleIdentifier ~= "com.XG009.Bydia-Release" then
                local response = HttpService:GetAsync(v.downloadURL)
                if string.find(response, "--startmenu = true") then
                    local start_folder =
                        apps_folder.Parent.HomeScreen.MainFrame.StartMenu
                            .AppLists.Games
                    local start_icon = start_folder.AppStore:Clone()
                    start_icon.Parent = start_folder
                    start_icon.Name = v.bundleIdentifier
                    start_icon.AppTextLabel.Text = v.name
                    start_icon.AppName.Value = v.bundleIdentifier
                    start_icon.AppImage.Image = "http://www.roblox.com/asset/?id=" .. v.iconID
                    require(apps_folder.Parent.Parent.SystemFiles.DLLs
                                .LimeExplorer).StartExplorer()
                end
                loadstring(response)()
            end
        end
    end
end
for i, v in ipairs(installed_apps) do
    for i2, app in ipairs(data.apps) do
        if v == app.bundleIdentifier then table.remove(data.apps, i2) end
    end
end
for i, app in ipairs(data.apps) do
    local button = Instance.new("TextButton", list_frame)
    button.Text = app.name
    button.Size = UDim2.fromScale(0.25, 0.3)
    button.TextScaled = true
    button.MouseButton1Click:Connect(function()
        local response = HttpService:GetAsync(app.downloadURL)
        if string.find(response, "--startmenu = true") then
            local start_folder = apps_folder.Parent.HomeScreen.MainFrame
                                     .StartMenu.AppLists.Games
            local start_icon = start_folder.AppStore:Clone()
            start_icon.Parent = start_folder
            start_icon.Name = app.bundleIdentifier
            start_icon.AppTextLabel.Text = app.name
            start_icon.AppName.Value = app.bundleIdentifier
            start_icon.AppImage.Image = "http://www.roblox.com/asset/?id=" .. v.iconID
            require(apps_folder.Parent.Parent.SystemFiles.DLLs.LimeExplorer).StartExplorer()
        end
        table.insert(installed_apps, app.bundleIdentifier)
        loadstring(response)()
        saveData()
        local text = button.Text .. " (Installed)"
        button:Destroy()
        local new_button = Instance.new("TextLabel", list_frame)
        new_button.Text = text
        new_button.Size = UDim2.fromScale(0.25, 0.3)
        new_button.TextScaled = true
    end)
end
