# Benchosample

A sample benchmark using the Bencho framework.

## Building

### Initialization

Supported operating systems are Linux and Max OS X, however the PAPI library wont work on the Apple operating systems.

To build Benchosample first you have to check if the Bencho framework submodule is initialized correctly.

	git submodule update --init

Further information to the framework: [Bencho](https://github.com/schwald/bencho)

### Running the sample

To run the sample benchmark, call

	make run

### Using Bencho

If you want to use Bencho for yourself, place your own benchmarks into the benchmarks/ folder and external include files into include/_name-of-benchmark_/.

Have a look at the sample benchmark source code (benchmarks/Stride.cpp) as well as the Bencho documentation to get to know how a benchmark has to be structured to work well with Bencho.

### Connecting Bencho to the SAP HANA database

Have a look at benchmarks/Soci_HanaConnection.cpp to get to know with the setup for benchmarking queries on the Hana database.
We are using the database access library [Soci](http://soci.sourceforge.net/index.html).
Also you have to have the SAP HANA Client installed. Then just add the soci-includes to your benchmark (see benchmarks/Soci_HanaConnection.cpp), compile with -I/_path-to-soci_/ and link with -lsoci_core -lsoci_odbc, just like in the provided sample Makefile.