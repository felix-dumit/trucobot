
#include lib.ahk

#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Relative
SetMouseDelay, 2


StartX =0
StartY =0

getStartCoordinateS()

sit=%1%
;cover=%2%

if(sit=="y")
{
	ImageSearch x,y,StartX+400,StartY+500,StartX+600,Starty+600, *100 img\_screen\ok.png
	MouseClick,L,x,y
}
else if(sit=="n")
{
	ImageSearch x,y,StartX+400,StartY+500,StartX+600,Starty+600, *100 img\_screen\nok.png
	MouseClick,L,x,y
}
else if(sit=="6")
{
	ImageSearch x,y,StartX+400,StartY+500,StartX+600,Starty+600, *100 img\_screen\6.png
	MouseClick,L,x,y
}
else if(sit=="9")
{
	ImageSearch x,y,StartX+400,StartY+500,StartX+600,Starty+600, *100 img\_screen\9.png
	MouseClick,L,x,y
}
else if(sit=="12")
{
	ImageSearch x,y,StartX+400,StartY+500,StartX+600,Starty+600, *100 img\_screen\9.png
	MouseClick,L,x,y
}
else if(sit=="t")
{
	ImageSearch x,y,StartX+400,StartY+500,StartX+600,Starty+600, *100 img\_screen\ttruco.png
	MouseClick,L,x,y
}
else if(sit=="r")
{
	ImageSearch x,y,StartX,Starty,StartX+400,StartY+500,StartX+600,Starty+600, *100 img\_screen\restart.png
	MouseClick,L,x,y
}




