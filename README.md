benchosample
============

A sample benchmark using the bencho framework.


FIRST USE

To place the 'bencho'-framework into this repository as git-submodule,
type the following commands (after you cloned the benchosample.benchosample repository here):

	git submodule init
	git submodule update (use this to update your submodule, too)

for further information, visit http://git-scm.com/book/en/Git-Tools-Submodules



Quickstart

	1. Place your benchmarks (.cpp files) in ./benchmarks/

	2. If needed, place external include-files (.h and/or .cpp) in ./include/

	3. run 'make config'	(only first time)
			PAPI recommended, but not available for Mac

	4. run 'make' and 'make run'


For further information check out the Bencho documentation (bencho/docs/index.html).