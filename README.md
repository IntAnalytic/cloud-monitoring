# Redshift monitoring and reporting
​
## Assumptions
​
- Python 3.7.3 is installed and properly configured.
- Required libraries are installed.
- User running the script has access to the folders  - `/images`.
- The folder `/images` exists.

## Required libraries
​
- matplotlib v3.0.3 (`$sudo pip install matplotlib==3.0.3`)
- numpy v1.16.2 (`$sudo pip install numpy==1.16.2`)
- pandas v0.24.2 (`$sudo pip install pandas==0.24.2`)
- plotly v3.10.0 (`$sudo pip install plotly==3.10.0`)
- psycopg2 v2.8.3 (`$sudo pip install psycopg2==2.8.3`)
- seaborn v0.9.0 (`$sudo pip install seaborn==0.9.0`)
​
## INSTALLATION
​
- Fill in the database (lines 22-26) and email (lines 140-142) credentials in `Main.py` file.
- Go to https://plot.ly/settings/api and sign up for a free plot.ly account. Get the username and api key from there and enter that into line 2 of `LSCuniccp.py`, `LSCinvsr.py`, `LSCcorppgs.py`, `LTCuniccp.py`, `LTCinvsr.py`, `LTCcorppgs.py`, `Schemasuniccp.py`, `Schemasinvsr.py`, and `Schemascorppgs.py`.
- Install all the required libraries. 
- Run `$python Main.py`.
​
## Usage
​
- When the program is executed, it connects to the database, and extracts data for generating graphs in the form of images.
- The program produces images and csv files in the default directory.
- It uses these files, and the html inside to send emails to respective email addresses after connecting to the smtp server. 
- When a new csv file is created in the above folder, its contents are read.

## REFERENCES
​
N/A
