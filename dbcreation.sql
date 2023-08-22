DROP TABLE IF EXISTS Tasker_accomplishments;
DROP TABLE IF EXISTS Tasker_skill;
DROP TABLE IF EXISTS Tasker_category;
DROP TABLE IF EXISTS Order_details;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS Tasker;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customer_address;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Certification;
DROP TABLE IF EXISTS Tasks_accomplished;
DROP TABLE IF EXISTS Skill;
DROP TABLE IF EXISTS Tasks_category;


CREATE TABLE Tasks_category (
category_id INT PRIMARY KEY,
category_name VARCHAR(255),
Price DECIMAL(10, 2),
Duration INT
);


CREATE TABLE Skill (
skill_ID INT PRIMARY KEY,
skill_name VARCHAR(255),
skill_proficiency VARCHAR(50));
CREATE TABLE Tasks_accomplished (
accomplished_ID INT PRIMARY KEY,
task_name VARCHAR(255),
number_of_tasks INT
);


CREATE TABLE Certification (
certification_ID INT PRIMARY KEY,
certification_name VARCHAR(255),
certification_date DATE,
certification_description TEXT,
company VARCHAR(255));


CREATE TABLE Address (
address_ID INT PRIMARY KEY,
street VARCHAR(255),
city VARCHAR(255),
state VARCHAR(255),
country VARCHAR(255),
postal_code VARCHAR(20));


CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
first_name VARCHAR(255),
last_name VARCHAR(255),
email VARCHAR(255),
phone VARCHAR(20),
address_ID INT,
password VARCHAR(255),
creditlimit DECIMAL(10, 2),FOREIGN KEY (address_ID) REFERENCES Address(address_ID));


CREATE TABLE Payments (
payment_id INT PRIMARY KEY,
paymentDate DATE,
amount DECIMAL(10, 2),
customer_id INT,
payment_method VARCHAR(50),
donation_type VARCHAR(50),
donation_amt DECIMAL(10, 2),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id));


CREATE TABLE Customer_address (
customer_ID INT,
address_ID INT,
PRIMARY KEY (customer_ID, address_ID),
FOREIGN KEY (customer_ID) REFERENCES Customers(customer_id),
FOREIGN KEY (address_ID) REFERENCES Address(address_ID));


CREATE TABLE Orders (
order_id INT PRIMARY KEY,
order_date DATE,
status VARCHAR(50),
comments TEXT,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id));


CREATE TABLE Tasker (
tasker_id INT PRIMARY KEY,
name VARCHAR(255),
phone VARCHAR(20),
self_introduction TEXT,
hourly_rate DECIMAL(10, 2),
Skill_ID INT,
certification_ID INT,
FOREIGN KEY (Skill_ID) REFERENCES Skill(skill_ID),
FOREIGN KEY (certification_ID) REFERENCES Certification(certification_ID));


CREATE TABLE Vehicles (
tasker_id INT,
vehicle_name VARCHAR(255),
PRIMARY KEY (tasker_id, vehicle_name),
FOREIGN KEY (tasker_id) REFERENCES Tasker(tasker_id));


CREATE TABLE Review (
review_id INT PRIMARY KEY,
customer_id INT,
tasker_id INT,
review_description TEXT,
review_date DATE,
ratings_for_each INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
FOREIGN KEY (tasker_id) REFERENCES Tasker(tasker_id));


CREATE TABLE Order_details (
tasker_id INT,
quantity INT,
price_each DECIMAL(10, 2),
date_of_task DATE,
size VARCHAR(50),
veh_requirement VARCHAR(255),
task_name VARCHAR(255),
order_id INT,
Category_id INT,
PRIMARY KEY (tasker_id, order_id),
FOREIGN KEY (tasker_id) REFERENCES Tasker(tasker_id),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (category_id) REFERENCES Tasks_category (category_id));


CREATE TABLE Tasker_category (
tasker_ID INT,
category_ID INT,
PRIMARY KEY (tasker_ID, category_ID),
FOREIGN KEY (tasker_ID) REFERENCES Tasker(tasker_ID),
FOREIGN KEY (category_ID) REFERENCES Tasks_category(category_ID));


