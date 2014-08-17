#include lib.ahk

#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Relative
SetMouseDelay, 2

StartX =0
StartY =0

getStartCoordinates()

;ImageSearch, FoundX1, FoundY1, 0, 0, A_ScreenWidth, A_ScreenHeight, *48 img/c/4c.png
;ImageSearch, FoundX1, FoundY1, 0, 0, A_ScreenWidth, A_ScreenHeight, *140 img/_suits/d.png
;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *80 img/_screen/cutbaloon.png
;ImageSearch, FoundX, FoundY, 600, 552, 600+18,552+20, *48 img/_suits/s.png
;mousemove foundx,foundy
;msgbox  %foundx1%,%foundy1% || %foundx%,%foundy%
foundx:=foundx1-startx
foundy:=foundy1-starty

;mousemove foundx1,foundy1
;msgbox %foundx%,%foundy%


;mousemove, startx+450,starty+260
;sleep 1000
;mousemove, startx+450+30+18,starty+260+30+36
FileDelete files\player.txt

flipCard := getCard(536,407,5)
playerCard1 :=getCard(441,440,5)
playerCard2 :=getCard(461,440,5)
playerCard3 :=getCard(481,440,5)

FileAppend,
(
%flipcard%
%playercard1%
%playercard2%
%playercard3%
), files\player.txt



ExitApp

;msgbox %leftcard%|%topcard%|%rightcard%

;msgbox %flipcard%|%playercard1%|%playercard2%|%playercard3%



ALT::
mousemove ,510+StartX, 502+StartY,
ImageSearch x,y, 510+StartX, 502+StartY,  510+StartX+25, 502+StartY+25, *20 img\_screen\white.png
sleep 500
mousemove, 510+StartX+25, 502+StartY+25
msgbox %x%|%y%
return

CTRL::ExitAPP
SHIFT::Pause

BackSpace::
MouseGetPos x,y
x:=x-startx
y:=y-starty
msgbox %x%|%y%
return