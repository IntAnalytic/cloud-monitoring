Redshift Cluster Detailed Capacity/CPU/Connections/Table Counts and Usage Reporting Scripts

INTRODUCTION:
The purpose of scripts and associated schemas, tables and views associated with this process are intended 
to provide a single source for capacity and usage information from one or more Redshift clusters.  This information
in turn is used to populate a weekly capacity email, showing overall capacity, along with trending.

PRE-REQUISITES
- Server or AWS Workspace with access to source Redshift cluster and a destination PostGres RDS.
- AWS Command-Line Interface (AWSCLI) working with appropriate rights to read/query CloudWatch metrics.
- SQL Workbench / J and the corresponding Redshift / PostGresSqL jre (Java) drivers.
- SQL Workbench /J  profiles the source / destination databases.
- Separate local folders for Workbench, AWSCLI, Python code, Output Logs and Workbench scripts.  These will need to be documented and used
in the gathering batch file (Retrieve_Load_RS_database_data.bat).
- Specific permissions on the source cluster (grant scripts included); full permissions to the 
all resources Clustermetrics cluster on the destination.
- Logins on source/desinations clusters/RDS. 

DEPLOYMENT:
1. Copy the files into the their corresponding directories:
	-Contents of the py_db_query_scripts directory into a directory named PYTHON.  Note the location of this directory
	as it will be needed for a variable in the "Retrieve_Load_RS_database_data.bat" file.
	-Contents of the WB_DB_Upload_Scripts into a directory named Workbench_Scripts.  Note the location of this directory
	as it will be needed for a variable in the "Retrieve_Load_RS_database_data.bat" file.
	-Contents of Retrieval_Script into a directory named Retrieve_DB_Info.  Note the location of this file
	as it will be needed when configuring a scheduled task on a server
	-Contents of the clustermetrics_creation_scripts into a directory on the server/workspace.

2. Open SQL Workbench/J and create the following profiles:
	-Redshift, pointing to the source Redshift cluster
	-PostGresDestination, pointing to the destination PostGresSqL RDS 


3.  On the destination server in SQL Workbench / J:
	-Logged in as administrator on the Destination server, create a schema named clustermetrics.
	-Prior to running the script below, replace all instances of 'Prod' with the name of the Redshift cluster.
	-Run the clustermetrics_DDL_script.sql
	-If using a report user and not an administrator-level login, ensure all tables/views have select/update/insert rights. 

4.  Configure the Retrieve_Load_RS_database_data.bat file:
	- Set the PYTHON, AWSCLI, LogDirectory, Workbenchdirectory, and WorkbenchScripts to the correct directories on the server. 
	- Set the CLUSTERNAME to the source Cluster Name as defined in Cloudwatch/Redshift
	- Set the DestinationWBProfile to the destination RDS containing the clustermetrics schema

5.  Update the Workbench scripts to run against the source and insert the data into the destination.  This will require changing the source/destinations
    in each of the scripts in the Workbench_scripts directory:
	-The file being loaded is in the first line of the scripts.  The path to the file will need to be entered.  Note that drive:directory entries use a forward slash (/) not a back slash 
	as normally used in Windows.
	

6.  Test scripts to make sure data is properly reading the database information.

7.  If the previous step is successful, set up the job as a daily scheduled task.

