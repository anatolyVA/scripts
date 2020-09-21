TrayTip,MedBinder

IfnotExist, %A_ScriptDir%\MB ;Если такой капки нет, то...
{
 FileCreateDir, %A_ScriptDir%\MB ;Он создает эту папку
}

Filedelete, %A_ScriptDir%\MB\MedBinder.exe ;Команда для удаления вашего скрипта для скачивания новой версии
IfnotExist, %A_ScriptDir%\MB\MedBinder.exe ;Если такого файла нет, то...
{
URLDownloadToFile, https://raw.githubusercontent.com/NikZakonov410/scripts/master/MedBinder.ahk,%A_ScriptDir%\MedBinder.ahk ;Он скачивает ваш скрипт по ссылке
TrayTip,Проверка обновлений,Подождите 2 секунд ;Подсказка в трее
sleep 2000 ;Задержка между командами 5 секунд
Run,%A_ScriptDir%\MedBinder.ahk ;Запуск вашего скрипта


IniRead, name, med.ini, main, n
IniRead, delay, med.ini, main, d

IniRead, r, med.ini, main, r
IniRead, forg, med.ini, main, forg
IniRead, rankname, med.ini, main, rankname
if r = 1
rankname = Интерн 
if r = 2
rankname = Участковый врач
if r = 3
rankname = Терапевт
if r = 4
rankname = Нарколог
if r = 5
rankname = Окулист
if r = 6
rankname = Хирург
if r = 7
rankname = Психолог
if r = 8
rankname = Зав. Отделением
if r = 9
rankname = Зам.Глав.Врача
if r = 10
rankname = Глав.Врач

SendMessage, 0x50,, 0x4190419,, A
Gui, Font, S15 CDefault Bold, Trebuchet MS
Gui, Add, Text, x65 y9 w110 h30 ,  Настройки
Gui, Font, S10 CDefault Bold, Trebuchet MS
Gui, Add, Button, x26 y169 w180 h30 gKeyR, Ввести ранг(1-10)
Gui, Add, Button, x26 y129 w180 h30 gKeyS, Ввести задержку
Gui, Add, Button, x26 y89 w180 h30 gKeyN, Ввести Ник-Нейм
Gui, Add, Button, x26 y49 w180 h30 gKeyO, Ввести название орг.
Gui, Add, Button, x2 y229 w60 h30 gKeyOK, OK
Gui, Add, Button, x167 y229 w60 h30 gKeyI, INFO
; Generated using SmartGUI Creator 4.0
Gui, Show, x497 y241 h262 w230, MedBinder
Return

GuiClose:
ExitApp

keyN:
InputBox, ni, Ник Нейм, Введите свой ник. Ваш нынешний ник - %name%
IniWrite, %ni%, med.ini, main, n
return
keyR:
InputBox, fN, Ранк, Введите свой ранк(1-10). На данный момент вы     %rankname%[%r%]
IniWrite, %fN%, med.ini, main, r
reload
return
keyS:
InputBox, S, Задержка, Введите задержку(Пример: 1000) 1000 = 1 секунда. Ваша задержка - %delay%
IniWrite, %S%, med.ini, main, d
return
keyO:
InputBox, Org, Организация, Введите название своей организации. Ваша нынешняя организация - %forg% 
IniWrite, %Org%, med.ini, main, forg
return
keyOK:
gui,Minimize
return
keyI:
n=                                                  .
MsgBox, 64, INFO, Скрипт создан для МЗ структур Центрального Округа. Создатель - Ник Законов(@sukhankov - VK)                                       Всю информацию по командам, вы можете посмотреть в текстовом документе, который прилогается к архиву                                   
return


  :?*:/p:: 
  SendMessage, 0x50,, 0x4190419,, A
  IniRead, r, med.ini, main, r
  SendInput, {F6}{Enter}
  SendInput, {F6}Здравствуйте, меня зовут %name%, я %rankname% %forg% {Enter}
  sleep %delay%
  SendInput, {F6}Чем я могу вам помочь? {Enter}
  return
  :?*:/h:: 
  IniRead, r, med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 1
  {
  Sendinput, {F6}Хорошо, сейчас я выдам вам лекарство, в течение 10 минут вам должно быть легче.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Докторский ридикюль в руках.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me резким движением правой руки, открыл(а) ридикюль.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Докторский ридикюль открыт.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me протянул(а) руку, после чего взял(а) лекарство "Анальгин"{Enter}
   Sleep %delay%
  Sendinput, {F6}Держите лекарство, благодаря ему вам должно полегчать.{Enter}
   Sleep %delay%
  Sendinput, {F6}/heal {Space}
   Sleep %delay%

  }
  if r < 2
   {
   SendInput, {F6}Извините, но я не могу Вас вылечить, сейчас позову старших {Enter}
   sleep %delay%
   SendInput, {F6}/r Нужно вылечить гражданина, прошу подойти старших в палату {enter}
   }
  return
  
  :?*:/utatu:: 
  IniRead, r, med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 5
  {
   Sleep %delay%
  Sendinput, {F6}Отлично, оголяйте место татуировки.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b /showtatu{Enter}
   Sleep %delay%
  Sendinput, {F6}/me запустил(а) лазерный аппарат MV-110{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Аппарат запущен.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me одел(а) перчатки, после чего взял(а) аппарат в руку{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Перчатки одеты, аппарат в руке.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me плавным движением, начал(а) водить аппаратом по рисунку{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Рисунок потерял свой изначальный цвет.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Мазь "Пантенол" стоит в закрытом виде на столе.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me резким движением взял(а) мазь, после чего открыл(а) ее{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Мазь в открытом виде находится в руке.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me аккуратным движением нанес(ла) мазь, после чего покрыл(а) пленкой{Enter}
   Sleep %delay%
  Sendinput, {F6}Все, не снимайте пленку до следующего сеанса.{Enter}
   Sleep %delay%
  Sendinput, {F6}/unstuff 7000{Space}
   Sleep %delay%

  }
  if r < 6
   {
   SendInput, {F6}Извините, но я не могу снять вам тату, сейчас позову старших {Enter}
   sleep %delay%
   SendInput, {F6}/r Нужно снять тату гражданина, прошу подойти старших в кабинет хирурга {enter}
   }
  return
  :?*:/medc:: 
  IniRead, r, med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 2
  {
  Sendinput, {F6}Здравствуйте, вы пришли за мед.картой?{Enter}
   Sleep %delay%
  Sendinput, {F6}Хорошо, на заполнение мед.карты уйдет немного времени.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Бумага "Артикул МП-200" лежит на столе.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me протянул(а) руку за листом бумаги{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Лист бумаги в руке.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me вставил(а) лист бумаги в принтер{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Лист бумаги в принтере.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me начал(а) заполнять форму мед.карты через портативный компьютер{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Форма мед.карты готова к распечатке.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me нажал(а) кнопку "печать" после чего распечал(а) мед.карту{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Мед.карта распечатана.{Enter}
   Sleep %delay%
  Sendinput, {F6}Ваша мед.карта готова к использованию.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b Чтобы вам выдали мед.карту, вам нужно ее оплатить.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b /pay id 3000.{Enter}
   Sleep %delay%
  Sendinput, {F6}/medcard{Space}
   Sleep %delay%

  }
  if r < 3
   {
   SendInput, {F6}Извините, но я не могу выдать Вам мед.карту, сейчас позову старших {Enter}
   sleep %delay%
   SendInput, {F6}/r Нужно выдать мед.карту гражданину, прошу подойти старших в палату {enter}
   }
  return
  :?*:/apt:: 
  IniRead, r, med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 5
  {
  Sendinput, {F6}Здравствуйте, вы пришли за аптечкой?{Enter}
   Sleep %delay%
  Sendinput, {F6}Хорошо, сейчас я выдам вам комплект аптечек.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Комплектация аптечек лежит в сейфе, под столом.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me ввел(а) пароль от сейфа, после чего достал(а) нужное кол-во комплектации{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Комплектация аптечек лежит на столе.{Enter}
   Sleep %delay%
  Sendinput, {F6}Держите ваш комплект аптечек, перед тем как его забрать, вам нужно поставить вот тут подпись.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me показал(а) пальцем на место для росписи{Enter}
   Sleep %delay%
  Sendinput, {F6}/sellmed{Space}
   Sleep %delay%

  }
  if r < 6
   {
   SendInput, {F6}Извините, но я не могу выдать Вам аптечку, сейчас позову старших {Enter}
   sleep %delay%
   SendInput, {F6}/r Нужно выдать аптечку гражданину, прошу подойти старших в палату {enter}
   }
  return
  :?*:/rec:: 
  IniRead, r, med.ini, main, r
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
  if r > 3
  {
  Sendinput, {F6}Хорошо, на заполнение рецепта уйдет немного времени.{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Бумага "А4" лежит на столе.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me протянул(а) руку за листом бумаги{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Лист бумаги в руке.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me вставил(а) лист бумаги в принтер{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Лист бумаги в принтере.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me начал(а) заполнении анатации через портативный компьютер{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Анатация готова к распечатке.{Enter}
   Sleep %delay%
  Sendinput, {F6}/me нажал(а) кнопку "печать" после чего распечал(а) анатацию{Enter}
   Sleep %delay%
  Sendinput, {F6}/do Анатация распечатана.{Enter}
   Sleep %delay%
  Sendinput, {F6}Ваша анатация готова к использованию.{Enter}
   Sleep %delay%
  Sendinput, {F6}Чтобы вам выдали анатацию, вам нужно ее оплатить.{Enter}
   Sleep %delay%
  Sendinput, {F6}/b /pay id 1500.{Enter}
   Sleep %delay%
  Sendinput, {F6}/recept{Space}
   Sleep %delay%

  }
  if r < 4
   {
   SendInput, {F6}Извините, но я не могу выдать Вам рецепт, сейчас позову старших {Enter}
   sleep %delay%
   SendInput, {F6}/r Нужно выдать рецепт гражданину, прошу подойти старших в палату {enter}
   }
  return
   :?*:/sob:: 
   IniRead, r, med.ini, main, r
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
   :?*:/tpass:: 
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
   SendInput, {F6}Хорошо*возвращая паспорт {Enter}
   return
   :?*:/tlic:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do Лицензия авто на столе {Enter}
   sleep %delay%
   SendInput, {F6}/me взял лицензию в руки {Enter}
   sleep %delay%
   SendInput, {F6}/do Паспорт в руках{Enter}
   sleep %delay%
   SendInput, {F6}/me взяв лицензию, проверил её на подлинность {Enter}
   sleep %delay%
   SendInput, {F6}/do Лицензия проверена {Enter}
   sleep %delay%
   SendInput, {F6}Так..*возвращая лицензию {Enter}
   return
   :?*:/tmed:: 
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
   SendInput, {F6}Отлично*возвращая мед.карту {Enter}
   return
   :?*:/inv:: 
   IniRead, r, med.ini, main, r
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}Поздравляю, Вы нам подходите! {Enter}
   sleep %delay%
   SendInput, {F6}/do В шкафчике лежат бейджики {Enter}
   sleep %delay%
   SendInput, {F6}/me взяв бейджик, вписал туда должность, имя и фамилию{Enter}
   sleep %delay%
   SendInput, {F6}/do Бейджик готов {Enter}
   sleep %delay%
   SendInput, {F6}/me передал бейджик новому работнику {Enter}
   sleep %delay%
   if r > 8
   {
   SendInput, {F6}/invite {space}
   }
   if r < 9
   {
   SendInput, {F6}/rb Примите в организацию ID {space}
   }
   return
   :?*:/otkl:: 
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
  
  :?*:/grank:: 
  IniRead, r, med.ini, main, r
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
  :?*:/fw:: 
  IniRead, r, med.ini, main, r
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
  :?*:/ufw:: 
  IniRead, r, med.ini, main, r
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
  :?*:/op1:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    Sendinput, {F6}/me надел перчатки{Enter}
     sleep %delay%
    Sendinput, {F6}/me надел маску{Enter}
     sleep %delay%
    Sendinput, {F6}/me включил автоматический аппарат анестезии{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял скальпель{Enter}
     sleep %delay%
    Sendinput, {F6/me сделал небольшой надрез{Enter}
     sleep %delay%
    Sendinput, {F6}/me положил скальпель{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял лапароскоп{Enter}
     sleep %delay%
    Sendinput, {F6}/me провел манипуляцию по обнаружению червеобразного отростка{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял скальпель{Enter}
     sleep %delay%
    Sendinput, {F6}/me сделал небольшой надрез{Enter}
     sleep %delay%
    Sendinput, {F6}/me положил скальпель{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял необходимые инструменты{Enter}
     sleep %delay%
    Sendinput, {F6}/me аккуратно удалил червеобразный отросток.{Enter}
     sleep %delay%
    Sendinput, {F6}/me положил на стол все инструменты{Enter}
     sleep %delay%
    Sendinput, {F6}/me обработал рану антисептиком.{Enter}
     sleep %delay%
    Sendinput, {F6}/me наложил асептическую повязку.{Enter}
     sleep %delay%
    Sendinput, {F6}/me выключил автоматический аппарат анестезии{Enter}
     sleep %delay%    
    Sendinput, {F6}/me снял маску{enter}
     sleep %delay%
    Sendinput, {F6}/me провел мероприятия по выведению человека из анестезии.{Enter}
     sleep %delay%
    Sendinput, {F6}/heal{space}

  return
  :?*:/op2:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    Sendinput, {F6}/me осмотрел рану больного{Enter}
     sleep %delay%
    Sendinput, {F6}/me наложил давящую повязку для остановки кровотечения{Enter}
     sleep %delay%
    Sendinput, {F6}/me дал пациенту таблетку{Enter}
     sleep %delay%
    Sendinput, {F6}/me обработал рану больного{Enter}
     sleep %delay%
    Sendinput, {F6}/me вколол обезболивающее{Enter}
     sleep %delay%
    Sendinput, {F6}/me поставил капельницу{Enter}
     sleep %delay%
    Sendinput, {F6}/me включил аппарат наркоза{Enter}
     sleep %delay%
    Sendinput, {F6}/me надел маску наркоза на раненного{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял скальпель{Enter}
     sleep %delay%
    Sendinput, {F6}/me сделал разрез{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял щипцы{Enter}
     sleep %delay%
    Sendinput, {F6}/me вытащил пулю{Enter}
     sleep %delay%
    Sendinput, {F6}/me обрезал рваные и мертвые ткани около раны скальпелем{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял нитку и иголку{Enter}
     sleep %delay%
    Sendinput, {F6}/me зашил рану{Enter}
     sleep %delay%
    Sendinput, {F6}/me обработал рану зеленкой{Enter}
     sleep %delay%
    Sendinput, {F6}/me перевязал рану бинтом{Enter}
     sleep %delay%
    Sendinput, {F6}/me снял маску ингаляции{Enter}
     sleep %delay%
    Sendinput, {F6}/heal{space}
    if ascreen = true 
    {
    Sendinput, {F6}/time{Enter}
     sleep 200
    Sendinput, {F8}
    }
  return
  :?*:/op3:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    Sendinput, {F6}/me осмотрел рану больного{Enter}
     sleep %delay%
    Sendinput, {F6}/me наложил давящую повязку для остановки кровотечения{Enter}
     sleep %delay%
    Sendinput, {F6}/me обработал рану{Enter}
     sleep %delay%
    Sendinput, {F6}/me вколол обезболивающее{Enter}
     sleep %delay%
    Sendinput, {F6}/me поставил капельницу{Enter}
     sleep %delay%
    Sendinput, {F6}/me включил аппарат наркоза{Enter}
     sleep %delay%
    Sendinput, {F6}/me взял нитку и иголку{Enter}
     sleep %delay%
    Sendinput, {F6}/me зашил рану{Enter}
     sleep %delay%
    Sendinput, {F6}/me обработал рану зеленкой{Enter}
     sleep %delay%
    Sendinput, {F6}/me перевязал рану бинтом{Enter}
     sleep %delay%
    Sendinput, {F6}/heal{space}
    if ascreen = true 
    {
    Sendinput, {F6}/time{Enter}
     sleep 200
    Sendinput, {F8}
    }
  return
  :?*:-проверка:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}Здравствуйте, уважаемые сотрудники{!}{Enter}
      sleep %delay%
    SendInput, {F6}Сейчас я проведу небольшую проверку...{Enter}
     sleep %delay%
    SendInput, {F6}..на наличие мед.карт{Enter}
     sleep %delay%
    SendInput, {F6}Прошу всех достать свои мед.карты и предоставить их сотрудникам %forg%{Enter}
     sleep %delay%
    SendInput, {F6}Спасибо за понимание.{Enter}
     sleep %delay%
  return
  :?*:-проверкамед:: 
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
   SendInput, {F6}Отлично*возвращая мед.карту {Enter}
      SendInput, {F6}/time {Enter}
      sleep 100
   SendInput, {F8}
  return
  :?*:-проверкаеды:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/do На кухне находится холодильник{Enter}
   sleep %delay%
   SendInput, {F6}/me лёгким движением руки, открыл холодильник {Enter}
   sleep %delay%
   SendInput, {F6}/do Холодильник открыт{Enter}
   sleep %delay%
   SendInput, {F6}/me открыв ящик с мясом, проверил этикетки {Enter}
   sleep %delay%
   SendInput, {F6}/try Еда просрочена {Enter}
   sleep %delay%
   SendInput, {F6}/todo Хм*рассматривая этикетку {Enter}
   sleep %delay%
   SendInput, {F6}/time {Enter}
      sleep 100
   SendInput, {F8}
  return
  :?*:-едапросрочена:: 
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {F6}{Enter}
   SendInput, {F6}/me забрав еду в пакет, закрыл его{Enter}
   sleep %delay%
   SendInput, {F6}Так.. В холодильнике находится просроченное мясо{Enter}
   sleep %delay%
   SendInput, {F6}Мы приедем на следующей неделе, если ситуация не изменится..{Enter}
   sleep %delay%
   SendInput, {F6}..мы закроем закусочную, а вы должны будете выплатить штраф{!}{Enter}
   sleep %delay%
   SendInput, {F6}/time {Enter}
      sleep 100
   SendInput, {F8}
  return
  :?*:/lec1:: 
  SendMessage, 0x50,, 0x4190419,, A
  SendInput, {F6}{Enter}
    SendInput, {F6}/r Уважаемые коллеги, брать автомобили скорой помощи можно только с должности участковый врач и только на вызов.{Enter}
      sleep %delay%
    SendInput, {F6}/r На вызов можно ездить только с должности участковый врач.{Enter}
     sleep %delay%
    SendInput, {F6}/r Вертолет можно брать только с должности заведующий отделением и только на вызов.{Enter}
     sleep %delay%
    SendInput, {F6}/r Кто нарушит правила будет уволен и занесен в черный список.{Enter}
     sleep %delay%
    SendInput, {F6}/r Спасибо за внимание.{Enter}
     sleep %delay%
  return
  :?*:/lec2:: 
  SendMessage, 0x50,, 0x4190419,, A
    SendInput, {F6}/r Уважаемые сотрудники, прощу минуточку Вашего внимания. {Enter}
     Sleep %delay%
    SendInput, {F6}/r Отдыхать можно только в перерыв и только в ординаторской.{Enter}
     Sleep %delay%
    SendInput, {F6}/r Кто будет отдыхать вне ординаторской, получит выговор вплоть до увольнения.{Enter}
     Sleep %delay%
    SendInput, {F6}/r Спасибо за внимание.{Enter}
     Sleep %delay%
    Sendinput, {F6}/time{Enter}
     Sleep 150
    sendinput, {F8}
  Return
  :?*:/lec3:: 
  SendMessage, 0x50,, 0x4190419,, A
    SendInput, {F6}/r Уважаемые интерны прошу минуточку внимания. {Enter}
     Sleep %delay%
    SendInput, {F6}/r Чтобы получить должность участкового врача надо: сдать медицинский устав, медицинские термины.{Enter}
     Sleep %delay%
    SendInput, {F6}/r Чтобы получить должность участкового врача жду Вас в ординаторской на сдачу.{Enter}
     Sleep %delay%
    SendInput, {F6}/r Спасибо за внимание.{Enter}
     Sleep %delay%
    Sendinput, {F6}/time{Enter}
     Sleep 150
    Sendinput, {F8}
  Return
  :?*:-треня:: 
  SendMessage, 0x50,, 0x4190419,, A
    SendInput, {F6}Уважаемые сотрудники, сейчас я проведу вам тренировку. {Enter}
     Sleep %delay%
    SendInput, {F6}Для начала - разминка.{Enter}
     Sleep %delay%
    SendInput, {F6}20 приседаний и 30 отжиманий.{Enter}
     Sleep %delay%
    SendInput, {F6}Закончили, теперь бегом вокруг больницы{space}
  Return
  :?*:/reload:: 
  Reload
ExitApp ;Закрытие этого скрипта
return
}
; --------------------Отдел биндов---------------------------