CREATE TABLE Tasker_skill (
tasker_ID INT,
skill_ID INT,
PRIMARY KEY (tasker_ID, skill_ID),
FOREIGN KEY (tasker_ID) REFERENCES Tasker(tasker_ID),
FOREIGN KEY (skill_ID) REFERENCES Skill(skill_ID));


CREATE TABLE Tasker_accomplishments (
tasker_ID INT,
accomplished_ID INT,
PRIMARY KEY (tasker_ID, accomplished_ID),
FOREIGN KEY (tasker_ID) REFERENCES Tasker(tasker_ID),
FOREIGN KEY (accomplished_ID) REFERENCES Tasks_accomplished(accomplished_ID));--Table 1



INSERT INTO Tasks_category (category_id, category_name, Price, Duration)
VALUES
(10001, 'Cleaning', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10002, 'Gardening', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10003, 'Plumbing', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10004, 'Painting', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10005, 'Moving', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10006, 'Electrician', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10007, 'Carpentry', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10008, 'Cooking', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10009, 'Tutoring', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10010, 'Personal Training', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10011, 'Computer Repair', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10012, 'Event Planning', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10013, 'Graphic Design', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10014, 'Writing', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10015, 'Photography', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10016, 'Dog Walking', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10017, 'Babysitting', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10018, 'Music Lessons', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10019, 'Language Lessons', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1)),(10020, 'Art Lessons', ROUND(RAND() * 30 + 15, 2), ROUND(RAND() * 7.5 + 1, 1));-- table 2

INSERT INTO Skill (skill_ID, skill_name, skill_proficiency)
VALUES
(20001, 'Carpentry', 'Expert'),(20002, 'Graphic Design', 'Advanced'),(20003, 'Cooking', 'Intermediate'),(20004, 'Gardening', 'Beginner'),(20005, 'Programming', 'Expert'),(20006, 'Writing', 'Advanced'),(20007, 'Photography', 'Intermediate'),(20008, 'Language Translation', 'Beginner'),(20009, 'Data Analysis', 'Expert'),(20010, 'Painting', 'Advanced'),(20011, 'Music Composition', 'Intermediate'),(20012, 'Fitness Training', 'Beginner'),(20013, 'Web Development', 'Expert'),(20014, 'Video Editing', 'Advanced'),(20015, 'Math Tutoring', 'Intermediate'),(20016, 'Event Planning', 'Beginner'),(20017, 'Dog Training', 'Expert'),(20018, 'Interior Design', 'Advanced'),(20019, 'Accounting', 'Intermediate'),(20020, 'Social Media Management', 'Beginner');--table 3

INSERT INTO Tasks_accomplished (accomplished_ID, task_name, number_of_tasks)
VALUES
(100001, 'Carpentry Work', ROUND(RAND() * 100,2)),(100002, 'Graphic Design Projects', ROUND(RAND() * 100,2)),(100003, 'Cooking Events', ROUND(RAND() * 100,2)),(100004, 'Gardening Projects', ROUND(RAND() * 100,2)),(100005, 'Programming Tasks', ROUND(RAND() * 100,2)),(100006, 'Writing Assignments', ROUND(RAND() * 100,2)),(100007, 'Photography Shoots', ROUND(RAND() * 100,2)),(100008, 'Translation Projects', ROUND(RAND() * 100,2)),(100009, 'Data Analysis Tasks', ROUND(RAND() * 100,2)),(100010, 'Art and Painting Works', ROUND(RAND() * 100,2)),(100011, 'Music Compositions', ROUND(RAND() * 100,2)),(100012, 'Fitness Training Sessions', ROUND(RAND() * 100,2)),(100013, 'Web Development Projects', ROUND(RAND() * 100,2)),(100014, 'Video Editing Tasks', ROUND(RAND() * 100,2)),(100015, 'Math Tutoring Sessions', ROUND(RAND() * 100,2)),(100016, 'Event Planning Assignments', ROUND(RAND() * 100,2)),(100017, 'Dog Training Sessions', ROUND(RAND() * 100,2)),(100018, 'Interior Design Projects', ROUND(RAND() * 100,2)),(100019, 'Accounting Tasks', ROUND(RAND() * 100,2)),(100020, 'Social Media Management Tasks', ROUND(RAND() * 100,2));-- Table 4

