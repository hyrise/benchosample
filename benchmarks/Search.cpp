#include "bencho.h"

#include <iostream>
#include <algorithm>

class Search: public AbstractBenchmark
{
private:
    std::vector<unsigned int> v;
    unsigned long long size;
    unsigned long long length;
    unsigned int searchVal;
    int val;
    
public:

    static std::string name() { return "Search"; }

    unsigned int g_seed; 
    inline void fast_srand( int seed ){ g_seed = seed; }

    inline int fastrand()
    {
        g_seed = (214013 * g_seed + 2531011);
        return g_seed;
    }


    void initialize()
    {
        setName("Search");
        setSequenceId("length");
        setWarmUpRuns(0);
        setMaxRuns(10);
        
        addPerformanceCounter("PAPI_TOT_CYC");

        Parameter *length = new Parameter("length", 1, 4 * 8192 * 1024 / 4, 2, ParameterType::Multiply);
        addParameter(length);
        
        addTestSeries(0, "linearSearch");
        addTestSeries(1, "binarySearch");
        addTestSeries(2, "std::lower_bound");
        addTestSeries(3, "std::find");

        g_seed = time(NULL);

        setAggregatingFunction(AggregationType::Average);
    }
    
    void prepareStart()
    {
		
    }
    
    void finalize()
    {
		
    }
    
    void prepareCombination(std::map<std::string, int> parameters, int /*combination*/)
    {
        length = parameters["length"];
        size = (size_t)parameters["length"];
        
        v.reserve(size);
        
        for(unsigned long long i = 0; i < length; i++)
            v.push_back(i);
        
    }
    
    void finishCombination(std::map<std::string, int> /*parameters*/, int /*combination*/)
    {
        v.clear();
    }
    
    void prepareRun(std::map<std::string, int> /*parameters*/, int /*combination*/, int /*test_series_id*/, int /*run*/)
    {
		clear();
		val = 0;
        searchVal = abs(fastrand() % length);
	}
    
    void finishRun(std::map<std::string, int> /*parameters*/, int /*combination*/, int /*test_series_id*/, int /*run*/)
    {
        std::cout << "Found " << val << " and searched for " << searchVal << "." << std::endl;
	}
    
    void doTheTest(std::map<std::string, int> /*parameters*/, int /*combination*/, int test_series_id, int /*run*/)
    {     
        std::vector<unsigned int>::iterator itr;

        switch (test_series_id) {
            case 0: {
                for (itr = v.begin(); itr != v.end(); ++itr) {
                    if (*itr == searchVal) {
                        val = *itr;
                        break;
                    }
                }
                break;
            }

            case 1: {
                int min = 0;
                int max = length - 1;

                while (min < max) {
                        int middle = (min + max) >> 1;
                        if (searchVal > v[middle])
                                min = middle + 1;
                        else
                                max = middle;
                }
                val = min;
                break;
            }

            case 2: {
                itr = std::lower_bound(v.begin(), v.end(), searchVal);
                val = *itr;
                break;
            }

            case 3: {
                itr = std::find(v.begin(), v.end(), searchVal);
                val = *itr;
                break;
            }
        }
    }
};  


MAIN(Search)
