local DataStoreService = game:GetService("DataStoreService")
local bydia_datastore = DataStoreService:GetDataStore("bydia_datastore")
local dataStoreKey = game.Players:FindFirstChildWhichIsA("Player").Name
local apps_folder = game.Players:FindFirstChildWhichIsA("Player").PlayerGui
                        .LimeOS.UIs.Apps
local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild(
                        "HttpRequest")
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
function make_startmenu_icon(name, name2, icon)
    local start_folder = apps_folder.Parent.HomeScreen.MainFrame.StartMenu
                             .AppLists.Games
    local start_icon = start_folder.AppStore:Clone()
    start_icon.Parent = start_folder
    start_icon.Name = name2
    start_icon.AppTextLabel.Text = name
    start_icon.AppName.Value = name2
    start_icon.AppImage.Image = "http://www.roblox.com/asset/?id=" .. icon
end
make_startmenu_icon("🅱️ydia", "com.XG009.Bydia-Release", "954619039")
_G.makeapp = function(name, bundleIdentifier)
    local apps_folder = game.Players:FindFirstChildWhichIsA("Player").PlayerGui
                            .LimeOS.UIs.Apps
    local app = apps_folder.Template.Template:Clone()
    app.AppCode:Destroy()
    app.Parent = apps_folder
    app.Name = bundleIdentifier
    app.TextLabel.Text = name
    app.TextLabel.ZIndex = 2
    app.SysAppName.Value = name
    return app.MainFrame
end
local HttpService = game:GetService("HttpService")
local URL = "https://github.com/XG213/-ydia/raw/main/apps.json"
local response = HttpService:GetAsync(URL)
local data = HttpService:JSONDecode(response)
for i, v in ipairs(data.apps) do
    for i2, app in ipairs(installed_apps) do
        if v.bundleIdentifier == app then
            if v.bundleIdentifier ~= "com.XG009.Bydia-Release" then
                local response = HttpService:GetAsync(v.downloadURL)
                if string.find(response, "--startmenu = true") then
                    make_startmenu_icon(v.name, v.bundleIdentifier, v.iconID)
                end
                loadstring(response)()
            end
        end
    end
end
function install_app(app)
    local response = HttpService:GetAsync(app.downloadURL)
    if string.find(response, "--startmenu = true") then
        make_startmenu_icon(app.name, app.bundleIdentifier, app.iconID)
    end
    table.insert(installed_apps, app.bundleIdentifier)
    loadstring(response)()
    saveData()
end
function list_apps()
    bydia.MainFrame:ClearAllChildren()
    local refresh_apps = Instance.new("TextButton", bydia.MainFrame)
    refresh_apps.Size = UDim2.fromScale(0.5, 0.2)
    refresh_apps.Position = UDim2.fromScale(0, 0)
    refresh_apps.TextScaled = true
    refresh_apps.Text = "Refresh apps"
    refresh_apps.MouseButton1Click:Connect(function()
        local HttpService = game:GetService("HttpService")
        local URL = "https://github.com/XG213/-ydia/raw/main/apps.json"
        local response = HttpService:GetAsync(URL)
        local data = HttpService:JSONDecode(response)
        list_apps()
    end)
    local add_repo = Instance.new("TextButton", bydia.MainFrame)
    add_repo.Size = UDim2.fromScale(0.5, 0.2)
    add_repo.Position = UDim2.fromScale(0.5, 0)
    add_repo.TextScaled = true
    add_repo.Text = "Add a repo"
    local apps = Instance.new("TextLabel", bydia.MainFrame)
    apps.Size = UDim2.fromScale(1, 0.2)
    apps.Position = UDim2.fromScale(0, 0.2)
    apps.TextScaled = true
    apps.Text = "Apps:"
    local list_frame = Instance.new("ScrollingFrame", bydia.MainFrame)
    list_frame.Size = UDim2.fromScale(1, 0.6)
    list_frame.Position = UDim2.fromScale(0, 0.4)
    list_frame.CanvasSize = UDim2.fromScale(0, 0.9)
    local list = Instance.new("UIGridLayout", list_frame)
    list.CellSize = UDim2.fromScale(0.24, 0.25)
    list.CellPadding = UDim2.fromScale(0, 0)
    local current_app = false
    for i, app in ipairs(data.apps) do
        current_app = false
        for i2, installed_app in ipairs(installed_apps) do
            if app.bundleIdentifier == installed_app then
                current_app = true
            end
        end
        if current_app == false then
            local button = Instance.new("TextButton", list_frame)
            button.Text = app.name
            button.TextScaled = true
            button.MouseButton1Click:Connect(function()
                app_info(app, current_app)
            end)
        else
            local button = Instance.new("TextButton", list_frame)
            button.Text = app.name .. " (Installed)"
            button.TextScaled = true
            button.MouseButton1Click:Connect(function()
                app_info(app, current_app)
            end)
        end
    end
