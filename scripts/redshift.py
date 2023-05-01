import psycopg2
import configparser


def redshift_function():
    # Read the config file
    path = "/Users/gomes/Desktop/Projects/utils/Data-Engineer-Real-time-Transactions/config/config.ini"
    config = configparser.ConfigParser()
    config.read(path)

    # Replace these values with your Redshift connection details
    dbname = config.get("REDSHIFT", "RED_NAME")
    user = config.get("REDSHIFT", "RED_USER")
    password = config.get("REDSHIFT", "RED_PASSWORD")
    host = config.get("REDSHIFT", "RED_HOST")
    port = config.get("REDSHIFT", "RED_PORT")
    redshift_iam_role = config.get("REDSHIFT", "RED_IAM_ROLE")

    aws_access_key_id = config.get("AWS", "AWS_ACCESS_KEY_ID")
    aws_secret_access_key = config.get("AWS", "AWS_SECRET_ACCESS_KEY")
    aws_region = config.get("AWS", "AWS_REGION")
    target_bucket = config.get("S3", "TARGET_BUCKET")

    # Connect to the Redshift instance
    connection = psycopg2.connect(
        dbname=dbname, user=user, password=password, host=host, port=port
    )

    cursor = connection.cursor()

    # Create the dimensional modeling tables
    create_dim_dates = """
    CREATE TABLE dimdates (
        DateID INTEGER PRIMARY KEY,
        Date DATE,
        Day INTEGER,
        Month INTEGER,
        Year INTEGER,
        Quarter INTEGER,
        Weekday VARCHAR(10)
    );
    """

    create_dim_customers = """
    CREATE TABLE dimcustomers (
        CustomerID INTEGER PRIMARY KEY,
        FirstName VARCHAR(50),
        LastName VARCHAR(50),
        Email VARCHAR(100),
        Gender VARCHAR(10),
        DateOfBirth DATE,
        RegistrationDate DATE,
        AgeGroup VARCHAR(20),
        Address VARCHAR(100),
        City VARCHAR(50),
        State VARCHAR(50),
        Country VARCHAR(50),
        ZipCode VARCHAR(20)
    );
    """

    create_dim_products = """
    CREATE TABLE dimproducts (
        ProductID INTEGER PRIMARY KEY,
        ProductName VARCHAR(100),
        CategoryID INTEGER,
        CategoryName VARCHAR(100),
        Brand VARCHAR(50),
        Description TEXT,
        Price DECIMAL(10, 2),
        ImageURL VARCHAR(300)
    );
    """

    create_fact_sales = """
    CREATE TABLE factsales (
        SalesID INTEGER PRIMARY KEY,
        CustomerID INTEGER,
        ProductID INTEGER,
        DateID INTEGER,
        Quantity INTEGER,
        TotalAmount DECIMAL(10, 2),
        FOREIGN KEY (CustomerID) REFERENCES dimcustomers (CustomerID),
        FOREIGN KEY (ProductID) REFERENCES dimproducts (ProductID),
        FOREIGN KEY (DateID) REFERENCES dimdates (DateID)
    );
    """

    cursor.execute(create_dim_dates)
    cursor.execute(create_dim_customers)
    cursor.execute(create_dim_products)
    cursor.execute(create_fact_sales)

    # Load data from S3 Parquet files into Redshift tables
    # You'll need to adjust the 's3://...' paths to match your S3 bucket structure
    copy_dim_dates = f"""
    COPY dimdates
    FROM 's3://{target_bucket}/dates/'
    IAM_ROLE '{redshift_iam_role}'
    FORMAT AS PARQUET;
    """

    copy_dim_customers = f"""
    COPY dimcustomers
    FROM 's3://{target_bucket}/customers/'
    IAM_ROLE '{redshift_iam_role}'
    FORMAT AS PARQUET;
    """

    copy_dim_products = f"""
    COPY dimproducts
    FROM 's3://{target_bucket}/products/'
    IAM_ROLE '{redshift_iam_role}'
    FORMAT AS PARQUET;
    """

    copy_fact_sales = f"""
    COPY factsales
    FROM 's3://{target_bucket}/sales/'
    IAM_ROLE '{redshift_iam_role}'
    FORMAT AS PARQUET;
    """

    cursor.execute(copy_dim_dates)
    cursor.execute(copy_dim_customers)
    cursor.execute(copy_dim_products)
    cursor.execute(copy_fact_sales)

    # Commit and close the connection
    connection.commit()
    cursor.close()
    connection.close()

    print("Dimensional modeling tables created and data loaded successfully.")
