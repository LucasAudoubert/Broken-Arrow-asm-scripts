[ENABLE]
aobscanmodule(FUEL_SPAWN,GameAssembly.dll,45 0F B6 87 9D 00 00 00)
alloc(fuelCave,$100,FUEL_SPAWN)
label(fuelOriginal)
label(fuelBack)
registersymbol(FUEL_SPAWN)

fuelCave:
  mov rax,[r15+28]             // r15 = SpawnData -> OwnerInfo (PlayerInfo)
  test rax,rax
  jz fuelOriginal
  cmp byte ptr [rax+70],0      // _isBotSlot == 0 -> human player
  jne fuelOriginal
  mov r8d,1                    // infiniteFuel = true
  jmp fuelBack
fuelOriginal:
  movzx r8d,byte ptr [r15+9D]  // original: SpawnData.InfiniteFuel
fuelBack:
  jmp FUEL_SPAWN+8

FUEL_SPAWN:
  jmp fuelCave
  db 90 90 90

[DISABLE]
FUEL_SPAWN:
  db 45 0F B6 87 9D 00 00 00
unregistersymbol(FUEL_SPAWN)
dealloc(fuelCave)