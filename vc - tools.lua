script_name("vc - tools")
script_author("legacy")
script_version("1.48")

local fa = require('fAwesome6_solid')
local imgui = require 'mimgui'
local encoding = require 'encoding'

encoding.default = 'CP1251'
local u8 = encoding.UTF8

local renderWindow = imgui.new.bool(false)

local function applyTheme()
    local style = imgui.GetStyle()
    local clr = style.Colors
    style.WindowRounding, style.ChildRounding, style.FrameRounding = 0, 0, 5
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ItemSpacing = imgui.ImVec2(10, 10)

    clr[imgui.Col.Text] = imgui.ImVec4(0.85, 0.86, 0.88, 1)
    clr[imgui.Col.WindowBg] = imgui.ImVec4(0.05, 0.08, 0.10, 1)
    clr[imgui.Col.ChildBg] = clr[imgui.Col.WindowBg]
    clr[imgui.Col.Button] = imgui.ImVec4(0.10, 0.15, 0.18, 1)
    clr[imgui.Col.ButtonHovered] = imgui.ImVec4(0.15, 0.20, 0.23, 1)
    clr[imgui.Col.ButtonActive] = clr[imgui.Col.ButtonHovered]
end

imgui.OnInitialize(function()
    fa.Init(14)
    applyTheme()
    imgui.GetIO().IniFilename = nil
end)

-- Интерфейс настроек с fAwesome6
imgui.OnFrame(function() return renderWindow[0] end, function()
    applyTheme()
    imgui.SetNextWindowSize(imgui.ImVec2(500, 400), imgui.Cond.FirstUseEver)

    if imgui.Begin(u8"Настройки", renderWindow) then
        -- Пример кнопки с иконкой
        if imgui.Button(fa.GEAR .. u8" Настройки") then
            -- Действие при нажатии
        end

        imgui.End()
    end
end)

function main()
    while not isSampAvailable() do wait(0) end
sampAddChatMessage("{00FFFF}  [vc - tools] {FFFFFF} Скрипт загружен. Для активации используйте {FFD700}/vct", 0xFFFFFF)
    sampRegisterChatCommand('vct', function()
        renderWindow[0] = not renderWindow[0]
    end)

    wait(-1)
end
