import psycopg2
import configparser
from faker import Faker
import random


def dummy_data_function():
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

    fake = Faker()

    # Generate and insert dummy categories
    categories = ["Clothing", "Footwear", "Accessories"]
    for category in categories:
        cursor.execute("INSERT INTO categories (CategoryName) VALUES (%s)", (category,))

    # Generate and insert dummy customers
    customer_count = 100
    for _ in range(customer_count):
        customer_data = (
            fake.first_name(),
            fake.last_name(),
            fake.email(),
            random.choice(["M", "F"]),
            fake.date_of_birth(minimum_age=18, maximum_age=90),
            fake.date_between(start_date="-10y", end_date="today"),
            fake.street_address(),
            fake.city(),
            fake.state_abbr(),
            fake.country(),
            fake.zipcode(),
        )
        cursor.execute(
            """
            INSERT INTO customers (
                FirstName, LastName, Email, Gender, BirthDate, RegistrationDate,
                Address, City, State, Country, ZipCode
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """,
            customer_data,
        )

    # Generate and insert dummy products
    product_count = 50
    for _ in range(product_count):
        product_data = (
            fake.sentence(nb_words=3),
            random.randint(1, len(categories)),
            fake.company(),
            fake.paragraph(nb_sentences=2),
            float(fake.pydecimal(left_digits=3, right_digits=2, positive=True)),
            random.randint(1, 100),
            fake.image_url(width=600, height=400),
        )
        cursor.execute(
            """
            INSERT INTO products (
                ProductName, CategoryID, Brand, Description, Price, Stock, ImageURL
            ) VALUES (%s, %s, %s, %s, %s, %s, %s)
        """,
            product_data,
        )

    # Generate and insert dummy orders and order items
    order_count = 200
    for _ in range(order_count):
        customer_id = random.randint(1, customer_count)
        order_data = (
            customer_id,
            fake.date_between(start_date="-1y", end_date="today"),
            fake.street_address(),
            fake.city(),
            fake.state_abbr(),
            fake.country(),
            fake.zipcode(),
            0,  # TotalAmount will be updated later
        )
        cursor.execute(
            """
            INSERT INTO orders (
                CustomerID, OrderDate, ShippingAddress, ShippingCity, ShippingState,
                ShippingCountry, ShippingZipCode, TotalAmount
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING OrderID
        """,
            order_data,
        )
        order_id = cursor.fetchone()[0]

        # Generate and insert dummy order items for each order
        order_item_count = random.randint(1, 5)
        total_amount = 0
        for _ in range(order_item_count):
            product_id = random.randint(1, product_count)
            cursor.execute(
                "SELECT Price FROM products WHERE ProductID = %s", (product_id,)
            )
            price = cursor.fetchone()[0]
            quantity = random.randint(1, 5)
            total_amount += price * quantity

            order_item_data = (order_id, product_id, quantity, price)
            cursor.execute(
                """
                INSERT INTO order_items (
                    OrderID, ProductID, Quantity, Price
                ) VALUES (%s, %s, %s, %s)
            """,
                order_item_data,
            )

        # Update the total amount of the order
        cursor.execute(
            """
            UPDATE orders
            SET TotalAmount = %s
            WHERE OrderID = %s
        """,
            (total_amount, order_id),
        )

    connection.commit()
    cursor.close()
    connection.close()

    print("Dummy data generated and inserted successfully.")
