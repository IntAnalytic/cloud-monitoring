CREATE SCHEMA clustermetrics; 

CREATE TABLE IF NOT EXISTS clustermetrics.clusterinformation
(
   clustername      varchar(200),
   clusterrevision  varchar(10),
   status           varchar(50),
   clusterversion   varchar(20),
   clustertype      varchar(100),
   nodes            varchar(5),
   dateentered      date
);


CREATE TABLE IF NOT EXISTS clustermetrics.prodconnections
(
   datapoint       varchar(100),
   maxconnections  numeric(10,2),
   datetime        varchar(100),
   measurment      varchar(20)
);



CREATE TABLE IF NOT EXISTS clustermetrics.prodcpu
(
   datapoint     varchar(50),
   averagevalue  numeric(10,2),
   datetime      varchar(100),
   typecount     varchar(100)
);



CREATE TABLE IF NOT EXISTS clustermetrics.proddescribecluster
(
   clustername                    varchar(100),
   rev                            integer,
   status                         varchar(100),
   env                            varchar(100),
   ver                            varchar(20),
   db                             varchar(50),
   elsize1                        varchar(50),
   elsize2                        varchar(50),
   upgrade                        varchar(20),
   encrypt                        varchar(20),
   keyid                          varchar(200),
   maintenancetrackname           varchar(200),
   manualsnapshotretentionperiod  varchar(10),
   masterlogin                    varchar(50),
   clustertype                    varchar(100),
   nodes                          varchar(100),
   preferredmaintenance           varchar(100),
   publiclyaccessible             varchar(20),
   vpcid                          varchar(100)
);



CREATE TABLE IF NOT EXISTS clustermetrics.prodpercentagediskspaceused
(
   datapoint         varchar(50),
   maxdiskspaceused  numeric(10,2),
   datetime          varchar(100),
   typecount         varchar(100)
);






CREATE TABLE IF NOT EXISTS clustermetrics.latestschemacapacity
(
   clustername        varchar(100),
   schemaorremaining  varchar(100),
   usedandremaining   float8,
   dateentered        date
);



CREATE TABLE IF NOT EXISTS clustermetrics.latesttablecapacity
(
   clustername            varchar(100),
   tablecountorremaining  varchar(100),
   usedandremaining       float8,
   dateentered            date
);



CREATE TABLE IF NOT EXISTS clustermetrics.loginactivity
(
   clustername          varchar(100),
   username             varchar(200),
   authentication_time  varchar(200),
   app_name             varchar(200),
   authmethod           varchar(100),
   duration             varchar(200),
   dateentered          date
);



CREATE TABLE IF NOT EXISTS clustermetrics.longrunningqueries
(
   clustername  varchar(150),
   username     varchar(200),
   starttime    varchar(100),
   endtime      varchar(100),
   querytext    varchar(64000),
   elapsed      varchar(500),
   dateentered  date
);



CREATE TABLE IF NOT EXISTS clustermetrics.predictive_summary
(
   clustername   varchar(100),
   metric        varchar(100),
   change2week   varchar(50),
   capacitydate  varchar(100),
   dateentered   date
);



CREATE TABLE IF NOT EXISTS clustermetrics.rpt_connections_change
(
   clustername     varchar(100),
   difference      float8,
   percentchange   float8,
   weeksuntilfull  float8,
   capacity_date   varchar(100),
   currentdate     varchar(100)
);



CREATE TABLE IF NOT EXISTS clustermetrics.rpt_cpu_change
(
   clustername     varchar(100),
   difference      float8,
   percentchange   float8,
   weeksuntilfull  float8,
   capacity_date   varchar(100),
   currentdate     varchar(100)
);



CREATE TABLE IF NOT EXISTS clustermetrics.rpt_storage_change
(
   clustername     varchar(100),
   difference      float8,
   percentchange   float8,
   weeksuntilfull  float8,
   capacity_date   varchar(100),
   currentdate     varchar(100)
);



CREATE TABLE IF NOT EXISTS clustermetrics.rpt_table_count_change
(
   clustername     varchar(100),
   difference      float8,
   percentchange   float8,
   weeksuntilfull  float8,
   capacity_date   varchar(100),
   currentdate     varchar(100)
);



