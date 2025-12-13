script_name("vc - tools")
script_author("legacy")
script_version("2.1")

local imgui = require 'mimgui'
local fa = require 'fAwesome6_solid'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local renderWindow = imgui.new.bool(false)
local activeTab = imgui.new.int(1)

local autoUpdate = imgui.new.bool(true)
local notifications = imgui.new.bool(true)
local soundEffects = imgui.new.bool(false)

local function applyTheme()
 -- осн
    local bg = imgui.ImVec4(0.06, 0.08, 0.10, 1)
    local childBg = imgui.ImVec4(0.07, 0.09, 0.11, 1)
    local button = imgui.ImVec4(0.12, 0.16, 0.20, 1)
    local buttonHover = imgui.ImVec4(0.18, 0.22, 0.26, 1)
    local frame = imgui.ImVec4(0.10, 0.14, 0.18, 1)
    local text = imgui.ImVec4(0.85, 0.86, 0.88, 1)
 -- бок цвет
    local sidebar1 = imgui.ImVec4(0.12, 0.15, 0.17, 1)
    local sidebar2 = imgui.ImVec4(0.17, 0.20, 0.22, 1)
    local sidebar3 = imgui.ImVec4(0.17, 0.20, 0.22, 1)
    local style = imgui.GetStyle()
    local clr = style.Colors
    style.WindowRounding = 0
    style.ChildRounding = 4
    style.FrameRounding = 4
    style.WindowBorderSize = 0
    style.FrameBorderSize = 0
    style.ItemSpacing = imgui.ImVec2(10, 12)
    clr[imgui.Col.Text] = text
    clr[imgui.Col.WindowBg] = bg
    clr[imgui.Col.ChildBg] = childBg
    clr[imgui.Col.TitleBg] = bg
    clr[imgui.Col.TitleBgActive] = bg
    clr[imgui.Col.TitleBgCollapsed] = bg
    clr[imgui.Col.Button] = button
    clr[imgui.Col.ButtonHovered] = buttonHover
    clr[imgui.Col.ButtonActive] = buttonHover
    clr[imgui.Col.FrameBg] = frame
    clr[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.12, 0.16, 0.20, 1)
    clr[imgui.Col.FrameBgActive] = imgui.ImVec4(0.14, 0.18, 0.22, 1)
    clr[imgui.Col.Separator] = imgui.ImVec4(0.15, 0.18, 0.21, 1)
    return sidebar1, sidebar2, sidebar3
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    fa.Init(16)
    sidebar1, sidebar2, sidebar3 = applyTheme()
end)

local tabs = {
    { icon = fa.HOUSE, name = u8" Главная" },
    { icon = fa.SCREWDRIVER_WRENCH, name = u8" Инструменты" },
    { icon = fa.GEAR, name = u8" Настройки" }
}

local function drawSidebar()
    imgui.BeginChild("Sidebar", imgui.ImVec2(140, -1), true)
    local sidebarColors = {sidebar1, sidebar2, sidebar3}
    for i = 1, 3 do
        imgui.PushStyleColor(imgui.Col.Button + i - 1, sidebarColors[i])
    end

    for i, tab in ipairs(tabs) do
        if imgui.Button(tab.icon .. tab.name, imgui.ImVec2(120, 40)) then
            activeTab[0] = i
        end
    end

    imgui.PopStyleColor(3)
    imgui.EndChild()
end

local function drawContent()
    imgui.SameLine()
    imgui.BeginChild("Content", imgui.ImVec2(0, -1), true)
    
    local tab = activeTab[0]
    
    if tab == 1 then
        imgui.TextColored(imgui.ImVec4(0.4, 0.8, 1, 1), fa.CIRCLE_INFO .. u8" Информация")
        imgui.Separator()
        imgui.Dummy(imgui.ImVec2(0, 5))
        imgui.Text(u8"Добро пожаловать в vc-tools!")
        imgui.Dummy(imgui.ImVec2(0, 10))
        imgui.BulletText(u8"Версия: 2.1")
        imgui.BulletText(u8"Автор: legacy")
        imgui.BulletText(u8"Команда: /vc")
    
    elseif tab == 2 then
        imgui.TextColored(imgui.ImVec4(0.4, 0.8, 1, 1), fa.SCREWDRIVER_WRENCH .. u8" Инструменты")
        imgui.Separator()
        imgui.Dummy(imgui.ImVec2(0, 10))
        imgui.Checkbox(u8"Автообновление", autoUpdate)
        imgui.Checkbox(u8"Уведомления", notifications)
        imgui.Checkbox(u8"Звуковые эффекты", soundEffects)    
    elseif tab == 3 then
        imgui.TextColored(imgui.ImVec4(0.4, 0.8, 1, 1), fa.GEAR .. u8" Настройки")
        imgui.Separator()
        imgui.Dummy(imgui.ImVec2(0, 5))
        imgui.Text(u8"Настройки")
    end
    imgui.EndChild()
end

imgui.OnFrame(function() return renderWindow[0] end, function()
    imgui.SetNextWindowSize(imgui.ImVec2(600, 440), imgui.Cond.FirstUseEver)
    if imgui.Begin(u8"vc-tools", renderWindow, imgui.WindowFlags.NoResize) then
        drawSidebar()
        drawContent()
        imgui.End()
    end
end)

function main()
    repeat wait(0) until isSampAvailable()    
    sampAddChatMessage("{00FFFF}[vc-tools] {FFFFFF}Скрипт загружен. Команда: {00FFFF}/vc", -1)    
    sampRegisterChatCommand("vc", function()
        renderWindow[0] = not renderWindow[0]
    end)    
    wait(-1)
end
