
#include lib.ahk

#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Relative
SetMouseDelay, 2


StartX =0
StartY =0

card=%1%
cover=%2%


getStartCoordinateS()

playPlayerCard(card,cover)