INSERT INTO Certification (certification_ID, certification_name, certification_date, certification_description, company)
VALUES
(1001, 'Carpentry Certification', '2022-05-15', 'Certified in advanced carpentry skills.', 'Carpentry Institute'),(1002, 'Graphic Design Diploma', '2021-08-22', 'Received diploma in graphic design principles.', 'Design Academy'),(1003, 'Culinary Arts Certificate', '2023-02-10', 'Certificate in culinary arts and gourmet cooking.', 'Culinary Institute'),(1004, 'Landscaping Professional', '2020-11-30', 'Accredited as a professional landscaper.', 'Green Thumb Landscapes'),(1005, 'Programming Masterclass', '2023-06-28', 'Mastered various programming languages and concepts.', 'CodeCrafters'),(1006, 'Writing Workshop Completion', '2022-03-17', 'Completed intensive writing workshop.', 'Writers Guild'),(1007, 'Photography Certification', '2021-10-05', 'Certified in advanced photography techniques.', 'ShutterSense Academy'),(1008, 'Language Translation Credential', '2023-04-08', 'Certification for proficient language translation.', 'Global Linguists'),(1009, 'Data Analytics Specialist', '2020-07-12', 'Specialist certification in data analysis.', 'Data Insights Institute'),(1010, 'Artistic Painting Certification', '2022-09-19', 'Certified in various artistic painting styles.', 'Artistry Studio'),(1011, 'Music Composition Diploma', '2023-01-25', 'Diploma in music composition and theory.', 'Harmony Conservatory'),(1012, 'Fitness Trainer Certification', '2021-12-03', 'Certified as a fitness trainer and coach.', 'FitLife Academy'),(1013, 'Web Development Bootcamp', '2022-08-11', 'Completed intensive web development bootcamp.', 'WebWizards School'),(1014, 'Video Editing Expertise', '2023-03-14', 'Achieved expertise in video editing software.', 'FilmCraft Institute'),(1015, 'Math Tutor Certification', '2021-06-09', 'Certified as a math tutor and educator.', 'MathMinds Education'),(1016, 'Event Planning Professional', '2020-09-01', 'Certification as a professional event planner.', 'EventElegance Academy'),(1017, 'Dog Training Specialist', '2022-12-07', 'Specialist certification in dog training techniques.', 'Pawsitive Canines'),(1018, 'Interior Design Diploma', '2023-07-18', 'Diploma in interior design and aesthetics.', 'DesignScape Institute'),(1019, 'Accounting Certification', '2020-04-26', 'Certified in advanced accounting principles.', 'Financial Insights'),(1020, 'Social Media Management', '2023-05-29', 'Certification in effective social media management.', 'MediaMasters Academy');--Table 5