CREATE TABLE IF NOT EXISTS clustermetrics.schemacapacity
(
   clustername   varchar(100),
   schemaname    varchar(200),
   schemasizemb  integer,
   dateentered   date
);



CREATE TABLE IF NOT EXISTS clustermetrics.staleschemas
(
   clustername   varchar(100),
   schemaname    varchar(100),
   schemasizemb  float8,
   dateentered   date
);



CREATE TABLE IF NOT EXISTS clustermetrics.summary_cluster_stats
(
   clustername            varchar(100),
   "Storage Capacity %"   float8,
   "Connections % Total"  float8,
   "CPU Avg %"            float8,
   "Table %"              float8,
   dateentered            date
);



CREATE TABLE IF NOT EXISTS clustermetrics.tablecountmetrics
(
   clustername            varchar(100),
   totaltablesallschemas  varchar(10),
   totalallowabletables   varchar(10),
   dateentered            date
);



CREATE TABLE IF NOT EXISTS clustermetrics.tableinserts
(
   clustername  varchar(100),
   username     varchar(100),
   starttime    varchar(100),
   endtime      varchar(100),
   schemaname   varchar(200),
   tablename    varchar(200),
   numberrows   varchar(50),
   dateentered  date
);



CREATE TABLE IF NOT EXISTS clustermetrics.tablelist
(
   clustername  varchar(100),
   schema_name  varchar(100),
   table_name   varchar(200),
   rowcount     bigint,
   size         bigint,
   dateentered  date
);



CREATE TABLE IF NOT EXISTS clustermetrics.tablemetrics
(
   schemaname   varchar(100),
   tablename    varchar(200),
   tablesizemb  varchar(200),
   rowcount     varchar(1100),
   dateentered  date
);



CREATE TABLE IF NOT EXISTS clustermetrics.tablescanmetrics
(
   clustername  varchar(100),
   schemaname   varchar(100),
   tablename    varchar(200),
   scans        varchar(50),
   dateentered  date
);



CREATE TABLE IF NOT EXISTS clustermetrics.tablescanusers
(
   clustername  varchar(100),
   usename      varchar(100),
   starttime    date,
   schemaname   varchar(100),
   tablename    varchar(100),
   dateentered  date
);



CREATE TABLE IF NOT EXISTS clustermetrics.testclustercapacity
(
   clustername      varchar(200),
   dateentered      date,
   totalcapacitygb  integer,
   usedcapacitygb   integer,
   freespacegb      integer
);

CREATE TABLE IF NOT EXISTS clustermetrics.totaldbspaceused
(
   rdsname      varchar(50),
   dbname       varchar(50),
   sizemb       float8,
   dateentered  varchar(100)
);



CREATE OR REPLACE VIEW clustermetrics.rpt_connections_summary
(
  clustername,
  maxconnectionsaverage,
  datetime
)
AS 
 SELECT 'Prod'::text AS clustername,
    prodconnections.maxconnections / 500::numeric * 100::numeric AS maxconnectionsaverage,
    prodconnections.datetime
   FROM clustermetrics.prodconnections
  ORDER BY 3 DESC;




CREATE OR REPLACE VIEW clustermetrics.rpt_cpu_summary
(
  clustername,
  averagevalue,
  datetime
)
AS 
 SELECT 'Prod'::text AS clustername,
    prodcpu.averagevalue,
    prodcpu.datetime
   FROM clustermetrics.prodcpu
  ORDER BY 3 DESC;



CREATE OR REPLACE VIEW clustermetrics.rpt_latest_cluster_capacity
(
  clustername,
  dateentered,
  totalcapacitygb,
  usedcapacitygb,
  freespacegb
)
AS 
 SELECT clustercapacity.clustername,
    clustercapacity.dateentered,
    clustercapacity.totalcapacitygb,
    clustercapacity.usedcapacitygb,
    clustercapacity.freespacegb
   FROM clustermetrics.clustercapacity
  WHERE clustercapacity.dateentered > (CURRENT_DATE - '1 day'::interval)
  ORDER BY clustercapacity.dateentered;





