###
### This is the sample R script for plotting results with ggplot2
### It is dimensioned for the Stride benchmark,
### but can with little understanding of the R language easily be modified for other benchmarks
### The loading of requiered packages as well as getting of the directorys are done in the general 'system.r' in bencho/plotting/
### The first of three plot is highly commended to show what you can modify
### For further information have a look at http://docs.ggplot2.org
###


# The base name of the final plot files. Append an index for each individual plot below.
resultFileBase <- paste((strsplit(csvFile, ".result.csv")[[1]]), "_Rp_", sep="")


### Convert data into a readable table for ggplot (in "long format") ###

	# Declare which columns in your resultfile are the predefined values with which the benchmark worked
	preDefinedValues <- c("x","par_jumps","par_stride")
	# Declare which columns in your resultfile are the actual measured results
	measuredVariables <- c("random_PAPI_TOT_CYC_y", "sequential_forwards_PAPI_TOT_CYC_y")

	# Convert table to 'long' format. Check if the used counters exist to catch error below
	errorCheck <- try(
		data <- melt(read.table(csvFile, header=TRUE),
			id.vars=preDefinedValues,
			measure.vars=measuredVariables,
			variable.name="measuring",
			value.name="value")
	)

	# Rename variables that appear in the plot to better readability
	levels(data$measuring)[levels(data$measuring)=="random_PAPI_TOT_CYC_y"] <- "Random"
	levels(data$measuring)[levels(data$measuring)=="sequential_forwards_PAPI_TOT_CYC_y"] <- "Sequential"
	
### table ready to plot ###


### The actual plot command with several options ###

plot1 = (ggplot(data=data, aes(x=x, y=value, group=measuring, colour=measuring))
	# specify the title of the plot
	+ ggtitle("Stride")
	# specify the appearance of the plot with 'geom_*'
	#	(available e.g.: line, point, bar, errorbar, boxplot, density and many more)
	+ geom_line() + geom_point()
	# trans: scaling that ist applied to the data on the axis (befor plotting)
	#	(available e.g.: exp, identity, log, log10, log2, logit, pow10, reverse, sqrt)
	# breaks: function that defines where the lables should appear on the axis
	# labels needs 'breaks' to be defined
	+ scale_x_continuous("Stride in Bytes",
		trans="log2",
		breaks=trans_breaks("log2", function(x) 2^x)(2^0:2^20),
		labels=trans_format("log2", math_format(2^.x)))
	+ scale_y_continuous("CPU Cycles per Element",
		breaks=seq(0*4096,600*4096,100*4096),
		labels=function(x)x/4096)
	# specify the appearance of text elements, the legend etc.
	+ theme(text=element_text(family="Times", size=18, face="plain"),
		legend.title=element_text(colour="White"), # To make the legend title invisible
		legend.direction="vertical",
		legend.position="bottom"))

# correct naming of the first plot, with error check
if(class(errorCheck) != "try-error") {
	resultFile1 <- paste(resultFileBase, "1.pdf", sep="")
}
# save the plot

### end plot command ###



### Second plot ###

	preDefinedValues <- c("x","par_jumps","par_stride")
	measuredVariables <- c("random_PAPI_L1_DCM_y", "random_PAPI_L2_DCM_y", "random_PAPI_L3_TCM_y", "random_PAPI_TLB_DM_y")

	errorCheck <- try(
		data <- melt(read.table(csvFile, header=TRUE),
			id.vars=preDefinedValues,
			measure.vars=measuredVariables,
			variable.name="measuring",
			value.name="value")
	)

	levels(data$measuring)[levels(data$measuring)=="random_PAPI_L1_DCM_y"] <- "L1-Cache"
	levels(data$measuring)[levels(data$measuring)=="random_PAPI_L2_DCM_y"] <- "L2-Cache"
	levels(data$measuring)[levels(data$measuring)=="random_PAPI_L3_TCM_y"] <- "L3-Cache"
	levels(data$measuring)[levels(data$measuring)=="random_PAPI_TLB_DM_y"] <- "TLB"

plot2 = (ggplot(data=data, aes(x=x, y=value, group=measuring, colour=measuring))
	+ ggtitle("Stride Random Cache Misses")
	+ geom_line() + geom_point()
	+ scale_x_continuous("Stride in Bytes",
		trans="log2",
		breaks=trans_breaks("log2", function(x) 2^x)(2^0:2^20),
		labels=trans_format("log2", math_format(2^.x)))
	+ scale_y_continuous("Cache Misses per Element",
		breaks=seq(0*4096,3*4096,0.25*4096),
		labels=function(x)x/4096)
	+ theme(text=element_text(family="Times", size=18, face="plain"),
		legend.title=element_text(colour="White"), # To make the legend title invisible
		legend.direction="vertical",
		legend.position="bottom"))

if(class(errorCheck) != "try-error") {
	resultFile2 <- paste(resultFileBase, "2.pdf", sep="")
}

### end second plot ###



### Third plot ###

	preDefinedValues <- c("x","par_jumps","par_stride")
	measuredVariables <- c("sequential_forwards_PAPI_L1_DCM_y", "sequential_forwards_PAPI_L2_DCM_y", "sequential_forwards_PAPI_L3_TCM_y", "sequential_forwards_PAPI_TLB_DM_y")

	errorCheck <- try(
		data <- melt(read.table(csvFile, header=TRUE),
			id.vars=preDefinedValues,
			measure.vars=measuredVariables,
			variable.name="measuring",
			value.name="value")
	)

	levels(data$measuring)[levels(data$measuring)=="sequential_forwards_PAPI_L1_DCM_y"] <- "L1-Cache"
	levels(data$measuring)[levels(data$measuring)=="sequential_forwards_PAPI_L2_DCM_y"] <- "L2-Cache"
	levels(data$measuring)[levels(data$measuring)=="sequential_forwards_PAPI_L3_TCM_y"] <- "L3-Cache"
	levels(data$measuring)[levels(data$measuring)=="sequential_forwards_PAPI_TLB_DM_y"] <- "TLB"

plot3 = (ggplot(data=data, aes(x=x, y=value, group=measuring, colour=measuring))
	+ ggtitle("Stride Sequential Cache Misses")
	+ geom_line() + geom_point()
	+ scale_x_continuous("Stride in Bytes",
		trans="log2",
		breaks=trans_breaks("log2", function(x) 2^x)(2^0:2^20),
		labels=trans_format("log2", math_format(2^.x)))
	+ scale_y_continuous("Cache Misses per Element",
		breaks=seq(0*4096,3*4096,0.25*4096),
		labels=function(x)x/4096)
	+ theme(text=element_text(family="Times", size=18, face="plain"),
		legend.title=element_text(colour="White"), # To make the legend title invisible
		legend.direction="vertical",
		legend.position="bottom"))

if(class(errorCheck) != "try-error") {
	resultFile3 <- paste(resultFileBase, "3.pdf", sep="")
}

### end third plot ###


### Save all three plots as pdf (specified in filenames above) ###

try(ggsave(filename=resultFile1, plot=plot1, width=8, height=6))
try(ggsave(filename=resultFile2, plot=plot2, width=8, height=6))
try(ggsave(filename=resultFile3, plot=plot3, width=8, height=6))

###