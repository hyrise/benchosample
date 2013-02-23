#!/usr/bin/env python
# customizable settings for python plot

#Specify the title of your Plot (default: name of your benchmark)
settings['title'] = 'Stride'

#Uncomment next line to specify a label for the x axis (default: title of csv x-column)
settings['xLabel'] = 'Stride in Bytes'
#Uncomment next line to specify a label for the y axis (default: list of plotted column names)
settings['yLabel'] = 'CPU Cycles per Element'
 
#Uncomment next line to specify the scale of your benchmark (default: linear)
settings['xScale'] = 'log'
#Uncomment next line to specify the base of a logarithmic scale (dafault: 10) 
settings['xScaleBase'] = 2

#Specify the columns you want to have in your plot
settings['plotList'] = ['random_PAPI_TOT_CYC_y', 'sequential_forwards_PAPI_TOT_CYC_y']

#settings[...]