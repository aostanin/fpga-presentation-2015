VHDLEX ?= .vhd
TESTBENCHPATH ?= $(TESTBENCH)$(VHDLEX)
FILES += $(TESTBENCHPATH)

SIMDIR ?= ghdl
DOCKER_VOLUME ?= /work
DOCKER_PWD = $(DOCKER_VOLUME)/sim

DOCKER ?= docker run -w $(DOCKER_PWD) -v $(realpath $(PWD)/..):/work aostanin/ghdl
GHDL ?= ghdl
GHDL_IMPORT_FLAGS += --ieee=synopsys -fexplicit
GHDL_FLAGS += $(GHDL_IMPORT_FLAGS)

WAVEFORM_VIEWER ?= gtkwave

all: compile run

$(SIMDIR)/$(TESTBENCH): $(FILES)
	mkdir -p $(SIMDIR)
	$(DOCKER) $(GHDL) -i --mb-comments $(GHDL_IMPORT_FLAGS) --workdir=$(SIMDIR) $(FILES)
	$(DOCKER) $(GHDL) -m $(GHDL_FLAGS) --workdir=$(SIMDIR) $(TESTBENCH)
	mv $(TESTBENCH) $(SIMDIR)

compile: $(SIMDIR)/$(TESTBENCH)

$(SIMDIR)/$(TESTBENCH).ghw: $(SIMDIR)/$(TESTBENCH)
	$(DOCKER) sh -c 'cd $(SIMDIR); $(GHDL) -r $(TESTBENCH) $(GHDL_SIM_OPT) --wave=$(TESTBENCH).ghw'

run: $(SIMDIR)/$(TESTBENCH).ghw

view: $(SIMDIR)/$(TESTBENCH).ghw
	$(WAVEFORM_VIEWER) $(SIMDIR)/$(TESTBENCH).ghw $(WAVEFORM_SETTINGS)

clean:
	$(DOCKER) $(GHDL) --clean --workdir=$(SIMDIR)

