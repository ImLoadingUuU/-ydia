--startmenu = true
local app = _G.makeapp("BootUnlocker Installer", "com.XG009.BootUnlocker_Installer")
local info = Instance.new("TextLabel", app);
info.Size = UDim2.fromScale(0.8, 0.5);
info.Position = UDim2.fromScale(0, 0);
info.Text = "Welcome to installer blah blah blah";
info.TextScaled = true
local install = Instance.new("TextButton", app);
install.Size = UDim2.fromScale(1, 0.5);
install.Position = UDim2.fromScale(0, 0.5);
install.Text = "Install!";
install.TextScaled = true
install.MouseButton1Click:Connect(function()
    install:Destroy()
    local install = Instance.new("TextButton", app);
    install.Size = UDim2.fromScale(1, 0.5);
    install.Position = UDim2.fromScale(0, 0.5);
    install.Text = "Installed!!";
    install.TextScaled = true
    local LimeOS = game.Players:FindFirstChildWhichIsA("Player").PlayerGui
                       .LimeOS
    local HttpService = game:GetService("HttpService")
    local PhysicalDisk0 = Instance.new("Folder", LimeOS)
    PhysicalDisk0.Name = "PhysicalDisk0"
    local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild(
                            "HttpRequest")
    local bootunlocker_frame = Instance.new("Frame", LimeOS)
    bootunlocker_frame.Name = "bootunlocker_frame"
    bootunlocker_frame.Visible = false
    bootunlocker_frame.Size = UDim2.fromScale(1, 1)
    bootunlocker_frame.Position = UDim2.fromScale(0, 0)
    local back = Instance.new("TextButton", bootunlocker_frame)
    back.Size = UDim2.fromScale(0.2, 0.2);
    back.Position = UDim2.fromScale(0, 0.8);
    back.Text = "Back";
    back.TextScaled = true
    local clone = LimeOS.UIs.BIOS.MainFrame.Options.DOS_BOOT:Clone()
    clone.Parent = LimeOS.UIs.BIOS.MainFrame.Options
    clone.Name = "BOOTUNLOCKER_BOOT"
    clone.Text = "Boot to Bootunlocker"

    clone.MouseButton1Click:Connect(function()
        LimeOS.UIs.BIOS.MainFrame.Visible = false
        bootunlocker_frame.Visible = true
        local count = 0
        for i, Partion in ipairs(PhysicalDisk0:GetChildren()) do
            for i2, File in ipairs(Partion:GetChildren()) do
                if string.find(File.Name, ".efi") then
                    print(script)
                    local decoded_json = HttpService:JSONDecode(File.Value)
                    local bootoption = Instance.new("TextButton",
                                                    bootunlocker_frame)
                    bootoption.Text = decoded_json.name .. " " .. File.Name
                    bootoption.Size = UDim2.fromScale(0.8, 0.2)
                    bootoption.Position = UDim2.fromScale(0.1, count)
                    bootoption.MouseButton1Click:Connect(function()
                        loadstring(primary[decoded_json.boot].Value)()
                    end)
                    count = count + 0.2
                end
            end
        end
    end)
end)
