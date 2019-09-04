REM Script will load all cluster infor into PG RDS Reserved Instance

REM SET THE DEFAULT DIRECTORY FOR ALL THE LOGS AND OUTPUT FILES PRIOR TO RUNNING THIS FILE
REM Directories below are examples.  Actual directories would need to be configured prior

set LogDirectory = d:\users\%username%\logs
set WorkbenchDirectory= \users\%username%\workbench
set WorkBenchScripts = d:\users\%username%\WBScripts
set AWSCLI = d:\users\%username%\AWSCLI\Output
set PYTHON = d:\users\%username%\PYTHON
set CLUSTERNAME = TestCluster
set DestinationWBProfile = DestinationWBProfile

REM ==================  START  PROD RETRIEVAL AND UPLOAD

rem  PROD CLUSTER CAPACITY
d:
cd %WorkbenchDirectory%
    cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodloadcapacityerr.log' -script='%WorkBenchScripts%\wb_cluster_Capacity_load.txt' > %LogDirectory%\ProdCAPACITYoutput.txt
 
REM  PROD SCHEMA CAPACITY
    cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodschemaloaderr.log' -script='%WorkBenchScripts%\wb_schema_capacity.txt' > %LogDirectory%\prodschemacapacityoutput.txt
 
REM  PROD TABLE COUNTS
    cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodtablecountsloaderr.log' -script='%WorkBenchScripts%\wb_cluster_tablecounts.txt' > %LogDirectory%\Prodtablecountsoutput.txt

REM  PROD TABLE SCANS
    cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodtablescansloaderr.log' -script='%WorkBenchScripts%\wb_table_scan_metrics.txt' > %LogDirectory%\Prodtablescansoutput.txt


REM  PROD TABLE INSERTS
   cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodtableINSERTSloaderr.log' -script='%WorkBenchScripts%\wb_inserts.txt' > %LogDirectory%\Prodtableinsertsoutput.txt


REM  PROD TABLE LONG RUNNING QUERIES
   cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodtableLONGRUNNINGloaderr.log' -script='%WorkBenchScripts%\wb_long_running_queries.txt' > %LogDirectory%\Prodlongrunningqueriesoutput.txt


REM  PROD LOGINACTIVITY
    cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodLOGINACTIVITYoaderr.log' -script='%WorkBenchScripts%\wb_loginactivity.txt' > %LogDirectory%\Prodloginactivityoutput.txt


REM  PROD TABLE SCANS AND USERS
    cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodtablescansusersloaderr.log' -script='%WorkBenchScripts%\wb_tablescanusers.txt' > %LogDirectory%\Prodtablescansusersoutput.txt


REM  PROD table list
    cmd /c  java.exe  -jar sqlWorkbench.jar -logfile='%LogDirectory%\prodtablelistloaderr.log' -script='%WorkBenchScripts%\wb_tablelist.txt' > %LogDirectory%\Prodtablelistoutput.txt



REM ====================================END  PROD RETRIEVAL AND UPLOAD




REM =============== START AWSCLI CPU / CONNECTIONS RETRIEVAL


 

REM NEXT SECTION IS CPU/CONNECTIONS PULLED FROM AWSCLI



REM ---AWSCLI THEN WB INFO DOWNLOADED/UPLOADED FOR PROD

REM ------PROD CONNECTIONS THIS SECTION PREPS TEXT FILE, RUNS AWSCLI


c:
cd \program files (x86)\amazon\awscli\bin 
ECHO DATAPOINT	MAX	DATETIME	TYPECOUNT > %AWSCLI%\Prod_Conn.txt
rem Maximum for an entire day; period in seconds
 aws cloudwatch get-metric-statistics --metric-name DatabaseConnections --start-time 2019-01-01T23:59:00Z --end-time 2019-12-31T23:59:00Z --period 86400 --namespace AWS/Redshift --statistics Maximum --dimensions Name=ClusterIdentifier,Value=%CLUSTERNAME% --output text > %AWSCLI%\Prod_Conn_TEMP.txt
d:
cd %AWSCLI%
findstr /C:"DATAPOINTS" Prod_Conn_TEMP.txt >> Prod_Conn.TXT



REM ------PROD CPU - THIS SECTION PREPS TEXT FILE, RUNS AWSCLI

c:
cd \program files (x86)\amazon\awscli\bin 
ECHO DATAPOINT	AVG	DATETIME	TYPECOUNT > %AWSCLI%\Prod_CPU.txt
rem Maximum for an entire day; period in seconds
aws cloudwatch get-metric-statistics --metric-name CPUUtilization --start-time 2019-01-01T23:59:00Z --end-time 2019-12-31T02:59:00Z --period 86400 --namespace AWS/Redshift --statistics Average --dimensions Name=ClusterIdentifier,Value=%CLUSTERNAME% --output text > %AWSCLI%\Prodcpu_TEMP.txt
d:
cd %AWSCLI%\
findstr /C:"DATAPOINTS" %AWSCLI%\Prodcpu_TEMP.TXT >> %AWSCLI%\Prod_Cpu.TXT






REM ------THIS SECTION LOADS THE CONNECTION DATA INTO THE RESERVEDRDS INSTANCE CLUSTERMETRICS SCHEMA

cd %WorkbenchDirectory%
java.exe -jar sqlWorkbench.jar -profile='%DestinationWBProfile%' -logfile='%LogDirectory%\connoaderr.log' -script='%WorkBenchScripts%\wb_prod_connections.txt' > %LogDirectory%\wbconnouput.txt



REM ------THIS SECTION LOADS THE CPU DATA INTO THE RESERVEDRDS INSTANCE CLUSTERMETRICS SCHEMA

