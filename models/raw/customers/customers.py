from pyspark.sql.types import StructField,StringType,DecimalType,TimestampType,StructType,IntegerType
from pyspark.sql.functions import lit,col,input_file_name
import pyspark.sql.types as T
import pyspark.sql.functions as F

CUSTOMERS = StructType(fields=[
    StructField("Customerid", StringType(),False),
    StructField("CustomerName", StringType(),False),
    StructField("MobileNumber",IntegerType(),False),
    StructField("Gender", StringType(),False),
    StructField("Age",IntegerType(),False),
    StructField("Address",StringType(),False),
    StructField("City",StringType(),False),
    StructField("State",StringType(),False),
    StructField("ZipCode",StringType(),False),
])

def apply_schema_to_dataframe(df, schema):
    for field in schema.fields:
        df = df.withColumn(field.name, col(field.name).cast(field.dataType))
    return df

def model(dbt, session):
    dbt.config(
        materialized="incremental"
        format="delta",
        schema="bronze"
        incremental_strategy="append"
        on_schema_change="append"
    )

    file_path = dbt.config.get('landing_zone')
    file_name = dbt.config.get('file_name')
    df = session.read.schema(CUSTOMERS).load(file_path, format="parquet/json/csv", pathGlobalFilter="*.parquet/json/csv")
    new_df = df.withColumn('Load_DTS',F.current_timestamp())
    return new_df
