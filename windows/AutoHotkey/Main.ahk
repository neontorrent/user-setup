#Requires AutoHotkey v2.0

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
