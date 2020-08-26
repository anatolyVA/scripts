script_version("1.0")

local imgui = require 'imgui'
local inicfg = require 'inicfg'
local encoding = require 'encoding'
local vkeys = require 'vkeys'
local sampev = require 'lib.samp.events'
local notify = import 'lib_imgui_notf'
local res_lfs, lfs = pcall(require, "lfs")
local dlstatus = require('moonloader').download_status -- загружаем библиотеку
encoding.default = 'CP1251' -- указываем кодировку по умолчанию, она должна совпадать с кодировкой файла. CP1251 - это Windows-1251
u8 = encoding.UTF8 -- и создаём короткий псевдоним для кодировщика UTF-8

local themes = import 'resource/imgui_themes.lua'

local main_window_state = imgui.ImBool(false)
local med_window = imgui.ImBool(false)
local type_window = imgui.ImBool(false)
local ustav_window = imgui.ImBool(false)
local klyatva_window = imgui.ImBool(false)
local systemrank_window = imgui.ImBool(false)
local kd_window = imgui.ImBool(false)
local drugoe_window = imgui.ImBool(false)
local cen_window = imgui.ImBool(false)
local uval = imgui.ImBool(false)
local uninvite_reason = imgui.ImBuffer(256)
local uninvite_id = imgui.ImBuffer(256)

local text_buffer = imgui.ImBuffer(256)
local sw, sh = getScreenResolution()

local directIni = "moonloader\\config\\mh.ini"
local mainIni = inicfg.load(nil, directIni)
local mainBind = inicfg.load(nil, bindPath)

local tag = '{FF6347}[MedHelper] '
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })

local checked_radio = imgui.ImInt(mainIni.config.org)
local combo_select = imgui.ImInt(mainIni.config.rank - 1)
local question = imgui.ImInt(1)
local pass = imgui.ImInt(1)
local lic = imgui.ImInt(1)
local card = imgui.ImInt(1)
local MAction = imgui.ImInt(1)
local MainAction = imgui.ImInt(1)
local giverank = imgui.ImInt(1)
local upWithRp = imgui.ImBool(mainIni.config.upWithRp)
local search_ustav = imgui.ImBuffer(256)
local search_cen = imgui.ImBuffer(256)
local bl_reason			= imgui.ImBuffer(256)
local st_window = imgui.ImBool(false)

function style_gray()
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2
  style.WindowRounding = 10.0
  style.FrameRounding = 5.0
  style.ChildWindowRounding = 5.0
  style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)


colors[clr.Text] 					= ImVec4(0.95, 0.96, 0.98, 1.00)
colors[clr.TextDisabled] 			= ImVec4(0.36, 0.42, 0.47, 1.00)
colors[clr.WindowBg] 				= ImVec4(0.11, 0.15, 0.17, 1.00)
colors[clr.ChildWindowBg] 			= ImVec4(0.15, 0.18, 0.22, 1.00)
colors[clr.PopupBg] 				= ImVec4(0.11, 0.15, 0.17, 1.00)
colors[clr.Border] 					= ImVec4(0.86, 0.86, 0.86, 1.00)
colors[clr.BorderShadow] 			= ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.FrameBg] 				= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.FrameBgHovered] 			= ImVec4(0.12, 0.20, 0.28, 1.00)
colors[clr.FrameBgActive] 			= ImVec4(0.09, 0.12, 0.14, 1.00)
colors[clr.TitleBg] 				= ImVec4(0.09, 0.12, 0.14, 0.65)
colors[clr.TitleBgCollapsed] 		= ImVec4(0.00, 0.00, 0.00, 0.51)
colors[clr.TitleBgActive] 			= ImVec4(0.08, 0.10, 0.12, 1.00)
colors[clr.MenuBarBg] 				= ImVec4(0.15, 0.18, 0.22, 1.00)
colors[clr.ScrollbarBg] 			= ImVec4(0.02, 0.02, 0.02, 0.39)
colors[clr.ScrollbarGrab] 			= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.ScrollbarGrabHovered] 	= ImVec4(0.18, 0.22, 0.25, 1.00)
colors[clr.ScrollbarGrabActive] 	= ImVec4(0.09, 0.21, 0.31, 1.00)
colors[clr.ComboBg] 				= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.CheckMark] 				= ImVec4(0.28, 0.56, 1.00, 1.00)
colors[clr.SliderGrab] 				= ImVec4(0.28, 0.56, 1.00, 1.00)
colors[clr.SliderGrabActive] 		= ImVec4(0.37, 0.61, 1.00, 1.00)
colors[clr.Button] 					= ImVec4(0.20, 0.25, 0.29, 1.00)
colors[clr.ButtonHovered] 			= ImVec4(0.28, 0.56, 1.00, 1.00)
colors[clr.ButtonActive]			= ImVec4(0.06, 0.53, 0.98, 1.00)
colors[clr.Header] 					= ImVec4(0.20, 0.25, 0.29, 0.55)
colors[clr.HeaderHovered] 			= ImVec4(0.26, 0.59, 0.98, 0.80)
colors[clr.HeaderActive] 			= ImVec4(0.26, 0.59, 0.98, 1.00)
colors[clr.ResizeGrip] 				= ImVec4(0.26, 0.59, 0.98, 0.25)
colors[clr.ResizeGripHovered] 		= ImVec4(0.26, 0.59, 0.98, 0.67)
colors[clr.ResizeGripActive] 		= ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.CloseButton] 			= ImVec4(0.40, 0.39, 0.38, 0.16)
colors[clr.CloseButtonHovered] 		= ImVec4(0.40, 0.39, 0.38, 0.39)
colors[clr.CloseButtonActive] 		= ImVec4(0.40, 0.39, 0.38, 1.00)
colors[clr.PlotLines] 				= ImVec4(0.61, 0.61, 0.61, 1.00)
colors[clr.PlotLinesHovered] 		= ImVec4(1.00, 0.43, 0.35, 1.00)
colors[clr.PlotHistogram] 			= ImVec4(0.90, 0.70, 0.00, 1.00)
colors[clr.PlotHistogramHovered] 	= ImVec4(1.00, 0.60, 0.00, 1.00)
colors[clr.TextSelectedBg] 			= ImVec4(0.25, 1.00, 0.00, 0.43)
colors[clr.ModalWindowDarkening] 	= ImVec4(0.00, 0.00, 0.00, 0.10)
end


local arr_str = {u8(mainIni.nameRank[1].. '(1)'), u8(mainIni.nameRank[2].. '(2)'), u8(mainIni.nameRank[3].. '(3)'), u8(mainIni.nameRank[4].. '(4)'), u8(mainIni.nameRank[5].. '(5)'), u8(mainIni.nameRank[6].. '(6)'), u8(mainIni.nameRank[7].. '(7)'), u8(mainIni.nameRank[8].. '(8)'), u8(mainIni.nameRank[9].. '(9)'), u8(mainIni.nameRank[10].. '(10)')}

function imgui.BeforeDrawFrame()
  if fa_font == nil then
      local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
      font_config.MergeMode = true
      fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
  end
end