CREATE OR REPLACE VIEW clustermetrics.rpt_latest_schema_capacity
(
  clustername,
  schemaname,
  schemasizegb,
  dateentered
)
AS 
 SELECT DISTINCT schemacapacity.clustername,
    schemacapacity.schemaname,
    schemacapacity.schemasizemb / 1000 AS schemasizegb,
    schemacapacity.dateentered
   FROM clustermetrics.schemacapacity
  WHERE schemacapacity.dateentered > (CURRENT_DATE - '1 day'::interval) AND schemacapacity.schemaname::text !~~ 'pg%'::text
  ORDER BY (schemacapacity.schemasizemb / 1000) DESC;




CREATE OR REPLACE VIEW clustermetrics.rpt_latest_tablecountmetrics
(
  clustername,
  totaltablesallschemas,
  totalallowabletables,
  "?column?",
  dateentered
)
AS 
 SELECT tablecountmetrics.clustername,
    tablecountmetrics.totaltablesallschemas,
    tablecountmetrics.totalallowabletables,
    tablecountmetrics.totaltablesallschemas::double precision / tablecountmetrics.totalallowabletables::double precision * 100::double precision,
    tablecountmetrics.dateentered
   FROM clustermetrics.tablecountmetrics
  WHERE tablecountmetrics.dateentered > (CURRENT_DATE - '1 day'::interval)
  ORDER BY tablecountmetrics.dateentered DESC
 LIMIT 20;





CREATE OR REPLACE VIEW clustermetrics.vw_rpt_connections_change_prod
(
  clustername,
  difference,
  percentchange,
  weeksuntilfull,
  capacity_date,
  "current_date"
)
AS 
 SELECT a.clustername,
    a.connectionspercent - b.connectionspercent AS difference,
    (a.connectionspercent - b.connectionspercent) / b.connectionspercent * 100::double precision AS percentchange,
        CASE
            WHEN (((100::double precision - a.connectionspercent) / (a.connectionspercent - b.connectionspercent))::integer * 2) < 1 THEN 0
            ELSE ((500::double precision - a.connectionspercent) / (a.connectionspercent - b.connectionspercent))::integer * 2
        END AS weeksuntilfull,
        CASE
            WHEN (CURRENT_DATE + (((((100::double precision - a.connectionspercent) / (a.connectionspercent - b.connectionspercent))::integer * 2) || ' Weeks'::text)::interval)) < CURRENT_DATE THEN NULL::timestamp without time zone
            ELSE CURRENT_DATE + (((((100::double precision - a.connectionspercent) / (a.connectionspercent - b.connectionspercent))::integer * 2) || ' Weeks'::text)::interval)
        END AS capacity_date,
    CURRENT_DATE AS "current_date"
   FROM ( SELECT summary_cluster_stats.clustername,
            summary_cluster_stats."Connections % Total" AS connectionspercent
           FROM clustermetrics.summary_cluster_stats
          WHERE summary_cluster_stats.dateentered = CURRENT_DATE AND summary_cluster_stats.clustername::text = 'Prod'::text) a
     CROSS JOIN ( SELECT summary_cluster_stats.clustername,
            summary_cluster_stats."Connections % Total" AS connectionspercent
           FROM clustermetrics.summary_cluster_stats
          WHERE summary_cluster_stats.dateentered = (CURRENT_DATE - '14 days'::interval) AND summary_cluster_stats.clustername::text = 'Prod'::text) b;



CREATE OR REPLACE VIEW clustermetrics.vw_rpt_cpu_change_prod
(
  clustername,
  difference,
  percentchange,
  weeksuntilfull,
  capacity_date,
  "current_date"
)
AS 
 SELECT a.clustername,
    a.cpupercent - b.cpupercent AS difference,
    (a.cpupercent - b.cpupercent) / b.cpupercent * 100::double precision AS percentchange,
        CASE
            WHEN (((100::double precision - a.cpupercent) / (a.cpupercent - b.cpupercent))::integer * 2) < 1 THEN 0
            ELSE ((100::double precision - a.cpupercent) / (a.cpupercent - b.cpupercent))::integer * 2
        END AS weeksuntilfull,
        CASE
            WHEN (CURRENT_DATE + (((((100::double precision - a.cpupercent) / (a.cpupercent - b.cpupercent))::integer * 2) || ' Weeks'::text)::interval)) < CURRENT_DATE THEN NULL::timestamp without time zone
            ELSE CURRENT_DATE + (((((100::double precision - a.cpupercent) / (a.cpupercent - b.cpupercent))::integer * 2) || ' Weeks'::text)::interval)
        END AS capacity_date,
    CURRENT_DATE AS "current_date"
   FROM ( SELECT summary_cluster_stats.clustername,
            summary_cluster_stats."CPU Avg %" AS cpupercent
           FROM clustermetrics.summary_cluster_stats
          WHERE summary_cluster_stats.dateentered = CURRENT_DATE AND summary_cluster_stats.clustername::text = 'Prod'::text) a
     CROSS JOIN ( SELECT summary_cluster_stats.clustername,
            summary_cluster_stats."CPU Avg %" AS cpupercent
           FROM clustermetrics.summary_cluster_stats
          WHERE summary_cluster_stats.dateentered = (CURRENT_DATE - '14 days'::interval) AND summary_cluster_stats.clustername::text = 'Prod'::text) b;



