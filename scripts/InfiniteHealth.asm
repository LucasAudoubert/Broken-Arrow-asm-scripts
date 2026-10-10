[ENABLE]
aobscanmodule(HP_SPAWN,GameAssembly.dll,45 0F B6 80 9C 00 00 00)
alloc(healthCave,$100,HP_SPAWN)
label(healthOriginal)
label(healthBack)
registersymbol(HP_SPAWN)

healthCave:
  mov rax,[r8+28]             // r8 = SpawnData -> OwnerInfo (PlayerInfo)
  test rax,rax
  jz healthOriginal
  cmp byte ptr [rax+70],0     // _isBotSlot == 0 -> human player
  jne healthOriginal
  mov r8d,1                   // immortal = true
  jmp healthBack
healthOriginal:
  movzx r8d,byte ptr [r8+9C]  // original: SpawnData.Immortal
healthBack:
  jmp HP_SPAWN+8

HP_SPAWN:
  jmp healthCave
  db 90 90 90

[DISABLE]
HP_SPAWN:
  db 45 0F B6 80 9C 00 00 00
unregistersymbol(HP_SPAWN)
dealloc(healthCave)