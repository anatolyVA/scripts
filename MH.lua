script_version(1.0)
script_author("Ник Законов | Центральный Округ")

local dlstatus = require('moonloader').download_status
local sampev = require 'lib.samp.events'
local inicfg = require 'inicfg'
local screenshot = require 'lib.screenshot'
local main_color = 0xDC143C
local main_color_text = "{DC143C}"
local mc, sc, wc = '{006AC2}', '{006D86}', '{FFFFFF}'
local mcx = 0x006AC2
require "lib.moonloader"

update_state = false

local script_vers = 1
local script_vers_text = '1.00'

local update_url = "https://raw.githubusercontent.com/NikZakonov410/scripts/master/update.ini"
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = "https://raw.githubusercontent.com/NikZakonov410/scripts/master/MH.lua"
local script_path = thisScript().path

if not doesFileExist("moonloader/config/mhelper.ini") then--cfg
  inicfg.save(mainIni, "mhelper.ini") end
  
  local mainIni = inicfg.load({
    configIni =
    {
    Nick = "",
    Dol = "",
    Org = ""
    }
    }, "mhelper")

function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(100) end
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Загружен! Версия {DC143C}1.0 {ffffff}by {DC143C}Ник Законов {ffffff}| {DC143C}Центральный Округ",-1)
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Все команды - {DC143C}/mhelp 0",-1)
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Ваше имя - {DC143C}" ..mainIni.config.Nick.. "{ffffff}, Вы - {DC143C}" ..mainIni.config.Dol.. "{ffffff}, {DC143C}"..mainIni.config.Org, -1) 
  sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Приятного использования {DC143C}<3",-1)

  downloadUrlToFile (update_url,update_path, function(id, status)
    if status == dlstatus.STATUS.ENDDOWNLOADDATA then
       updateIni = inicfg.load[nil, update_path)
      if tonumber(updateIni.info.vers) > script_vers then
        sampAddChatMessage('{DC143C}[MedHelper] {ffffff}Требуется обновление! Новая версия: ' ..updateIni.info.vers_text,-1)
        update_state = true
      end
      os.remove(update_path)
    end
  end)

  sampRegisterChatCommand("mhelp", function(arg)
    if #arg == 0 then
      sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Введите /mhelp 0", -1)
    end
    if tonumber(arg) == 0 then
      sampShowDialog(10, "Помощь с MedHelper", "{DC143C}Внимание! {ffffff}За лечение на {DC143C}1-ом {ffffff}ранге, вы можете получить {DC143C}выговор!\n\n{DC143C}ПКМ + 1 {ffffff}- вылечить гражданина\n{DC143C}ПКМ + 2 {ffffff}- вылечить нелегала\n{DC143C}ПКМ + 3 {ffffff}- вылечить сотрудника Прав-ва, ФСБ, МЗ-Ю и ВМУ \n{DC143C}ПКМ + 4 {ffffff}- вылечить сотрудника ГУВД, ГИБДД, ЦБ, МРЭО, РЦ-П, ФСИН\n\n{DC143C}ПКМ + 5-8 {ffffff}нажимать {DC143C}ПОСЛЕ {ffffff}нажатия {DC143C}ПКМ + Z\n\n{DC143C}ПКМ + 5 {ffffff}- выдать мед.карту\n{DC143C}ПКМ + 6 {ffffff}- выдать рецепт\n{DC143C}ПКМ + 7 {ffffff}- свести тату\n{DC143C}ПКМ + 8 {ffffff}- выдать аптечку\n\n{DC143C}ПКМ + NumPad0 {ffffff}- Начать собеседование\n{DC143C}ПКМ + NumPad1 {ffffff}- Проверить документ(после отправки игроком кмд)\n{DC143C}ПКМ + NumPad 2 {ffffff}- Провести мини-опрос\n{DC143C}ПКМ + NumPad 3 {ffffff}- Принять в организацию\n{DC143C}ПКМ + NumPad 4 {ffffff}- Отказать в принятии\n\n{DC143C}ПКМ + Z {ffffff}- Запросить деньги за услуги(5-8)\n\nПровести лекции - /lec1 /lec2 /lec3\n\nДля изменения {DC143C}имени{ffffff}, {DC143C}должности {ffffff}и {DC143C}организации {ffffff}откройте файл {DC143C}MHELP.TXT{ffffff}, там всё написано", "Закрыть", "Закрыть", 0)
    end
  end)
	sampRegisterChatCommand('scrheal', function(fileName) -- /savescreen либо /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/Вылечил', fileName) -- путь сохранения будет: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrmedcard', function(fileName) -- /savescreen либо /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/Выдал мед-карты', fileName) -- путь сохранения будет: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrrecept', function(fileName) -- /savescreen либо /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/Выдал рецепты', fileName) -- путь сохранения будет: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrunstuff', function(fileName) -- /savescreen либо /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/HEAL', fileName) -- путь сохранения будет: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
  end)
  sampRegisterChatCommand('scrsellmed', function(fileName) -- /savescreen либо /savescreen <name>
		if fileName:len() > 0 then
			screenshot.requestEx('MedHelper/HEAL', fileName) -- путь сохранения будет: /GTA San Andreas User Files/App screens/example/
		else
			screenshot.request()
		end		
	end)		
	
  wait(-1)
  
  while true do 
   wait(0)

    if update_state then
      downloadUrlToFile (script_url,script_path, function(id, status)
        if status == dlstatus.STATUS.ENDDOWNLOADDATA then
          sampAddChatMessage('{DC143C}[MedHelper] {ffffff}Скрипт успешно обновлен!', -1)
          thisScript():reload()    
        end
      end)
      break
    end

   local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_1) then
         sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.Nick.. ", я Ваш лечащий врач", -1)
          wait(900)
         sampSendChat("/do На груди бейджик, на нём написано: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
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
         sampSendChat("/heal " ..id.. ' 1000', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Запрос на лечение ID - {DC143C}[" ..id.. "] {FFFFFF}отправлен.", -1)
          wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_2) then
          sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.Nick.. ", я Ваш лечащий врач", -1)
          wait(900)
         sampSendChat("/do На груди бейджик, на нём написано: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
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
         sampSendChat("/heal " ..id.. ' 1000', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Запрос на лечение ID - {DC143C}[" ..id.. "] {FFFFFF}отправлен.", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
         sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_3) then
          sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.Nick.. ", я Ваш лечащий врач", -1)
          wait(900)
         sampSendChat("/do На груди бейджик, на нём написано: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
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
         sampSendChat("/heal " ..id.. ' 250', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Запрос на лечение ID - {FFFF00}[" ..id.. "] {FFFFFF}отправлен.", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_4) then
          sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.Nick.. ", я Ваш лечащий врач", -1)
          wait(900)
         sampSendChat("/do На груди бейджик, на нём написано: " ..mainIni.config.Nick.. " - " ..mainIni.config.Dol.. " " ..mainIni.config.Org, -1)
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
         sampSendChat("/heal " ..id.. ' 500', -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Запрос на лечение ID - {4169E1}[" ..id.. "] {FFFFFF}отправлен.", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrheal heal')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_5) then
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
          sampSendChat("/medcard " ..id.. " 3", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы выдали мед.карту ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrmedcard medcard')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_6) then
          sampSendChat("Хорошо, вы оплатили нужную сумму, сейчас я выдам вам рецепты", -1)
          wait(900) 
          sampSendChat("/do В мед.сумке лежат чистые рецепты", -1)
          wait(900)
          sampSendChat("/me подписав рецепт, отдал его гражданину", -1)
          wait(900) 
          sampSendChat("Вот ваши рецепты.", -1)
          wait(900)  
          sampSendChat("/recept " ..id, -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы выдали рецепт ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrrecept recept')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_7) then
         sampSendChat("/do Аппарат для вышивки тату на столе.", -1)
          wait(900) 
          sampSendChat("me взял аппарат для извлечения тату.", -1)
          wait(900)
          sampSendChat("/do Аппарат в правой руке.", -1)
          wait(900) 
          sampSendChat("/me начал выводить тату.", -1)
          wait(900)
          sampSendChat("Все, ваш сеанс окончен. Всего Вам доброго.", -1)
          wait(900) 
          sampSendChat("/unstuff " ..id.. " 4000", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы начали сводить тату ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrunstuff unstuff')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_8) then
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
          sampSendChat("/sellmed " ..id.. " 5", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы выдали аптечку ID {DC143C}[" ..id.. "]", -1)
         wait(900)
         sampSendChat("/time")
          wait(900)
          sampSendChat('/scrsellmed sellmed')
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
      _, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if result and isKeyJustPressed(VK_Z) then
          sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.Nick.. ", я Ваш лечащий врач", -1)
          wait(900) 
          sampSendChat("В данный момент у нас следующая ценовая политика..", -1)
          wait(900)
          sampSendChat("..Мед карты - 2000руб. Рецепт - 1500руб.", -1)
          wait(900) 
          sampSendChat("Аптечка - 1000руб. Свести тату - 4000руб.", -1)
          wait(900)
          sampSendChat("Прошу Вас передать мне нужную сумму.", -1)
          wait(900)
          sampSendChat("/b /pay " ..myID.. " сумма", -1)
          wait(900) 
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Ожидайте поступления денег на Ваш счёт от ID {DC143C}[" ..id.. "]", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
      _, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if result and isKeyJustPressed(VK_NUMPAD0) then
          sampSendChat("Здравствуйте, меня зовут " ..mainIni.config.Nick.. ", я "..mainIni.config.Dol.. "этой больницы", -1)
          wait(900) 
          sampSendChat("Вы пришли на собеседование?", -1)
          wait(900)
          sampSendChat("Если да, то покажите мне такие документы: паспорт, мед.карту и лицензии.", -1)
          wait(900) 
          sampSendChat("/b По РП, используя команды /showpass " ..myID.. " /showmc " ..myID.. " /showlic " ..myID, -1)
          wait(900)
          sampSendChat("/b Наркозависимость - не более 5.", -1) 
          wait(900) 
          sampSendChat("/b Лицензии - на вод. права, законопослушность не меньше 35.", -1) 
          wait(900) 
          sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы начали собеседование для ID {DC143C}[" ..id.. "]", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD1) then
          sampSendChat("/do На столе лежит документ гражданина", -1)
            wait(900)
          sampSendChat("/me открыл документ на 2-й странице", -1)
            wait(900)
          sampSendChat("/do Страница открыта", -1)
            wait(900)
          setVirtualKeyDown(VK_Y, true)
            wait(900)
          setVirtualKeyDown(VK_Y, false)
            wait(900)
          sampSendChat("/me изучил данную страницу", -1)
            wait(900)
          sampSendChat("/do Страница изучена", -1)
            wait(900)
          sampSendChat("/me вернул документ владельцу", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Тщательно проверьте документ!", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD3) then
          sampSendChat("Хорошо, я думаю вы нам подходите!", -1)
          wait(900) 
          sampSendChat("/me достал форму", -1)
          wait(900)
          sampSendChat("/do Форма в руках.", -1)
          wait(900) 
          sampSendChat("/me выдал форму человеку на против", -1)
          wait(900)
          sampSendChat("Вот ваша новая форма!", -1)
          wait(900) 
          sampSendChat("/invite " ..id, -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы приняли в организацию ID {DC143C}[" ..id.. "]", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD2) then
          sampSendChat("Хорошо, документы в порядке. Перейдём к следующему этапу.. Я задам вам пару вопросов", -1)
          wait(900) 
          sampSendChat("Охарактеризуйте себя 3-мя словами.", -1)
          wait(900)
          sampSendChat("Был ли у Вас опыт в сфере здравоохранения?", -1)
          wait(900) 
          sampSendChat("/b Различаете ли вы чаты?", -1)
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы задали вопросы ID {DC143C}[" ..id.. "] {ffffff}ожидайте ответы", -1)
        end
    end
    local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if valid and doesCharExist(ped) then
      local result, id = sampGetPlayerIdByCharHandle(ped)
        if result and isKeyJustPressed(VK_NUMPAD4) then
          sampSendChat("К сожалению Вы нам не подходите.", -1)
          wait(900) 
          sampSendChat("/b Лидер организации имеет право выбирать состав на своё усмотрение, но так-же..", -1)
          wait(900)
          sampSendChat("/b ..причиной может быть: МГ, несоответствие минимальным требованиям для приёма..", -1)
          wait(900) 
          sampSendChat("/b ..не отыгровка РП, наркозависимость более 5. Все критерии можете посмотреть на форуме Rodina RP", -1)
          wait(900) 
          sampSendChat("Ждём Вас на следующем собеседовании!", -1)
        wait(900) 
         sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Вы закончили собеседование с ID {DC143C}[" ..id.. "] {ffffff}Причина: отказ", -1)
        end
    end
    local result, button, list, input = sampHasDialogRespond(10)
    if result then 
      if button == 1 then
        sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Приятной игры {DC143C}<3", -1)
      else
        sampAddChatMessage("{DC143C}[MedHelper] {ffffff}Приятной игры {DC143C}<3", -1)
      end
    end
  end
end
