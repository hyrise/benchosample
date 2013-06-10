#!/usr/bin/env python
# customizable python plot settings for Stride benchmark. These settings cover the mostly used settings of matplotlib 
# but definitively not all. If something else should be specified, you can add the proper settings entry or
# overwrite functions to your needed behavior from system.py.

# This gets you the base class Pyplot from system.py provided by the Bencho library.
from system import Pyplot


class Myplot(Pyplot):

    def setUp(self):

        #First plot
        self.settings['xLabel'] = 'Stride in Bytes'
        self.settings['yLabel'] = 'CPU Cycles per Element'
        self.settings['yDivider'] = 4096
        self.settings['xScale'] = 'log'
        self.settings['xScaleBase'] = 2
        self.settings['grid'] = 'yAxis'
        self.settings['numberOfYTicks'] = 12
        self.settings['figureSize'] = (6.5, 8)
        self.settings['plotList'] = [('random_PAPI_TOT_CYC_y', 'Random'), ('sequential_forwards_PAPI_TOT_CYC_y', 'Sequential')]
        
        self.plots.append(dict(self.settings))
        

        #Second plot
        self.settings['title'] = 'Stride Random Cache Misses'
        self.settings['yLabel'] = 'Cache Misses per Element'
        self.settings['plotList'] = [('random_PAPI_L1_DCM_y', 'L1-Cache'), ('random_PAPI_L2_DCM_y', 'L2-Cache'), ('random_PAPI_L3_TCM_y', 'L3-Cache'), ('random_PAPI_TLB_DM_y', 'TLB')]
        
        self.plots.append(dict(self.settings))
        

        #Third plot
        self.settings['title'] = 'Stride Sequential Cache Misses'
        self.settings['yLabel'] = 'Cache Misses per Element'
        self.settings['plotList'] = [('sequential_forwards_PAPI_L1_DCM_y', 'L1-Cache'), ('sequential_forwards_PAPI_L2_DCM_y', 'L2-Cache'), ('sequential_forwards_PAPI_L3_TCM_y', 'L3-Cache'), ('sequential_forwards_PAPI_TLB_DM_y', 'TLB')]
        
        self.plots.append(dict(self.settings))


        #Fourth plot: Example Settings for a Boxplot
        self.settings['title'] = 'Stride Boxplot for Sequential Values'
        self.settings['yLabel'] = 'Stride in Bytes'
        self.settings['type'] = 'boxplot'
        self.settings['plotList'] = [('sequential_forwards_PAPI_TOT_CYC_y', 'Sequential')]

        self.plots.append(dict(self.settings))
        
myplot = Myplot()