[ENABLE]
// Mono doit être activé (menu Cheat Engine - Mono - Activate mono features)
aobscanmodule(INJECTmoney,GameAssembly.dll,48 85 C0 0F 84 * * * * F2 0F 10 40 * F2 0F 11 44 24 30 8B 40 * 89 * * * 33)
alloc(newmem,$1000,INJECTmoney)
label(code memmoneyBck)
label(return)
newmem:
  push rax
  push rcx
  push rdx
  push r8
  sub rsp,10
  movaps [rsp],xmm1
  mov edx,(float)500000 // argent
  movd xmm1,edx
  xor edx,edx
  xor r8d,r8d
  db 48 8D 48
  readMem(INJECTmoney+D,1)
  sub rsp,60
  call BrokenArrow.Core.Security.GAFloat.set_Value
  add rsp,60
  movaps xmm1,[rsp]
  add rsp,10
  pop r8
  pop rdx
  pop rcx
  pop rax
code:
  readMem(INJECTmoney+9,5)
  jmp return
memmoneyBck:
  readMem(INJECTmoney+9,5)
INJECTmoney+9:
  jmp newmem
return:
registersymbol(INJECTmoney)
registersymbol(memmoneyBck)
[DISABLE]
INJECTmoney+9:
  readMem(memmoneyBck,5)
unregistersymbol(INJECTmoney)
unregistersymbol(memmoneyBck)
dealloc(newmem)