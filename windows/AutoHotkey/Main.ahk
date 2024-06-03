#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode('RegEx')

; IntelliJ
#HotIf WinActive("ahk_class SunAwt.*")
;!b::^b
;$LWin::LAlt
;$RWin::RAlt
;$LAlt::LCtrl
;$RAlt::RCtrl
#!Left::^!Left
#!Right::^!Right
!w::^F4
!p::^p
!s::^s
^j::^q
!LButton::^LButton
!Down::F4

; Windows Explorer
#HotIf WinActive("ahk_exe explorer.exe")
!Backspace::
{
    if WinActive("ahk_class CabinetWClass") ; explorer
    {
        ; The control retrieved by this command is the one that has keyboard focus
        FocusedControl := ControlGetClassNN(ControlGetFocus("A"))  ; A means the active window
        ; MsgBox %FocusedControl%
        if (FocusedControl ~= "i)(DirectUIHWND|DirectUIHWND2|SysListView)")
             Send("^d")
        else
            Send("{delete}")
    }
    else
        Send("{delete}")
    return
}
Enter::
{
    if WinActive("ahk_class CabinetWClass") ; explorer
    {
        ; The control retrieved by this command is the one that has keyboard focus
        FocusedControl := ControlGetClassNN(ControlGetFocus("A"))  ; A means the active window
        ; MsgBox %FocusedControl%
        if (FocusedControl ~= "i)(DirectUIHWND|DirectUIHWND2|SysListView)")
             Send("{F2}")
        else
            Send("{Enter}")
    }
    else
        Send("{Enter}")
    return
}
!Down::
{
    if WinActive("ahk_class CabinetWClass") ; explorer
    {
        ; The control retrieved by this command is the one that has keyboard focus
        FocusedControl := ControlGetClassNN(ControlGetFocus("A"))  ; A means the active window
        ; MsgBox %FocusedControl%
        if (FocusedControl ~= "i)(DirectUIHWND|DirectUIHWND2|SysListView)")
             Send("{Enter}")
        else
            Send("!{Down}")
    }
    else
        Send("!{Down}")
    return
}
!LButton::
{
    if WinActive("ahk_class CabinetWClass") ; explorer
    {
        FocusedControl := ControlGetClassNN(ControlGetFocus("A"))  ; A means the active window
        if (FocusedControl ~= "i)(DirectUIHWND|DirectUIHWND2|SysListView)")
             Send("^{LButton}")
        else
            Send("!{LButton}")
    }
    else
        Send("!{LButton}")
    return
}

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
!t::^+t
!w::^+w
!f::^+f


; Elsewhere
#HotIf
;#HotIf not WinActive("ahk_class SunAwt.*")
;Alt::LWin
!c::^c
!v::^v
!x::^x
!z::^z
!a::^a
!f::^f
!s::^s
!p::^p
!l::^l
!t::^t
!+t::^+t
!w::^w
!r::^r
!p::^p
!f::^f
!n::^n
^a::Home
^e::End
!+3::SendInput "<#{PrintScreen}"
!+4::SendInput "{PrintScreen}"
!+i::^+i
!q::!F4
!Enter::^Enter
Browser_Home::Esc
!Backspace::Del

/*
if not A_IsAdmin
    Run("*RunAs `"" A_ScriptFullPath "`"")
touchpadEnabled:=1
#F1::
{
global touchpadEnabled
#SingleInstance Force
if not A_IsAdmin
    Run("*RunAs `"" A_ScriptFullPath "`"")
Run("SystemSettingsAdminFlows.exe EnableTouchPad " (touchpadEnabled := !touchpadEnabled))
ToolTip("Touchpad enabled = " touchpadEnabled)
SetTimer RemoveToolTip, 3000
return
}

#Include LidWatcher.ahk
r := Start_LidWatcher()
OnExit(cleanup)

cleanup(ExitReason, ExitCode)
{
  ;MsgBox("Cleanup")
  Stop_LidWatcher(r)  ;Stop watching the lid state changes
  ExitApp
  return 1
}

LidStateChange(newstate)
{
  ;FormatTime(TimeString, "h:mm:ss tt")
  ;FileAppend(The lid was %newstate% at %TimeString%`n, lid.log)
  ;MgBox(newstate)
  if (newstate)
  {
    Run('pnputil /enable-device "ACPI\PNP0C50\3&62D7E73&0"')
  }
  else
  {
    Run('pnputil /disable-device "ACPI\PNP0C50\3&62D7E73&0"')
  }
  ;ToggleDevice("ACPI\PNP0C50\3&62D7E73&0")
  ToolTip("Touchpad enabled = " newstate)
  SetTimer RemoveToolTip, 3000
}


RemoveToolTip()
{
SetTimer(RemoveToolTip, 0)
ToolTip
return
}

FadingMsgBox(text){
	myGui := Gui()
	myGui.Opt("+AlwaysOnTop +ToolWindow -SysMenu -Caption")
	myGui.BackColor := "ffffff" ;changes background color
	myGui.SetFont("000000 s20 bold", "Verdana") ;changes font color, size and font
	myGui.Add("Text", "x0 y0", text) ;the text to display
	myGui.Title := "Xn: 0"
	myGui.Show("NoActivate", , "Yn: 0")

	Sleep(5000)
	myGui.Destroy()
}
; Run C:\Windows\System32\DevManView.exe /enable "HID-compliant touch screen"	; path to DevManView and enable device with this name/ID

ToggleDevice(device_id) {
  command := 'pnputil /enum-devices /instanceid "' device_id '" | find "Status"'
  result := ComObject("WScript.Shell").Exec(A_ComSpec ' /C "' command '"').StdOut.ReadAll()
  status := InStr(result, "Disabled") ? 'enable' : 'disable'
  Run('pnputil /' status '-device "' device_id '"')
  return status = "enable"
}
*/