.PHONY: all clean ready globom globom-coverage test

all: globom

globom: sources/tinycompo.hpp
	@cd sources && make --no-print-directory -j8 COMPOBAYES_EXTRA_FLAGS="-O3"

globom-coverage: sources/tinycompo.hpp
	@cd sources && make --no-print-directory -j8 CPPFLAGS="--std=c++11 -O0 -fprofile-arcs -ftest-coverage" LDFLAGS="-fprofile-arcs -ftest-coverage"

sources/tinycompo.hpp:
	@curl https://raw.githubusercontent.com/vlanore/tinycompo/master/tinycompo.hpp > $@

clean:
	@cd sources && make --no-print-directory clean

format:
	@cd sources && make --no-print-directory format

test: globom
	data/globom -t data/c3c4/C4Amaranthaceae.tree -d data/c3c4/C4Amaranthaceaeshort.ali -x 1 1 tmp

mvcov: all
	find _build -type f -name "*.gcno" -exec mv -t src/ {} +
	find _build -type f -name "*.gcda" -exec mv -t src/ {} +

ready: all
	@cd sources && make format
	@git status
