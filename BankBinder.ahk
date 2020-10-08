buildscr = 2 ;версия для сравнения, если меньше чем в ver.ini - обновляем
downlurl := "https://raw.githubusercontent.com/NikZakonov410/scripts/master/upb.ahk"
downllen := "https://raw.githubusercontent.com/NikZakonov410/scripts/master/bankver.ini"

Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
    If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
        BOM = 3
    Else
        BOM = 0

    UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "Int", 0, "Int", 0)
    VarSetCapacity(UniBuf, UniSize * 2)
    DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "UInt", &UniBuf, "Int", UniSize)

    AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Int", 0, "Int", 0
                    , "Int", 0, "Int", 0)
    VarSetCapacity(AnsiString, AnsiSize)
    DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Str", AnsiString, "Int", AnsiSize
                    , "Int", 0, "Int", 0)
    Return AnsiString
}
WM_HELP(){
    IniRead, vupd, %a_temp%/ver.ini, UPD, v
    IniRead, desupd, %a_temp%/ver.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, update, %a_temp%/ver.ini, UPD, upd
    msgbox, Список изменений версии %vupd%`n%update%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nПроверяем наличие обновлений.
URLDownloadToFile, %downllen%, %a_temp%/ver.ini
IniRead, buildupd, %a_temp%/ver.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОшибка. Нет связи с сервером.
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/ver.ini, UPD, v
    SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОбнаружено обновление до версии %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/ver.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/ver.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    SplashTextoff
    msgbox, 16384, Обновление скрипта до версии %vupd%, %desupd%
    IfMsgBox OK
    {
        msgbox, 1, Обновление скрипта до версии %vupd%, Хотите ли Вы обновиться?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nОбновляем скрипт до версии %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/up.exe
            sleep, 1000
            run, %a_temp%/up.exe
            exitapp
        }
    }
}
SplashTextoff
IfnotExist, %A_ScriptDir%\Bb ;Если такой капки нет, то...
{
 FileCreateDir, %A_ScriptDir%\Bb ;Он создает эту папку
}
IfnotExist, %A_ScriptDir%\Bb\bank.ini ;Если такого файла нет, то...
{
URLDownloadToFile, https://raw.githubusercontent.com/NikZakonov410/scripts/master/bank.ini, %A_ScriptDir%\Bb\bank.ini ;Он этот файл скачивает
}
IfnotExist, %A_ScriptDir%\bhelp.txt ;Если такого файла нет, то...
{
URLDownloadToFile, https://raw.githubusercontent.com/NikZakonov410/scripts/master/bhelp.txt, %A_ScriptDir%\bhelp.txt ;Он этот файл скачивает
}


IniRead, name, Bb\bank.ini, main, n
IniRead, delay, Bb\bank.ini, main, d

IniRead, r, Bb\bank.ini, main, r
IniRead, forg, Bb\bank.ini, main, forg
IniRead, rankname, Bb\bank.ini, main, rankname
 if r = 1
 rankname = Охранник 
 if r = 2
 rankname = Сотрудник Банка
 if r = 3
 rankname = Ст.Охранник
 if r = 4
 rankname = Ст.Сотрудник Банка
 if r = 5
 rankname = Нач. Охраны
 if r = 6
 rankname = Нач. Отдела Сбережений
 if r = 7
 rankname = Зав. Отдела Сбережений
 if r = 8
 rankname = Менеджер
 if r = 9
 rankname = Зам.Директора
 if r = 10
 rankname = Директор
SendMessage, 0x50,, 0x4190419,, A
Gui, Font, S15 CDefault Bold, Trebuchet MS
Gui, Add, Text, x65 y9 w110 h30 ,  Настройки
Gui, Font, S10 CDefault Bold, Trebuchet MS
Gui, Add, Button, x25 y169 w180 h30 gKeyR, Ввести ранг(1-10)
Gui, Add, Button, x25 y129 w180 h30 gKeyS, Ввести задержку
Gui, Add, Button, x25 y89 w180 h30 gKeyN, Ввести Ник-Нейм
Gui, Add, Button, x2 y229 w60 h30 gKeyOK, OK
Gui, Add, Button, x167 y229 w60 h30 gKeyI, INFO
; Generated using SmartGUI Creator 4.0
Gui, Show, x497 y241 h262 w230, BankBinder
Return

GuiClose:
ExitApp

keyN:
InputBox, ni, Ник Нейм, Введите свой ник.`nВаш нынешний ник - %name%
IniWrite, %ni%, Bb\bank.ini, main, n
return
keyR:
InputBox, fN, Ранк, Введите свой ранк(1-10).`nНа данный момент вы %rankname%[%r%]
IniWrite, %fN%, Bb\bank.ini, main, r
reload
return
keyS:
InputBox, S, Задержка, Введите задержку(Пример: 1000) 1000 = 1 секунда.`nВаша задержка - %delay%
IniWrite, %S%, Bb\bank.ini, main, d
return
keyOK:
gui,Minimize
return
keyI:
MsgBox, 64, INFO, Скрипт создан для Сбербанка Центрального Округа. Создатель - Ник Законов`n(@sukhankov - VK)`nВсю информацию по командам, вы можете посмотреть в текстовом документе, который скачается после запуска скрипта.                                
return


  :?:/p:: 
  SendMessage, 0x50,, 0x4190419,, A
  IniRead, r, Bb\bank.ini, main, r
  SendInput, {F6}{Enter}
  SendInput, {F6}Здравствуйте, меня зовут %name%, я %rankname% СберБанка {Enter}
  sleep %delay%
  SendInput, {F6}Чем я могу вам помочь? {Enter}
  return
  :?:/dep:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 4
  {
  Sendinput, {F6}Хорошо, сейчас я помогу Вам с депозитом{Enter}
   Sleep %delay%
  Sendinput, {F6}/do На столе стоит компьютер.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me распечатав бланк для заполнения, передал его гражданину.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Бланк находится у гражданина.{Enter}
   Sleep %delay%
  Sendinput, {F6}/todo Хорошо, заполните его*указывая на нужны строчки{Enter}
   Sleep %delay%
  Sendinput, {F6}/bankmenu{space}
  }
  if r < 5
   {
   SendInput, {F6}Извините, но я не могу помочь Вам с депозитом, сейчас позову старших. {Enter}
   sleep %delay%
   SendInput, {F6}/r Прошу подойти старших к стойке и помочь гражданину с депозитом. {enter}
   }
  return
  
  :?:/card:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 4
  {
   Sleep %delay%
  Sendinput, {F6}Хорошо, сейчас я оформлю Вам бановскую карту.{Enter}
   Sleep %delay%
  Sendinput, {F6}Т.к у нас уже есть ваши данные, мы быстро оформим Вам карту{Enter}
   Sleep %delay%
  Sendinput, {F6}/do В компьютере находятся данные гражданина.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me зайдя в раздел "Карты", активировал нужную.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Карта активирована.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me достав из под стола карту, передал её гражданину{Enter}
   Sleep %delay%
  Sendinput, {F6}/todo Вот ваша карта{!}*передавая карту{Enter}
  Sleep %delay%
  Sendinput, {F6}/bankmenu{Space}
  }
  if r < 5
   {
   SendInput, {F6}Для получения карты, зайдите в кабинет справа от кассы. {Enter}
   }
  return
  :?:/credit1:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 5
  {
  Sendinput, {F6}Хорошо, давайте оформим Вам кредит.{Enter}
   Sleep %delay%
  Sendinput, {F6}Для получения кредита, Вам нужна передать мне паспорт{Enter}
   Sleep %delay%
  Sendinput, {F6}Так-же напомню, максимальная сумма кредита 100.000руб.{Enter}
  }
  if r < 6
   {
   SendInput, {F6}Извините, но я не могу выдать Вам кредит, сейчас позову старших {Enter}
   sleep %delay%
   SendInput, {F6}/r Нужно выдать кредит гражданину, прошу подойти старших к стойке.{enter}
   }
  return
    :?:/credit2:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 5
  {
  Sendinput, {F6}/me взял паспорт у гражданина.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Паспорт на столе.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ввел нужны данные в компьютер.{Enter}
     Sleep %delay%
  Sendinput, {F6}/do Данные в компьютере{Enter}
     Sleep %delay%
  Sendinput, {F6}/me распечатав бланк, передал его гражданину напротив{Enter}
       Sleep %delay%
  Sendinput, {F6}/todo Распишитесь вот тут и кредит Ваш*указывая на строчки{Enter}
       Sleep %delay%
  Sendinput, {F6}/bankmenu{space}
  }
  if r < 6
   {
   SendInput, {F6}{enter}
   }
  return
  :?:/pcard:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 4
  {
  Sendinput, {F6}Хорошо, сейчас я помогу Вам восстановить пин-код{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Компьютер находится на столе.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ввел нужны данные в компьютер.{Enter}
     Sleep %delay%
  Sendinput, {F6}/do Данные в компьютере{Enter}
     Sleep %delay%
  Sendinput, {F6}/me зашёл в личные кабинет гражданина, и через root права запустил процесс восстановления{Enter}
       Sleep %delay%
  Sendinput, {F6}Введите пароль в эту онлайн-кассу{Enter}
       Sleep %delay%
  Sendinput, {F6}/bankmenu{space}
  }
  if r < 5
   {
     Sendinput, {F6}Я не могу сменить Вам пин-код, сейчас позову старших{Enter}
   Sleep %delay%
  Sendinput, {F6}/r Прошу старших подойти к стойке и помочь сменить пин-код гражданину.{Enter}
   Sleep %delay%
   }
  return
   :?:/sob:: 
   IniRead, r, Bb\bank.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   if r > 4
   {
   SendInput, {F6}Здравствуйте, предоставьте мне пожалуйста ваши документы, а именно.. {Enter}
     sleep %delay%
   SendInput, {F6}..паспорт, мед.карту и лицензию на вождение{Enter}
     sleep %delay%
   SendInput, {F6}/b Критерии: 3 LVL, 35 законопослушность, не больше 5 наркозависимости {Enter}
     sleep %delay%
   SendInput, {F6}/b Все документы отыгрывать по РП{!} {Enter}
   }
   if r < 5
   {
   SendInput, {F6}Извините, я не могу проводить собеседование, сейчас позову старших {Enter}
     sleep %delay%
   SendInput, {F6}/r Гражданин пришёл на собеседование, прошу подойти старших к стойке {enter}
   }
   
   return
   :?:/sobq:: 
   IniRead, r, Bb\bank.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}Хорошо, теперь я задам Вам пару вопросов {Enter}
     sleep %delay%
   SendInput, {F6}Работали ли вы прежде в Сбербанке?{Enter}
     sleep %delay%
   SendInput, {F6}Проходили ли вы обучени в эконом. ВУЗе?{Enter}
     sleep %delay%
   SendInput, {F6}Готовы ли вы соблюдать устав Сбербанка и выполнять все требования начальства?{Enter}
   return
    :?:/sobtest:: 
   IniRead, r, Bb\bank.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}Хорошо, представим такую ситуацию..{Enter}
     sleep %delay%
   SendInput, {F6}Вы - сотрудник банка, к Вам приходит клиент и просит выдать ему кредит{Enter}
     sleep %delay%
   SendInput, {F6}Как вы заполните бланк?{Enter}
     sleep %delay%
   SendInput, {F6}/me передал бланк{Enter}
   return
       :?:/sobtest2:: 
   IniRead, r, Bb\bank.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}Отлично, допустим к Вам приезжает работник налоговой и просит выдать ему деньги{Enter}
     sleep %delay%
   SendInput, {F6}Как Вы поступите?{Enter}
   return
   :?:/tpass:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do Паспорт на столе {Enter}
     sleep %delay%
   SendInput, {F6}/me взял паспорт в руки {Enter}
     sleep %delay%
   SendInput, {F6}/do Паспорт в руках{Enter}
     sleep %delay%
   SendInput, {F6}/me открыв паспорт на второй странице, просмотрел нужные данные {Enter}
     sleep %delay%
   SendInput, {F6}/do Паспорт проверен {Enter}
     sleep %delay%
   SendInput, {F6}/todo Хорошо*возвращая паспорт {Enter}
   return
   :?:/tlic:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do Лицензия авто на столе {Enter}
     sleep %delay%
   SendInput, {F6}/me взял лицензию в руки {Enter}
     sleep %delay%
   SendInput, {F6}/do Лицензия в руках{Enter}
     sleep %delay%
   SendInput, {F6}/me взяв лицензию, проверил её на подлинность {Enter}
     sleep %delay%
   SendInput, {F6}/do Лицензия проверена {Enter}
     sleep %delay%
   SendInput, {F6}/todo Так..*возвращая лицензию {Enter}
   return
   :?:/tmed:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do Мед.карта на столе {Enter}
     sleep %delay%
   SendInput, {F6}/me взял мед.карту в руки {Enter}
     sleep %delay%
   SendInput, {F6}/do Мед.карта в руках{Enter}
     sleep %delay%
   SendInput, {F6}/me открыв мед.карту, проверил историю заболеваний {Enter}
     sleep %delay%
   SendInput, {F6}/do Мед.карта проверена {Enter}
     sleep %delay%
   SendInput, {F6}/todo Отлично*возвращая мед.карту {Enter}
   return
   :?:/inv:: 
   IniRead, r, Bb\bank.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}Поздравляю, Вы нам подходите{!} {Enter}
     sleep %delay%
   SendInput, {F6}/do В шкафчике лежат бейджики {Enter}
     sleep %delay%
   SendInput, {F6}/me взяв бейджик, вписал туда должность, имя и фамилию{Enter}
     sleep %delay%
   SendInput, {F6}/do Бейджик готов {Enter}
     sleep %delay%
   SendInput, {F6}/me передал бейджик новому работнику {Enter}
     sleep %delay%
      SendInput, {F6}Вы - охранник, ваша задача следить за порядком и направлять клиентов к нужной кассе.{Enter}
     sleep %delay%
           SendInput, {F6}Для повышения вы должны выполнить ряд поручений, зайдите ко мне в кабинет что-бы их получить{Enter}
     sleep %delay%
   if r > 8
   {
   SendInput, {F6}/invite{space}
   }
   if r < 9
   {
   SendInput, {F6}/rb Примите в организацию ID {space}
   }
   return
   :?:/otkl:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}К сожалению, Вы нам не подходите {Enter}
     sleep %delay%
   SendInput, {F6}/b Возможные причины отказа: {Enter}
     sleep %delay%
   SendInput, {F6}/b Не подходите по критериям, Нон РП, псих.растройства{Enter}
     sleep %delay%
   SendInput, {F6}Приходите ещё! {Enter}
   return
  
  :?:/grank:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 8
  {
  SendInput, {F6}Поздравляю Вас с повышением{!} {Enter}
    sleep %delay%
  SendInput, {F6}/do Новый бейджик в руках {Enter}
    sleep %delay%
  SendInput, {F6}/me передал бейджик сотруднику {Enter}
    sleep %delay%
  SendInput, {F6}/giverank{space}
  }
  if r < 9
  {
  SendInput, {F6}Я не могу Вас повысить {Enter}
  }
  return
  :?:/fw:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 6
  {
  SendInput, {F6}/do Планшет в руке {Enter}
    sleep %delay%
  SendInput, {F6}/me зайдя в личное дело сотрудника, выдал ему выговор {Enter}
    sleep %delay%
  SendInput, {F6}/do Сотруднику начислен выговор {Enter}
    sleep %delay%
  SendInput, {F6}/fwarn{space}
  }
  if r < 7
  {
  SendInput, {F6}Я не могу выдать выговор{enter}
  }
  return
  :?:/ufw:: 
  IniRead, r, Bb\bank.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 8
  {
  SendInput, {F6}/do Планшет в руке {Enter}
  sleep %delay%
  SendInput, {F6}/me зайдя в личное дело сотрудника, снял ему выговор {Enter}
  sleep %delay%
  SendInput, {F6}/do У сотрудника -1 выговор {Enter}
  sleep %delay%
  SendInput, {F6}/unfwarn{space}
  }
  if r < 9
  {
  SendInput, {F6}Я не могу снять выговор{enter}
  }
  return
  :?:-треня:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}Уважаемые сотрудники, сейчас я проведу вам тренировку. {Enter}
     Sleep %delay%
    SendInput, {F6}Начнем с разминки...{Enter}
     Sleep %delay%
    SendInput, {F6}20 приседаний и 30 отжиманий.{Enter}
     Sleep %delay%
    SendInput, {F6}Закончили, теперь бегом вокруг больницы{space}
  Return
  :?:/reload:: 
  Reload


!Home::
Process, Close, gta_sa.exe
Process, Close, bdcam.exe
return
; --------------------Отдел биндов---------------------------

