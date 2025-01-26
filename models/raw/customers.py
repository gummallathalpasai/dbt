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

