ENTRY(_start)

SECTIONS
{
	. = 0x10000;
	.text : { *(.text) }
	. = 0x10100;
	.data : { *(.data) }
	.bss : { *(.bss) }
}
