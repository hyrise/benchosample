


# plot cycles
###########################
set log x 2
set log x2 2
set format x "2^{%L}"
set xlabel "Stride in Bytes"
set ylabel "CPU Cycles per Element"
set xrange [1:262144]

set x2tics ('[Cache Linesize]' 64, '[Pagesize]' 4096)
set grid noxtics x2tics
JUMPS = 4096

plot\
    "DATAFILE" using ($1):(§@random_PAPI_TOT_CYC_y@§/JUMPS) title "Random" ls 1 with linespoints,\
    "DATAFILE" using ($1):(§@sequential_forwards_PAPI_TOT_CYC_y@§/JUMPS) title "Sequential" ls 2 with linespoints


# plot random cache misses
###########################
set output "plot2.ps"
set ylabel "Misses per Element"
set format y "%.1f"


plot\
    "DATAFILE" using ($1):(§@random_PAPI_L3_TCM_y@§/JUMPS) ls 3 with linespoints,\
    "DATAFILE" using ($1):(§@random_PAPI_L1_DCM_y@§/JUMPS) ls 1 with linespoints,\
    "DATAFILE" using ($1):(§@random_PAPI_L2_DCM_y@§/JUMPS) ls 2 with linespoints,\
    "DATAFILE" using ($1):(§@random_PAPI_TLB_DM_y@§/JUMPS) ls 4 with linespoints
    
    
# plot sequential cache misses
###########################
set output "plot3.ps"
set ylabel "Misses per Element"
set format y "%.1f"

plot\
    "DATAFILE" using ($1):(§@sequential_forwards_PAPI_L1_DCM_y@§/JUMPS) ls 1 with linespoints,\
    "DATAFILE" using ($1):(§@sequential_forwards_PAPI_L2_DCM_y@§/JUMPS) ls 2 with linespoints,\
    "DATAFILE" using ($1):(§@sequential_forwards_PAPI_L3_TCM_y@§/JUMPS) ls 3 with linespoints,\
    "DATAFILE" using ($1):(§@sequential_forwards_PAPI_TLB_DM_y@§/JUMPS) ls 4 with linespoints