INSERT INTO Address (address_ID, street, city, state, country, postal_code)
VALUES
(1, '123 Maple Street', 'Toronto', 'Ontario', 'Canada', 'M1N 2P3'),(2, '456 Oak Avenue', 'Vancouver', 'British Columbia', 'Canada', 'V6C 1A1'),(3, '789 Elm Drive', 'Montreal', 'Quebec', 'Canada', 'H2X 1Y6'),(4, '101 Pine Road', 'Calgary', 'Alberta', 'Canada', 'T2E 8K8'),(5, '222 Birch Lane', 'Edmonton', 'Alberta', 'Canada', 'T5J 2P1'),(6, '333 Cedar Street', 'Ottawa', 'Ontario', 'Canada', 'K1P 5V8'),(7, '444 Spruce Avenue', 'Quebec City', 'Quebec', 'Canada', 'G1R 4M8'),(8, '555 Maple Road', 'Winnipeg', 'Manitoba', 'Canada', 'R3C 0A5'),(9, '666 Oak Drive', 'Halifax', 'Nova Scotia', 'Canada', 'B3H 1W3'),(10, '777 Elm Lane', 'Saskatoon', 'Saskatchewan', 'Canada', 'S7H 0A1'),(11, '888 Pine Street', 'Victoria', 'British Columbia', 'Canada', 'V8W 1P6'),(12, '999 Birch Avenue', 'Regina', 'Saskatchewan', 'Canada', 'S4P 3Y2'),(13, '111 Cedar Drive', 'Hamilton', 'Ontario', 'Canada', 'L8N 1E9'),(14, '222 Spruce Road', 'London', 'Ontario', 'Canada', 'N6A 5B8'),(15, '333 Maple Lane', 'Oshawa', 'Ontario', 'Canada', 'L1G 7X5'),(16, '444 Oak Street', 'Kitchener', 'Ontario', 'Canada', 'N2G 4Y5'),(17, '555 Elm Avenue', 'Windsor', 'Ontario', 'Canada', 'N9A 4M5'),(18, '666 Pine Drive', 'Burlington', 'Ontario', 'Canada', 'L7R 2G2'),(19, '777 Birch Lane', 'Barrie', 'Ontario', 'Canada', 'L4N 6E5'),(20, '888 Cedar Road', 'St. Catharines', 'Ontario', 'Canada', 'L2N 4R4');--Table 6 has to remove address id

INSERT INTO Customers (customer_id, first_name, last_name, email, phone, password, creditlimit)
VALUES
(1, 'John', 'Doe', 'john@example.com', '123-456-7890', 'password123', 1000.00),(2, 'Jane', 'Smith', 'jane@example.com', '987-654-3210', 'securepass', 1500.00),(3, 'Michael', 'Johnson', 'michael@example.com', '555-123-4567', 'mypass123', 1200.00),(4, 'Emily', 'Brown', 'emily@example.com', '555-987-6543', 'brown123', 1800.00),(5, 'William', 'Lee', 'william@example.com', '555-111-2222', 'lee123', 900.00),(6, 'Sophia', 'Wang', 'sophia@example.com', '555-555-5555', 'wangpass', 1350.00),(7, 'James', 'Martinez', 'james@example.com', '555-777-8888', 'jamespass', 2000.00),(8, 'Olivia', 'Garcia', 'olivia@example.com', '555-444-3333', 'olivia123', 950.00),(9, 'Liam', 'Lopez', 'liam@example.com', '555-222-6666', 'lopezpass', 1750.00),(10, 'Emma', 'Adams', 'emma@example.com', '555-666-9999', 'emmapass', 1200.00),(11, 'Noah', 'Scott', 'noah@example.com', '555-333-7777', 'scottpass', 800.00),(12, 'Ava', 'Harris', 'ava@example.com', '555-444-8888', 'avapass', 1300.00),(13, 'Jackson', 'Young', 'jackson@example.com', '555-222-3333', 'jacksonpass', 1100.00),(14, 'Isabella', 'Martin', 'isabella@example.com', '555-666-2222', 'isabellapass', 1600.00),(15, 'Lucas', 'Turner', 'lucas@example.com', '555-555-4444', 'lucaspass', 1400.00),(16, 'Mia', 'Perez', 'mia@example.com', '555-777-1111', 'miapass', 1000.00),(17, 'Jacob', 'Hernandez', 'jacob@example.com', '555-888-2222', 'jacobpass', 1900.00),(18, 'Sophia', 'Gonzalez', 'sophia@example.com', '555-999-5555', 'sophiapass', 1700.00),(19, 'Ethan', 'King', 'ethan@example.com', '555-111-1111', 'ethanpass', 1250.00),(20, 'Olivia', 'Hill', 'olivia@example.com', '555-333-3333', 'oliviapass', 1500.00);-- Table 7

