#RedShiftMonitoring main code
import psycopg2
import ClusterStats

import LSCuniccp
import LTCuniccp
import Schemasuniccp
import CDuniccp

import LSCinvsr
import LTCinvsr
import Schemasinvsr
import CDinvsr

import LSCcorppgs
import LTCcorppgs
import Schemascorppgs
import CDcorppgs

def DBConn():
    try:
        connection = psycopg2.connect(user = "ENTER USERNAME HERE",
                                  password = "ENTER PASSWORD HERE",
                                  host = "ENTER HOSTNAME HERE",
                                  port = "ENTER PORT NUMBER HERE",
                                  database = "ENTER DATABASE NAME HERE")
        cursor = connection.cursor()
        # Print PostgreSQL Connection properties
        print (connection.get_dsn_parameters(),"\n")
        # Print PostgreSQL version
        
        cursor.execute("select * from clustermetrics.summary_clusterstats;")
        rows1 = cursor.fetchall()
        ClusterStats.sendfunc(rows1)

        #Fetch data for sidebar
        cursor.execute("select * from clustermetrics.clustergeneralinformation;")
        cur = connection.cursor()
        sql = "COPY (select * from clustermetrics.clustergeneralinformation) TO STDOUT WITH DELIMITER ',' CSV HEADER"
        with open("sidebar.csv", "w") as file:
            cur.copy_expert(sql, file)

        #Fetch data for uni_ccp
        cursor.execute("select change2week, capacitydate from clustermetrics.predictive_summary where clustername='uni_ccp';")
        cur = connection.cursor()
        sql = "COPY (select change2week, capacitydate from clustermetrics.predictive_summary where clustername='uni_ccp') TO STDOUT WITH DELIMITER ',' CSV HEADER"
        with open("htmltable_uniccp.csv", "w") as file:
            cur.copy_expert(sql, file)

        cursor.execute("select schemaorremaining, usedandremaining from clustermetrics.latestschemacapacity where clustername = 'uni_ccp' order by usedandremaining asc;")
        rows2 = cursor.fetchall()
        LSCuniccp.sendfunc(rows2)

        cursor.execute("select tablecountorremaining, usedandremaining from clustermetrics.latesttablecapacity where clustername = 'uni_ccp' order by usedandremaining asc;")
        rows3 = cursor.fetchall()
        LTCuniccp.sendfunc(rows3)

        cursor.execute("select schemaorremaining, usedandremaining from clustermetrics.lateststaleschema where clustername = 'uni_ccp' order by usedandremaining asc;")
        rows4 = cursor.fetchall()
        Schemasuniccp.sendfunc(rows4)

        cursor.execute("select * from clustermetrics.summary_cluster_stats where clustername = 'uni_ccp' and cast(dateentered as date) between '2019-03-10' and '2019-06-11' order by dateentered asc;")
        cur = connection.cursor()
        sql = "COPY (select * from clustermetrics.summary_cluster_stats where clustername = 'uni_ccp' and cast(dateentered as date) between '2019-03-10' and '2019-06-11' order by dateentered asc) TO STDOUT WITH DELIMITER ',' CSV HEADER"
        with open("capacitydate_uniccp.csv", "w") as file:
            cur.copy_expert(sql, file)

        #Fetch data for inv_sr
        cursor.execute("select change2week, capacitydate from clustermetrics.predictive_summary where clustername='inv_sr';")
        cur = connection.cursor()
        sql = "COPY (select change2week, capacitydate from clustermetrics.predictive_summary where clustername='inv_sr') TO STDOUT WITH DELIMITER ',' CSV HEADER"
        with open("htmltable_invsr.csv", "w") as file:
            cur.copy_expert(sql, file)

        cursor.execute("select schemaorremaining, usedandremaining from clustermetrics.latestschemacapacity where clustername = 'inv_sr' order by usedandremaining asc;")
        rows5 = cursor.fetchall()
        LSCinvsr.sendfunc(rows5)

        cursor.execute("select tablecountorremaining, usedandremaining from clustermetrics.latesttablecapacity where clustername = 'inv_sr' order by usedandremaining asc;")
        rows6 = cursor.fetchall()
        LTCinvsr.sendfunc(rows6)

        cursor.execute("select schemaorremaining, usedandremaining from clustermetrics.lateststaleschema where clustername = 'inv_sr' order by usedandremaining asc;")
        rows7 = cursor.fetchall()
        Schemasinvsr.sendfunc(rows7)

        cursor.execute("select * from clustermetrics.summary_cluster_stats where clustername = 'inv_sr' and cast(dateentered as date) between '2019-03-10' and '2019-06-11' order by dateentered asc;")
        cur = connection.cursor()
        sql = "COPY (select * from clustermetrics.summary_cluster_stats where clustername = 'inv_sr' and cast(dateentered as date) between '2019-03-10' and '2019-06-11' order by dateentered asc) TO STDOUT WITH DELIMITER ',' CSV HEADER"
        with open("capacitydate_invsr.csv", "w") as file:
            cur.copy_expert(sql, file)

        #Fetch data for corp_pgs
        cursor.execute("select change2week, capacitydate from clustermetrics.predictive_summary where clustername='corp_pgs';")
        cur = connection.cursor()
        sql = "COPY (select change2week, capacitydate from clustermetrics.predictive_summary where clustername='corp_pgs') TO STDOUT WITH DELIMITER ',' CSV HEADER"
        with open("htmltable_corppgs.csv", "w") as file:
            cur.copy_expert(sql, file)

        cursor.execute("select schemaorremaining, usedandremaining from clustermetrics.latestschemacapacity where clustername = 'corp_pgs' order by usedandremaining asc;")
        rows8 = cursor.fetchall()
        LSCcorppgs.sendfunc(rows8)

        cursor.execute("select tablecountorremaining, usedandremaining from clustermetrics.latesttablecapacity where clustername = 'corp_pgs' order by usedandremaining asc;")
        rows9 = cursor.fetchall()
        LTCcorppgs.sendfunc(rows9)

        cursor.execute("select schemaorremaining, usedandremaining from clustermetrics.lateststaleschema where clustername = 'corp_pgs' order by usedandremaining asc;")
        rows10 = cursor.fetchall()
        Schemascorppgs.sendfunc(rows10)

        cursor.execute("select * from clustermetrics.summary_cluster_stats where clustername = 'corp_pgs' and cast(dateentered as date) between '2019-04-08' and '2019-06-17' order by dateentered asc;")
        cur = connection.cursor()
        sql = "COPY (select * from clustermetrics.summary_cluster_stats where clustername = 'corp_pgs' and cast(dateentered as date) between '2019-04-08' and '2019-06-17' order by dateentered asc) TO STDOUT WITH DELIMITER ',' CSV HEADER"
        with open("capacitydate_corppgs.csv", "w") as file:
            cur.copy_expert(sql, file)

    except (Exception, psycopg2.Error) as error :
        print ("Error while connecting to PostgreSQL", error)
    finally:
    #closing database connection.
        if(connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

DBConn()