import psycopg2 
#import csv
con=psycopg2.connect(dbname= 'test', host='testpg.ttttttttt.us-west-1.rds.amazonaws.com',port= '5432', user= 'master', password= 'password')


cur=con.cursor()
insertquery=

#Start Stale Schemas

"""insert into clustermetrics.staleschemas
select distinct clustername, schemaname, schemasizemb, dateentered from clustermetrics.schemacapacity
where schemaname not in (
select distinct schemaname from clustermetrics.tablescanusers
where dateentered > CURRENT_DATE - INTERVAL '60 day' and schemaname not like 'pg%'
and clustername = 'Prod')
and schemaname not like 'pg%' and cast(dateentered as date) =CURRENT_DATE 
and clustername = 'Prod' ORDER BY schemasizemb DESC;


# End Stale Schemas


#Start Populate Top 3 Schemas table


truncate table clustermetrics.latestschemacapacity ; 

----- INSERT FOR PROD
insert into clustermetrics.latestschemacapacity 
SELECT clustername,  schemaname,schemasizegb , CURRENT_DATE 
FROM clustermetrics.rpt_latest_schema_capacity c
where dateentered = CURRENT_DATE
and clustername = 'Prod' order by schemasizegb desc limit 3;

insert into clustermetrics.latestschemacapacity 
select 'Prod', 'Remaining/Other Schemas', totalcapacitygb - 
(select sum(usedandremaining)from clustermetrics.latestschemacapacity 
where dateentered =CURRENT_DATE and clustername = 'Prod') as total, CURRENT_DATE 
from clustermetrics.clustercapacity where clustername = 'Prod' 
and dateentered = CURRENT_DATE;



---- table counts top 3 vs. Total  PROD
truncate table clustermetrics.latesttablecapacity ; 
INSERT INTO clustermetrics.latesttablecapacity 
SELECT  clustername, schema_name, count(distinct schema_name||table_name) as tablecount, CURRENT_DATE 
FROM clustermetrics.tablelist
where dateentered = CURRENT_DATE
and clustername = 'Prod' group by schema_name, clustername order by tablecount desc limit 3;



INSERT INTO clustermetrics.latesttablecapacity 
select 'Prod', 'Remaining/Other Schemas', cast(totalallowabletables as float) - 
(select sum(usedandremaining) from clustermetrics.latesttablecapacity 
where clustername = 'Prod' and dateentered = CURRENT_DATE), CURRENT_DATE
from clustermetrics.tablecountmetrics where clustername = 'Prod'
and dateentered = CURRENT_DATE; 



#End Populate Top 3 Schemas table


#start populate summary table information

insert into clustermetrics.summary_cluster_stats
select c.clustername, 
(select  cast(usedcapacitygb as float) / cast(totalcapacitygb as float)*100
from clustermetrics.clustercapacity ---where clustername = 'Prod'   
where dateentered > CURRENT_DATE - INTERVAL '1 day' and clustername = c.clustername
limit 1), 
(select maxconnectionsaverage from clustermetrics.rpt_connections_summary
where clustername = c.clustername order by "datetime" desc limit 1), 
(select averagevalue from clustermetrics.rpt_cpu_summary
where clustername = c.clustername
order by "datetime" desc  limit 1 ) , 

(select (cast(totaltablesallschemas as float) /9900) * 100
 from clustermetrics.tablecountmetrics 
where clustername = c.clustername and dateentered > CURRENT_DATE - INTERVAL '1 day'  limit 1), 
now() 

from clustermetrics.clustercapacity c group by c.clustername;


--- populate table for predictive summary information

truncate table clustermetrics.predictive_summary; 


--- Prod
insert into clustermetrics.predictive_summary
select clustername, 'Storage', 
percentchange , capacity_date, current_date
 from clustermetrics.vw_rpt_storage_change_prod limit 1; 
 
insert into clustermetrics.predictive_summary
select clustername, 'Table Count', 
percentchange , capacity_date,  current_date
 from clustermetrics.vw_rpt_table_count_change_prod limit 1 ;
 

insert into clustermetrics.predictive_summary
select clustername, 'CPU', 
percentchange , capacity_date, current_date
 from clustermetrics.vw_rpt_cpu_change_prod limit 1; 
 
insert into clustermetrics.predictive_summary
select clustername, 'Connections', 
percentchange , capacity_date, current_date
 from clustermetrics.vw_rpt_connections_change_prod limit 1; 




update clustermetrics.predictive_summary
set change2week  = substring(change2week, 1,5)
where cast(change2week as float) <> 0;

update clustermetrics.predictive_summary
set change2week  = '0'
where cast(change2week as float)  < 5;



update clustermetrics.predictive_summary
set change2week  = substring(change2week, 1,5)
where change2week not like '%+ .5%';

update  clustermetrics.predictive_summary
set capacitydate = 'N/A'
where cast(change2week as float) = 0;





#start populate summary table information

"""
cur.execute(insertquery)

con.commit()


