-- 1. check storage integration
SHOW INTEGRATIONS;
-- AWSDDCFSNP_INTEGRATION

DESC INTEGRATION AWSDDCFSNP_INTEGRATION;
-- STORAGE_AWS_IAM_USER_ARN	String	arn:aws:iam::021712061285:user/qwyl-s-vass1253
-- STORAGE_AWS_EXTERNAL_ID	String	CAI_SFCRole=2_vcjZt6NINosfkTIqDUvIzClTJAA=
-- STORAGE_ALLOWED_LOCATIONS	List	*: all S3 bucket?

-- 2. stage: per Schema
SHOW stages;
-- SNOWFLAKE_AWSDDCFSNP_RDIM_STAGE	DT_SOFTWARE_ENGINEERING_DEV	RDIM

DESC STAGE SNOWFLAKE_AWSDDCFSNP_RDIM_STAGE
-- URL	String	["s3://snowflake-awsddcfsnp/DTBI/"]
-- STORAGE_INTEGRATION	String	AWSDDCFSNP_INTEGRATION
-- AWS_ROLE	String	arn:aws:iam::211620491330:role/snowflake-cai-storage-integration
-- AWS_EXTERNAL_ID	String	CAI_SFCRole=2_vcjZt6NINosfkTIqDUvIzClTJAA=
-- SNOWFLAKE_IAM_USER	String	arn:aws:iam::021712061285:user/qwyl-s-vass1253

-- 3. pipe: 
SHOW pipes;
-- 3.1 definition:
-- COPY INTO DT_SOFTWARE_ENGINEERING_DEV.RDIM.DIM_CUSTOMER_S3 
-- FROM @DT_SOFTWARE_ENGINEERING_DEV.RDIM.SNOWFLAKE_AWSDDCFSNP_RDIM_STAGE/RDIM/DIM_CUSTOMER/ 
-- FILE_FORMAT = (     TYPE=PARQUET,     REPLACE_INVALID_CHARACTERS=TRUE,     BINARY_AS_TEXT=FALSE ) MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE

-- 3.2 notification_channel (SQS)
-- arn:aws:sqs:us-east-1:021712061285:sf-snowpipe-AIDAIAEHI7HBOVJAUWCV6-hHmaW8W7qEPcSWrdpXeEtA

-- 4. streams
SHOW streams;

-- 5. tasks
use schema DT_SOFTWARE_ENGINEERING_DEV.RDIM;
show tasks
desc task dim_customer_task;

alter task dim_customer_task resume; 
alter task dim_customer_task suspend;


-- COMPLETE_TASK_GRAPHS(
--     [ RESULT_LIMIT => <integer> ]
--     [, ROOT_TASK_NAME => '<string>' ]
--     [, ERROR_ONLY => { TRUE | FALSE } ] );

-- COMPLETE_TASK_GRAPHS(
--     [ RESULT_LIHIT => 5 ]
--     [, ROOT_TASK_NAME => 'DT_SOFTWARE_ENGINEERING_DEV.RDIM.dim_customer_task' ]
--     [, ERROR_ONLY -> { TRUE1I |FALSE } ] );

-- select root_task_name, state 
-- from snowflake.account_usage.complete_task_graphs 
-- limit 10 ;

