#!/usr/bin/env python
# a line plot with errorbars
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
import csv
import string
import sys
from optparse import OptionParser

def getOptionParser():
    parser = OptionParser()
    parser.add_option('-f', '--file', help="set csv file", type='string', dest='file')
    parser.add_option('-n', '--name', help="set benchmark name", type='string', dest='name')
    return parser

def plot(csvFile, benchmarkScript):

	csvReader = csv.reader(open(csvFile))

	#defining default settings (in extra file too?)
	settings = {}
	settings['title'] = 'Stride'
	settings['xScale'] = 'linear'
	settings['xScaleBase'] = 10
	settings['xLabel'] = 'par_stride'
	settings['yLabel'] = 'CPU Cycles'
	settings['yDivider'] = 1
	settings['xDivider'] = 1
	settings['grid'] = 'none'
	settings['plotList'] = []

	#executing the particular script so settings is filled with customization
	# execfile(options.name + '.py')	
	execfile(benchmarkScript)

	line = csvReader.next()
	lineContents = line[0].split(' ')
	lineIndices = list()
	for entry in lineContents:
		for counter in settings['plotList']:
			if entry == counter:
				lineIndices.append(lineContents.index(entry))

	x = list()
	y = list()
	for index in lineIndices:
		z = list()
		y.append(z)

	for line in csvReader:
		lineContents = line[0].split(' ')
		x.append(int(lineContents[0]) / settings['xDivider'])
		for i in range(0,len(lineIndices)):
			y[i].append(int(lineContents[lineIndices[i]]) / settings['yDivider'])


	yy = np.arange(24)
	yy.shape = (6,4)

	mpl.rc('lines', linewidth=2)

	fig = plt.figure()
	mpl.rcParams['axes.color_cycle'] = ['r', 'g', 'b', 'c']
	ax = fig.add_subplot(2,1,1)
	for i in range(0,len(lineIndices)):
		ax.plot(x, y[i])
	ax.set_title(settings['title'])
	ax.set_xlabel(settings['xLabel'])
	ax.set_ylabel(settings['yLabel'])
	ax.set_xscale(settings['xScale'], basex=settings['xScaleBase'])
	if settings['grid'] is 'yAxis':
		ax.yaxis.grid(True)

	ax.annotate('Cache Linesize', (64, 500), xytext=None, xycoords='data', textcoords='data', arrowprops=None)

	plotDir = csvFile[:csvFile.rfind('/') + 1]
	plotName = csvFile[csvFile.rfind('/'):]
	plotName = plotName[:plotName.find('.')]
	
	plt.savefig(plotDir + plotName + '.pdf')
	# plt.show()


# parser = getOptionParser()
# (options, args) = parser.parse_args(sys.argv, None)

# if options.file == None:
# 	parser.print_help()
# 	sys.exit(0)

# plot(options.file, options.name)
