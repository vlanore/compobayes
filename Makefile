.PHONY: all clean ready globom test

all: globom

globom: sources/tinycompo.hpp
	@cd sources && make --no-print-directory -j8

sources/tinycompo.hpp:
	@curl https://raw.githubusercontent.com/vlanore/tinycompo/master/tinycompo.hpp > $@

clean:
	@cd sources && make --no-print-directory clean

format:
	@cd sources && make --no-print-directory format

test:
	data/globom -d ../data/cyp_coding.phy -t ../data/cyp_2cond.tree -x 1 1 tmp

ready: all
	@cd sources && make format
	@git status
