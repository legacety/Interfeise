local fa = require 'fAwesome6_solid'
local imgui = require 'mimgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local renderWindow = imgui.new.bool(false)

local function applyTheme()
    local style = imgui.GetStyle()
    local clr = style.Colors

    style.WindowRounding = 0
    style.ChildRounding = 4
    style.FrameRounding = 4
    style.ScrollbarRounding = 0
    style.ItemSpacing = imgui.ImVec2(10, 12)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ScrollbarSize = 13

    clr[imgui.Col.Text]                 = imgui.ImVec4(0.85, 0.86, 0.88, 1.00)
    clr[imgui.Col.WindowBg]             = imgui.ImVec4(0.06, 0.08, 0.10, 1.00)
    clr[imgui.Col.ChildBg]              = imgui.ImVec4(0.07, 0.09, 0.11, 1.00)
    clr[imgui.Col.TitleBg]              = imgui.ImVec4(0.06, 0.08, 0.10, 1.00)
    clr[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.06, 0.08, 0.10, 1.00)
    clr[imgui.Col.Button]               = imgui.ImVec4(0.12, 0.16, 0.20, 1.00)
    clr[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.18, 0.22, 0.26, 1.00)
    clr[imgui.Col.ButtonActive]         = imgui.ImVec4(0.18, 0.22, 0.26, 1.00)
    clr[imgui.Col.FrameBg]              = imgui.ImVec4(0.10, 0.14, 0.18, 1.00)
    clr[imgui.Col.Separator]            = imgui.ImVec4(0.15, 0.18, 0.21, 1.00)

    clr[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.15, 0.18, 0.21, 1.00)
    clr[imgui.Col.CheckMark]            = imgui.ImVec4(0.00, 0.70, 1.00, 1.00)
    clr[imgui.Col.SliderGrab]           = imgui.ImVec4(0.12, 0.16, 0.20, 1.00)
    clr[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.18, 0.22, 0.26, 1.00)
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    applyTheme()
    fa.Init(13)
end)

imgui.OnFrame(function() return renderWindow[0] end, function()
    imgui.SetNextWindowSize(imgui.ImVec2(550, 450), imgui.Cond.FirstUseEver)
    local sw, sh = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(sw * 0.5, sh * 0.5), imgui.Cond.Appearing, imgui.ImVec2(0.5, 0.5))
    if imgui.Begin(u8"SetVc Tools", renderWindow, imgui.WindowFlags.NoResize , imgui.WindowFlags.NoCollapse) then        
        imgui.End()
    end
end)

function main()
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage("{00FFFF}[Calc Craft] {FFFFFF}Загружен. Активация {00FFFF}/cc", -1)
    sampRegisterChatCommand("cc", function() renderWindow[0] = not renderWindow[0] end)
    wait(-1)
end