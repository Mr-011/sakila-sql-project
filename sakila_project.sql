USE sakila;


-- films count

SELECT COUNT(*) AS total_films
FROM film

-- top 10 film

SELECT f.title, COUNT(r.rental_id) as rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f on i.film_id = f.film_id
GROUP BY f.title
ORDER BY rentals DESC
limit  10;

-- top 10 films money 
SELECT f.title, SUM(p.amount) AS total_revenue ,  AVG(p.amount) AS avg_ticket
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY total_revenue DESC
LIMIT 10;

-- top customers
SELECT c.first_name, c.last_name, SUM(p.amount) as total_paid
FROM customer c
JOIN payment p on c.customer_id = p.customer_id
group by c.customer_id
ORDER BY total_paid DESC
LIMIT 5;

-- films category
SELECT c.name AS category, COUNT(f.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
order by film_count DESC;

-- customers city
select ci.city , count(c.customer_id) as customers 
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
group by ci.city 
order by customers desc ;

-- country sales
Select Country.country AS Country_Name,
       Sum(Payment.amount) AS Total_Sales
From Payment
Join Rental ON Payment.rental_id = Rental.rental_id
Join Inventory ON Rental.inventory_id = Inventory.inventory_id
Join Store ON Inventory.store_id = Store.store_id
Join Address ON Store.address_id = Address.address_id
Join City ON Address.city_id = City.city_id
Join Country ON City.country_id = Country.country_id
Group By Country.country
Order By Total_Sales DESC;


