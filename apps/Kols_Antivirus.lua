-- startmenu = true
local app = _G.makeapp("Antivirs", "com.idk.Antivirus")

local active = Instance.new("BoolValue", app).Value
active = true
local old_active = true

local blocked_list = {
    "virus", "destroy", "inject", "youareanidiot", "exploit", "secretwebsite",
    "error", "crash", "destory", "enocrypt"
}

local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild(
                        "HttpRequest")
remoteEvent:FireAllClients(
    [[local app = uisfolder().Apps["com.idk.Antivirus"].MainFrame; local toggle = new("TextButton", app); toggle.Size = UDim2.fromScale(1,0.5); toggle.Position = UDim2.fromScale(0,0.5); toggle.Text = "Turn off!"; toggle.MouseButton1Click:Connect(function() if app.BoolValue.Value == false then toggle.Text = "Turn off!"; app.BoolValue.Value = true; else toggle.Text = "Turn on!"; app.BoolValue.Value = false; end end)]],
    true, false)

loadlib("LimeExplorer").StartApp(uisfolder().Apps.UserAppStore, "User Appstore")
loadlib("LimeExplorer").StartApp(uisfolder().Apps.LimeWeb, "LimeWeb")
uisfolder().Apps.LimeWeb.MainFrame.WebSites:WaitForChild(
    "first-limeos-website.lime")
local backup = uisfolder().Apps.LimeWeb.MainFrame.WebSites:Clone()
backup.Parent = app.Parent
loadlib("LimeExplorer").CloseApp("LimeWeb")
uisfolder().Apps.UserAppStore.MainFrame:WaitForChild("Template")
local backup = uisfolder().Apps.UserAppStore.MainFrame:Clone()
backup.Parent = app.Parent
loadlib("LimeExplorer").CloseApp("User Appstore")

function disable()
    active = false
    local backup = app.Parent.WebSites:Clone()
    backup.Parent = uisfolder().Apps.LimeWeb.MainFrame
    local backup = app.Parent.MainFrame:Clone()
    backup.Parent = uisfolder().Apps.UserAppStore.MainFrame
end

function enable()
    active = true
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
while wait() do
    if active == true and old_active == false then
        enable()
        old_active = true
    elseif active == false and old_active == true then
        disable()
        old_active = false;
    end
end
