#!/bin/bash

busted --coverage test
luacov src/
awk '/Summary/,/Total/' luacov.report.out
