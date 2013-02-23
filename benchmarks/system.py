#!/usr/bin/env python
# a line plot with errorbars
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
import csv
import string

csvReader = csv.reader(open('../results/Stride/Stride_1.result.csv'))

#defining default settings (in extra file too?)
settings = {}
settings['title'] = 'Stride'
settings['xScale'] = 'linear'
settings['xScaleBase'] = 10
settings['xLabel'] = 'par_stride'
settings['yLabel'] = 'CPU Cycles'
settings['plotList'] = []

#executing the particular script so settings is filled with customization
execfile('Stride.py')	

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
	x.append(int(lineContents[0]))
	for i in range(0,len(lineIndices)):
		y[i].append(int(lineContents[lineIndices[i]]))

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

plt.show()
