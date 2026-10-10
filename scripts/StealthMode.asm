[ENABLE]
define(PLAYERFLAG,GameAssembly.dll+112A20)
aobscanmodule(STEALTH,GameAssembly.dll,F3 0F 11 46 0C F3 44 0F 11 06)
alloc(stealthCave,$100,STEALTH)
label(stealthOriginal)
label(stealthBack)
registersymbol(STEALTH)

stealthCave:
  cmp byte ptr [PLAYERFLAG],1
  jne stealthOriginal
  mov dword ptr [rsi+0C],41200000   // AntiVisible = 10.0
  jmp stealthBack
stealthOriginal:
  db F3 0F 11 46 0C
stealthBack:
  jmp STEALTH+5

STEALTH:
  jmp stealthCave

[DISABLE]
STEALTH:
  db F3 0F 11 46 0C
unregistersymbol(STEALTH)
dealloc(stealthCave)