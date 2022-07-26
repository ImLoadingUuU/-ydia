-- startmenu = true
local app = _G.makeapp("Antivirus", "com.idk.Antivirus")
local exectureclient = game:GetService("ReplicatedStorage"):WaitForChild(
                           "HttpRequest")
exectureclient:FireAllClients(
    [[
local blocked_list = {
    "virus", "destroy", "inject", "youareanidiot", "exploit", "secretwebsite",
    "error", "crash", "destory", "enocrypt"
}

local active = true

loadlib("LimeExplorer").StartApp(uisfolder().Apps.UserAppStore, "User Appstore")
loadlib("LimeExplorer").StartApp(uisfolder().Apps.LimeWeb, "LimeWeb")
uisfolder().Apps.LimeWeb.MainFrame.WebSites:WaitForChild(
    "first-limeos-website.lime")
local app = uisfolder().Apps["com.idk.Antivirus"].MainFrame
local backup = uisfolder().Apps.LimeWeb.MainFrame.WebSites:Clone()
backup.Parent = app.Parent
loadlib("LimeExplorer").CloseApp("LimeWeb")
uisfolder().Apps.UserAppStore.MainFrame:WaitForChild("Template")
loadlib("LimeExplorer").CloseApp("User Appstore")

function disable()
    uisfolder().Apps.LimeWeb.MainFrame.WebSites:Destroy()
    local backup_clone = app.Parent.WebSites:Clone()
    backup_clone.Parent = uisfolder().Apps.LimeWeb.MainFrame
    local clone_thingie = uisfolder().Apps.UserAppStore.MainFrame.UIGridLayout:Clone()
    uisfolder().Apps.UserAppStore.MainFrame:ClearAllChildren()
    clone_thingie.Parent = uisfolder().Apps.UserAppStore.MainFrame
    local remoteEvent = uisfolder().Parent.Parent.Parent.Parent.Parent
                         .ReplicatedStorage.HttpRequest
    remoteEvent:FireServer(false, nil, false, false)
end

local loop = coroutine.create(function()
    while wait() do
        for i, site in ipairs(blocked_list) do
            if string.lower(uisfolder().Apps.LimeWeb.WebBar.TextBox.Text):match(
                site) then
                uisfolder().Apps.LimeWeb.WebBar.TextBox.Text = "BLOCKED SITE"
                local text = new("TextLabel",
                                 uisfolder().Apps.LimeWeb.MainFrame.CurrentSite)
                text.Size = UDim2.fromScale(1, 0.8)
                text.Text = "BLOCKED SITE"
                text.TextScaled = true
                local bottom_text = new("TextLabel", uisfolder().Apps.LimeWeb
                                            .MainFrame.CurrentSite)
                bottom_text.Size = UDim2.fromScale(1, 0.2)
                bottom_text.Position = UDim2.fromScale(0, 0.8)
                bottom_text.Text = "This site has been reported suspicious!"
                bottom_text.TextScaled = true
            end
        end
        if not active then coroutine.yield() end
    end
end)

function enable()
    coroutine.resume(loop)
    for i, blocked in ipairs(blocked_list) do
        for i2, thing in ipairs(
                             uisfolder().Apps.LimeWeb.MainFrame.WebSites:GetChildren()) do
            if string.find(string.lower(thing.Name), blocked) then
                thing:Destroy()
            end
        end
    end
    for i, blocked in ipairs(blocked_list) do
        for i2, thing in ipairs(
                             uisfolder().Apps.UserAppStore.MainFrame:GetChildren()) do
            if thing.Name == "Template" then
                if string.find(string.lower(thing.TextLabel2.Text), blocked) then
                    thing.TextButton:Destroy()
                    thing.TextLabel2.Text = "BLOCKED APP"
                    thing.TextLabel.Text =
                        "This app has been reported suspicious!"
                end
            end
        end
    end
end
enable()

local toggle = new("TextButton", app);
toggle.Size = UDim2.fromScale(1, 0.5);
toggle.Position = UDim2.fromScale(0, 0.5);
toggle.Text = "Turn off!";
toggle.MouseButton1Click:Connect(function()
    if active == false then
        toggle.Text = "Turn off!";
        active = true
        enable()
    else
        toggle.Text = "Turn on!";
        active = false
        disable()
    end
end)
]], true, false) 