INSERT INTO Payments (payment_id, paymentDate, amount, customer_id, payment_method, donation_type, donation_amt)
VALUES
(10001, '2023-08-01', 50.00, 1, 'Credit Card', 'Charity', 10.00),(10002, '2023-08-02', 75.00, 2, 'PayPal', 'Education', 20.00),(10003, '2023-08-03', 100.00, 3, 'Bank Transfer', 'Healthcare', 15.00),(10004, '2023-08-04', 90.00, 4, 'Credit Card', 'Environment', 12.00),(10005, '2023-08-05', 120.00, 5, 'PayPal', 'Animal Welfare', 18.00),(10006, '2023-08-06', 110.00, 6, 'Bank Transfer', 'Charity', 22.00),(10007, '2023-08-07', 80.00, 7, 'Credit Card', 'Education', 8.00),(10008, '2023-08-08', 60.00, 8, 'PayPal', 'Healthcare', 14.00),(10009, '2023-08-09', 70.00, 9, 'Bank Transfer', 'Environment', 11.00),(10010, '2023-08-10', 85.00, 10, 'Credit Card', 'Animal Welfare', 16.00),(10011, '2023-08-11', 95.00, 11, 'PayPal', 'Charity', 19.00),(10012, '2023-08-12', 150.00, 12, 'Bank Transfer', 'Education', 25.00),(10013, '2023-08-13', 130.00, 13, 'Credit Card', 'Healthcare', 24.00),(10014, '2023-08-14', 70.00, 14, 'PayPal', 'Environment', 10.00),(10015, '2023-08-15', 110.00, 15, 'Bank Transfer', 'Animal Welfare', 17.00),(10016, '2023-08-16', 40.00, 16, 'Credit Card', 'Charity', 6.00),(10017, '2023-08-17', 55.00, 17, 'PayPal', 'Education', 9.00),(10018, '2023-08-18', 90.00, 18, 'Bank Transfer', 'Healthcare', 13.00),(10019, '2023-08-19', 65.00, 19, 'Credit Card', 'Environment', 7.00),(10020, '2023-08-20', 75.00, 20, 'PayPal', 'Animal Welfare', 21.00);--Table 8

INSERT INTO Customer_address (customer_ID, address_ID)
VALUES
(1, 1),(2, 2),(3, 3),(4, 4),(5, 5),(6, 6),(7, 7),(8, 8),(9, 9),(10, 10),(11, 11),(12, 12),(13, 13),(14, 14),(15, 15),(16, 16),(17, 17),(18, 18),(19, 19),(20, 20);--Table 9

INSERT INTO Orders (order_id, order_date, status, comments, customer_id)
VALUES
(10001, '2023-08-01', 'Processing', 'Awaiting shipment', 1),(10002, '2023-08-02', 'Shipped', 'Delivered on time', 2),(10003, '2023-08-03', 'Pending', 'Payment pending', 3),(10004, '2023-08-04', 'Completed', 'Successfully delivered', 4),(10005, '2023-08-05', 'Processing', 'Preparing for shipment', 5),(10006, '2023-08-06', 'Pending', 'Awaiting customer response', 6),(10007, '2023-08-07', 'Shipped', 'Out for delivery', 7),(10008, '2023-08-08', 'Processing', 'Order in progress', 8),(10009, '2023-08-09', 'Completed', 'Delivered and received', 9),(10010, '2023-08-10', 'Pending', 'Pending verification', 10),(10011, '2023-08-11', 'Processing', 'Order being prepared', 11),(10012, '2023-08-12', 'Shipped', 'Expected delivery date', 12),(10013, '2023-08-13', 'Pending', 'Payment confirmation awaited', 13),(10014, '2023-08-14', 'Completed', 'Successfully received', 14),(10015, '2023-08-15', 'Shipped', 'Out for delivery', 15),(10016, '2023-08-16', 'Processing', 'Processing order', 16),(10017, '2023-08-17', 'Pending', 'Awaiting further instructions', 17),(10018, '2023-08-18', 'Shipped', 'In transit', 18),(10019, '2023-08-19', 'Completed', 'Delivered and signed', 19),(10020, '2023-08-20', 'Pending', 'Order verification pending', 20),(10021, '2023-08-21', 'Processing', 'Order processing initiated', 1),(10022, '2023-08-22', 'Completed', 'Successfully delivered', 2),(10023, '2023-08-23', 'Shipped', 'Out for delivery', 3),(10024, '2023-08-24', 'Pending', 'Payment confirmation awaited', 4),(10025, '2023-08-25', 'Processing', 'Preparing for shipment', 5),(10026, '2023-08-26', 'Shipped', 'In transit', 6),(10027, '2023-08-27', 'Completed', 'Delivered and signed', 7),(10028, '2023-08-28', 'Processing', 'Order being processed', 8),(10029, '2023-08-29', 'Pending', 'Pending verification', 9),(10030, '2023-08-30', 'Completed', 'Successfully received', 10),(10031, '2023-08-31', 'Processing', 'Preparing for delivery', 11),(10032, '2023-09-01', 'Shipped', 'Expected delivery date', 12),(10033, '2023-09-02', 'Pending', 'Awaiting customer response', 13),(10034, '2023-09-03', 'Completed', 'Successfully delivered', 14),(10035, '2023-09-04', 'Shipped', 'Out for delivery', 15);--Table 10

