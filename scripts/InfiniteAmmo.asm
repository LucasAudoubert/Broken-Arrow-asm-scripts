[ENABLE]
aobscanmodule(AMMO,GameAssembly.dll,48 89 5C 24 08 57 48 83 EC 50 80 3D D3 18 9F 07 00 48 8B D9)
AMMO:
  db B8 0F 27 00 00 C3    // mov eax,270F (9999) ; ret
registersymbol(AMMO)

[DISABLE]
AMMO:
  db 48 89 5C 24 08 57
unregistersymbol(AMMO)