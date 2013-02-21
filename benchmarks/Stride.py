#!/usr/bin/env python
# a line plot with errorbars
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
import csv
import string

plotList = ['random_PAPI_TOT_CYC_y', 'sequential_forwards_PAPI_TOT_CYC_y']

csvReader = csv.reader(open('../results/Stride/Stride_1.result.csv'))

line = csvReader.next()
lineContents = line[0].split(' ')
lineIndices = list()
for entry in lineContents:
	for counter in plotList:
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
ax.set_title('Stride')
ax.set_xscale('log')

plt.show()
