[ENABLE]
aobscanmodule(BOMBRELOAD,GameAssembly.dll,F3 0F 10 B0 84 00 00 00 EB 64)
BOMBRELOAD:
  db 0F 57 F6 90 90 90 90 90   // xorps xmm6,xmm6 (timer=0) + nops
registersymbol(BOMBRELOAD)

[DISABLE]
BOMBRELOAD:
  db F3 0F 10 B0 84 00 00 00
unregistersymbol(BOMBRELOAD)