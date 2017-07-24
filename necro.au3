HotKeySet("{F8}", "__ExitBot")

msgbox(0,"BotRunning", "Bot is active")
WinActivate("EverQuest","")

while(1)
sleep(200)
__mezAdds()
sleep(500)
__outofCombatSit()
;sleep(5000) ;iterative testing purposes
   WEnd

Func __ExitBot()
   msgbox(0,"BotDone", "Bot is stopped")
   Exit
EndFunc

Func __outofCombatSit()
   $currentCombatPixel = pixelgetcolor(1068,717) ;checks for black incombat icon logo - hex value: 0x000000
   $standingPixel = pixelgetcolor(1564,926) ;checks sit/stand button for standing status - hex value:0xC7C7C9
   $recentCombatPixel = pixelgetcolor(971,797) ;checks combat timer bar exists - hex value:0x999699
   ;msgbox(0,"test", $standingPixel) ;for testing
   If $currentCombatPixel <> 0 AND $standingPixel = 13290189 AND $recentCombatPixel = 10065561 Then ;if out of combat AND standing AND recently in combat/, then send SIT hotkey.. calculated off of the 30sec CD timer top gold color pixel
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
	  sleep(500)
	  $mobCount = __getMobCount()
	  ;testing purposes ;msgbox(0,"mobCount",$mobCount)
	  If $mobCount = 3 Then
		 Send("{F7}") ;targets xtar3 and mezes then pauses 10sec
		 sleep(300)
		 Send("0")
		 sleep(5000)
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(5000)
		 Send("{F6}") ;targets xtar2 and mezes then pauses 10sec
		 sleep(300)
		 Send("0")
		 sleep(4000)0
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(4000)
	  ElseIf $mobCount = 2 Then
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(1000)
		 Send("{F6}") ;targets xtar2 and mezes then pauses 10sec
		 sleep(300)
		 Send("0")
		 sleep(4000)
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(4000)
	  ElseIf $mobCount = 1 Then
		 Send("3") ;assists w/pet and pauses 1sec
		 sleep(1000)
	  EndIf
   EndIf

EndFunc

Func __mobInLOS()
   Send("{ESCAPE}")
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
   Send("{ESCAPE}") ;clears target window
   sleep(200)
   Send("{F7}") ;ingame hotkey for xtarget mob3
   sleep(200)
   $targetPixel = pixelgetcolor(726,667) ;gets pixel for target pane to determine if anything selected: 0x101521
   If $targetPixel <> 1053985 Then ;if target window has a target, there are at least 3 mobs in aggro list
	  Return 3
   Else
	  Send("{ESCAPE}")
	  sleep(200)
	  Send("{F6}") ;ingame hotkey for xtarget mob2
	  sleep(200)
	  $targetPixel = pixelgetcolor(726,667) ;gets pixel for target pane to determine if anything selected
	  If $targetPixel <> 1053985 Then
		 Return 2
	  Else
		 Send("{ESCAPE}")
		 sleep(200)
		 Send("{F5}") ;ingame hotkey for xtarget mob1
		 sleep(200)
		 $targetPixel = pixelgetcolor(726,667) ;gets pixel for target pane to determine if anything selected
		 If $targetPixel <> 1053985 Then
			Return 1
		 Else
			Return 0 ;msgbox(0,"mobCount","No mobs in Xtarget") ;after testing, replace this msgbox with return 0
		 EndIf
	  EndIf
   EndIf

EndFunc


;--------Future Functions To Write---------------

Func __conCheck() ;logic to determine if spells should be cast on mob based on CON
EndFunc