function imgui.OnDrawFrame()
  if not main_window_state.v and not med_window.v then
    imgui.Process = false
  end 

  if main_window_state.v then
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(450, 310), imgui.Cond.FirstUseEver)
  

    imgui.Begin(u8'MedHelper', main_window_state, imgui.WindowFlags.NoResize)


    imgui.BeginChild("Mhmain", imgui.ImVec2(150, 190), true)
    imgui.CenterTextColoredRGB('{FF6347}Статистика врача')
    imgui.CenterTextColoredRGB('Имя: ' ..mainIni.config.name)
    imgui.CenterTextColoredRGB('{FF6347}Должность:')
    imgui.CenterTextColoredRGB(mainIni.nameRank[mainIni.config.rank])
    imgui.NewLine()
    imgui.CenterTextColoredRGB('Вылечено: ' ..mainIni.stat.heal)
    imgui.CenterTextColoredRGB('Выдано мед.карт: ' ..mainIni.stat.medc)
    imgui.CenterTextColoredRGB('Выдано рецептов: ' ..mainIni.stat.rec)
    imgui.CenterTextColoredRGB('Выдано аптечек: ' ..mainIni.stat.aptech)
    imgui.CenterTextColoredRGB('Снято тату: ' ..mainIni.stat.utatu)
    imgui.EndChild()
    imgui.SameLine()
   if MainAction.v == 2 then
    imgui.BeginChild("Mhchange", imgui.ImVec2(-1, 185), false)
    imgui.Text(u8'Введите ваше имя')
    if imgui.InputText(u8'##1', text_buffer) then -- условие будет срабатывать при изменении текста
    end
    if imgui.Button(u8'Сохранить', imgui.ImVec2(100, 20)) then
      mainIni.config.name = u8:decode(text_buffer.v)
      if inicfg.save(mainIni, directIni) then
         sampAddChatMessage(tag.. '{FFFFFF}Новое имя: {DC143C}' ..mainIni.config.name, -1)
      end
    end
    imgui.Text(u8' ')
    imgui.Text(u8'Выберите вашу должность')
    if imgui.Combo(u8'##2', combo_select, arr_str, #arr_str) then
      mainIni.config.rank = combo_select.v + 1
      if inicfg.save(mainIni, directIni) then
          sampAddChatMessage(tag.. '{FFFFFF}Сохранено, новая должность: {DC143C}' ..mainIni.nameRank[mainIni.config.rank], -1)
      end
    end
  
    imgui.Text(u8'Выберите вашу организацию')
    if imgui.RadioButton(u8'ВМУ', checked_radio, 1) then
      mainIni.config.org = 1
      mainIni.nameRank[1] = 'Интерн'
      mainIni.nameRank[2] = 'Мед.Работник'
      mainIni.nameRank[3] = 'Терапевт'
      mainIni.nameRank[4] = 'Нарколог'
      mainIni.nameRank[5] = 'Офтальмолог'
      mainIni.nameRank[6] = 'Хирург'
      mainIni.nameRank[7] = 'Психиатор'
      mainIni.nameRank[8] = 'Зав.Отделением'
      mainIni.nameRank[9] = 'Зам.Глав.Врача'
      mainIni.nameRank[10] = 'Глав.Врач'
      if inicfg.save(mainIni, directIni) then
          sampAddChatMessage(tag.. '{FFFFFF}Сохранено, новая организация: {DC143C}' ..mainIni.nameOrg[mainIni.config.org].. '{FFFFFF} Перезапустите для изменения названий рангов', -1)
      end
    end
    imgui.SameLine()
    if imgui.RadioButton(u8'МЗ-Ю', checked_radio, 2) then
      mainIni.config.org = 2
      mainIni.nameRank[1] = 'Интерн'
      mainIni.nameRank[2] = 'Участковый Врач'
      mainIni.nameRank[3] = 'Терапевт'
      mainIni.nameRank[4] = 'Нарколог'
      mainIni.nameRank[5] = 'Окулист'
      mainIni.nameRank[6] = 'Хирург'
      mainIni.nameRank[7] = 'Психолог'
      mainIni.nameRank[8] = 'Зав.Отделением'
      mainIni.nameRank[9] = 'Зам.Глав.Врача'
      mainIni.nameRank[10] = 'Глав.Врач'
      if inicfg.save(mainIni, directIni) then
        sampAddChatMessage(tag.. '{FFFFFF}Сохранено, новая организация: {DC143C}' ..mainIni.nameOrg[mainIni.config.org].. '{FFFFFF} Перезапустите для изменения названий рангов', -1)
      end
    end
    imgui.EndChild()
   end
   if MainAction.v == 1 then
    imgui.BeginChild("Chmain", imgui.ImVec2(-1, 200), false)
      if imgui.Button(u8('Устав'), imgui.ImVec2(-1, 30)) then
        ustav_window.v = true
      end
      if imgui.Button(u8('Клятва Гипократа'), imgui.ImVec2(-1, 30)) then
        klyatva_window.v = true
      end
      if imgui.Button(u8('Система повышения'), imgui.ImVec2(-1, 30)) then
        systemrank_window.v = true
      end
      if imgui.Button(u8('К/Д между повышениями'), imgui.ImVec2(-1, 30)) then
        kd_window.v = true
      end
      if imgui.Button(u8('Старший Состав'), imgui.ImVec2(-1, 30)) then
        st_window.v = true
      end
      if imgui.Button(u8('Ценовая Политика'), imgui.ImVec2(-1, 30)) then
        cen_window.v = true
      end
    imgui.EndChild()
   end
    if MainAction.v == 3 then
    imgui.BeginChild("ChLections", imgui.ImVec2(-1, 185), false)
        	imgui.CenterTextColoredRGB('Меню проведения лекций сотрудникам {868686}(?)')
        	imgui.HintHovered(u8'Вы можете добавлять свои лекции!\nДля этого в папке moonloader/MH/Lec\nсоздайте текстовый файл и вставьте туда нужную лекцию')
        	imgui.NewLine()
        if doesDirectoryExist("moonloader/MH/Lec") then
				  for line in lfs.dir(getWorkingDirectory().."\\MH\\Lec") do
				  	if line == nil then
				  	elseif line:match(".+%.txt") then
				  		if imgui.Button(u8(line:match("(.+)%.txt")), imgui.ImVec2(-1, 30)) then
							  lua_thread.create(function()
								    local lection_text = io.open("moonloader/MH/Lec/"..line:match("(.+)%.txt")..".txt", "r+")
								    for line in lection_text:lines() do
									    sampSendChat(line)
									    wait(1500)
								    end
								    lection_text:close()
								    sampAddChatMessage(tag.. '{FFFFFF}Воспроизведение лекции окончено!', -1)
							  end)
						  end
            end
          end
			  else
				   imgui.NewLine(); imgui.NewLine()
				   imgui.CenterTextColoredRGB('У вас отсутствует папка с лекциями\nНо вы можете скачать заготовленные\nДля этого нажмите "Скачать лекции"')
				   imgui.NewLine()
				   imgui.SetCursorPosX((imgui.GetWindowWidth() - 130) / 2)
				    if imgui.Button(u8('Скачать лекции '), imgui.ImVec2(130, 30)) then
					   downloadLections()
				    end
        end
    imgui.EndChild()
    end
     imgui.SetCursorPos(imgui.ImVec2(10, 225))
     imgui.RadioButton(u8("INFO"), MainAction, 1)
     imgui.SetCursorPos(imgui.ImVec2(10, 255))
     imgui.RadioButton(u8("Настройки"), MainAction, 2)
     imgui.SetCursorPos(imgui.ImVec2(10, 285))
     imgui.RadioButton(u8("Лекции"), MainAction, 3)
     imgui.SameLine()
     imgui.SetCursorPosX(235)
     imgui.SetCursorPosY(250)
     if imgui.Button(u8('Меню увольнения'), imgui.ImVec2(130, 30)) then
      uval.v = true
     end
    imgui.End()
  end
  if ustav_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(xx / 1.5, yy / 1.5), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8'Устав Министерства Здравоохранения', ustav_window, imgui.WindowFlags.NoCollapse)
       imgui.PushItemWidth(200)
       imgui.PushAllowKeyboardFocus(false)
       imgui.InputText("##search_ustav", search_ustav, imgui.InputTextFlags.EnterReturnsTrue)
       imgui.PopAllowKeyboardFocus()
       imgui.PopItemWidth()
      if not imgui.IsItemActive() and #search_ustav.v == 0 then
       imgui.SameLine(15)
       imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
       imgui.Text(u8'Поиск по уставу')
       imgui.PopStyleColor()
      end
			local ustav = io.open("moonloader/MH/INFO/Устав_МЗ.txt", "r+")
      for line in ustav:lines() do
        if #search_ustav.v < 1 then
          imgui.TextColoredRGB(u8:decode(line))
				elseif string.rlower(line):find(string.rlower(u8:decode(search_ustav.v))) then
					imgui.TextColoredRGB(u8:decode(line))
				end
      end
			ustav:close()

		imgui.End()
  end
  if klyatva_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'Клятва Гиппократа', klyatva_window)
			local klyatva = io.open("moonloader/MH/INFO/Клятва_Гиппократа.txt", "r+")
			for line in klyatva:lines() do
        imgui.TextColoredRGB(u8:decode(line))
      end
			klyatva:close()

		imgui.End()
  end
  if systemrank_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(xx / 1.5, yy / 1.5), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'Система повышения Министерства Здравоохранения', systemrank_window, imgui.WindowFlags.NoCollapse)
     if checked_radio.v == 1 then
			local systemrank = io.open("moonloader/MH/INFO/Система_Повышения.txt", "r+")
			for line in systemrank:lines() do
        imgui.TextColoredRGB(u8:decode(line))
      end
      systemrank:close()
     end
     if checked_radio.v == 2 then
			local systemrank = io.open("moonloader/MH/INFO/Система_Повышения_МЗ-Ю.txt", "r+")
			for line in systemrank:lines() do
        imgui.TextColoredRGB(u8:decode(line))
      end
      systemrank:close()
     end
		imgui.End()
  end
  if kd_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    if checked_radio.v == 1 then
        imgui.Begin(u8'К/Д между повышениями МЗ', kd_window, imgui.WindowFlags.NoCollapse)
			local kd = io.open("moonloader/MH/INFO/КД_Между_Повышениями.txt", "r+")
			for line in kd:lines() do
        imgui.CenterTextColoredRGB(u8:decode(line))
      end
			kd:close()
    end
    if checked_radio.v == 2 then
      imgui.Begin(u8'К/Д между повышениями МЗ', kd_window, imgui.WindowFlags.NoCollapse)
      local kd = io.open("moonloader/MH/INFO/КД_Между_Повышениями_МЗ-Ю.txt", "r+")
      for line in kd:lines() do
        imgui.CenterTextColoredRGB(u8:decode(line))
      end
      kd:close()
    end
		imgui.End()
  end
  if cen_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8'Ценовая Политика Министерства Здравоохранения', cen_window, imgui.WindowFlags.NoCollapse)
       imgui.PushItemWidth(200)
       imgui.PushAllowKeyboardFocus(false)
       imgui.InputText("##search_cen", search_cen, imgui.InputTextFlags.EnterReturnsTrue)
       imgui.PopAllowKeyboardFocus()
       imgui.PopItemWidth()
      if not imgui.IsItemActive() and #search_ustav.v == 0 then
       imgui.SameLine(15)
       imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
       imgui.Text(u8'Поиск по политике цен')
       imgui.PopStyleColor()
      end
			local cen = io.open("moonloader/MH/INFO/Ценовая_Политика.txt", "r+")
      for line in cen:lines() do
        if #search_cen.v < 1 then
          imgui.TextColoredRGB(u8:decode(line))
				elseif string.rlower(line):find(string.rlower(u8:decode(search_cen.v))) then
					imgui.TextColoredRGB(u8:decode(line))
				end
      end
			cen:close()
    imgui.End()
  end
  if st_window.v then
		local xx, yy = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(xx / 2, yy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
     imgui.Begin(u8'Руководство Министерства Здравоохранения', st_window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
     if checked_radio.v == 1 then
     imgui.CenterTextColoredRGB('Руководство Больницы Арзамас(ВМУ) {868686}(?)')
     imgui.HintHovered(u8'Следящие:\nГС: Веган Гасбаро\nЗГС: Дима Сальваторе\nСледящий: Ник Законов\nСледящий: Влад Горпинюк')
     imgui.CenterTextColoredRGB('{FF6347}Глав.Врач')
     imgui.CenterTextColoredRGB('Никитос Бурбон | Срок (22.09.2020)')
     imgui.CenterTextColoredRGB('{FF6347}Зам.Глав.Врач')
     imgui.CenterTextColoredRGB('Нету')
     imgui.CenterTextColoredRGB('{FF6347}Зам.Глав.Врач')
     imgui.CenterTextColoredRGB('Нету')
     imgui.CenterTextColoredRGB('{FF6347}Зам.Глав.Врач')
     imgui.CenterTextColoredRGB('Нету')
     end
     if checked_radio.v == 2 then
     imgui.CenterTextColoredRGB('Руководство Больницы Южный(МЗ-Ю) {868686}(?)')
     imgui.HintHovered(u8'Следящие:\nГС: Веган Гасбаро\nЗГС: Дима Сальваторе\nСледящий: Ник Законов\nСледящий: Влад Горпинюк')
     imgui.CenterTextColoredRGB('{FF6347}Глав.Врач')
     imgui.CenterTextColoredRGB('Нету | Срок ( .. -  ..)')
     imgui.CenterTextColoredRGB('{FF6347}Зам.Глав.Врач')
     imgui.CenterTextColoredRGB('Нету')
     imgui.CenterTextColoredRGB('{FF6347}Зам.Глав.Врач')
     imgui.CenterTextColoredRGB('Нету')
     imgui.CenterTextColoredRGB('{FF6347}Зам.Глав.Врач')
     imgui.CenterTextColoredRGB('Нету')
     end
     imgui.End()
  end

  if med_window.v then 

    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(500, 290), imgui.Cond.FirstUseEver)
    imgui.Begin(u8'MedHelperH', med_window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)

    imgui.BeginChild("ChInfo", imgui.ImVec2(150, 170), true)
      if sampIsPlayerConnected(actionId) then
       imgui.CenterTextColoredRGB('{FF6347}Имя игрока')
       imgui.CenterTextColoredRGB(sampGetPlayerNickname(actionId)..' ['..actionId..']')
       imgui.NewLine()
       imgui.CenterTextColoredRGB('{FF6347}Время')
       imgui.CenterTextColoredRGB(string.format(os.date("%H",os.time())..':'..os.date("%M",os.time())))
       imgui.NewLine()
       imgui.CenterTextColoredRGB('{FF6347}Проживает в округе')
        if MAction.v ~= 2 then 
          imgui.CenterTextColoredRGB(tostring(sampGetPlayerScore(actionId))..' лет')
        else
          if sampGetPlayerScore(actionId) > 2 then
           imgui.CenterTextColoredRGB(tostring(sampGetPlayerScore(actionId))..' лет | Подходит')
          else
           imgui.CenterTextColoredRGB(tostring(sampGetPlayerScore(actionId))..' лет | {FF0000}Не подходит')
          end
      end
    imgui.EndChild()
    imgui.SameLine()
    if MAction.v == 1 then
      imgui.BeginChild("Chheal", imgui.ImVec2(-1, 278), false)
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
      imgui.SetCursorPosY(5)
       if imgui.Button(u8'Вылечить гражданского ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.name.. ", я Ваш лечащий врач", -1)
            wait(900)
           sampSendChat("/do На груди бейджик, на нём написано: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
            wait(900) 
           sampSendChat("Сейчас попробую Вам помочь!", -1)
            wait(900) 
           sampSendChat("/do Мед. сумка на плече.", -1)
            wait(900)
           sampSendChat("/me снял мед.сумку", -1)
            wait(900) 
           sampSendChat("/me открыл мед.сумку", -1)
            wait(900)
           sampSendChat("/me достал нужный препарат", -1)
            wait(900) 
           sampSendChat("/do Препарат в руке.", -1)
            wait(900)
            sampSendChat("/todo Вот, возьмите, это должно Вам помочь*передав препарат", -1)
            wait(900) 
            sampSendChat("/heal " ..actionId.. ' 1000', -1)
            function sampev.onServerMessage(color, text)
              if text:find('Вы отправили предложение') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', 'Вы отправили запрос на лечение ID {DC143C}[' ..actionId.. ']\nВы уже вылечили: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('Вы не доктор!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не доктор!', 2, 2, 6)
              end
              if text:find('Чтобы лечить пациентов вы должны быть на дежурстве!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не на дежурстве!', 2, 2, 6)
              end
              if text:find('Получить медикаменты можно в вашей больнице!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}У вас нет медикаментов!', 2, 2, 6)
              end
              if text:find('Вы далеко от игрока') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы далеко от игрока!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}Вы должны находиться в больнице, госпитале или машине МЧC!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Не находитесь в больнице или в машине!', 2, 2, 6)
              end
            end
          end)
        else
            notify.addNotify('{DC143C}[MedHelper]', 'Доступно только со 2 ранга', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'Вылечить нелегала ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.name.. ", я Ваш лечащий врач", -1)
            wait(900)
           sampSendChat("/do На груди бейджик, на нём написано: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
            wait(900) 
           sampSendChat("Сейчас попробую Вам помочь!", -1)
            wait(900) 
           sampSendChat("/do Мед. сумка на плече.", -1)
            wait(900)
           sampSendChat("/me снял мед.сумку", -1)
            wait(900) 
           sampSendChat("/me открыл мед.сумку", -1)
            wait(900)
           sampSendChat("/me достал нужный препарат", -1)
            wait(900) 
           sampSendChat("/do Препарат в руке.", -1)
            wait(900)
            sampSendChat("/todo Вот, возьмите, это должно Вам помочь*передав препарат", -1)
            wait(900) 
            sampSendChat("/heal " ..actionId.. ' 1000', -1)
            function sampev.onServerMessage(color, text)
              if text:find('Вы отправили предложение') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', 'Вы отправили запрос на лечение ID {DC143C}[' ..actionId.. ']\nВы уже вылечили: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('Вы не доктор!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не доктор!', 2, 2, 6)
              end
              if text:find('Чтобы лечить пациентов вы должны быть на дежурстве!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не на дежурстве!', 2, 2, 6)
              end
              if text:find('Получить медикаменты можно в вашей больнице!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}У вас нет медикаментов!', 2, 2, 6)
              end
              if text:find('Вы далеко от игрока') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы далеко от игрока!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}Вы должны находиться в больнице, госпитале или машине МЧC!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Не находитесь в больнице или в машине!', 2, 2, 6)
              end
            end
          end)
        else
            notify.addNotify('{DC143C}[MedHelper]', 'Доступно только со 2 ранга', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'Вылечить сотрудника ФСБ Пра-ва и МЗ ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.name.. ", я Ваш лечащий врач", -1)
            wait(900)
           sampSendChat("/do На груди бейджик, на нём написано: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
            wait(900) 
           sampSendChat("Сейчас попробую Вам помочь!", -1)
            wait(900) 
           sampSendChat("/do Мед. сумка на плече.", -1)
            wait(900)
           sampSendChat("/me снял мед.сумку", -1)
            wait(900) 
           sampSendChat("/me открыл мед.сумку", -1)
            wait(900)
           sampSendChat("/me достал нужный препарат", -1)
            wait(900) 
           sampSendChat("/do Препарат в руке.", -1)
            wait(900)
            sampSendChat("/todo Вот, возьмите, это должно Вам помочь*передав препарат", -1)
            wait(900) 
            sampSendChat("/heal " ..actionId.. ' 250', -1)
            function sampev.onServerMessage(color, text)
              if text:find('Вы отправили предложение') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', 'Вы отправили запрос на лечение ID {DC143C}[' ..actionId.. ']\nВы уже вылечили: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('Вы не доктор!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не доктор!', 2, 2, 6)
              end
              if text:find('Чтобы лечить пациентов вы должны быть на дежурстве!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не на дежурстве!', 2, 2, 6)
              end
              if text:find('Получить медикаменты можно в вашей больнице!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}У вас нет медикаментов!', 2, 2, 6)
              end
              if text:find('Вы далеко от игрока') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы далеко от игрока!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}Вы должны находиться в больнице, госпитале или машине МЧC!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Не находитесь в больнице или в машине!', 2, 2, 6)
              end
            end
          end)
        else
            notify.addNotify('{DC143C}[MedHelper]', 'Доступно только со 2 ранга', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'Вылечить сотрудника МВД, ЦБ, РЦ-П, ФСИН ' ..fa.ICON_HEART_O, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 1 then
          lua_thread.create(function()
            sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.name.. ", я Ваш лечащий врач", -1)
            wait(900)
           sampSendChat("/do На груди бейджик, на нём написано: - " ..mainIni.config.name.. ", " ..mainIni.nameRank[mainIni.config.rank].. " " ..mainIni.nameOrg[mainIni.config.org], -1)
            wait(900) 
           sampSendChat("Сейчас попробую Вам помочь!", -1)
            wait(900) 
           sampSendChat("/do Мед. сумка на плече.", -1)
            wait(900)
           sampSendChat("/me снял мед.сумку", -1)
            wait(900) 
           sampSendChat("/me открыл мед.сумку", -1)
            wait(900)
           sampSendChat("/me достал нужный препарат", -1)
            wait(900) 
           sampSendChat("/do Препарат в руке.", -1)
            wait(900)
            sampSendChat("/todo Вот, возьмите, это должно Вам помочь*передав препарат", -1)
            wait(900) 
            sampSendChat("/heal " ..actionId.. ' 500', -1)
            function sampev.onServerMessage(color, text)
              if text:find('Вы отправили предложение') then 
               mainIni.stat.heal = mainIni.stat.heal + 1
               notify.addNotify('{DC143C}[MedHelper]', 'Вы отправили запрос на лечение ID {DC143C}[' ..actionId.. ']\nВы уже вылечили: {DC143C}' ..mainIni.stat.heal.. '', 2, 2, 6)
               wait(900)
               sampSendChat("/time")
               wait(900)
               setVirtualKeyDown(VK_F8, true)
               wait(100)
               setVirtualKeyDown(VK_F8, false)
              end
            end
            function sampev.onServerMessage(color, text)
              if text:find('Вы не доктор!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не доктор!', 2, 2, 6)
              end
              if text:find('Чтобы лечить пациентов вы должны быть на дежурстве!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы не на дежурстве!', 2, 2, 6)
              end
              if text:find('Получить медикаменты можно в вашей больнице!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}У вас нет медикаментов!', 2, 2, 6)
              end
              if text:find('Вы далеко от игрока') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Вы далеко от игрока!', 2, 2, 6)
              end
              if text:find('{FF0000}x {AFAFAF}Вы должны находиться в больнице, госпитале или машине МЧC!') then 
               notify.addNotify('{DC143C}[Ошибка]', 'Вы не можете вылечить ID {DC143C}[' ..actionId.. ']\n{DC143C}Не находитесь в больнице или в машине!', 2, 2, 6)
              end
            end
          end)
        else
          notify.addNotify('{DC143C}[MedHelper]', 'Доступно только со 2 ранга', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX(14)
       if imgui.Button(u8'Выдать мед.карту ' ..fa.ICON_ID_CARD_O, imgui.ImVec2(257, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 2 then
          lua_thread.create(function()
           sampSendChat("Хорошо, вы оплатили нужную сумму, но я обязан вас осмотреть", -1)
           wait(900) 
           sampSendChat("/me надев перчатки, осмотрел человека напротив", -1)
           wait(900)
           sampSendChat("/do Гражданин полностью здоров", -1)
           wait(900) 
           sampSendChat("Отлично! Сейчас выдам вам мед.карту", -1)
           wait(900) 
           sampSendChat("/me достал пачку чистых мед. карт и начал заполнять новую мед. карту", -1)
           wait(900) 
           sampSendChat("/do Мед. карта готова. Статус: полностью здоров.", -1)
           wait(900)
           sampSendChat("/me передал готовую мед. карту человеку", -1)
           wait(900)  
           sampSendChat("/medcard " ..actionId.. " 3", -1)
           mainIni.stat.medc = mainIni.stat.medc + 1
           notify.addNotify('{DC143C}[MedHelper]', 'Вы выдали мед.карту игроку с ID {DC143C}[' ..actionId.. ']\nВыдано уже: {DC143C}' ..mainIni.stat.medc.. '', 2, 2, 6)
           wait(900)
           sampSendChat("/time")
           wait(900)
           setVirtualKeyDown(VK_F8, true)
            wait(100)
           setVirtualKeyDown(VK_F8, false)
          end)
        else
           notify.addNotify('{DC143C}[MedHelper]', 'Доступно только с 3 ранга', 2, 2, 3)
        end
       end
       imgui.SameLine()
       if imgui.Button('' ..fa.ICON_RUB, imgui.ImVec2(35, 30)) then 
        med_window.v = false
         lua_thread.create(function()
          sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.name.. ", я Ваш лечащий врач", -1)
          wait(900) 
          sampSendChat("В данный момент у нас следующая ценовая политика..", -1)
          wait(900)
          sampSendChat("..Мед карты - " ..mainIni.config.mcard.. " Рецепт - " ..mainIni.config.recept, -1)
          wait(900) 
          sampSendChat("Аптечка - " ..mainIni.config.apte.. " Свести тату - " ..mainIni.config.tatu, -1)
          wait(900)
          sampSendChat("Прошу Вас передать мне нужную сумму.", -1)
          wait(900)
          sampSendChat("/b /pay " ..myID.. " сумма", -1)
          wait(900) 
          notify.addNotify('{DC143C}[MedHelper]', 'Ожидайте деньги от игрока с ID {DC143C}[' ..id.. ']', 2, 2, 6)
         end)
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'Выписать рецепт ' ..fa.ICON_PENCIL_SQUARE_O, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 3 then
          lua_thread.create(function()
            sampSendChat("Хорошо, вы оплатили нужную сумму, сейчас я выдам вам рецепты", -1)
            wait(900) 
            sampSendChat("/do В мед.сумке лежат чистые рецепты", -1)
            wait(900)
            sampSendChat("/me подписав рецепт, отдал его гражданину", -1)
            wait(900) 
            sampSendChat("Вот ваши рецепты.", -1)
            wait(900)  
            sampSendChat("/recept " ..actionId, -1)
            mainIni.stat.rec = mainIni.stat.rec + 1
            notify.addNotify('{DC143C}[MedHelper]', 'Вы выдали рецепт игроку с ID {DC143C}[' ..actionId.. ']\nВыдано уже: {DC143C}' ..mainIni.stat.rec.. '', 2, 2, 6)
            wait(900)
            sampSendChat("/time")
            wait(900)
            setVirtualKeyDown(VK_F8, true)
             wait(100)
           setVirtualKeyDown(VK_F8, false)
          end)
        else
          notify.addNotify('{DC143C}[MedHelper]', 'Доступно только с 4 ранга', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'Выдать аптечки ' ..fa.ICON_MEDKIT, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 5 then
          lua_thread.create(function()
           sampSendChat("/me достал бланк", -1)
           wait(900) 
           sampSendChat("/do Бланк в руке.", -1)
           wait(900)
           sampSendChat("/me взял ручку и заполнил имя и фамилию покупателя", -1)
           wait(900) 
           sampSendChat("/do Бланк заполнен.", -1)
           wait(900)
           sampSendChat("Пожалуйста распишитесь", -1)
           wait(900) 
           sampSendChat("/me передал бланк и ручку человеку на против", -1)
           wait(900)  
           sampSendChat("/me забрал бланк и ручку", -1)
           wait(900) 
           sampSendChat("Возьмите свою аптечку.", -1)
           wait(900)   
           sampSendChat("/sellmed " ..actionId.. " 5", -1)
           mainIni.stat.aptech = mainIni.stat.aptech + 5
           notify.addNotify('{DC143C}[MedHelper]', 'Вы выдали аптечки игроку с ID {DC143C}[' ..actionId.. ']\nВыдано уже: {DC143C}' ..mainIni.stat.aptech.. '', 2, 2, 6)
           wait(900)
           sampSendChat("/time")
           wait(900)
           setVirtualKeyDown(VK_F8, true)
            wait(100)
           setVirtualKeyDown(VK_F8, false)
          end)
        else
           notify.addNotify('{DC143C}[MedHelper]', 'Доступно только с 6 ранга', 2, 2, 3)
        end
       end
       imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
       if imgui.Button(u8'Снять тату ' ..fa.ICON_USER_MD, imgui.ImVec2(300, 30)) then 
        med_window.v = false
        if mainIni.config.rank > 5 then
          lua_thread.create(function()
             sampSendChat("/do Аппарат для вышивки тату на столе.", -1)
              wait(900) 
              sampSendChat("/me взял аппарат для извлечения тату.", -1)
              wait(900)
              sampSendChat("/do Аппарат в правой руке.", -1)
              wait(900) 
              sampSendChat("/me начал выводить тату.", -1)
              wait(900)
              sampSendChat("Все, ваш сеанс окончен. Всего Вам доброго.", -1)
              wait(900) 
              sampSendChat("/unstuff " ..actionId.. " 4000", -1)
              mainIni.stat.utatu = mainIni.stat.utatu + 1
             notify.addNotify('{DC143C}[MedHelper]', 'Вы сняли тату игроку с ID {DC143C}[' ..actionId.. ']\nСнято уже: {DC143C}' ..mainIni.stat.utatu.. ' {DC143C}тату', 2, 2, 6)
             wait(900)
             sampSendChat("/time")
             wait(900)
             setVirtualKeyDown(VK_F8, true)
               wait(100)
             setVirtualKeyDown(VK_F8, false)
          end)
        else
          notify.addNotify('{DC143C}[MedHelper]', 'Доступно только с 6 ранга', 2, 2, 3)
        end
       end
      imgui.EndChild()
    end
    if MAction.v == 2 then
    imgui.BeginChild("Chheal", imgui.ImVec2(-1, 280), false)
      imgui.CenterTextColoredRGB('{FF6347}Обязательные критерии:')
      imgui.CenterTextColoredRGB('• 3 года проживания в округе (3+ лвл)')
      imgui.CenterTextColoredRGB('• 35 и более законопослушности')
      imgui.CenterTextColoredRGB('• Отсуствие псих. растройств')
      imgui.CenterTextColoredRGB('• Отсуствие наркозовисимости {868686}(?)')
      if imgui.IsItemHovered() then
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(u8'Допускается до 5 ед.')
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()       
                end
      imgui.CenterTextColoredRGB('• Адекватное поведение и знание РП')
      imgui.NewLine()
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
      if imgui.Button(u8('Приветствие'), imgui.ImVec2(300, 30)) then
        lua_thread.create(function()
                    sampSendChat("Здравствуйте, я "..mainIni.config.nameRank[mainIni.config.rank].." - " ..mainIni.config.name)
                    wait(2500)
                    sampSendChat("Вы на собеседование?")
                  end)
      end
      if pass.v == 1 then
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 315 + imgui.GetStyle().ItemSpacing.x) / 2)
        if imgui.Button(u8('Паспорт'), imgui.ImVec2(100, 30)) then
        lua_thread.create(function()
          sampSendChat("Хорошо, предъставьтесь и покажите мне ваш паспорт!")
                  end)
                  pass.v = 2
        end
      end
      if pass.v == 2 then
        if imgui.Button(u8('Взять'), imgui.ImVec2(100, 30)) then
        lua_thread.create(function()
          sampSendChat("/do На столе лежит паспорт")
            wait(900)
            sampSendChat("/me открыв паспорт, проверил его на опечатки")
            wait(900)
            sampSendChat("/me проверив паспорт, закрыл его")
            wait(900)
            sampSendChat("/do Паспорт лежит на столе")    
                  end)
                  pass.v = 1
        end
      end
      imgui.SameLine()
      if card.v == 1 then
        if imgui.Button(u8('Мед.Карта'), imgui.ImVec2(100, 30)) then
        lua_thread.create(function()
          sampSendChat("Так, паспорт в порядке, теперь покажите мне вашу мед.карту")
                  end)
                  card.v = 2
        end
      end
      if card.v == 2 then
        if imgui.Button(u8('Взять'), imgui.ImVec2(90, 30)) then
        lua_thread.create(function()
          sampSendChat("/do На столе лежит мед.карта")
            wait(900)
            sampSendChat("/me открыв мед.карту, проверил наличее заболеваний")
            wait(900)
            sampSendChat("/me проверив мед.карту, закрыл её")
            wait(900)
            sampSendChat("/do Мед.карта лежит на столе")   
                  end)
                  card.v = 1
        end
      end
      imgui.SameLine()
      if lic.v == 1 then
        if imgui.Button(u8('Лицензии'), imgui.ImVec2(90, 30)) then
        lua_thread.create(function()
          sampSendChat("Хм.. Отлично, покажите-ка мне ваши лицензии") 
                  end)
                  lic.v = 2
        end
      end
      if lic.v == 2 then
        if imgui.Button(u8('Взять'), imgui.ImVec2(90, 30)) then
        lua_thread.create(function()
          sampSendChat("/do На столе лежит папка с лицензиями")
          wait(900)
          sampSendChat("/me открыв папку, проверил наличее лицензии на вождение")
          wait(900)
          sampSendChat("/me проверив папку, закрыл её")
          wait(900)
          sampSendChat("/do Папка лежит на столе")    
                  end)
                  lic.v = 1
        end
      end
      if question.v == 1 then 
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
        if imgui.Button(u8('Задать вопрос №1'), imgui.ImVec2(300, 30)) then
          lua_thread.create(function()
                  sampSendChat("С документами всё в порядке, теперь я задам вам пару вопросов")
                   wait(900)
                   sampSendChat("Готовы ли вы использовать наши новые рации от компании 'Дискорд'")
                    question.v = 2
          end)
        end
      end
      if question.v == 2 then 
        if imgui.Button(u8('Задать вопрос №2'), imgui.ImVec2(300, 30)) then
                  sampSendChat("Как долго планируете работать в нашей организации?")
                    question.v = 3
        end
      end
      if question.v == 3 then 
        if imgui.Button(u8('Задать вопрос №3'), imgui.ImVec2(300, 30)) then
          lua_thread.create(function()
                    sampSendChat("До какой должности планируете дойти у нас?")
                    wait(500)
                    sampAddChatMessage(tag..'Вопросы кончились! Можно завершать опрос!', -1)
                      question.v = 1
                  end)
        end
      end
      imgui.NewLine()
      greenbtn()
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 150 + imgui.GetStyle().ItemSpacing.x) / 2)
      if imgui.Button(u8('Принять'), imgui.ImVec2(75, 30)) then
        med_window.v = false
        lua_thread.create(function()
                    sampSendChat("Поздравляю! Вы нам подходите")
                    wait(900)
                    sampSendChat("/do Под столом лежат пакеты с новой формой")
                      wait(900)
                      sampSendChat("/me взяв один из пакетов, передал его новому сотруднику")
                        wait(900)
                        sampSendChat("Бейджик Вы сможете взять в отделе кадров, приятной работы!")
                  end)
      end
      endbtn()
      imgui.SameLine()
      redbtn()
      if imgui.Button(u8('Отказать'), imgui.ImVec2(75, 30)) then
        med_window.v = false
        lua_thread.create(function()
                    sampSendChat("К сожалению, вы нам не подходите")
                    wait(900)
                    sampSendChat("/b Причин может быть несколько..")
                    wait(900)
                    sampSendChat("/b Самые вероятные из них - НонРП, не подходите по критериям..")
                    wait(900)
                    sampSendChat("Приходите на следующее собеседование!")
                  end)
      end
      endbtn()
    imgui.EndChild()
    end
    if MAction.v == 3 then
    imgui.BeginChild("Chgiverank", imgui.ImVec2(-1, 280), false)
      
      imgui.NewLine()
      imgui.SetCursorPosX(51)
      imgui.TextDisabled('1'); imgui.SameLine(78)
      imgui.TextDisabled('2'); imgui.SameLine(105)
      imgui.TextDisabled('3'); imgui.SameLine(132)
      imgui.TextDisabled('4'); imgui.SameLine(159)
      imgui.TextDisabled('5'); imgui.SameLine(186)
      imgui.TextDisabled('6'); imgui.SameLine(213)
      imgui.TextDisabled('7'); imgui.SameLine(240)
      imgui.TextDisabled('8'); imgui.SameLine(267)
      imgui.TextDisabled('9')

      imgui.SetCursorPosX(45)
      imgui.RadioButton(u8("##giverank1"), giverank, 1); imgui.HintHovered(u8(mainIni.nameRank[1])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank2"), giverank, 2); imgui.HintHovered(u8(mainIni.nameRank[2])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank3"), giverank, 3); imgui.HintHovered(u8(mainIni.nameRank[3])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank4"), giverank, 4); imgui.HintHovered(u8(mainIni.nameRank[4])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank5"), giverank, 5); imgui.HintHovered(u8(mainIni.nameRank[5])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank6"), giverank, 6); imgui.HintHovered(u8(mainIni.nameRank[6])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank7"), giverank, 7); imgui.HintHovered(u8(mainIni.nameRank[7])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank8"), giverank, 8); imgui.HintHovered(u8(mainIni.nameRank[8])); imgui.SameLine()
      imgui.RadioButton(u8("##giverank9"), giverank, 9); imgui.HintHovered(u8(mainIni.nameRank[9]));
      imgui.NewLine()
      imgui.SetCursorPosX(110)
      if imgui.Checkbox(u8'С РП отыгровкой', upWithRp) then 
        mainIni.config.upWithRp = upWithRp.v
        if inicfg.save(mainIni, directIni) then
          sampAddChatMessage(tag.. '{FFFFFF}Сохранено', -1)
        end
      end
      imgui.NewLine()
      imgui.SetCursorPosX((imgui.GetWindowWidth() - 295 + imgui.GetStyle().ItemSpacing.x) / 2)
      if imgui.Button(u8('Повысить'), imgui.ImVec2(140, 30)) then
        med_window.v = false
    if upWithRp.v then 
      lua_thread.create(function()
        sampSendChat('/do В руках планшет')
          wait(900)
        sampSendChat('/me запустив отдел кадров МЗ, нашёл сотрудника')
          wait(900)
        sampSendChat('/me выбрав сотрудника, повысил его в должности')
          wait(900)
        sampSendChat('/do Новая должность сотрудника - ' ..mainIni.config.nameRank[giverank.v])
          wait(900)
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
        if mainIni.config.rank > 8 then
          if not doesDirectoryExist(getWorkingDirectory()..'/MH/Повышения') then 
              if createDirectory(getWorkingDirectory()..'/MH/Повышения') then 
                sampfuncsLog('Bank-Helper: Создана дирректория /BHelper/Повышения')
              end
            end
            log_giverank = io.open(getWorkingDirectory()..'/MH/Повышения/Повышения.txt', "a")
          log_giverank:write(sampGetPlayerNickname(actionId).." | "..tostring(giverank.v - 1).." -> "..tostring(giverank.v).." | "..os.date("%d.%m.%Y").." | "..os.date("%H:%M:%S", os.time()).." | "..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))).."\n")
          log_giverank:close()
        end
      end)
    else
      lua_thread.create(function()
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
        if mainIni.config.rank > 8 then
          if not doesDirectoryExist(getWorkingDirectory()..'/MH/Повышения') then 
              if createDirectory(getWorkingDirectory()..'/MH/Повышения') then 
                sampfuncsLog('Bank-Helper: Создана дирректория /BHelper/Повышения')
              end
            end
            log_giverank = io.open(getWorkingDirectory()..'/MH/Повышения/Повышения.txt', "a")
          log_giverank:write(sampGetPlayerNickname(actionId).." | "..tostring(giverank.v - 1).." -> "..tostring(giverank.v).." | "..os.date("%d.%m.%Y").." | "..os.date("%H:%M:%S", os.time()).." | "..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))).."\n")
          log_giverank:close()
        end
      end)
    end
  end
  imgui.SameLine()
  if imgui.Button(u8('Понизить'), imgui.ImVec2(140, 30)) then
    med_window.v = false
    if upWithRp.v then 
      lua_thread.create(function()
        sampSendChat('/do В руках планшет')
          wait(900)
        sampSendChat('/me запустив отдел кадров МЗ, нашёл сотрудника')
          wait(900)
        sampSendChat('/me выбрав сотрудника, понизил его в должности')
          wait(900)
        sampSendChat('/do Новая должность сотрудника - ' ..mainIni.config.nameRank[giverank.v])
          wait(900)
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
      end)
    else
      lua_thread.create(function()
        sampSendChat('/giverank '..' '..actionId..' '..giverank.v)
      end)
    end
  end
  imgui.NewLine()
  imgui.CenterTextColoredRGB('Внимание!')
  imgui.CenterTextColoredRGB('После повышения сотрудника на 5-й ранг\n вам нужно оставить анти-блат на форуме')

    imgui.EndChild()
    end
      imgui.SetCursorPos(imgui.ImVec2(10, 200))
    if mainIni.config.rank > 1 then
      imgui.RadioButton(u8("Мед.Помощь"), MAction, 1)
    else
      imgui.RadioButton(u8"Мед.Помощь " ..fa.ICON_LOCK, false)
      imgui.HintHovered(u8'Доступно с 2+ ранга')
    end
      imgui.SetCursorPos(imgui.ImVec2(10, 230))
    if mainIni.config.rank > 4 then
      imgui.RadioButton(u8("Cобеседованиe"), MAction, 2)
    else
      imgui.RadioButton(u8"Cобеседованиe " ..fa.ICON_LOCK, false)
      imgui.HintHovered(u8'Доступно с 5+ ранга')
    end
      imgui.SetCursorPos(imgui.ImVec2(10, 260))
    if mainIni.config.rank > 8 then
      imgui.RadioButton(u8("Повышения"), MAction, 3)
    else
      imgui.RadioButton(u8"Повышения " ..fa.ICON_LOCK, false)
      imgui.HintHovered(u8'Доступно с 9+ ранга')
    end
        end
    imgui.End()
  end
  if uval.v then
    imgui.SetNextWindowSize(imgui.ImVec2(335, 205), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Меню увольнения', uval, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)

		imgui.CenterTextColoredRGB('Укажите ID{SSSSSS} игрока и причину{SSSSSS} увольнения')
		imgui.NewLine()
		imgui.SetCursorPosY(65)
		imgui.PushItemWidth(120)
		imgui.InputText(u8"##uninvite_id", uninvite_id, imgui.InputTextFlags.CharsDecimal)
		imgui.PopItemWidth()
		if not imgui.IsItemActive() and #uninvite_id.v == 0 then
			imgui.SameLine(15)
			imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
			imgui.Text(u8'ID')
			imgui.PopStyleColor()
		end
		imgui.PushItemWidth(120)
		imgui.InputText(u8"##uninvite_reason", uninvite_reason)
		imgui.PopItemWidth()
		if not imgui.IsItemActive() and #uninvite_reason.v == 0 then
			imgui.SameLine(15)
			imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
			imgui.Text(u8'Причина')
			imgui.PopStyleColor()
		end
		imgui.PushItemWidth(120)
		imgui.InputText(u8"##bl_reason", bl_reason)
		imgui.HintHovered(u8'Оставьте пустым\nесли без ЧС')
		imgui.PopItemWidth()
		if not imgui.IsItemActive() and #bl_reason.v == 0 then
			imgui.SameLine(15)
			imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.5, 0.5, 0.5, 1))
			imgui.Text(u8'Причина ЧС')
			imgui.PopStyleColor()
		end 
		imgui.SetCursorPos(imgui.ImVec2(140, 65))
		imgui.BeginChild("##UvalInfo", imgui.ImVec2(-1, 68), true, imgui.WindowFlags.NoScrollbar)
		if #uninvite_id.v > 0 then
			if sampIsPlayerConnected(tonumber(uninvite_id.v)) then
				name_uval = '{SSSSSS}'..sampGetPlayerNickname(tonumber(uninvite_id.v))
			else
				name_uval = '{FF0000}Нет на сервере!'
			end
		else
			name_uval = '{565656}Неверный ID'
		end
		imgui.CenterTextColoredRGB('Имя: '..name_uval)
		if #uninvite_reason.v == 0 then
			uval_res = '{565656}Не указана' 
		else 
			if #bl_reason.v == 0 then
				uval_res = u8:decode(uninvite_reason.v) 
			else
				uval_res = u8:decode(uninvite_reason.v)..' + ЧС'
			end
		end
		imgui.CenterTextColoredRGB('Причина: {SSSSSS}'..uval_res)
		if #bl_reason.v == 0 then
			chs_res = '{565656}Без ЧС' 
		else 
			chs_res = '{SSSSSS}'..u8:decode(bl_reason.v)
		end
		imgui.CenterTextColoredRGB('Причина ЧС: '..chs_res)

		imgui.EndChild()
		imgui.NewLine()
		if #uninvite_id.v > 0 and #uninvite_reason.v > 0 then
			if imgui.Button(u8('Уволить ')..fa.ICON_MINUS_CIRCLE, imgui.ImVec2(-1, 40)) then
				uval.v = false
				lua_thread.create(function()
	                sampSendChat('/me достал из кармана КПК и включил его')
	                wait(2500)
	                sampSendChat('/me достал раздел «Сотрудники»')
	                wait(2500)
	                sampSendChat('/me открыл меню сотрудника '..sampGetPlayerNickname(tonumber(uninvite_id.v)))
	                wait(2500)
	                sampSendChat('/me уволил сотрудника из организации')
	                wait(500)
	                sampSendChat('/uninvite '..uninvite_id.v..' '..tostring(uval_res))
	                if #bl_reason.v > 0 then
						wait(2000)
						sampSendChat('/me загрузил раздел «Чёрный список»')
						wait(2500)
						sampSendChat('/me внёс '..sampGetPlayerNickname(tonumber(uninvite_id.v))..' в чёрный список организации')
						wait(500)
						sampSendChat('/blacklist '..uninvite_id.v..' '..tostring(u8:decode(bl_reason.v)))
					end
					uninvite_id.v, uninvite_reason.v, bl_reason.v = '', '', ''
					name_uval, uval_res, chs_res = '', '', ''
	            end)
			end
		end
		imgui.End()
	end
  
