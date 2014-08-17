#SingleInstance

		FormatTime, TimeString,,hhmmss
		msgbox %timestring%

/*
sleep 5000
SetTimer, ChangeButtonNames, 50
MsgBox,54,TEMPO DE AVALIACAO EXPIRADO, Versao de Testes possuio suporte para apenas uma rodada!`nInsira Nota 10 para versao Completa:
return


ChangeButtonNames:
IfWinNotExist, TEMPO DE AVALIACAO EXPIRADO
	return
SetTimer ChangeButtonNames, off
WinActivate
ControlSetText, Button1, &Nota 10
ControlSetText, Button2, &Nota 9.5
ControlSetText, Button3, &Nota 10
return*/