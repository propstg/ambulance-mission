#!/bin/bash

abort() {
	printf "\n\nABORTING: $1\n"
	exit 1
}

rm -rf luacov.report.out luacov.stats.out

printf '\n==============================================================================\n'
printf 'Unit tests'
printf '\n==============================================================================\n'
busted --coverage test/ || abort "unit tests failed"
cat luacov.stats.out

printf '\n==============================================================================\n'
printf 'Luacheck'
printf '\n==============================================================================\n'
luacheck src || abort "linting failed"

luacov -h

echo $(pwd)/src/

luacov $(pwd)/src/

cat luacov.report.out

printf '\n==============================================================================\n'
printf 'Coverage '
awk '/Summary/,/Total/' luacov.report.out

printf '\nView luacov.report.out for detailed coverage information.\n\n'
