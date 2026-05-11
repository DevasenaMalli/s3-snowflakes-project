
USE HRMS;
USE SCHEMA ETL;

CREATE OR REPLACE FILE FORMATE HRMS.ETL.JSON_ETL_FILEFORMATE
TYPE = JSON;

CREATE OR REPLACE STAGE HRMS.ETL.AWS_ETL_JSON_STAGE
STORAGE_INTEGRATION = AWS_S3_INT
URL = 's3//learn2cloud-snowflakes/loadingdata/Json/'
FILE_FORMATE = JSON_ETL_FILEFORMATE

LIST @AWS_ETL_JSON_STAGE;

--Loading object Data

CREATE OR REPLACE TABLE EMPLPOEE_DATA_OBJECT
(
EMPLOYEE_INFO OBJECT
);

COPY INTO EMPLPOEE_DATA_OBJECT
(
FILES = ('employee_object.json')

)
SELECT * FROM EMPLPOEE_DATA_OBJECT;

SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: address
FROM EMPLPOEE_DATA_OBJECT

SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: address.city,
    EMPLOYEE_INFO: address.street,
    EMPLOYEE_INFO: address.state,
    EMPLOYEE_INFO: address.zip_code
FROM EMPLPOEE_DATA_OBJECT


SELECT 
    EMPLOYEE_INFO: employee_id :: STRING  AS EMPLOYEE_ID,
    EMPLOYEE_INFO: employee_name :: STRING  AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING       AS POSITION,
    EMPLOYEE_INFO: address.city :: STRING   AS CITY,              --make it string
    EMPLOYEE_INFO: address.street :: STRING AS STREET,
    EMPLOYEE_INFO: address.state :: STRING  AS STATE,
    EMPLOYEE_INFO: address.zip_code :: STRING AS ZIP_CODE
FROM EMPLPOEE_DATA_OBJECT;




---Load Array Data--

CREATE OR REPLACE TABLE EMPLOYEE_DATA_ARRAY
(
EMPLOYEE_INFO ARRAY
);
COPY INTO EMPLOYEE_DATA_ARRAY FROM @AWS_ETL_JSON_STAGE
FILE = ('employee_array.json')

SELECT * FROM EMPLOYEE_DATA_ARRAY;

SELECT EMPLOYEE_INFO FROM EMPLOYEE_DATA_ARRAY;

SELECT 
    EMPLOYEE_INFO[0],
    EMPLOYEE_INFO[1],
    EMPLOYEE_INFO[2]
FROM EMPLOYEE_DATA_ARRAY;

SELECT 
    EMPLOYEE_INFO[0] :: STRING PRIMARY_PHONE,
    EMPLOYEE_INFO[1] :: STRING SECONDARY_PHONE,
    EMPLOYEE_INFO[2] :: STRING TERITIARY_PHONE
FROM EMPLOYEE_DATA_ARRAY;


SELECT ARRAT_SIZE(EMPLOYEE_INFO) FROM EMPLOYEE_DATA_ARRAY;






--Loading Json Data---

CREATE OR REPLACE TABLE EMPLOYEE_DATA_JSON
(
EMPLOYEE_INFO VARIANT
);

COPY INTO EMPLOYEE_DATA_JSON FROM @AWS_ETL_JSON_STAGE
FILE = ('employee_E105.json')

SELECT * FROM EMPLOYEE_DATA_JSON;

SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position
    
FROM EMPLPOEE_DATA_JSON;

SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: phone_numbers
FROM EMPLPOEE_DATA_JSON;



SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: phone_numbers[0],
    EMPLOYEE_INFO: phone_numbers[1]
FROM EMPLPOEE_DATA_JSON;


SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: phone_numbers[0],
    EMPLOYEE_INFO: phone_numbers[1],
    EMPLOYEE_INFO: address
FROM EMPLPOEE_DATA_JSON;


SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: phone_numbers[0],
    EMPLOYEE_INFO: phone_numbers[1],
    EMPLOYEE_INFO: address.city,
    EMPLOYEE_INFO: address.street,
    EMPLOYEE_INFO: address.state,
    EMPLOYEE_INFO: address.zip_code
