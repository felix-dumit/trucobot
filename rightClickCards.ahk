x=
y=

ENTER::
MouseClick,R
sleep 200
SEND,{DOWN}{DOWN}{ENTER}
;msgbox %Clipboard%
return


SHIFT::
MouseGetPos x,y
msgbox %x%|%y%

CTRL::
ExitAPP