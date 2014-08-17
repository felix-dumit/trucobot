max(x,y,z)
{
	
if( x>=y and x>=z)
	return x
if(y>=x and y>=z)
	return y
if(z>=x and z>=y)
	return z


msgbox here
}


getStartCoordinates()
{
Global startx
Global starty

	
	;mousemove 300,600

	IfWinNotActive, gTruco, , WinActivate, gTruco,
		sleep 500
		Send,{PGUP}

	ImageSearch, StartX, StartY, 0, 0, A_ScreenWidth, A_ScreenHeight, *48 img\_screen\gTruco.png




}


getSuit(x=0,y=0,z=0){
global startx
global starty

xx:=startx+x
yy:=starty+y

;mousemove xx-z,yy-z
	
	Loop img\_suits\*.png
	{
		
		;mousemove, xx,yy
		ImageSearch, foundx, foundy, xx , yy , xx+18 +z, yy+20 +z, *48 img\_suits\%A_LoopFileName%
		;sleep 1000
		;mousemove, xx+18+z,yy+20+z
			if ErrorLevel=0
			{					
				StringTrimRight, suit, A_loopFileName, 4
				return suit
			}
	}
	
	
}


getCard(x=0,y=0,z=0){
global startx
global starty

suit:= getSuit(x,y+19,z)
;msgbox %suit%
	Loop img\%suit%\*.png
	{
		
		ImageSearch, foundx, foundy, startx+x , starty+y , startx+x+18 +z, starty+y+36 +z, *48 img\%suit%\%A_LoopFileName%
			if ErrorLevel=0				
			{
					
				StringTrimRight, card, A_loopFileName, 4
				return card
			}
	}
	
	return 0	
}

playPlayerCard(card, cover=""){
global startx
global starty


StringSplit kard,card,,
num:=kard1
suit:=kard2

ImageSearch, cardx,cardy,startx+441,starty+440,startx+440+60,starty+441+60, *48 img\%suit%\%card%.png
;mousemove cardx,cardy

if(cover){
	MouseClick,L, cardx+3,cardy+55

	
}
else MouseClick,L, cardx,cardy

MouseMove startx,starty+400

}
