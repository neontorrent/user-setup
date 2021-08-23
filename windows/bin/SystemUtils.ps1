#[reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
#Add-Type -AssemblyName "System.Windows.Forms"
#$win = New-Object Windows.Forms.Form
using assembly System.Windows.Forms
using namespace System.Windows.Forms
$win = [Form]::new()

$Display = Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices; 
public class Display
{
    [DllImport("User32.dll")]
    public static extern bool EnumDisplaySettings(
    [param: MarshalAs(UnmanagedType.LPTStr)]
    string lpszDeviceName,
    [param: MarshalAs(UnmanagedType.U4)]
    int iModeNum,
    [param: MarshalAs(UnmanagedType.LPArray)]
    byte[] lpDevMode);

    [DllImport("User32.dll")]
    public static extern long ChangeDisplaySettings(
    [param: MarshalAs(UnmanagedType.LPArray)]
    byte[] lpDevMode,
    [param: MarshalAs(UnmanagedType.U4)]
    int flags);

    static void CopyInt32(Int32 v, byte[] arr, int offset)
    {
        byte[] vBytes = BitConverter.GetBytes(v);
        for (int i = 0; i < sizeof(Int32); i++)
            arr[offset + i] = vBytes[i];
    }

    public static byte[] ChangeResolution(int bits, int width, int height, int refreshRate) 
    {
    byte[] dm = new byte[156];
    Console.WriteLine(EnumDisplaySettings(null, -1, dm));

    CopyInt32(0x5c0000, dm, 40);
    if (bits > 0)
        CopyInt32(bits, dm, 104);
    if (width > 0)
        CopyInt32(width, dm, 108);
    if (height > 0)
        CopyInt32(height, dm, 112);
    if (refreshRate > 0)
        CopyInt32(refreshRate, dm, 120);

    Console.WriteLine(ChangeDisplaySettings(dm, 0));
    
    return dm;
    }
}
'@ -Pas

$SendMessage = Add-Type @'
[DllImport("user32.dll")]
public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);
'@ -Name a  -Pas


function CreateButton {
    param ([string]$label)
    $btn = [Button]::new()
    $btn.Text = $label
    $btn.AutoSize = $true
    $btn.Anchor = [AnchorStyles]::Left -bor [AnchorStyles]::Top -bor [AnchorStyles]::Bottom -bor [AnchorStyles]::Right
    $btn
}


$btn1 = CreateButton "Restart Printer Spooler"
echo test
$btn1.add_click({
    echo "start"
    Restart-Service -Force -DisplayName "Print Spooler"
    echo "end"
    $win.Close()
})


$btn2 = CreateButton "Turn Off Monitor"
$btn2.add_click({
    $SendMessage::SendMessage(-1,0x0112,0xF170,2)
    $win.Close()
})

$btn3 = CreateButton "Reset Monitor"
$btn3.add_click({
    $Display::ChangeResolution(32, 1920, 1080, 144)
    $win.Close()
})

$container = [TableLayoutPanel]::new()
$container.Dock = [DockStyle]::Fill
#$container.ColumnStyles.Add([ColumnStyle]::new([SizeType]::Percent, 33.333))
#$container.ColumnStyles.Add([ColumnStyle]::new([SizeType]::Percent, 33.333))
#$container.ColumnStyles.Add([ColumnStyle]::new([SizeType]::Percent, 33.333))

$container.Controls.Add($btn1)
$container.Controls.Add($btn2)
$container.Controls.Add($btn3)

$win.Controls.Add($container)

#$win.MaximizeBox = $false
#$win.MinimizeBox = $false
$win.FormBorderStyle = [Windows.Forms.FormBorderStyle]::FixedToolWindow
$win.StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
#$win.ShowInTaskbar = $false
#$win.Height = 200
$win.ShowDialog()
