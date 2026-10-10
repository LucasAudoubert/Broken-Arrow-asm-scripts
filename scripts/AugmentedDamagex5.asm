[ENABLE]
aobscanmodule(DAMAGE,GameAssembly.dll,F3 0F 10 41 64 C3 CC CC CC CC CC CC CC CC CC CC F3 0F 10 81 E0 00 00 00)
alloc(damageCave,$100,DAMAGE)
registersymbol(DAMAGE)

damageCave:
  movss xmm0,dword ptr [rcx+64]   // Ammunitions.Damage
  mov edx,(float)5.0              // <-- multiplier
  movd xmm1,edx
  mulss xmm0,xmm1
  ret

DAMAGE:
  jmp damageCave

[DISABLE]
DAMAGE:
  db F3 0F 10 41 64
unregistersymbol(DAMAGE)
dealloc(damageCave)