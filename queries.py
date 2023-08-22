query_detail = {
              1:"Top 3 taskers with the most accomplished tasks ",
              2:"Best tasker in each category in terms of rating and experience ",
              3:"SRetrieve customer names and email addresses for those who have a credit limit greater than a 1700$ ",
              4:"List all the customers who have placed orders within last 7 days.  ",
              5:"Get a count of orders placed by each customer.",
              6:"Find the top selling task category by city ",
              7:"Customers LTV(Lifetime value) ordered in Descending order ",
              8:"Get Count of taskers for each vehicle category ",
              9:"Top 3 most common skills among taskers",
              10:"Display all the orders in pending status ",
              11:"List 3 taskers having worst rating ",
              12:"Retrieve the average rating of taskers in each category ",
              13:"Average hourly rate for each category ",
              14:"Customer with customer_id = 1 wants to ask for refund for all the processing status products",
              15:"Find the most popular task category based on the total number of orders in that category ",
              16:"Show the addresses of customers along with their names and contact information.",
              17:"Taskers who have hourly rate below the category rate for plumbing category ",
              18:" Get tasker name with maximum and minimum hourly rate",
              19:"Average rating, total no. of tasks accomplished for each tasker  ",
              20:"Find the most similar user for customer 1 according to task category"
              }

