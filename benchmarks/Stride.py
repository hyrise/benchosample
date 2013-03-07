#!/usr/bin/env python
# customizable python plot settings for Stride benchmark. These settings cover the mostly used settings of matplotlib 
# and definitely not all. If something else should be specified, feel free to add the settings entry or the specific 
# line in systems.py.

#Specify the title of your Plot (default: name of your benchmark)
settings['title'] = 'Stride'

#Uncomment next line to specify a label for the x axis (default: title of csv x-column)
settings['xLabel'] = 'Stride in Bytes'
#Uncomment next line to specify a label for the y axis (default: list of plotted column names)
settings['yLabel'] = 'CPU Cycles per Element'

#Uncomment next line if the yAxis tics should be divided by a special divider (like number on lines)
settings['yDivider'] = 4096
 
#Uncomment next line to specify the scale of your benchmark (default: linear)
settings['xScale'] = 'log'
#Uncomment next line to specify the base of a logarithmic scale (dafault: 10) 
settings['xScaleBase'] = 2

#Uncomment next line get a grid to the plot (default none, possible: xAxis, yAxis, both, none)
settings['grid'] = 'yAxis'

#Uncomment to specify the number of ticks on the y-Axis
settings['numberOfYTicks'] = 12

#Uncomment to specify the exact figure size
settings['figureSize'] = (6.5, 8)

#Specify the columns you want to have in your plot
settings['plotList'] = ['random_PAPI_TOT_CYC_y', 'sequential_forwards_PAPI_TOT_CYC_y']

plots.append(dict(settings))

#Specify the title of your Plot (default: name of your benchmark)
settings['title'] = 'Stride Random Cache Misses'

#Uncomment next line to specify a label for the y axis (default: list of plotted column names)
settings['yLabel'] = 'Chache Misses per Element'

#Specify the columns you want to have in your plot
settings['plotList'] = ['random_PAPI_L1_DCM_y', 'random_PAPI_L2_DCM_y', 'random_PAPI_L3_TCM_y', 'random_PAPI_TLB_DM_y']

plots.append(dict(settings))

#Specify the title of your Plot (default: name of your benchmark)
settings['title'] = 'Stride Sequential Cache Misses'

#Uncomment next line to specify a label for the y axis (default: list of plotted column names)
settings['yLabel'] = 'Chache Misses per Element'

#Specify the columns you want to have in your plot
settings['plotList'] = ['sequential_forwards_PAPI_L1_DCM_y', 'sequential_forwards_PAPI_L2_DCM_y', 'sequential_forwards_PAPI_L3_TCM_y', 'sequential_forwards_PAPI_TLB_DM_y']

plots.append(dict(settings))



