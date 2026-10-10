[ENABLE]
aobscanmodule(RELOAD,GameAssembly.dll,0F 2F F0 0F 87 F2 00 00 00)
RELOAD+3:
  db 90 90 90 90 90 90
registersymbol(RELOAD)

[DISABLE]
RELOAD+3:
  db 0F 87 F2 00 00 00
unregistersymbol(RELOAD)