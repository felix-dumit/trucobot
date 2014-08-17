
#include lib.ahk
#include Gdip.ahk


FileCreateDir img
fileCreateDir img\C
fileCreateDir img\H
fileCreateDir img\S
fileCreateDir img\D
FileCreateDir img\_download\
FileCreateDir img\_download\C
FileCreateDir img\_download\H
FileCreateDir img\_download\S
FileCreateDir img\_download\D
FileCreateDir img\_suits
FileCreateDir img\_screen

FileCopy truco.png, img\_screen\truco.png
FileCopy nao.png, img\_screen\nao.png
FileCopy aceito.png, img\_screen\aceito.png
FileCopy white.png, img\_screen\white.png
FileCopy extra_img\*.png, img\_screen\*.png
URLDownloadToFile http://www1.gtruco.com.br/img/logo_gtruco2.gif, img\_screen\gTruco.png
URLDownloadToFile http://www1.gtruco.com.br/img/mgr_2.gif, img\_screen\gerente.png
URLDownloadToFile http://www1.gtruco.com.br/img/t.gif, img\_screen\Ttruco.png
URLDownloadToFile http://www1.gtruco.com.br/img/closedSignalingt.gif, img\_screen\encobrir.png
URLDownloadToFile http://www1.gtruco.com.br/img/dt.gif, img\_screen\ok.png
URLDownloadToFile http://www1.gtruco.com.br/img/ct.gif, img\_screen\nok.png
URLDownloadToFile http://www1.gtruco.com.br/img/6.gif, img\_screen\6.png
URLDownloadToFile http://www1.gtruco.com.br/img/9.gif, img\_screen\9.png
URLDownloadToFile http://www1.gtruco.com.br/img/12.gif, img\_screen\12.png
URLDownloadToFile http://www1.gtruco.com.br/img/rightPlayerBaloon.gif, img\_screen\baloon.png
URLDownloadToFile http://www1.gtruco.com.br/img/back-gTruco.gif, img\_screen\back.png
URLDownloadToFile http://www1.gtruco.com.br/img/deckA/back-gTrucot.gif, img\_screen\fback.png


URL = http://www1.gtruco.com.br/img/deckA/


Nums = A,2,3,4,5,6,7,J,Q,K
Suits= c,e,o,p




pToken := Gdip_Startup()

npBitmap := Gdip_CreateBitmap(20, 36)
pBitmap := Gdip_CreateBitmapFromFile("img\_screen\baloon.png")
G := Gdip_GraphicsFromImage(npBitmap)
Gdip_DrawImage(G, pBitmap, 0,0,20,36,0,0,20,36)
outfile = img\_screen\cutbaloon.png
Gdip_SaveBitmapToFile(npBitmap, outfile, 100)


npBitmap := Gdip_CreateBitmap(20, 36)
pBitmap := Gdip_CreateBitmapFromFile("img\_screen\back.png")
G := Gdip_GraphicsFromImage(npBitmap)
Gdip_DrawImage(G, pBitmap, 0,0,20,36,2,10,20,36)
outfile = img\_screen\_back.png
Gdip_SaveBitmapToFile(npBitmap, outfile, 100)




Loop,parse,suits, `, 
{
	suit:=A_LoopField
	newsuit:=suit
	StringReplace newsuit,newsuit,e,s
	StringReplace newsuit,newsuit,c,h
	StringReplace newsuit,newsuit,o,d
	StringReplace newsuit,newsuit,p,c
	
	Loop,parse,nums,`,
	{
		num:=A_LoopField
		newURL=%URL%%num%%suit%.gif
		fileSave = img\_download\%newsuit%\%num%%newsuit%.png
		URLDownloadToFile %newURL%, %filesave%
		
		pBitmap := Gdip_CreateBitmapFromFile(fileSave)

		npBitmap := Gdip_CreateBitmap(18, 36)

		G := Gdip_GraphicsFromImage(npBitmap)

		Gdip_DrawImage(G, pBitmap, 0,0,18,36,1,1,18,36)

		outfile = img\%newsuit%\%num%%newsuit%.png
		Gdip_SaveBitmapToFile(npBitmap, outfile, 100)	
		
		IfInString num,a
		{
		
		pBitmap := Gdip_CreateBitmapFromFile(fileSave)

		npBitmap := Gdip_CreateBitmap(18, 20)

		G := Gdip_GraphicsFromImage(npBitmap)

		Gdip_DrawImage(G, pBitmap, 0,0,18,20,1,20,18,20)

		outfile = img\_suits\%newsuit%.png
		Gdip_SaveBitmapToFile(npBitmap, outfile, 100)		
		
		}
			


	}
}
Gdip_Shutdown(pToken)

/*
Loop img\download\*.png, 0,1
{


pBitmap := Gdip_CreateBitmapFromFile(A_LoopFileFullPath)

npBitmap := Gdip_CreateBitmap(18, 20)

G := Gdip_GraphicsFromImage(npBitmap)

Gdip_DrawImage(G, pBitmap, 0,0,18,20,1,20,18,20)

outfile = img\aaa.png
Gdip_SaveBitmapToFile(npBitmap, outfile, 100)
msgbox %A_LoopFileFullPath%

}
*/


ExitAPP

CTRL::ExitAPP