CREATE OR REPLACE VIEW clustermetrics.vw_rpt_storage_change_prod
(
  clustername,
  difference,
  percentchange,
  weeksuntilfull,
  capacity_date,
  "current_date"
)
AS 
 SELECT a.clustername,
    a.usedcapacitygb - b.usedcapacitygb AS difference,
    (a.usedcapacitygb - b.usedcapacitygb) / b.usedcapacitygb * 100::double precision AS percentchange,
    ((a.totalcapacitygb - a.usedcapacitygb) / (a.usedcapacitygb - b.usedcapacitygb))::integer * 2 AS weeksuntilfull,
    CURRENT_DATE + (((((a.totalcapacitygb - a.usedcapacitygb) / (a.usedcapacitygb - b.usedcapacitygb))::integer * 2) || ' Weeks'::text)::interval) AS capacity_date,
    CURRENT_DATE AS "current_date"
   FROM ( SELECT clustercapacity.clustername,
            clustercapacity.usedcapacitygb::double precision AS usedcapacitygb,
            clustercapacity.totalcapacitygb::double precision AS totalcapacitygb
           FROM clustermetrics.clustercapacity
          WHERE clustercapacity.dateentered = CURRENT_DATE AND clustercapacity.clustername::text = 'Prod'::text) a
     CROSS JOIN ( SELECT clustercapacity.clustername,
            clustercapacity.usedcapacitygb::double precision AS usedcapacitygb
           FROM clustermetrics.clustercapacity
          WHERE clustercapacity.dateentered = (CURRENT_DATE - '14 days'::interval) AND clustercapacity.clustername::text = 'Prod'::text) b;




CREATE OR REPLACE VIEW clustermetrics.vw_rpt_table_count_change_prod
(
  clustername,
  difference,
  percentchange,
  weeksuntilfull,
  capacity_date,
  "current_date"
)
AS 
 SELECT a.clustername,
    a.totaltablesallschemas - b.totaltablesallschemas AS difference,
    (a.totaltablesallschemas - b.totaltablesallschemas) / b.totaltablesallschemas * 100::double precision AS percentchange,
    ((9900::double precision - a.totaltablesallschemas) / (a.totaltablesallschemas - b.totaltablesallschemas))::integer * 2 AS weeksuntilfull,
    CURRENT_DATE + (((((9900::double precision - a.totaltablesallschemas) / (a.totaltablesallschemas - b.totaltablesallschemas))::integer * 2) || ' Weeks'::text)::interval) AS capacity_date,
    CURRENT_DATE AS "current_date"
   FROM ( SELECT tablecountmetrics.clustername,
            tablecountmetrics.totaltablesallschemas::double precision AS totaltablesallschemas
           FROM clustermetrics.tablecountmetrics
          WHERE tablecountmetrics.dateentered = CURRENT_DATE AND tablecountmetrics.clustername::text = 'Prod'::text) a
     CROSS JOIN ( SELECT tablecountmetrics.clustername,
            tablecountmetrics.totaltablesallschemas::double precision AS totaltablesallschemas
           FROM clustermetrics.tablecountmetrics
          WHERE tablecountmetrics.dateentered = (CURRENT_DATE - '14 days'::interval) AND tablecountmetrics.clustername::text = 'Prod'::text) b;




