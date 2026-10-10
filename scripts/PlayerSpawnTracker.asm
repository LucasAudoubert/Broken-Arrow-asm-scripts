[ENABLE]
define(PLAYERFLAG,GameAssembly.dll+112A20)
aobscanmodule(FOW_CALL,GameAssembly.dll,4C 8D 41 58 48 8D 51 50 45 33 C9 48 8B 49 38 E8 83 50 FE FF)
alloc(fowCave,$100,FOW_CALL)
label(fowSkip)
registersymbol(FOW_CALL)

fowCave:
  mov r10,[rsp+340]
  mov r10,[r10+28]              // SpawnData -> OwnerInfo (PlayerInfo)
  test r10,r10
  jz fowSkip
  cmp byte ptr [r10+70],0       // _isBotSlot == 0 -> human player NOT AI!!!!
  jne fowSkip
  mov byte ptr [PLAYERFLAG],1
fowSkip:
  call GameAssembly.dll+34AF20  // original call: InitFogOfWar
  mov byte ptr [PLAYERFLAG],CC
  jmp FOW_CALL+14

FOW_CALL+0F:
  jmp fowCave

[DISABLE]
FOW_CALL+0F:
  db E8 83 50 FE FF
unregistersymbol(FOW_CALL)
dealloc(fowCave)