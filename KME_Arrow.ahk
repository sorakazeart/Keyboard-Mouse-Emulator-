#Requires AutoHotkey v2.0

; --- POPUP KILLER (Do NOT touch these lines) ---
; These lines stop the annoying "Too many hotkeys" error popups.
A_HotkeyInterval := 0 ; Completely disables the check interval
A_MaxHotkeysPerInterval := 1000 ; Sets the max limit high enough to never trigger

; This is the "Nuclear Option" for v2 to stop timer warnings
A_MaxHotkeysPerInterval := 1000

; --- USER SETTINGS (CHANGE THESE TO YOUR PREFERENCE) ---

; Change "10" to any number if you want the cursor to move faster or slower globally.
global MouseSpeed := 10

; ============================================================
; --SEPPARATE SPEED TWEAKERS-- (The most important settings for you!)
; ============================================================
; 1. To change how fast the cursor moves on your Desktop/Menus, change the 10 below.
global CursorSpeedMult := 10   ; <-- Lower = Slower desktop cursor | Higher = Faster

; 2. To change how fast the camera rotates in Games, change the 35 below.
global CameraSpeedMult := 35   ; <-- Lower = Slower camera | Higher = Faster game camera

; ============================================================
; END OF USER SETTINGS
; ============================================================


; --- SYSTEM VARIABLES (DO NOT TOUCH) ---
global Toggle := false
global dirX := 0
global dirY := 0
global moving := false

; Read your system's real mouse speed from Windows Registry
try {
    MouseSpeed := RegRead("HKCU\Control Panel\Mouse", "MouseSpeed")
    if (MouseSpeed <= 0)
        MouseSpeed := 10
} catch {
    MouseSpeed := 10
}

; This removes the Windows "holding pause" so keys respond instantly.
SetKeyDelay(-1, -1)

; --- DOUBLE-TAP ` (Backtick) TOGGLE ---
; This block handles the Double-tap feature to turn the script ON/OFF.
global ToggleTimer := 0
`:: {
    global Toggle, ToggleTimer
    if (ToggleTimer > 0) {
        SetTimer(ToggleTimerFunc, 0)
        ToggleTimer := 0
        Toggle := !Toggle
        ToolTip(Toggle ? "Mouse Mode: ON`nArrows=Move, PgUp=Drag, PgDn=R-Click" : "Mouse Mode: OFF", 10, 10)
        SetTimer(() => ToolTip(), -2000)
        return
    }
    ToggleTimer := 1
    SetTimer(ToggleTimerFunc, -250)
}

; If you only pressed ` once, it types a backtick character normally.
ToggleTimerFunc() {
    global ToggleTimer
    if (ToggleTimer > 0) {
        ToggleTimer := 0
        Send("``")
    }
}

; --- SPEED CALCULATIONS (DO NOT CHANGE) ---
MoveAmount := 10 * MouseSpeed / 10
if (MoveAmount < 5)
    MoveAmount := 5

CursorSpeed := MoveAmount * CursorSpeedMult / 10
CameraSpeed := MoveAmount * CameraSpeedMult / 10

; --- ARROW HOTKEYS (PRESS) ---
; This tells the script "An arrow key has been pressed."
#HotIf Toggle

*Up:: {
    global dirY := -CursorSpeed
    global moving := true
}

*Down:: {
    global dirY := CursorSpeed
    global moving := true
}

*Left:: {
    global dirX := -CursorSpeed
    global moving := true
}

*Right:: {
    global dirX := CursorSpeed
    global moving := true
}

; --- ARROW HOTKEYS (RELEASE) ---
; This tells the script "The arrow key has been let go."
*Up Up:: {
    global dirY := 0
    global moving := false
}

*Down Up:: {
    global dirY := 0
    global moving := false
}

*Left Up:: {
    global dirX := 0
    global moving := false
}

*Right Up:: {
    global dirX := 0
    global moving := false
}

; --- ACTION TIMER (DO NOT CHANGE) ---
; This invisible timer runs constantly and does the actual mouse movement.
SetTimer(MoveTimer, 15)

MoveTimer() {
    global moving, dirX, dirY, CursorSpeed, CameraSpeed
    if (!moving || !Toggle)
        return

    x := dirX
    y := dirY

    ; Safety check
    if (x = 0 && y = 0)
        return

    ; --- PRECISION MODE ---
    ; If you hold CTRL while moving, the speed is cut in half.
    if GetKeyState("Ctrl", "P") {
        x := x / 2
        y := y / 2
    }

    ; --- TURBO MODE ---
    ; If you hold ALT while moving, it uses the faster CameraSpeed.
    if GetKeyState("Alt", "P") {
        altX := (x > 0 ? CameraSpeed : -CameraSpeed)
        altY := (y > 0 ? CameraSpeed : -CameraSpeed)
        
        MouseMove(x, y, 0, "R")                 ; Move desktop cursor
        DllCall("mouse_event", "UInt", 0x0001, "Int", altX, "Int", altY, "UInt", 0, "UInt", 0) ; Move game camera
    } else {
        ; --- NORMAL MODE ---
        ; If neither CTRL nor ALT is held, it moves at the standard speed.
        MouseMove(x, y, 0, "R")
        DllCall("mouse_event", "UInt", 0x0001, "Int", x, "Int", y, "UInt", 0, "UInt", 0)
    }

    ; --- DRAG MODE ---
    ; If you hold PgUp while moving, it holds down the left mouse button (Drag).
    ; If you let go of PgUp, it releases the left mouse button.
    if GetKeyState("PgUp", "P") {
        Click("Down")
    } else {
        Click("Up")
    }
}

; --- PAGE UP / DOWN CLICKS ---
; These are the standard Left and Right click buttons.
PgUp::Click("Left")
PgDn::Click("Right")

#HotIf
