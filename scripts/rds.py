import psycopg2
import configparser


def rds_function():
    # Read the config file
    path = "/Users/gomes/Desktop/Projects/utils/Data-Engineer-Real-time-Transactions/config/config.ini"
    config = configparser.ConfigParser()
    config.read(path)

    # Connect to RDS instance
    connection = psycopg2.connect(
        dbname=config.get("RDS", "RDS_NAME"),
        user=config.get("RDS", "RDS_USER"),
        password=config.get("RDS", "RDS_PASSWORD"),
        host=config.get("RDS", "RDS_HOST"),
    )

    cursor = connection.cursor()

    # Create tables
    categories_table = """
    CREATE TABLE categories (
        CategoryID SERIAL PRIMARY KEY,
        CategoryName VARCHAR(100)
    );
    """

    customers_table = """
    CREATE TABLE customers (
        CustomersID SERIAL PRIMARY KEY,
        FirstName VARCHAR(50),
        LastName VARCHAR(50),
        Email VARCHAR(100),
        Gender VARCHAR(10),
        BirthDate DATE,
        RegistrationDate DATE,
        Address VARCHAR(100),
        City VARCHAR(50),
        State VARCHAR(50),
        Country VARCHAR(50),
        ZipCode VARCHAR(20)
    );
    """

    products_table = """
    CREATE TABLE products (
        ProductID SERIAL PRIMARY KEY,
        ProductName VARCHAR(100),
        CategoryID INTEGER,
        Brand VARCHAR(50),
        Description TEXT,
        Price DECIMAL(10, 2),
        Stock INTEGER,
        ImageURL VARCHAR(300),
        FOREIGN KEY (CategoryID) REFERENCES categories (CategoryID)   
    );
    """

    orders_table = """
    CREATE TABLE orders (
        OrderID SERIAL PRIMARY KEY,
        CustomerID INTEGER,
        OrderDate DATE,
        ShippingAddress VARCHAR(200),
        ShippingCity VARCHAR(50),
        ShippingState VARCHAR(50),
        ShippingCountry VARCHAR(50),
        ShippingZipCode VARCHAR(20),
        TotalAmount DECIMAL(10, 2),
        FOREIGN KEY (CustomerID) REFERENCES customers (CustomerID)
    );
    """

    order_items_table = """
    CREATE TABLE order_items (
        OrderItemID SERIAL PRIMARY KEY,
        OrderID INTEGER,
        ProductID INTEGER,
        Quantity INTEGER,
        Price DECIMAL(10, 2),
        FOREIGN KEY (OrderID) REFERENCES orders (OrderID),
        FOREIGN KEY (ProductID) REFERENCES products (ProductID)
    );
    """

    # Execute the table creation queries
    cursor.execute(categories_table)
    cursor.execute(customers_table)
    cursor.execute(products_table)
    cursor.execute(orders_table)
    cursor.execute(order_items_table)

    # Commit the changed and close the connection
    connection.commit()
    cursor.close()
    connection.close()

    print("Tables created successfully.")
