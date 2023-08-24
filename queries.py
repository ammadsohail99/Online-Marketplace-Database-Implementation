query_detail = {
              1:"Top 3 taskers with the most accomplished tasks ",
              2:"Best tasker in each category in terms of rating and experience ",
              3:"Retrieve customer names and email addresses for those who have a credit limit greater than a 1700$ ",
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
              18:"Get tasker name with maximum and minimum hourly rate",
              19:"Write a Query which can be used to insert Average rating column in the tasker table",
              20:"Find the most similar user for customer id = 1 according to task category"
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
    tkc.category_id = 10003 AND t.hourly_rate < tkc.Price;  """,

2:""" 
WITH TR AS (
    SELECT
        Tasker.tasker_id,
        Tasker.name,
        AVG(Review.ratings_for_each) AS ratings
    FROM
        Tasker
    LEFT JOIN
        Review ON Tasker.tasker_id = Review.tasker_id
    GROUP BY
        Tasker.tasker_id, Tasker.name
)
SELECT
    TR.tasker_id,
    TR.name,
    MAX(TR.ratings) AS best_rating,
    TC.category_id,
    Tasks_category.category_name
FROM
    TR
LEFT JOIN
    Tasker_category TC ON TR.tasker_id = TC.tasker_id
LEFT JOIN
    Tasks_category ON Tasks_category.category_id = TC.category_id
WHERE
    TC.category_id IS NOT NULL
    AND Tasks_category.category_name IS NOT NULL
    AND TR.ratings IS NOT NULL
GROUP BY
    TR.tasker_id, TR.name, TC.category_id, Tasks_category.category_name;
  """,

3:""" SELECT  
    CONCAT(first_name, ' ', last_name) AS name, 
    email 
FROM 
    Customers 
WHERE 
    creditlimit >= 1700; """,

4:""" SELECT 
    CONCAT(first_name, ' ', last_name) AS Names
FROM 
    customers
INNER JOIN 
    orders ON customers.customer_id = orders.customer_id
WHERE 
    orders.order_date BETWEEN DATEADD(DAY, -7, GETDATE()) AND GETDATE();
  """,

5:""" SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS number_of_orders 
FROM Customers c 
LEFT JOIN Orders o ON c.customer_id = o.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY number_of_orders DESC;  """,

6:""" WITH OA AS (
    SELECT
        A.city,
        C.customer_id,
        O.order_id
    FROM
        Address A
    LEFT JOIN
        Customer_address CA ON A.address_id = CA.address_id
    LEFT JOIN
        Customers C ON CA.customer_id = C.customer_id
    LEFT JOIN
        Orders O ON O.customer_id = C.customer_id
)
SELECT
    city,
    category_name,
    MAX(counts) AS max_count
FROM (
    SELECT
        OA.city,
        TC.category_name,
        COUNT(TC.category_name) AS counts
    FROM
        OA
    LEFT JOIN
        Order_details ON OA.order_id = Order_details.order_id
    LEFT JOIN
        Tasks_category TC ON TC.category_id = Order_details.Category_id
    WHERE
        TC.category_id IS NOT NULL
    GROUP BY
        OA.city, TC.category_name
) t1
GROUP BY
    city, category_name;
 """,

7:""" SELECT
    A.customer_id,
    CONCAT(A.first_name, ' ', A.last_name) AS customer_name,
    A.email,
    A.phone,
    SUM(B.amount) AS TOT_Payment_AMT
FROM
    Customers A
LEFT JOIN
    Payments B ON A.customer_id = B.customer_id
GROUP BY
    A.customer_id, A.first_name, A.last_name, A.email, A.phone
ORDER BY
    TOT_Payment_AMT DESC;
  """,

8:""" SELECT vehicle_name 
, COUNT(tasker_id) AS COUNT 
FROM Vehicles 
GROUP BY vehicle_name;  """,

9:""" SELECT TOP 3
    B.skill_id,
    B.skill_name,
    B.skill_proficiency,
    COUNT(A.tasker_id) AS tasker_count
FROM
    tasker A
LEFT JOIN
    Skill B ON A.Skill_ID = B.skill_id
GROUP BY
    B.skill_id, B.skill_name, B.skill_proficiency
ORDER BY
    tasker_count DESC;
  """,

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
WHERE A.status = 'Pending';  """,

11:""" SELECT 
    s.name, 
    AVG(s.ratings_for_each) AS AVG_RATINGS 
FROM 
    ( 
    SELECT 
        t.name, 
        r.ratings_for_each 
    FROM 
        Tasker t 
    LEFT JOIN review r ON 
        r.tasker_id = t.tasker_id 
    ) AS s 
GROUP BY 
    s.name 
HAVING 
    AVG(s.ratings_for_each) IS NOT NULL 
ORDER BY 
    AVG_RATINGS 
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;
 """,

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

14:""" SELECT
    OC.customer_id,
    OC.first_name,
    OC.last_name,
    SUM(P.amount + P.donation_amt) AS total_refund
FROM (
    SELECT O.*, C.first_name, C.last_name
    FROM Orders O
    JOIN Customers C ON O.customer_id = C.customer_id
    WHERE O.customer_id = 1 AND O.status = 'Processing'
) AS OC
JOIN Payments P ON OC.customer_id = P.customer_id
GROUP BY OC.customer_id, OC.first_name, OC.last_name;
 """,

15:""" SELECT TOP 1
    tc.category_ID,
    tkc.category_name,
    COUNT(tc.category_ID) AS Total_Orders_category
FROM
    Orders o
LEFT JOIN
    Order_details od ON od.order_id = o.order_id
LEFT JOIN
    Tasker t ON t.tasker_id = od.tasker_id
LEFT JOIN
    Tasker_category tc ON tc.tasker_id = t.tasker_id
LEFT JOIN
    Tasks_category tkc ON tkc.category_id = tc.category_ID
GROUP BY
    tc.category_ID, tkc.category_name
ORDER BY
    Total_Orders_category DESC;
  """,

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

18:""" SELECT 
    tasker.name, tasker.hourly_rate, 'MAX' AS "Maximum/Minimum"
FROM tasker
WHERE tasker.hourly_rate = (SELECT MAX(hourly_rate) FROM tasker)
UNION
SELECT 
    tasker.name, tasker.hourly_rate, 'MIN' AS "Maximum/Minimum"
FROM tasker
WHERE tasker.hourly_rate = (SELECT MIN(hourly_rate) FROM tasker)

ORDER BY 3 ;""",

19:""" SELECT  AVG(ratings_for_each) AS avg_rating 

FROM review,tasker

WHERE review.tasker_ID = tasker.tasker_ID

GROUP BY name; """,

20:""" 
WITH CT AS (
    SELECT
        Customers.customer_id,
        Tasks_category.category_id,
        OD.quantity
    FROM
        Customers
    INNER JOIN
        Orders ON Customers.customer_id = Orders.customer_id
    INNER JOIN
        Order_details OD ON OD.order_id = Orders.order_id
    INNER JOIN
        Tasks_category ON Tasks_category.category_id = OD.category_id
)

SELECT TOP 1
    t2.customer_id,
    t2.category_id,
    SUM(t2.quantity) AS same_purchased
FROM (
    SELECT DISTINCT
        customer_id,
        category_id
    FROM
        CT
    WHERE
        customer_id = 1
) t1
CROSS JOIN (
    SELECT DISTINCT
        customer_id,
        category_id,
        quantity
    FROM
        CT
    WHERE
        customer_id != 1
) t2
WHERE
    t1.category_id = t2.category_id
GROUP BY
    t2.customer_id, t2.category_id
ORDER BY
    same_purchased DESC;
 """
              }