INSERT INTO Tasker (tasker_id, name, phone, self_introduction, hourly_rate, Skill_ID, certification_ID)
VALUES
(1, 'Alex Smith', '123-456-7890', 'Experienced carpenter with a passion for quality craftsmanship.', 25.00, 20001, 1001),(2, 'Emily Johnson', '987-654-3210', 'Graphic designer with a keen eye for creative solutions.', 30.00, 20002, 1002),(3, 'Daniel Lee', '555-123-4567', 'Seasoned cook specializing in diverse cuisines.', 20.00, 20003, 1003),(4, 'Sophia Brown', '555-987-6543', 'Passionate gardener with a green thumb and eye for beauty.', 22.50, 20004, 1004),(5, 'Michael Davis', '555-111-2222', 'Skilled programmer with a love for solving complex challenges.', 40.00, 20005, 1005),(6, 'Olivia Miller', '555-555-5555', 'Wordsmith and writer with a gift for storytelling.', 35.00, 20006, 1006),(7, 'Ethan Wilson', '555-777-8888', 'Photographer capturing moments that last a lifetime.', 28.00, 20007, 1007),(8, 'Ava Martinez', '555-444-3333', 'Accurate language translator bridging communication gaps.', 25.00, 20008, 1008),(9, 'Noah Johnson', '555-222-6666', 'Data enthusiast crunching numbers to derive insights.', 50.00, 20009, 1009),(10, 'Emma Taylor', '555-666-9999', 'Artist with a brush, creating colorful worlds on canvas.', 18.00, 20010, 1010),(11, 'Liam Anderson', '555-333-7777', 'Composer making melodies that touch hearts.', 32.00, 20011, 1011),(12, 'Isabella Hall', '555-444-8888', 'Fitness coach helping people achieve their health goals.', 40.00, 20012, 1012),(13, 'Jackson Allen', '555-222-3333', 'Web developer turning ideas into interactive experiences.', 45.00, 20013, 1013),(14, 'Mia Turner', '555-666-2222', 'Video editor crafting visual stories with precision.', 30.00, 20014, 1014),(15, 'Lucas Baker', '555-555-4444', 'Math tutor sparking curiosity and fostering understanding.', 25.00, 20015, 1015),(16, 'Emma Roberts', '555-777-1111', 'Event planner orchestrating unforgettable experiences.', 35.00, 20016, 1016),(17, 'Ethan Johnson', '555-888-2222', 'Dog trainer building strong bonds between pets and owners.', 28.00, 20017, 1017),(18, 'Oliver Williams', '555-999-5555', 'Interior designer transforming spaces into personal sanctuaries.', 42.00, 20018, 1018),(19, 'Sophia Smith', '555-111-1111', 'Accountant with an eye for detail and numbers.', 38.00, 20019, 1019),(20, 'Liam Davis', '555-333-3333', 'Social media manager navigating the digital landscape.', 30.00, 20020, 1020),(21, 'Aiden Brown', '555-444-4444', 'Creative carpenter with a knack for custom designs.', 28.00, 20001, 1001),(22, 'Olivia Johnson', '555-555-5555', 'Innovative graphic designer with a passion for aesthetics.', 35.00, 20002, 1002),(23, 'Lucas Lee', '555-666-6666', 'Cook with a flair for fusion cuisines.', 25.00, 20003, 1003),(24, 'Ava Brown', '555-777-7777', 'Green thumb gardener creating magical outdoor spaces.', 30.00, 20004, 1004),(25, 'Jackson Davis', '555-888-8888', 'Software engineer turning ideas into reality.', 50.00, 20005, 1005),(26, 'Emma Wilson', '555-999-9999', 'Aspiring writer crafting stories that captivate.', 20.00, 20006, 1006),(27, 'Liam Martinez', '555-123-1234', 'Photographer capturing fleeting moments.', 28.00, 20007, 1007),(28, 'Sophia Johnson', '555-456-7890', 'Language enthusiast connecting cultures through words.', 25.00, 20008, 1008),(29, 'Ethan Thompson', '555-987-6543', 'Data analyst with a passion for patterns.', 40.00, 20009, 1009),(30, 'Olivia Moore', '555-555-1234', 'Painter expressing emotions through art.', 18.00, 20010, 1010);--Table 11