FROM EMPLPOEE_DATA_JSON;


SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: phone_numbers[0],
    EMPLOYEE_INFO: phone_numbers[1],
    EMPLOYEE_INFO: address.city,
    EMPLOYEE_INFO: address.street,
    EMPLOYEE_INFO: address.state,
    EMPLOYEE_INFO: address.zip_code,
    EMPLOYEE_INFO: skills
FROM EMPLPOEE_DATA_JSON;


SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: phone_numbers[0],
    EMPLOYEE_INFO: phone_numbers[1],
    EMPLOYEE_INFO: address.city,
    EMPLOYEE_INFO: address.street,
    EMPLOYEE_INFO: address.state,
    EMPLOYEE_INFO: address.zip_code,
    EMPLOYEE_INFO: skills[0],
    EMPLOYEE_INFO: skills[1],
    EMPLOYEE_INFO: skills[2]
    
FROM EMPLPOEE_DATA_JSON;



SELECT 
    EMPLOYEE_INFO: employee_id,
    EMPLOYEE_INFO: employee_name,
    EMPLOYEE_INFO: position,
    EMPLOYEE_INFO: phone_numbers[0],
    EMPLOYEE_INFO: phone_numbers[1],
    EMPLOYEE_INFO: address.city,
    EMPLOYEE_INFO: address.street,
    EMPLOYEE_INFO: address.state,
    EMPLOYEE_INFO: address.zip_code,
    EMPLOYEE_INFO: skills[0].skill_name,
    EMPLOYEE_INFO: skills[0].proficiency_level,
    EMPLOYEE_INFO: skills[1].skill_name,
    EMPLOYEE_INFO: skills[1].proficiency_level,
    EMPLOYEE_INFO: skills[2].skill_name,
    EMPLOYEE_INFO: skills[2].proficiency_level
    
FROM EMPLPOEE_DATA_JSON;

SELECT 
    EMPLOYEE_INFO: employee_id :: STRING        AS EMPLOYEE_ID,
    EMPLOYEE_INFO: employee_name :: STRING      AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING           AS POSITION,
    EMPLOYEE_INFO: phone_numbers[0] :: STRING   AS PRIMARY_NUMBER,
    EMPLOYEE_INFO: phone_numbers[1] :: STRING   AS SECONDARY_NUMBER,
    EMPLOYEE_INFO: address.city :: STRING       AS CITY,
    EMPLOYEE_INFO: address.street :: STRING     AS STREET_ADDRESS,
    EMPLOYEE_INFO: address.state :: STRING      AS STATE,
    EMPLOYEE_INFO: address.zip_code :: STRING   AS ZIP_CODE,
    EMPLOYEE_INFO: skills[0].skill_name         AS SKILL_NAME_1,
    EMPLOYEE_INFO: skills[0].proficiency_level  AS SKILL1_PROFICIENCY_LEVEL,
    EMPLOYEE_INFO: skills[1].skill_name         AS SKILL_NAME_2,
    EMPLOYEE_INFO: skills[1].proficiency_level  AS SKILL1_PROFICIENCY_LEVEL,
    EMPLOYEE_INFO: skills[2].skill_name         AS SKILL_NAME_3,
    EMPLOYEE_INFO: skills[2].proficiency_level  AS SKILL1_PROFICIENCY_LEVEL
FROM EMPLPOEE_DATA_JSON;


