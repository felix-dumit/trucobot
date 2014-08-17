#include lib.ahk

#SingleInstance force
#include gdip.ahk

screengrab(coord=0,outfile="")
{
pToken := Gdip_Startup()
screen:=coord
pBitmap:=Gdip_BitmapFromScreen(screen)
Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
}


SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Relative
SetMouseDelay, 2

StartX =0
StartY =0

last=%1%

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
FileDelete files\truco_call.txt
FileDelete files\new_round.txt
FileDelete files\left.txt
FileDelete files\right.txt
FileDelete files\top.txt
FileAppend,,files\new_round.txt
FileAppend,,files\truco_call.txt
FileAppend,,files\left.txt
FileAppend,,files\Right.txt
FileAppend,,files\top.txt


l=0
r=0
t=0

o_left=0
o_right=0
o_top=0
;IniRead o_left, cards.ini, table1, Left
;IniRead o_right, cards.ini, table1, Right
;IniRead o_top, cards.ini, table1, Top
;IniRead valid, cards.ini, table1, Valid

while (1){
	

	

	;ImageSearch, x,y,200,300,1500, 500, *48 img\_screen\aceito.png
	;if ErrorLevel
	;	sleep 1
	;else msgbox aceito

	
	leftCard:= getCard(380,290,40)
	topCard:=getCard(440,240,40)
	rightCard:=getCard(510,290,40)
	
	

		if o_left<>%LeftCard%
		{
			
			if LeftCard<>0
			{				
				;l:=max(l+1,r,t)
				l++
				;IniWrite %leftcard%,cards.ini, Left,card%l%
				FileAppend, %LeftCard%`n, files\left.txt
				o_left:=leftCard
			}
		}
		if o_right<>%rightCard%  
		{
			if RightCard<>0
			{
				;r:=max(l,r+1,t)
				r++
				;IniWrite %rightcard%,cards.ini, Right,card%r%
				FileAppend, %RightCard%`n, files\right.txt
				o_right:=rightCard
			}
		}
		if o_top<>%topCard%
		{
			if topCard<>0
			{
				;t:=max(l,r,t+1)
				t++
				;IniWrite %topcard%,cards.ini, Top,card%t%
				FileAppend, %TopCard%`n, files\top.txt
				o_top:=topCard
			}
		}					
		
		/*else
		{
	
		IniWrite %leftcard%,cards.ini, table%round%, Left
		IniWrite %topcard%,cards.ini, table%round%, Top
		IniWrite %rightcard%,cards.ini, table%round%, Right
		Iniwrite 1,cards.ini,table%round%,Valid
		}
		*/
		
		
		ImageSearch x,y,StartX+300,StartY+500,StartX+400,StartY+600, *48 img\_screen\restart.png
		if ErrorLevel=0
		{
		FormatTime, TimeString,,hhmmss	
		str=capture\%timestring%.png
		coord= 0|0|%A_ScreenWidth%|%A_ScreenHeight%
		screengrab(coord,str)	
		
		MouseClick,L,x,y
		ExitApp		
		
		
		}
		
		
		ImageSearch x,y, 510+StartX, 502+StartY,  510+StartX+25, 502+StartY+25, *25 img\_screen\white.png
		if ErrorLevel=1
		{
			
			ImageSearch, x,y,Startx+300,starty+400,startx+600, starty+700, *48 img\_screen\ok.png
			If ErrorLevel=0
			{
				FileAppend Yes, files\truco_call.txt 
				ExitApp	
			}

			f := getCard(536,407,5)
			current=%f%
			;msgbox %current%::::%last%
			if(current<>last)
			{
			;	MsgBox new_round
				FileAppend,Yes,files\new_round.txt
				ExitApp
			}
		
			FileAppend No, files\new_round.txt
			FileAppend No, files\truco_call.txt
			
		ExitApp
		;my turn	
		}	
		
		sleep 300
		

}




;msgbox %leftcard%|%topcard%|%rightcard%

;msgbox %flipcard%|%playercard1%|%playercard2%|%playercard3%

;run cards.ini

ALT::
mousemove ,510+StartX, 502+StartY,
ImageSearch x,y,StartX,StartY,A_ScreenWidth,A_ScreenHeight, *48 img\_screen\ok.png
sleep 500
;mousemove, 510+StartX+25, 502+StartY+25
Mousemove x,y
msgbox %x%|%y%
return

SHIFT::Pause

CTRL::
MouseGetPos x,y
x:=x-startx
y:=y-starty
msgbox %x%|%y%
return


ESC::
WinKill, *Python Shell*
Sleep 500
Send {ENTER}
ExitApp
