PREFIX ?= m68k-unknown-elf
CC = $(PREFIX)-gcc
CC_OPTS ?= -nostdlib -m68000 -std=c99 -Wall
LD_OPTS ?= 
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
BIN2VHDL ?= ../bin2vhdl.py

all: $(TARGET).vhd

$(TARGET).elf: $(SRC)
	$(CC) $(CC_OPTS) $(LD_OPTS) $(SRC) -o $(TARGET).elf

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

$(TARGET).vhd: $(TARGET).bin
	$(BIN2VHDL) $(TARGET).bin $(TARGET).vhd

disassem: $(TARGET).elf
	$(OBJDUMP) -d $(TARGET).elf

copy: $(TARGET).vhd
	cp $(TARGET).vhd ../../hdl/bootrom.vhd

clean:
	rm -f $(TARGET).elf $(TARGET).bin $(TARGET).vhd

