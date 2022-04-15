--Query 1 - The names of all customers who have both a life insurance and a vehicle policy. 

SELECT name
FROM customer, policy, vehicle_policy, life_policy
WHERE policy.SSN=customer.SSN and policy.policy_no=vehicle_policy.policy_num and policy.policy_no=life_policy.policy_num;


--Query 2 - The name and driver license of customers who had 2 or more accidents in the past year. 

SELECT name, DriverLicense 
FROM customer 
WHERE DriverLicense IN 
	(SELECT DriverLicense 
	FROM report 
	HAVING COUNT(*)>2) 
	AND DriverLicense IN 	
	(SELECT DriverLicense 
	FROM report 
	WHERE YEAR(accident_date) > YEAR(NOW())-1);



--Query 3 - Find the total number of customers who owned cars that were involved in accidents in 2022.

SELECT COUNT(DISTINCT DriverLicense) 
FROM report R, cars C 
WHERE C.VIN_no=R.VIN_numb and YEAR(R.accident_date)=2022;


--Query 4 - Find the name of the customer who has the most number of accidents (total accidents). 

SELECT name
FROM report, customer
WHERE report.DriverLicense=customer.DriverLicense
GROUP BY DriverLicense
ORDER BY COUNT(*) DESC
LIMIT 1;


--Query 5 - Find the name of customers who own a life policy but not a vehicle policy. 

SELECT name
FROM customer, policy, life_policy
WHERE policy.SSN=customer.SSN and policy.policy_no=life_policy.policy_num and policy.policy_no not in
	(SELECT policy_num
	FROM vehicle_policy
	);


--Query 6 - Find the name of customers who either owned a Honda CRV or been in an accident with a Honda CRV. 

SELECT name 
FROM customer 
WHERE DriverLicense IN (
	SELECT DISTINCT(DriverLicense) 
	FROM report 
	WHERE VIN_no IN 
		(SELECT cars.VIN_no 
		FROM cars 
		INNER JOIN vehicle 
		ON cars.VIN_no = vehicle.VIN_no AND vehicle.model = 'Honda CRV'
		)
	);


--Query 7 - Find the name of customers who never owned a Honda CRV or been in an accident with a Honda CRV. 

SELECT name 
FROM customer 
WHERE DriverLicense NOT IN (
	SELECT DISTINCT(DriverLicense) 
	FROM report 
	WHERE VIN_no IN 
		(SELECT cars.VIN_no 
		FROM cars 
		INNER JOIN vehicle 
		ON cars.VIN_no = vehicle.VIN_no AND vehicle.model = 'Honda CRV'
		)
	);
