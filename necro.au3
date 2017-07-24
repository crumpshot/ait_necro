HotKeySet("{F8}", "__ExitBot")

msgbox(0,"BotRunning", "Bot is active")
WinActivate("EverQuest","")

while(1)
sleep(200)
__mezAdds()
;sleep(5000) ;iterative testing purposes
   WEnd

Func __healTarget()
   Send("3")
EndFunc

Func __ExitBot()
   msgbox(0,"BotDone", "Bot is stopped")
   Exit
EndFunc

Func __outofCombatSit()
   $currentCombatPixel = pixelgetcolor(1236,867) ;checks for black incombat icon logo - hex value: 0x000000
   $standingPixel = pixelgetcolor(1801,1005) ;checks sit/stand button for standing status - hex value:0xC6C6C9
   $recentCombatPixel = pixelgetcolor(1139,947) ;checks combat timer bar exists - hex value:0x999699
   ;msgbox(0,"test", $standingPixel)
   If $currentCombatPixel <> 0 AND $standingPixel = 13290189 AND $recentCombatPixel = 10065561 Then ;if out of combat AND standing AND recently in combat/, then send SIT hotkey
	  sleep(2000)
	  Send("x")
	  sleep(1000)
   EndIf
EndFunc

Func __hpCheck80()
      $hpPixel = pixelgetcolor(1220,900) ;gets hp pixel at 80% mark. Set this coords value per character/screen
   ;msgbox(0,"hp", $hpPixel)
   If $hpPixel = 14221312 Then ;IFstatement returns VALUE 1 for mana bar color being BLUE (ie has >=80% mana) hex value:0xD90000
	  Return 1
   Else
	  Return 2
   EndIf
EndFunc


Func __manaCheck80()
      $manaPixel = pixelgetcolor(1220,910) ;gets mana pixel at 80% mark. Set this coords value per character/screen
   If $manaPixel = 29415 Then ;IFstatement returns VALUE 1 for mana bar color being BLUE (ie has >=80% mana) hex value:0x0072E7
	  Return 1
   Else
	  Return 0
   EndIf
EndFunc

Func __mezAdds()
   $mobCheck = __mobInLOS()
   If $mobCheck = 1 Then
	  $mobCount = __getMobCount()
	  If $mobCount = 3 Then
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(1000)
		 Send("F7") ;targets xtar3 and mezes then pauses 10sec
		 sleep(200)
		 Send("0")
		 sleep(10000)
		 Send("F6") ;targets xtar2 and mezes then pauses 10sec
		 sleep(200)
		 Send("0")
	  ElseIf $mobCount = 2 Then
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(1000)
		 Send("F6") ;targets xtar2 and mezes then pauses 10sec
		 sleep(200)
		 Send("0")
	  ElseIf $mobCount = 1 Then
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(1000)
	  EndIf
   EndIf

EndFunc

Func __mobInLOS()
   Send("ESCAPE")
   sleep(100)
   Send("f")
   sleep(200)
   $targetPixel = pixelgetcolor(726,667) ;gets pixel for target pane to determine if anything selected
   If $targetPixel <> 1053985 Then
	  Return 1
   Else
	  Return 0
   EndIf
EndFunc

Func __getMobCount()
   Send("ESCAPE")
   sleep(100)
   Send("F7")
   sleep(200)
   $targetPixel = pixelgetcolor(726,667) ;gets pixel for target pane to determine if anything selected
   If $targetPixel <> 1053985 Then
	  Return 3
   Else
	  Send("ESCAPE")
	  sleep(100)
	  Send("F6")
	  sleep(200)
	  $targetPixel = pixelgetcolor(726,667) ;gets pixel for target pane to determine if anything selected
	  If $targetPixel <> 1053985 Then
		 Return 2
	  Else
		 Send("ESCAPE")
		 sleep(100)
		 Send("F5")
		 sleep(200)
		 $targetPixel = pixelgetcolor(726,667) ;gets pixel for target pane to determine if anything selected
		 If $targetPixel <> 1053985 Then
			Return 1
		 Else
			msgbox(0,"mobCount","No mobs in Xtarget")
		 EndIf
	  EndIf
   EndIf

EndFunc


;--------Future Functions To Write---------------

Func __conCheck() ;logic to determine if spells should be cast on mob based on CON
EndFunc

