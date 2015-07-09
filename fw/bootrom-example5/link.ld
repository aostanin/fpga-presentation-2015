OUTPUT_ARCH(m68k)

MEMORY
{
  rom (rx)  : ORIGIN = 0x00000000, LENGTH = 0x2000
  ram (rwx) : ORIGIN = 0x10000000, LENGTH = 0x1000
}

SECTIONS
{
  .text : { *(.text*) } > rom
  .bss  : { *(.bss*)  } > rom
}
