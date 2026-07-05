#Requires AutoHotkey v2.0

; --- POPUP KILLER (v2 Compliant) ---
A_HotkeyInterval := 0     ; Completely disables the check interval
A_MaxHotkeysPerInterval := 1000 ; Sets the max limit high enough to never trigger

; This is the "Nuclear Option" for v2 to stop timer warnings
A_MaxHotkeysPerInterval := 1000

; --- SETTINGS ---
global Toggle := false
global MouseSpeed := 10

; --- SEPARATE SPEED TWEAKERS ---
global CursorSpeedMult := 10   ; <-- Lower = Slower desktop cursor
global CameraSpeedMult := 35   ; <-- Higher = Faster in-game camera

global dirX := 0
global dirY := 0
global moving := false

; Read Windows mouse speed
try {
    MouseSpeed := RegRead("HKCU\Control Panel\Mouse", "MouseSpeed")
    if (MouseSpeed <= 0)
        MouseSpeed := 10
} catch {
    MouseSpeed := 10
}

SetKeyDelay(-1, -1)

; --- Double-tap ` (Backtick) Toggle ---
global ToggleTimer := 0
`:: {
    global Toggle, ToggleTimer
    if (ToggleTimer > 0) {
        SetTimer(ToggleTimerFunc, 0)
        ToggleTimer := 0
        Toggle := !Toggle
        ToolTip(Toggle ? "Mouse Mode: ON`nArrows=Move, PgUp=Drag, Alt+Click=Lock" : "Mouse Mode: OFF", 10, 10)
        SetTimer(() => ToolTip(), -2000)
        return
    }
    ToggleTimer := 1
    SetTimer(ToggleTimerFunc, -250)
}

ToggleTimerFunc() {
    global ToggleTimer
    if (ToggleTimer > 0) {
        ToggleTimer := 0
        Send("``")
    }
}

; --- Speed Calculations ---
MoveAmount := 10 * MouseSpeed / 10
if (MoveAmount < 5)
    MoveAmount := 5

CursorSpeed := MoveAmount * CursorSpeedMult / 10
CameraSpeed := MoveAmount * CameraSpeedMult / 10

; --- Arrow Hotkeys (Press) ---
#HotIf Toggle

; Note: We removed the ~ because Alt will now handle the pass-through
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

; --- Arrow Hotkeys (Release - DRIFT FIX) ---
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

; --- Action Timer (Dynamic speed switcher) ---
SetTimer(MoveTimer, 15)

MoveTimer() {
    global moving, dirX, dirY, CursorSpeed, CameraSpeed
    if (!moving || !Toggle)
        return

    x := dirX
    y := dirY

    ; SAFETY CHECK
    if (x = 0 && y = 0)
        return
if GetKeyState("Ctrl", "P") {
    x := x / 2  ; Cut speed in half
    y := y / 2
}

    ; Determine which speed to use based on Alt being held
    if GetKeyState("Alt", "P") {
        ; ALT HELD: Use FAST Camera Speed for RAW signals
        altX := (x > 0 ? CameraSpeed : -CameraSpeed)
        altY := (y > 0 ? CameraSpeed : -CameraSpeed)
        
        ; Move desktop cursor (still uses slow speed)
        MouseMove(x, y, 0, "R")
        ; Send raw camera signal (uses fast speed)
        DllCall("mouse_event", "UInt", 0x0001, "Int", altX, "Int", altY, "UInt", 0, "UInt", 0)
    } else {
        ; NO ALT: Use normal CursorSpeed for everything
        MouseMove(x, y, 0, "R")
        DllCall("mouse_event", "UInt", 0x0001, "Int", x, "Int", y, "UInt", 0, "UInt", 0)
    }

    ; Drag handling
    if GetKeyState("PgUp", "P") {
        Click("Down")
    } else {
        Click("Up")
    }
}

; --- Page Up / Down clicks ---
; Because Alt is now a modifier in the timer, these clicks act completely independently
PgUp::Click("Left")
PgDn::Click("Right")

#HotIf
