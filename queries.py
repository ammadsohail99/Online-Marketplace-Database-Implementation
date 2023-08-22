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
              14:"Ask for refund for unsatisfied task",
              15:"Find the most popular task category based on the total number of orders in that category ",
              16:"Show the addresses of customers along with their names and contact information.",
              17:"Taskers who have hourly rate below the category rate for plumbing category ",
              18:"Write a query to add a column in tasker table to add avg(rating) for each  ",
              19:"average rating, total no. of tasks accomplished for each tasker  ",
              20:"find the most similar user for customer 1 according to task category"
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
2:"""  """,
3:"""  """,
4:"""  """,
5:"""  """,
6:"""  """,
7:"""  """,
8:"""  """,
9:"""  """,
10:"""  """,
11:"""  """,
12:"""  """,
13:"""  """,
14:"""  """,
15:"""  """,
16:"""  """,
17:"""  """,
18:"""  """,
19:"""  """,
20:"""  """
              }