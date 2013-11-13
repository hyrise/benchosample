
#include "bencho.h"

#include <soci/soci.h>
#include <soci/odbc/soci-odbc.h>

#include <iostream>
#include <string>

using namespace soci;

class HanaConnection: public AbstractBenchmark
{
private:
    session sql;
    std::string tablename;
    std::string query;
   
public:

    static std::string name() { return "HanaConnection"; }


    void initialize()
    {
        setName("HanaConnection");
        setSequenceId("stride");
        setWarmUpRuns(0);
        setMaxRuns(1);
        
        
        addPerformanceCounter("walltime");
        

        std::unique_ptr<Parameter> partitions(new Parameter("partitions", 1, 2, 2, ParameterType::Multiply));
        std::unique_ptr<Parameter> type(new Parameter("type", 0, 2, 1, ParameterType::Add));
        addParameter(std::move(partitions));
        addParameter(std::move(type));
        
        addTestSeries(0, "select");
        addTestSeries(1, "count");
        addTestSeries(2, "min");
        addTestSeries(3, "max");

        setAggregatingFunction(AggregationType::Average); 

    }
    
    void prepareStart()
    {
        connection_parameters parameters("odbc", "DSN=hana;UID=System;PWD=System04");
        parameters.set_option(odbc_option_driver_complete, "0");
        sql.open(parameters);
    }
    
    void finalize()
    {
        sql.close();
    }
    
    void prepareCombination(std::map<std::string, int> parameters, int /*combination*/)
    {
        std::string partitionType;
        switch (parameters.at("type")) {
            case 0:
                partitionType = "H";
                break;
            default:
                partitionType = "R";
        }
        tablename = "PANDA.DATA_" + partitionType + "_" + std::to_string(parameters.at("partitions"));
    }
    
    void finishCombination(std::map<std::string, int> /*parameters*/, int /*combination*/)
    {
    }
    
    void prepareRun(std::map<std::string, int> /*parameters*/, int /*combination*/, int test_series_id, int /*run*/)
    {
        switch (test_series_id) {
            case 0:
                query = "SELECT * FROM " + tablename;
                break;
            case 1:
                query = "SELECT COUNT(*) FROM " + tablename;
                break;
            case 2:
                query = "SELECT MIN(id) FROM " + tablename;
                break;
            case 3:
                query = "SELECT MAX(id) FROM " + tablename;
                break;
        }
    }
    
    void finishRun(std::map<std::string, int> /*parameters*/, int /*combination*/, int /*test_series_id*/, int /*run*/)
    {
    }
    
    void doTheTest(std::map<std::string, int> /*parameters*/, int /*combination*/, int /*test_series_id*/, int /*run*/)
    {
        sql << query;
    }
};  


MAIN(HanaConnection)
