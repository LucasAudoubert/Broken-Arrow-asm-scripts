[ENABLE]
// DeckSlotModel.get_Count()           -> getter is at AOB+0xB
aobscanmodule(DEPLOY_MAIN,GameAssembly.dll,B0 01 48 83 C4 28 C3 CC CC CC CC 8B 41 38 C3)
// DeckSlotModel.get_TransportCount()  -> getter is at AOB+0xD
aobscanmodule(DEPLOY_TRAN,GameAssembly.dll,5B E9 C7 5F 00 00 CC CC CC CC CC CC CC 8B 41 3C C3)

DEPLOY_MAIN+B:
  // mov eax,[rcx+38] / test eax,eax / jz ret / mov eax,0x14 (20) / ret
  db 8B 41 38 85 C0 74 05 B8 14 00 00 00 C3
DEPLOY_TRAN+D:
  // same for TransportCount: mov eax,[rcx+3C] ...
  db 8B 41 3C 85 C0 74 05 B8 14 00 00 00 C3

registersymbol(DEPLOY_MAIN)
registersymbol(DEPLOY_TRAN)

[DISABLE]
DEPLOY_MAIN+B:
  db 8B 41 38 C3 CC CC CC CC CC CC CC CC CC
DEPLOY_TRAN+D:
  db 8B 41 3C C3 CC CC CC CC CC CC CC CC CC
unregistersymbol(DEPLOY_MAIN)
unregistersymbol(DEPLOY_TRAN)