end

function main() -- маин
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(tag.. '{FFFFFF}Загружен', -1)
    imgui.Process = false
    sampRegisterChatCommand('mhelp', function()
        main_window_state.v = not main_window_state.v
        imgui.Process = main_window_state.v
    end)
    sampRegisterChatCommand('uval', function(id_player)
      if mainIni.config.rank > 8 then
        if #id_player == 0 then 
          sampAddChatMessage(tag..'Можешь использовать: /uval [id] [Причина] [ЧС Причина (0 если без)]', -1)
          uninvite_id.v, uninvite_reason.v, bl_reason.v = '', '', ''
          name_uval, uval_res, chs_res = '', '', ''
          main_window_state.v = not main_window_state.v
          imgui.Process = main_window_state.v
          uval.v = not uval.v
          imgui.Process = uval.v
        else
          local id_u, reason_u, bl_u = id_player:match('(%d+) (.+) (.+)')
          if tonumber(id_u) and reason_u and bl_u then
            if bl_u == '0' then 
              bl_reason.v = ''
            else
              bl_reason.v = u8(bl_u)
            end
            uninvite_id.v = tostring(id_u)
            uninvite_reason.v = u8(reason_u)
            main_window_state.v = not main_window_state.v
            imgui.Process = main_window_state.v
            uval.v = not uval.v
            imgui.Process = uval.v
          else
            sampAddChatMessage('[Ошибка] /uval [id] [Причина] [ЧС Причина (0 если без)]', -1)
          end
        end
      else
        sampAddChatMessage(tag..'Функция доступна только с 9-ого ранга', -1)
      end
    end)
    

    imgui.SwitchContext()
    style_gray()
    autoupdate("https://raw.githubusercontent.com/NikZakonov410/scripts/master/version.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/NikZakonov410/scripts/master/version.json")
    while true do
        wait(0)
        if testCheat('MM') then
          MainAction.v = 1
          main_window_state.v = not main_window_state.v
          imgui.Process = main_window_state.v
        end
        if testCheat('uval') then
          MainAction.v = 3
          main_window_state.v = not main_window_state.v
          imgui.Process = main_window_state.v
        end
        if isKeyJustPressed(0x52) then
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) --лечение
            if valid and doesCharExist(ped) then
                local result, id = sampGetPlayerIdByCharHandle(ped)
                local _, selfid = sampGetPlayerIdByCharHandle(playerPed) 
	            if result then
                    sampAddChatMessage(tag..'{ffffff}Используй Esc, что бы закрыть меню', -1)
                    actionId = id
                    med_window.v = not med_window.v
                end
                imgui.Process = med_window.v
	        end
        end
        if isKeyJustPressed(0x32) then
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) --лечение
            if valid and doesCharExist(ped) then
                local result, id = sampGetPlayerIdByCharHandle(ped)
	            if result then
                    sampAddChatMessage(tag..'{ffffff}Используй Esc, что бы закрыть меню', -1)
                    actionId = id
                    our_window_state.v = not our_window_state.v
                end
                imgui.Process = our_window_state.v
	        end
        end
        if isKeyJustPressed(0x33) then
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) --лечение
            if valid and doesCharExist(ped) then
                local result, id = sampGetPlayerIdByCharHandle(ped)
	            if result then
                    sampAddChatMessage(tag..'{ffffff}Используй Esc, что бы закрыть меню', -1)
                    actionId = id
                    sobes_window_state.v = not sobes_window_state.v
                end
                imgui.Process = sobes_window_state.v
	        end
      end
    end
