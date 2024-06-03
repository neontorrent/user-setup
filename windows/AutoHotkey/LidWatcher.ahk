#Requires AutoHotkey v2.0

/*
 This script should work for Vista+

 Details:
 Use Start_LidWatcher to begin monitoring the lid state.
 r := Start_LidWatcher()

 When the state changes, the function "LidStateChange" will be called.
 LidStateChange should have the following format:
 LidStateChange(newstate)
 {
   ...
 }

 newstate will be one of two values:
 "opened" = The lid was opened
 "closed" = The lid was closed

 Note: It's possible that this function will be immediately called after 
       using Start_LidWatcher with the lid's current state (usually open).

 When the application no longer needs to monitor the lid state,
 call Stop_LidWatcher with the return value from Start_LidWatcher.
 Pass it the return value from Start_LidWatcher.
 Stop_LidWatcher(r)

*/

Start_LidWatcher()
{
  ;VarSetStrCapacity(&guid, 16)
  guid := Buffer(16)
  ;GUID_LIDSWITCH_STATE_CHANGE
  ;Numput(0xBA3E0F4D, guid, 0, "uint"), Numput(0x4094B817, guid, 4, "uint")
  ;Numput(0x63D5D1A2, guid, 8, "uint"), Numput(0xF3A0E679, guid, 12, "uint")
  NumPut("uint", 0xBA3E0F4D, guid, 0), NumPut("uint", 0x4094B817, guid, 4)
  NumPut("uint", 0x63D5D1A2, guid, 8), NumPut("uint", 0xF3A0E679, guid, 12)
  
  try
  {
    r := DllCall("RegisterPowerSettingNotification", "ptr", A_ScriptHwnd, "ptr", guid, "uint", 0)
    if (!r)
    {
      throw Error("RegisterPowerSettingNotification returns null")
    }
  }
  catch as e
  {
    ;MSDN says check GetLastError if the return value was NULL.
    Msgbox("RegisterPowerSettingNotification failed with error: " (e ? e.Message : A_LastError))
    return 0
  }
  OnMessage(0x218, WM_POWERBROADCAST)
  ;MsgBox("Started " Type(r))
  return r
}

Stop_LidWatcher(r)
{
  DllCall("UnregisterPowerSettingNotification", "ptr", r)
  OnMessage(0x218, WM_POWERBROADCAST, 0)
  ;MsgBox("Stopped")
}

WM_POWERBROADCAST(wparam, lparam, msg, hwnd)
{
  static fx := "LidStateChange"
  ; if (wparam = 0x8013 && isFunc(fx))
  if (wparam = 0x8013)
  {
    ;data = 0 = closed
    ;data = 1 = opened
    %fx%(Numget(lparam+20, 0, "uchar") ? 1 : 0)
  }
  return 1
}