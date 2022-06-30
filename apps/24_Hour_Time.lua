spawn(function()
    local thing = game.Players:FindFirstChildWhichIsA("Player").PlayerGui.LimeOS
                      .UIs.HomeScreen.MainFrame.Taskbar.Clock.Time
    thing.TimeScript:Destroy()
    local date
    while wait(1) do
        date = os.date("*t")
        thing.Text = ("%02d:%02d"):format(date.hour, date.min)
    end
end)