CREATE OR REPLACE TABLE JSON_EXTRACTED_EMPLOYEES
AS 
SELECT
    EMPLOYEE_INFO: employee_id :: STRING        AS EMPLOYEE_ID,
    EMPLOYEE_INFO: employee_name :: STRING      AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING           AS POSITION,
    EMPLOYEE_INFO: phone_numbers[0] :: STRING   AS PRIMARY_NUMBER,
    EMPLOYEE_INFO: phone_numbers[1] :: STRING   AS SECONDARY_NUMBER,
    EMPLOYEE_INFO: address.city :: STRING       AS CITY,
    EMPLOYEE_INFO: address.street :: STRING     AS STREET_ADDRESS,
    EMPLOYEE_INFO: address.state :: STRING      AS STATE,
    EMPLOYEE_INFO: address.zip_code :: STRING   AS ZIP_CODE,
    EMPLOYEE_INFO: skills[0].skill_name         AS SKILL_NAME_1,
    EMPLOYEE_INFO: skills[0].proficiency_level  AS SKILL1_PROFICIENCY_LEVEL,
    EMPLOYEE_INFO: skills[1].skill_name         AS SKILL_NAME_2,
    EMPLOYEE_INFO: skills[1].proficiency_level  AS SKILL1_PROFICIENCY_LEVEL,
    EMPLOYEE_INFO: skills[2].skill_name         AS SKILL_NAME_3,
    EMPLOYEE_INFO: skills[2].proficiency_level  AS SKILL1_PROFICIENCY_LEVEL
FROM EMPLPOEE_DATA_JSON;


SELECT * FROM JSON_EXTRACTED_EMPLOYEES;



---Lateral Flatten----

CREATE OR REPLACE TABLE EMPLOYEE_DATA_JSON_FLATTEN
(
EMPLOYEE_INFO VARIANT
);

COPY INTO EMPLOYEE_DATA_JSON_FLATTEN FROM @AWS_ETL_JSON_STAGE
FILE = ('employee_E105.json')

SELECT * FROM EMPLOYEE_DATA_JSON_FLATTEN;

SELECT
EMPLOYEE_INFO: employee_id :: STRING           AS EMPLOYEE_ID,
EMPLOYEE_NAME: employee_name :: STRING         AS EMPLOYEE_NAME,
EMPLOYEE_INFO: position :: STRING              AS JOB_TITLE

FROM EMPLOYEE_DATA_JSON_FLATTEN;


SELECT
    EMPLOYEE_INFO: employee_id :: STRING           AS EMPLOYEE_ID,
    EMPLOYEE_NAME: employee_name :: STRING         AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING              AS JOB_TITLE,
    f.*

FROM EMPLOYEE_DATA_JSON_FLATTEN, lateral flatten(EMPLOYEE_INFO:phone_numbers) f;



SELECT
    EMPLOYEE_INFO: employee_id :: STRING           AS EMPLOYEE_ID,
    EMPLOYEE_NAME: employee_name :: STRING         AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING              AS JOB_TITLE,
    fp.VALUE

FROM EMPLOYEE_DATA_JSON_FLATTEN, lateral flatten(EMPLOYEE_INFO:phone_numbers) fp;

SELECT
    EMPLOYEE_INFO: employee_id :: STRING           AS EMPLOYEE_ID,
    EMPLOYEE_NAME: employee_name :: STRING         AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING              AS JOB_TITLE,
     fs.VALUE

FROM EMPLOYEE_DATA_JSON_FLATTEN, lateral flatten(EMPLOYEE_INFO:skills) fs;


SELECT
    EMPLOYEE_INFO: employee_id :: STRING           AS EMPLOYEE_ID,
    EMPLOYEE_NAME: employee_name :: STRING         AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING              AS JOB_TITLE,
     fs.VALUE: proficiency_level                    AS proficiency_level,
     fs.VALUE: skill_name                           AS skill_name

FROM EMPLOYEE_DATA_JSON_FLATTEN, lateral flatten(EMPLOYEE_INFO:skills) fs;



SELECT
    EMPLOYEE_INFO: employee_id :: STRING           AS EMPLOYEE_ID,
    EMPLOYEE_NAME: employee_name :: STRING         AS EMPLOYEE_NAME,
    EMPLOYEE_INFO: position :: STRING              AS JOB_TITLE,                   ---We can flatten querry with multiple arrays
     fs.VALUE: proficiency_level                    AS proficiency_level,
     fs.VALUE: skill_name                           AS skill_name,
     fp.VALUE

FROM EMPLOYEE_DATA_JSON_FLATTEN, lateral flatten(EMPLOYEE_INFO:skills) fs, lateral flatten(EMPLOYEE_INFO:phone_numbers) fp;