end

 function sampev.onServerMessage(color, text)
  if text:find('передал вам 4000 руб.') then
    notify.addNotify('{DC143C}[MedHelper]', 'Нажмите {DC143C}ПКМ + 3 {FFFFFF}что-бы вывести тату', 2, 2, 6)
  end
 end

 function sampev.onServerMessage(color, text)
  if text:find('передал вам 2000 руб.') then
    notify.addNotify('{DC143C}[MedHelper]', 'Нажмите {DC143C}ПКМ + 3 {FFFFFF}что-бы выдать мед.карту', 2, 2, 6)
  end
 end

 function sampev.onServerMessage(color, text)
  if text:find('передал вам 1500 руб.') then
    notify.addNotify('{DC143C}[MedHelper]', 'Нажмите {DC143C}ПКМ + 3 {FFFFFF}что-бы выдать рецепт', 2, 2, 6)
  end
 end

 function sampev.onServerMessage(color, text)
  if text:find('передал вам 1000 руб.') then
    notify.addNotify('{DC143C}[MedHelper]', 'Нажмите {DC143C}ПКМ + 3 {FFFFFF}что-бы выдать аптечку', 2, 2, 6)
  end
 end

function imgui.CenterTextColoredRGB(text)
  local width = imgui.GetWindowWidth()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local ImVec4 = imgui.ImVec4

  local explode_argb = function(argb)
      local a = bit.band(bit.rshift(argb, 24), 0xFF)
      local r = bit.band(bit.rshift(argb, 16), 0xFF)
      local g = bit.band(bit.rshift(argb, 8), 0xFF)
      local b = bit.band(argb, 0xFF)
      return a, r, g, b
  end

  local getcolor = function(color)
      if color:sub(1, 6):upper() == 'SSSSSS' then
          local r, g, b = colors[1].x, colors[1].y, colors[1].z
          local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
          return ImVec4(r, g, b, a / 255)
      end
      local color = type(color) == 'string' and tonumber(color, 16) or color
      if type(color) ~= 'number' then return end
      local r, g, b, a = explode_argb(color)
      return imgui.ImColor(r, g, b, a):GetVec4()
  end

  local render_text = function(text_)
      for w in text_:gmatch('[^\r\n]+') do
          local textsize = w:gsub('{.-}', '')
          local text_width = imgui.CalcTextSize(u8(textsize))
          imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
          local text, colors_, m = {}, {}, 1
          w = w:gsub('{(......)}', '{%1FF}')
          while w:find('{........}') do
              local n, k = w:find('{........}')
              local color = getcolor(w:sub(n + 1, k - 1))
              if color then
                  text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                  colors_[#colors_ + 1] = color
                  m = n
              end
              w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
          end
          if text[0] then
              for i = 0, #text do
                  imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                  imgui.SameLine(nil, 0)
              end
              imgui.NewLine()
          else
              imgui.Text(u8(w))
          end
      end
  end
  render_text(text)
end
function sampev.onSendChat(msg)
 if msg:find('{my_name}') then
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name_without_space = sampGetPlayerNickname(myid):gsub('_', ' ')
  local input_with_name = msg:gsub('{my_name}', name_without_space)
  sampSendChat(input_with_name)
  return false
 end
end
function imgui.HintHovered(text)
  if imgui.IsItemHovered() then
      imgui.BeginTooltip()
      imgui.PushTextWrapPos(450)
      imgui.TextUnformatted(text)
      imgui.PopTextWrapPos()
      imgui.EndTooltip()
  end
end

function greenbtn()
  imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.50, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.00, 0.40, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.00, 0.30, 0.00, 1.00))
