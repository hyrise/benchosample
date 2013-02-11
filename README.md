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

Have a look at the sample benchmark source code as well as the Bencho documentation to get to know how a benchmark has to be structured to work well with Bencho.