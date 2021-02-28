GHDL=ghdl
OPTIONS="--std=08"

# append '.pack' suffix to identify packages
PACKAGES=numeric_std.pack numeric_std-body.pack sillygamepack.pack

# GHDL hack to change ieee.numeric_std.all to work.numeric_std.all
GHDLHACK=enemy.ghdl

# use NO suffix for components
COMPONENTS=inputcontroller leddriver randomizer display gameclock player hittest sillygame

# also use NO suffix for testbenches
TESTS=

all: packages ghdlhack components
packages: $(PACKAGES)
ghdlhack: $(GHDLHACK)
components: $(COMPONENTS)
tests: $(TESTS)

%.pack: %.vhdl
	$(GHDL) -a $(OPTIONS) $<

%.ghdl: %.vhdl
	cat $< | sed 's/ieee.numeric_std.all/work.numeric_std.all/g' > $<-ghdl
	$(GHDL) -a $(OPTIONS) $<-ghdl

%: %.vhdl
	$(GHDL) -a $(OPTIONS) $<
	$(GHDL) -e $(OPTIONS) $@

clean:
	rm work-obj08.cf
