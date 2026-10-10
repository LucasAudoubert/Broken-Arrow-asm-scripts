[ENABLE]
define(PLAYERFLAG,GameAssembly.dll+112A20)
aobscanmodule(PERCEPTION,GameAssembly.dll,F3 44 0F 11 06 F3 0F 11 7E 04 F3 0F 11 76 08)
alloc(perceptionCave,$100,PERCEPTION)
label(perceptionOriginal)
label(perceptionBack)
registersymbol(PERCEPTION)

perceptionCave:
  cmp byte ptr [PLAYERFLAG],1
  jne perceptionOriginal
  mov dword ptr [rsi],461C4000      // DistanceGround
  mov dword ptr [rsi+04],461C4000   // DistanceLowAlt
  mov dword ptr [rsi+08],461C4000   // DistanceHighAlt
  jmp perceptionBack
perceptionOriginal:
  db F3 44 0F 11 06
  db F3 0F 11 7E 04
  db F3 0F 11 76 08
perceptionBack:
  jmp PERCEPTION+0F

PERCEPTION:
  jmp perceptionCave
  db 90 90 90 90 90 90 90 90 90 90

[DISABLE]
PERCEPTION:
  db F3 44 0F 11 06 F3 0F 11 7E 04 F3 0F 11 76 08
unregistersymbol(PERCEPTION)
dealloc(perceptionCave)