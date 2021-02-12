# Wikipedia Big Data Analysis

## Project Description

Project 1's analysis consists of using big data tools to answer questions about datasets from Wikipedia. There are a series of basic analysis questions, answered using Hive Query Language. The output of the analysis includes .hql files so that the analysis is a repeatable process that works on a larger dataset, not just an ad hoc calculation. Assumptions and simplfications are required in order to answer these questions, and the final presentation of results includes a discussion of those assumptions/simplifications and the reasoning behind them. In addition to answers and explanations, this project requires a discussion of any intermediate datasets and the reproduceable process used to construct those datasets. Finally, in addition to code outputs, this project requires a simple slide deck providing an overview of results. 

The questions follow: 
1. Which English wikipedia article got the most traffic on October 20, 2020? 
2. What English wikipedia article has the largest fraction of its readers follow an internal link to another wikipedia article? 
3. What series of wikipedia articles, starting with Hotel California, keeps the largest fraction of its readers clicking on internal links? 
4. Find an example of an English wikipedia article that is relatively more popular in the UK, then find the same for the US and Australia. 
5. How many users will see the average vandalized wikipedia page before the offending edit is reversed? 
6. Run an analysis you find interesting on the wikipedia datasets we're using.

## Technologies Used

* YARN
* HDFS
* Scala 2.13
* Hive
* Git + GitHub
* DBeaver

## Features

List of features ready and TODOs for future development
* 6 different .hql scripts corresponding to the question they answer
* 1 PowerPoint presentation analyzing the results at a high level

To-do list:
* Optimize databases to partition data
* Tweak queries to more accurately represent/answer questions 

## Getting Started
   
You can copy the repo using:
``` git clone https://github.com/HomelessSkittle/CJS-Wiki-Analysis.git ```

I ran my queries on a Hadoop "cluster" that ran only on my local machine, so your process for spinning up Hadoop + YARN daemons might look slightly different than this:

FROM YOUR MAIN HADOOP DIRECTORY:
```
sbin/start-dfs.sh
sbin/start-yarn.sh
```
Once the "cluster" is started, you can initalize a hive server:
```
hiveserver2
```
With the hiveserver running, you can connect to it with DBeaver and begin running queries.
(Again, my project was run totally on a locally hosted cluster, so my database was at localhost:10000)

## Usage

Using the project is simply editing and running, or simply just running the queries as they appear in the HQL files in your DBeaver.
The create for relevant tables is listed at the top of each .hql file, and a creation of the database is listed in Q1.hql. It is assumed you are using the same database for all queries.


## License

This project uses the following license: [<license_name>](<link>).