end

function redbtn()
  imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.50, 0.00, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.40, 0.00, 0.00, 1.00))
  imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.30, 0.00, 0.00, 1.00))
end

function imgui.PushDisableButton()
	imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.0, 0.0, 0.0, 0.2))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.0, 0.0, 0.0, 0.2))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.0, 0.0, 0.0, 0.2))
end

function imgui.PopDisableButton()
	imgui.PopStyleColor(3)
end

function endbtn()
  imgui.PopStyleColor(3)
end

function imgui.TextColoredRGB(text)
  local style = imgui.GetStyle()
  local colors = style.Colors
  local ImVec4 = imgui.ImVec4

  local explode_argb = function(argb)
      local a = bit.band(bit.rshift(argb, 24), 0xFF)
      local r = bit.band(bit.rshift(argb, 16), 0xFF)
      local g = bit.band(bit.rshift(argb, 8), 0xFF)
      local b = bit.band(argb, 0xFF)
      return a, r, g, b
  end

  local getcolor = function(color)
      if color:sub(1, 6):upper() == 'SSSSSS' then
          local r, g, b = colors[1].x, colors[1].y, colors[1].z
          local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
          return ImVec4(r, g, b, a / 255)
      end
      local color = type(color) == 'string' and tonumber(color, 16) or color
      if type(color) ~= 'number' then return end
      local r, g, b, a = explode_argb(color)
      return imgui.ImColor(r, g, b, a):GetVec4()
  end

  local render_text = function(text_)
      for w in text_:gmatch('[^\r\n]+') do
          local text, colors_, m = {}, {}, 1
          w = w:gsub('{(......)}', '{%1FF}')
          while w:find('{........}') do
              local n, k = w:find('{........}')
              local color = getcolor(w:sub(n + 1, k - 1))
              if color then
                  text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                  colors_[#colors_ + 1] = color
                  m = n
              end
              w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
          end
          if text[0] then
              for i = 0, #text do
                  imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                  imgui.SameLine(nil, 0)
              end
              imgui.NewLine()
          else imgui.Text(u8(w)) end
      end
  end

  render_text(text)
end
local russian_characters = {
  [168] = 'Ё', [184] = 'ё', [192] = 'А', [193] = 'Б', [194] = 'В', [195] = 'Г', [196] = 'Д', [197] = 'Е', [198] = 'Ж', [199] = 'З', [200] = 'И', [201] = 'Й', [202] = 'К', [203] = 'Л', [204] = 'М', [205] = 'Н', [206] = 'О', [207] = 'П', [208] = 'Р', [209] = 'С', [210] = 'Т', [211] = 'У', [212] = 'Ф', [213] = 'Х', [214] = 'Ц', [215] = 'Ч', [216] = 'Ш', [217] = 'Щ', [218] = 'Ъ', [219] = 'Ы', [220] = 'Ь', [221] = 'Э', [222] = 'Ю', [223] = 'Я', [224] = 'а', [225] = 'б', [226] = 'в', [227] = 'г', [228] = 'д', [229] = 'е', [230] = 'ж', [231] = 'з', [232] = 'и', [233] = 'й', [234] = 'к', [235] = 'л', [236] = 'м', [237] = 'н', [238] = 'о', [239] = 'п', [240] = 'р', [241] = 'с', [242] = 'т', [243] = 'у', [244] = 'ф', [245] = 'х', [246] = 'ц', [247] = 'ч', [248] = 'ш', [249] = 'щ', [250] = 'ъ', [251] = 'ы', [252] = 'ь', [253] = 'э', [254] = 'ю', [255] = 'я',
}
function string.rlower(s)
  s = s:lower()
  local strlen = s:len()
  if strlen == 0 then return s end
  s = s:lower()
  local output = ''
  for i = 1, strlen do
      local ch = s:byte(i)
      if ch >= 192 and ch <= 223 then -- upper russian characters
          output = output .. russian_characters[ch + 32]
      elseif ch == 168 then -- Ё
          output = output .. russian_characters[184]
      else
          output = output .. string.char(ch)
      end
  end
  return output
end
function sampev.onServerMessage(clr, msg) -- хук чата
	local other, get_rank = string.match(msg, '(.+) повысил до (%d+) ранга')
	if other and rank ~= nil then
		if tonumber(get_rank) > 0 and tonumber(get_rank) < 10 then
			sampAddChatMessage(tag..'Поздравляем! '..other..' повысил Вас до '..get_rank..' ранга!', -1)
			sampAddChatMessage(tag..'Теперь ваш ранг: '..mainIni.nameRank[tonumber(get_rank)], -1)
			sampAddChatMessage(tag..'Не забудьте сделать скриншот с /time', -1)
			mainIni.config.rank = tonumber(get_rank)
			inicfg.save(mainIni, directIni)
		end
  end
end

function onWindowMessage(msg, wparam, lparam)
  if wparam == vkeys.VK_ESCAPE then 
    if med_window.v then
        consumeWindowMessage(true, true)
        med_window.v = false
      end
      --if bank.v and not binder_open then
        --consumeWindowMessage(true, true)
        --bank.v = false
      --end
      if main_window_state.v then
        consumeWindowMessage(true, true)
        main_window_state.v = false
      end
  end
end
function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((tag..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), -1)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((tag..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end