java.exe -jar sqlWorkbench.jar -profile='%DestinationWBProfile%' -logfile='%LogDirectory%\cpuloaderr.log' -script='%WorkBenchScripts%\wb_prod_cpu.txt' > %LogDirectory%\wbcpuouput.txt



REM  PROD LOAD CONNECTION/CPU DATA INTO RESERVED INSTANCE FOR ONE DAY


rem java.exe -jar sqlWorkbench.jar -profile='%DestinationWBProfile%' -logfile='%LogDirectory%\connonedayloaderr.log' -script='%WorkBenchScripts%\wb_prod_connections_oneday.txt' > %LogDirectory%\wbconnoutput_oneday.txt


REM ------  PROD THIS SECTION LOADS THE CPU ONE DAYDATA INTO THE RESERVEDRDS INSTANCE CLUSTERMETRICS SCHEMA

java.exe -jar sqlWorkbench.jar -profile='%DestinationWBProfile%' -logfile='%LogDirectory%\cpuloaderr_oneday.log' -script='%WorkBenchScripts%\wb_prod_cpu_oneday.txt' > %LogDirectory%\wbcpuoutput_oneday.txt




REM ======================== END AWSCLI CPU / CONNECTIONS RETRIEVAL

REM ------  PROD THIS SECTION LOADS THE PERCENTAGEDISKSPACSED ONE DAY DATA INTO THE RESERVEDRDS INSTANCE CLUSTERMETRICS SCHEMA


java.exe -jar sqlWorkbench.jar -profile='%DestinationWBProfile%' -logfile='%LogDirectory%\percentagediskspacsedloaderr_oneday.log' -script='%WorkBenchScripts%\wb_prod_percentagediskspacsed_oneday.txt' > %LogDirectory%\wbpercentagediskspacsedoutput_oneday.txt




REM ========================END   PROD AWSCLI PERCENTAGEDISKSPACSED BY DAY RETRIEVAL












REM ==========================START DATA ALIGNMENT AND CLEANUP - RUNS PYTHON SCRIPT TO CONSOLIDATE DATA FOR REPORTING



cd %PYTHON%

python data_retrieval_updates_cleanup.py

REM ==========================START DATA ALIGNMENT AND CLEANUP - RUNS PYTHON SCRIPT TO CONSOLIDATE DATA FOR REPORTING






REM  ===== START LOAD CLUSTER INFORMATION WITH SPECIFIC FIELDS - NEW CODE 7/3/2019


REM =====================START SECTION LOAD CLUSTER INFORMATION FOR  PROD 




c:
cd \Program Files (x86)\Amazon\AWSCLI\bin
aws redshift describe-clusters --cluster %CLUSTERNAME% --output text > %AWSCLI%\DESCRIBECLUSTER.out

D:
cd %AWSCLI%
python DESCRIBECLUSTERNEW.PY > DESCRIBECLUSTER.CSV
echo clustername, clusterrevision, status,clusterversion, clustertype, nodes,dateentered >  %AWSCLI%\DESCRIBECLUSTERload1.csv
TYPE  %AWSCLI%\DESCRIBECLUSTER.csv >>    %AWSCLI%\DESCRIBECLUSTERload1.csv



cd %WORKBENCH%
REM  PROD DESCRIBE CLUSTER INFORMATION
   cmd /c  java.exe  -jar sqlWorkbench.jar -profile='%DestinationWBProfile%' -logfile='%LogDirectory%\proddescribclusterloaderr.log' -script='%WorkBenchScripts%\wb_prod_describecluster_NEW.txt' > %LogDirectory%\Proddescribeclusteroutput.txt





REM  ===== END LOAD CLUSTER INFORMATION WITH SPECIFIC FIELDS - NEW CODE 7/3/2019





======  END LOAD CLUSTER INFORMATION FOR  PROD







REM  START LOAD PERCENTAGE DISK SPACE USED  PROD






c:
cd \program files (x86)\amazon\awscli\bin 
ECHO DATAPOINT	MAXDISKSPACEUSED	DATETIME	TYPECOUNT > %AWSCLI%\Prod_PercentageDiskSpacsed.txt
rem Maximum for an entire day; period in seconds
aws cloudwatch get-metric-statistics --metric-name PercentageDiskSpacsed --start-time 2019-01-01T23:59:00Z --end-time 2019-12-31T02:59:00Z --period 86400 --namespace AWS/Redshift --statistics Average --dimensions Name=ClusterIdentifier,Value=%CLUSTERNAME% --output text > %AWSCLI%\Prod_PercentageDiskSpacsed_TEMP.txt
d:
cd %AWSCLI%
findstr /C:"DATAPOINTS" %AWSCLI%\Prod_PercentageDiskSpacsed_TEMP.TXT >> %AWSCLI%\Prod_PercentageDiskSpacsed.TXT



cd d:\users\rhill\workbench
java.exe -jar sqlWorkbench.jar -profile='%DestinationWBProfile%' -logfile='percentagediskspacsedloaderr.log' -script='d:\users\rhill\awscli\prod\wb_prod_percentagediskspacsed.txt' > d:\users\rhill\awscli\prod\prod_output\wbpercentagediskspacsedouput.txt






REM  END LOAD PERCENTAGE DISK SPACE USED  PROD




















REM =====  LOAD CLUSTER INFORMATION INTO SINGLE SUMMARY TABLE


cd D:\Users\rhill\PYTHON\POPULATE_DESCRIBECLUSTER_TABLES
python populate_describe_cluster_tables_rds.py > output.txt




REM ================= END LOAD CLUSTER INFORMATION INTO SINGLE SUMMARY TABLE



