SNOWFLAKE_SAMPLE_DATA-- use sysadmin role
use role sysadmin;

-- create development sandbox database/schema if does not exist
create database if not exists sandbox;
use database sandbox;

-- create a warehouse if not exist 
create warehouse if not exists adhoc_wh
     comment = 'This is the adhoc-wh'
     warehouse_size = 'x-small' 
     auto_resume = true 
     auto_suspend = 60 
     enable_query_acceleration = false 
     warehouse_type = 'standard' 
     min_cluster_count = 1 
     max_cluster_count = 1 
     scaling_policy = 'standard'
     initially_suspended = true;

-- Created 4 schemas, 1 for each of the 3 layers and 1 for all of them. 
create schema if not exists stage_sch;
create schema if not exists clean_sch;
create schema if not exists consumption_sch;
create schema if not exists common;

use schema stage_sch;

--create file format to process the csv file
  create file format if not exists stage_sch.csv_file_format 
        type = 'csv' 
        compression = 'auto' 
        field_delimiter = ',' 
        record_delimiter = '\n' 
        skip_header = 1 
        field_optionally_enclosed_by = '\042' 
        null_if = ('\\N');

--created a stage
    --  csv_stg under stage_sch schema is a place where data will be first loaded before entering into eternal table
create stage stage_sch.csv_stg
    directory = (enable = true)
    comment = 'this is the snowflake internal stage';

show stages in schema stage_sch;

--created a tag 
create or replace tag
    common.pii_policy_tag
    allowed_values 'PII','PRICE','SENSITIVE','EMAIL'
    comment = 'This is PII policy tag object';

create or replace masking policy 
    common.pii_masking_policy as (pii_text string)
    returns string -> 
    to_varchar('** PII **');

create or replace masking policy 
    common.email_masking_policy as (email_text string)
    returns string -> 
    to_varchar('** EAMIL **');

create or replace masking policy 
    common.phone_masking_policy as (phone string)
    returns string -> 
    to_varchar('** Phone **');


-- loading data and validating the date
-- HOW MANY FILES ARE PRESENT IN YOUR STAGE
list @STAGE_SCH.CSV_STG


select 
        t.$1::text as locationid, -- $ means first column
        t.$2::text as city, -- $ means second column
        t.$3::text as state,
        t.$4::text as zipcode,
        t.$5::text as activeflag,
        t.$6::text as createddate,
        t.$7::text as modifieddate,
    from @stage_sch.csv_stg/initial/location 
    (file_format => 'stage_sch.csv_file_format') t;


