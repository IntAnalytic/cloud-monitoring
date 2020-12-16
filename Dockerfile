FROM python:3.7.4-stretch

WORKDIR /home/centos/src

COPY . .

RUN pip install matplotlib==3.0.3 &&\
    pip install numpy==1.16.2 &&\
    pip install pandas==0.24.2 &&\
    pip install plotly==3.10.0 &&\
    pip install psycopg2==2.8.3 &&\
    pip install seaborn==0.9.0

CMD [ "python", "./Main.py"]
