#!/usr/bin/env python
# a line plot with errorbars

import sys
import system
from optparse import OptionParser

def getOptionParser():
    parser = OptionParser()
    parser.add_option('-f', '--file', help="set csv file", type='string', dest='file')
    parser.add_option('-s', '--scriptfile', help="set benchmarks script file", type='string', dest='scriptfile')
    return parser


parser = getOptionParser()
(options, args) = parser.parse_args(sys.argv, None)

if options.file == None:
	parser.print_help()
	sys.exit(0)

system.plot(options.file, options.scriptfile)