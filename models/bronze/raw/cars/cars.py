from pyspark.sql.types import StructField,StringType,DecimalType,TimestampType,StructType,IntegerType
from pyspark.sql.functions import lit,col,input_file_name
import pyspark.sql.types as T
import pyspark.sql.functions as F

CARS = StructType(fields=[
    StructField("Carid", StringType(),False),
    StructField("CarName", StringType(),False),
    StructField("Model",StringType(),False),
    StructField("Make", StringType(),False),
    StructField("Year",IntegerType(),False),
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
    df = session.read.schema(CARS).load(file_path, format="parquet/json/csv", pathGlobalFilter="*.parquet/json/csv")
    new_df = df.withColumn('Load_DTS',F.current_timestamp())
    return new_df