INSERT INTO Vehicles (tasker_id, vehicle_name)
VALUES
(1, 'car'),(2, 'truck'),(3, 'cycle'),(4, 'motorcycle'),(5, 'car'),(6, 'truck'),(7, 'cycle'),(8, 'motorcycle'),(9, 'car'),(10, 'truck'),(11, 'cycle'),(12, 'motorcycle'),(13, 'car'),(14, 'truck'),(15, 'cycle'),(16, 'motorcycle'),(17, 'car'),(18, 'truck'),(19, 'cycle'),(20, 'motorcycle'),(1, 'truck'),(2, 'cycle'),(3, 'motorcycle'),(4, 'car'),(5, 'truck'),(6, 'cycle'),(7, 'motorcycle'),(8, 'car'),(9, 'truck'),(10, 'cycle');--Table 12

INSERT INTO Review (review_id, customer_id, tasker_id, review_description, review_date, ratings_for_each)
VALUES
(1, 1, 21, 'Great service! Highly recommended.', '2023-08-01', 5),(2, 2, 22, 'Excellent work! Very satisfied.', '2023-08-02', 4),(3, 3, 23, 'Fantastic job! Will hire again.', '2023-08-03', 5),(4, 4, 24, 'Impressive skills. Pleased with the outcome.', '2023-08-04', 4),(5, 5, 25, 'Outstanding programming. Met my expectations.', '2023-08-05', 5),(6, 6, 26, 'Beautiful writing. Captivating storytelling.', '2023-08-06', 4),(7, 7, 27, 'Exceptional photography. Cherished memories.', '2023-08-07', 5),(8, 8, 28, 'Flawless translation. Effective communication.', '2023-08-08', 4),(9, 9, 29, 'Insightful data analysis. Valuable insights.', '2023-08-09', 5),(10, 10, 30, 'Artistic masterpiece. Impressed with the painting.', '2023-08-10', 4),(11, 11, 1, 'Melodious compositions. Enchanting music.', '2023-08-11', 5),(12, 12, 2, 'Transformed my fitness journey. Thank you!', '2023-08-12', 4),(13, 13, 3, 'User-friendly website. Satisfied with the design.', '2023-08-13', 5),(14, 14, 4, 'Edited video exceeded expectations. Great work!', '2023-08-14', 4),(15, 15, 5, 'Patient and clear explanations. Improved my math skills.', '2023-08-15', 5),(16, 16, 6, 'Flawless event planning. Unforgettable experience.', '2023-08-16', 4),(17, 17, 7, 'Effective dog training methods. Improved behavior.', '2023-08-17', 5),(18, 18, 8, 'Transformed my living space. Outstanding interior design.', '2023-08-18', 4),(19, 19, 9, 'Accurate accounting. Organized my finances.', '2023-08-19', 5),(20, 20, 10, 'Strategic social media management. Increased engagement.', '2023-08-20', 4);--Table 13

