[ENABLE]
aobscanmodule(SMOKE,GameAssembly.dll,E8 FC 8E 19 00 45 33 C0 48 8D 4C 24 60 8D 50 FF E8 BC 8E 19 00)
SMOKE+0D:
  db 8D 50 00    // lea edx,[rax] instead of [rax-1]
registersymbol(SMOKE)

[DISABLE]
SMOKE+0D:
  db 8D 50 FF
unregistersymbol(SMOKE)