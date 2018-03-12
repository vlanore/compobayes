.PHONY: all clean ready globom globom-coverage test

all: globom

globom: sources/tinycompo.hpp
	@cd sources && make --no-print-directory -j8 COMPOBAYES_EXTRA_FLAGS="-O3"

globom-coverage: sources/tinycompo.hpp
	@cd sources && make --no-print-directory -j8 COMPOBAYES_EXTRA_FLAGS="-O0 -fprofile-arcs -ftest-coverage" COMPOBAYES_EXTRA_LINK_FLAGS="-fprofile-arcs -ftest-coverage"

sources/tinycompo.hpp:
	@curl https://raw.githubusercontent.com/vlanore/tinycompo/master/tinycompo.hpp > $@

clean:
	@cd sources && make --no-print-directory clean

format:
	@cd sources && make --no-print-directory format

test: globom
	data/globom -d ../data/cyp_coding.phy -t ../data/cyp_2cond.tree -x 1 1 tmp

ready: all
	@cd sources && make format
	@git status