INSERT INTO Order_details (tasker_id, quantity, price_each, date_of_task, size, veh_requirement, task_name, order_id,category_id)
VALUES
(1, 2, 50.00, '2023-08-01', 'Small', 'Car required', 'Carpentry', 10001,10020),(2, 3, 40.00, '2023-08-02', 'Medium', 'Truck required', 'Design', 10002,10019),(3, 1, 25.00, '2023-08-03', 'Small', 'Cycle required', 'Cooking', 10003,10018),(4, 4, 30.00, '2023-08-04', 'Large', 'Truck required', 'Gardening', 10004,10017),(5, 2, 60.00, '2023-08-05', 'Medium', 'Motorcycle required', 'Programming', 10005,10016),(6, 1, 35.00, '2023-08-06', 'Small', 'Cycle required', 'Writing', 10006,10015),(7, 3, 45.00, '2023-08-07', 'Medium', 'Motorcycle required', 'Photography', 10007,10014),(8, 2, 30.00, '2023-08-08', 'Small', 'Car required', 'Translation', 10008,10013),(9, 1, 40.00, '2023-08-09', 'Small', 'Car required', 'Data Analysis', 10009,10012),(10, 3, 20.00, '2023-08-10', 'Medium', 'Cycle required', 'Art', 10010,10011),(11, 2, 55.00, '2023-08-11', 'Small', 'Car required', 'Music Composition', 10011,10009),(12, 1, 30.00, '2023-08-12', 'Small', 'Car required', 'Fitness Coaching', 10012,10008),(13, 3, 50.00, '2023-08-13', 'Medium', 'Motorcycle required', 'Web Development', 10013,10007),(14, 2, 25.00, '2023-08-14', 'Small', 'Car required', 'Video Editing', 10014,10006),(15, 1, 40.00, '2023-08-15', 'Small', 'Car required', 'Math Tutoring', 10015,10005),(16, 3, 35.00, '2023-08-16', 'Medium', 'Motorcycle required', 'Event Planning', 10016,10004),(17, 2, 30.00, '2023-08-17', 'Small', 'Car required', 'Dog Training', 10017,10003),(18, 1, 60.00, '2023-08-18', 'Small', 'Car required', 'Interior Design', 10018,10002),(19, 3, 25.00, '2023-08-19', 'Medium', 'Motorcycle required', 'Accounting', 10019,10001),(20, 2, 35.00, '2023-08-20', 'Small', 'Car required', 'Social Media Management', 10020,10010);-- Table 14

INSERT INTO Tasker_category (tasker_ID, category_ID)
VALUES
(1, 10001),(2, 10002),(3, 10003),(4, 10004),(5, 10005),(6, 10006),(7, 10007),(8, 10008),(9, 10009),(10, 10010),(11, 10011),(12, 10012),(13, 10013),(14, 10014),(15, 10015),(16, 10016),(17, 10017),(18, 10018),(19, 10019),(20, 10020);--Table 15

INSERT INTO Tasker_skill (tasker_ID, skill_ID)
VALUES
(1, 20001),(2, 20002),(3, 20003),(4, 20004),(5, 20005),(6, 20006),(7, 20007),(8, 20008),(9, 20009),(10, 20010),(11, 20011),(12, 20012),(13, 20013),(14, 20014),(15, 20015),(16, 20016),(17, 20017),(18, 20018),(19, 20019),(20, 20020);--Table 16

INSERT INTO Tasker_accomplishments (tasker_ID, accomplished_ID)
VALUES
(1, 100001),(2, 100002),(3, 100003),(2, 100004),(5, 100005),(4, 100006),(7, 100007),(9, 100008),(9, 100009),(10, 100010),(11, 100011),(6, 100012),(13, 100013),(14, 100014),(15, 100015),(16, 100016),(17, 100017),(18, 100018),(7, 100019),(8,100014),(19, 100019),(20, 100020),(12, 100008),(9, 100016);