query_dict = {
1:""" SELECT 
    t.tasker_id, 
    t.name 
FROM 
    Tasker t 
LEFT JOIN Tasker_category tc ON 
    tc.tasker_ID = t.tasker_id 
LEFT JOIN Tasks_category tkc ON 
    tkc.category_id = tc.category_ID 
WHERE 
    tkc.category_id = 10003 AND t.hourly_rate < tkc.Price  """,

2:""" 
WITH TR AS 
(SELECT Tasker.tasker_id, Tasker.name, AVG(Review.ratings_for_each) AS ratings 
FROM Tasker 
LEFT JOIN Review 
ON Tasker.tasker_id = Review.tasker_id 
GROUP BY Tasker.tasker_id) 
SELECT TR.tasker_id, TR.name, MAX(TR.ratings) as best_rating, TC.category_id, Tasks_category.category_name 
FROM TR 
LEFT JOIN Tasker_category TC 
ON TR.tasker_id = TC.tasker_id 
LEFT JOIN Tasks_category 
ON Tasks_category.category_id = TC.category_id 
WHERE TC.category_id IS NOT NULL and Tasks_category.category_name IS NOT NULL and TR.ratings iS NOT NULL 
GROUP BY category_name ;  """,

3:""" SELECT  
    CONCAT(first_name, ' ', last_name) AS name, 
    email 
FROM 
    Customers 
WHERE 
    creditlimit >= 1700; """,

4:""" SELECT CONCAT (first_name," ", last_name) AS Names FROM customers 
INNER JOIN orders ON customers.customer_id = orders.customer_id 
WHERE orders.order_date BETWEEN NOW () - INTERVAL 7 DAY AND NOW ();   """,

5:""" SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS number_of_orders 
FROM Customers c 
LEFT JOIN Orders o ON c.customer_id = o.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY number_of_orders DESC;  """,
6:""" WITH OA AS 
(SELECT A.city, C.customer_id, O.order_id 
FROM Address A 
LEFT JOIN Customer_address CA 
ON A.address_id = CA.address_id 
LEFT JOIN Customers C 
ON CA.customer_id = C.customer_id 
LEFT JOIN Orders O 
ON O.customer_id = C.customer_id) 

SELECT city, category_name, MAX(counts) as max_count 
FROM( 
	SELECT distinct OA.city, TC.category_name, COUNT(TC.category_name) AS counts 
	FROM OA 
	LEFT JOIN Order_details 
	ON OA.order_id = Order_details.order_id 
	LEFT JOIN Tasks_category TC 
	ON TC.category_id = Order_details.Category_id 
	WHERE TC.category_id IS NOT NULL 
	GROUP BY OA.city 
) t1 
GROUP BY category_name;  """,

7:""" SELECT A.customer_id 
	, CONCAT(A.first_name," ", A.last_name) as customer_name 
    , A.email 
    , A.phone 
    , SUM(B.amount) AS TOT_Payment_AMT 
	FROM Customers A 
	LEFT JOIN Payments B 
	ON A.customer_id = B.customer_id 
	GROUP BY A.customer_id 
    ORDER BY SUM(B.amount) DESC;  """,

8:""" SELECT vehicle_name 
, COUNT(tasker_id) AS COUNT 
FROM Vehicles 
GROUP BY vehicle_name;  """,

9:""" SELECT A.Skill_ID 
, B.skill_name 
    , B.skill_proficiency 
, COUNT(A.tasker_id) AS COUNT  
FROM tasker A 
LEFT JOIN Skill B 
ON A.Skill_ID = B.skill_ID 
GROUP BY Skill_ID 
ORDER BY COUNT(tasker_id) DESC 
LIMIT 3;  """,

10:""" SELECT A.* 
    , C.NAME as Tasker_Assigned 
, B.price_each 
    , B.quantity 
    , B.size 
    , B.task_name 
    , B.veh_requirement 
FROM Orders A 
LEFT JOIN Order_details B 
ON A.order_id = B.order_id 
LEFT JOIN Tasker C 
ON B.tasker_id = C.tasker_id 
WHERE STATUS = "Pending";  """,

11:""" SELECT 
    s.name, 
    AVG(s.ratings_for_each) as AVG_RATINGS 
FROM 
    ( 
    SELECT 
        t.name, 
        r.ratings_for_each 
    FROM 
        Tasker t 
    LEFT JOIN review r ON 
        r.tasker_id = t.tasker_id 
) s 
GROUP BY  1 
HAVING AVG(s.ratings_for_each) IS NOT NULL 
ORDER BY 2 

LIMIT 3;  """,

12:""" SELECT tc.category_ID, tcat.category_name, AVG(r.ratings_for_each) AS average_rating 
FROM Tasker_category tc 
JOIN Tasks_category tcat ON tc.category_ID = tcat.category_id 
JOIN Tasker t ON tc.tasker_ID = t.tasker_id 
LEFT JOIN Review r ON t.tasker_id = r.tasker_id 
GROUP BY tc.category_ID, tcat.category_name 
ORDER BY average_rating DESC;  """,

13:""" SELECT tcat.category_id, tcat.category_name, AVG(t.hourly_rate) AS average_hourly_rate 
FROM Tasks_category tcat 
JOIN Tasker_category tc ON tcat.category_id = tc.category_ID 
JOIN Tasker t ON tc.tasker_ID = t.tasker_id 
GROUP BY tcat.category_id, tcat.category_name 
ORDER BY average_hourly_rate DESC;  """,

14:""" SELECT OC.customer_id, OC.first_name, OC.last_name, SUM(P.amount + P.donation_amt) AS total_refund 
FROM 
(SELECT O.*, C.first_name, C.last_name 
FROM Orders O, Customers C 
WHERE O.customer_id = 1 and C.customer_id= 1 AND O.`status` = 'Processing') OC, Payments P 
WHERE OC.customer_id = P.customer_id 
GROUP BY customer_id;  """,

15:""" SELECT 
    tc.category_ID, 
    tkc.category_name, 
    COUNT(tc.category_ID) as Total_Orders_category 
FROM 
    Orders o 
LEFT JOIN Order_details od ON 
    od.order_id = o.order_id 
LEFT JOIN Tasker t ON 
    t.tasker_id = od.tasker_id 
LEFT JOIN Tasker_category tc ON 
    tc.tasker_id = t.tasker_id 
LEFT JOIN Tasks_category tkc ON 
    tkc.category_id = tc.category_ID 
GROUP BY  1 
ORDER BY 1 
DESC 
LIMIT 1;  """,
16:""" SELECT  
    c.first_name,  
    c.last_name,  
    c.email,  
    c.phone,  
    a.street,  
    a.city,  
    a.state,  
    a.country,  
    a.postal_code 
FROM Customers c 
JOIN Customer_address ca ON c.customer_id = ca.customer_ID 
JOIN Address a ON ca.address_ID = a.address_ID 
ORDER BY c.last_name, c.first_name;  """,

17:""" SELECT 
    t.tasker_id, 
    t.name 
FROM 
    Tasker t 
LEFT JOIN Tasker_category tc ON 
    tc.tasker_ID = t.tasker_id 
LEFT JOIN Tasks_category tkc ON 
    tkc.category_id = tc.category_ID 
WHERE 
    tkc.category_id = 10003 AND t.hourly_rate < tkc.Price; """,
18:""" ALTER TABLE tasker 
ADD COLUMN avg_rating DECIMAL(3,2); 
UPDATE tasker 
JOIN ( 
    SELECT tasker_ID, AVG(ratings_for_each) AS avg_rating 
    FROM review 
    GROUP BY tasker_ID 
) AS avg_reviews ON avg_reviews.tasker_ID = tasker.tasker_ID 
SET tasker.avg_rating = avg_reviews.avg_rating;  """,
19:""" SELECT tasker.name, tasker.avg_rating, COUNT(tasker_accomplishments.accomplished_ID) AS accomplished_tasks    
FROM tasker, tasker_accomplishments   
WHERE tasker.tasker_id = tasker_accomplishments.tasker_ID   
GROUP BY tasker.name, tasker.avg_rating  """,
20:""" 
WITH CT AS 
(SELECT Customers.customer_id, Tasks_category.category_id, OD.quantity 
FROM Customers 
INNER JOIN Orders 
ON Customers.customer_id = Orders.customer_id 
INNER JOIN Order_details OD 
ON OD.order_id = Orders.order_id 
INNER JOIN Tasks_category 
ON Tasks_category.category_id = OD.category_id) 

SELECT t2.customer_id, t2.category_id, SUM(t2.quantity) AS same_purchased 
FROM 
	(SELECT distinct customer_id, category_id 
    FROM CT 
    WHERE customer_id = 1) t1, 
    (SELECT distinct customer_id, category_id, quantity 
    FROM CT 
    WHERE customer_id != 1) t2 
WHERE t1.category_id = t2.category_id 
GROUP BY t2.customer_id 
ORDER BY same_purchased DESC 
LIMIT 1;  """
              }