end
function app_info(app, installed)
    bydia.MainFrame:ClearAllChildren()
    local app_name = Instance.new("TextLabel", bydia.MainFrame)
    app_name.Size = UDim2.fromScale(0.6, 0.2)
    app_name.Position = UDim2.fromScale(0.4, 0)
    app_name.TextScaled = true
    app_name.Text = app.name
    local app_icon = Instance.new("ImageLabel", bydia.MainFrame)
    app_icon.Size = UDim2.fromScale(0.2, 0.2)
    app_icon.Position = UDim2.fromScale(0.2, 0)
    app_icon.Image = "http://www.roblox.com/asset/?id=" .. app.iconID
    local author = Instance.new("TextLabel", bydia.MainFrame)
    author.Size = UDim2.fromScale(1, 0.1)
    author.Position = UDim2.fromScale(0, 0.2)
    author.TextScaled = true
    author.Text = "By: " .. app.developerName
    local install = Instance.new("TextButton", bydia.MainFrame)
    install.Size = UDim2.fromScale(1, 0.1)
    install.Position = UDim2.fromScale(0, 0.3)
    install.TextScaled = true
    local back = Instance.new("TextButton", bydia.MainFrame)
    back.Size = UDim2.fromScale(0.2, 0.2)
    back.Position = UDim2.fromScale(0, 0)
    back.TextScaled = true
    back.Text = "Back"
    back.MouseButton1Click:Connect(function() list_apps() end)
    local description = Instance.new("TextLabel", bydia.MainFrame)
    description.Size = UDim2.fromScale(1, 0.6)
    description.Position = UDim2.fromScale(0, 0.4)
    description.TextScaled = true
    description.Text = app.description
    local app_installed = false;
    for i, installed_app in ipairs(installed_apps) do
        if app.bundleIdentifier == installed_app then
            app_installed = true
        end
    end
    if app_installed == true then
        install.Text = "Uninstall"
        install.MouseButton1Click:Connect(function()
            for i, installed_app in ipairs(installed_apps) do
                if app.bundleIdentifier == installed_app then
                    if app.bundleIdentifier ~= "com.XG009.Bydia-Release" then
                        await table.remove(installed_apps, i)
                        saveData()
                        app_info(app, installed)
                        if apps_folder.Parent.HomeScreen.MainFrame.StartMenu
                            .AppLists.Games:FindFirstChild(app.bundleIdentifier) ~=
                            nil then
                            apps_folder.Parent.HomeScreen.MainFrame.StartMenu
                                .AppLists.Games[app.bundleIdentifier]:Destroy()
                        end
                    end
                end
            end
        end)
    else
        install.Text = "Install"
        install.MouseButton1Click:Connect(function()
            await install_app(app)
            saveData()
            app_info(app, installed)
        end)
    end
end
list_apps()
remoteEvent:FireAllClients(
    [[uisfolder().Apps.Bydia_Installer.MainFrame.TextButton.Text = "Installed!"]],
    true, false)
