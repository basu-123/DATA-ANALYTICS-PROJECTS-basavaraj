create table route_details(
route_id int primary key not null,
origin_airport varchar(100) not null,
destination_airport varchar(100),
distance_miles  bigint not null,
flight_num int,
aircraft_id int not null,
check (flight_num >=0),
unique(route_id));
/*query to display all the passengers (customers) who have travelled in routes 01 to 25 Take data from
the passengers_on_flights table.*/
SELECT C.first_name FROM passengers_on_flights_csv P LEFT JOIN customer_csv C ON(C.customer_id=P.customer_id) WHERE route_id BETWEEN 1 AND 25;

/*Query to identity the number of passengers and total revenue in business class from the ticket_details table*/
SELECT COUNT(customer_id), SUM(Price_per_ticket) FROM ticket_details_csv WHERE`class_id`='Bussiness';

/*Query to display the Full name ot the customer by extracting the first name and last name trom the customer table*/
SELECT CONCAT(first_name,last_name) AS Full_name FROM customer_csv

/*Query to extract the customers who have registered ana book a ticket. use data trom the customer and ticket_details tables*/
SELECT DISTINCT(C.customer_id) FROM ticket_details_csv T LEFT JOIN customer_csv C ON (C.customer_id = T.customer_id) WHERE T.customer_id IS NOT NULL;

/*Query to identity the customer's first name and last name based on their customer ID and  brand (Emirates) from the ticket_details table*/
SELECT CONCAT(C.first_name,C.last_name) AS Full_name FROM customer_csv C LEFT JOIN ticket_details_csv T ON(C.customer_id = T.customer_id) WHERE T.brand='Emirates' ORDER BY C.customer_id,T.brand;

/*Query to identity the customers who have travelled by Economy Plus class using Group By and Having clause on the passenger_on_flight  table*/
SELECT COUNT(customer_id) AS Total_Customers FROM passengers_on_flights_csv GROUP BY class_id HAVING class_id="Economy Plus";

/* Query to identity whether the revenue has crossed  10000  using the IF clause on the ticket_details table*/
SELECT IF(SUM(Price_per_ticket)>10000,"Yes Revenue has Crossed 10000", "no Revenue has Crossed not 10000") AS Total_Revenue FROM ticket_details_csv


/*Query to create and grant access to a new user to perform operations on a database*/
USE air cargo;
GRANT ALL ON . TO 'root'@'localhost';
#FLUSH PRIVILEGES;

/*Query to find the maximum ticket price for each class using window functions on the ticket_details table*/
SELECT customer_id,  class_id , MAX(Price_per_ticket) OVER(PARTITION BY class_id) FROM ticket_details_csv;

/*Query to extract the passengers whose route ID is 4 by improving the speed and performance of the passenger_on_flight table*/
SELECT customer_id FROM passengers_on_flights_csv WHERE route_id=4;

/*For the route ID 4, write a query to view the execution plan of the passengers_on_flight table*/
SELECT * FROM passengers_on_flights_csv WHERE route_id=4;

/*A query to calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function*/
SELECT customer_id,aircraft_id,SUM(Price_per_ticket)AS Total_sales FROM ticket_details_csv GROUP BY customer_id,aircraft_id WITH ROLLUP;

/*Query to create a view with only business class customers along with the brand of airlines*/
CREATE VIEW Bussiness_Class AS
SELECT customer_id,brand FROM ticket_details_csv WHERE class_id='Bussiness';
SELECT * FROM Bussiness_Class;
