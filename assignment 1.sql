use sakila;
 1 ----get all the customers whose first_name starts with 'j' and who are active-----
select first_name,active
from customer
where first_name like 'j%' 
and active = 1;

2 ---find all the films where title contains the word 'action' or description contains the word 'war'-------
select film_id,title,description
from film
where title like '%action%' or description like '%war%';

3 ---- List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
use sakila;
select customer_id,first_name,last_name,email,active
from customer
where last_name not like 'smith' and first_name like '%a';

4 ----- Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
select film_id,title,rental_rate,replacement_cost
from film
where rental_rate > '3.0'
 and replacement_cost is not null;
 
 
 
5 --- Count how many customers exist in each store who have active status = 1.
 
 select store_id,active,count(*) as active_members
 from customer
 group by store_id,active
 having active=1;
 
 6 ----Show distinct film ratings available in the film table.

select distinct rating
from film;


7---Find the number of films for each rental duration where the average length is more than 100 minutes.
select rental_duration,count(film_id) as total_films,avg(length) as avg_length
from film
group by rental_duration
having avg(length)>100;

8--- List payment dates and total amount paid per date, but only include days where more than 100 payments were made.

select date(payment_date) as payment_day,count(payment_id) as total_payments,sum(amount)as total_amount
from payment
group by date(payment_date)
having count(payment_id)>100
order by payment_day;


9--- Find customers whose email address is null or ends with '.org'.
select customer_id,first_name,last_name,email
from customer
where email is null or email like '%.org';


10---- List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
select film_id,rental_rate,rating,title
from film
where rating in ( 'pg' , 'g')
order by rental_rate desc;

11---- Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
select length,
count(film_id) as total_films
from film 
where title like 't%'
group by length
having count(film_id)> 5


12--- List all actors who have appeared in more than 10 films.
select first_name,last_name,count(actor_id) as actors

13---- Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
select  film_id,title,rental_rate, length
from film
order by rental_rate desc , length desc
limit 5; 

14--- Show all customers along with the total number of rentals they have made, ordered from most to least rentals


15--- List the film titles that have never been rented.
select title 
from film
where title is null;

16---Find all staff members along with the total payments they have processed, ordered by total payment amount in descending order.

17--- Show the category name along with the total number of films in each category.
select name , count(category_id ) as total_films
from  category
group by name;

18--- List the top 3 customers who have spent the most money in total.
select c.customer_id,c.first_name,c.last_name,
sum(p.amount) as total_spent
from customer c
join payment p on c. customer_id = p.customer_id
group by c.customer_id,c.first_name,c.last_name
order by total_spent desc
limit 3;
 
 19--. Find all films that were rented in the month of May (any year) and have a rental duration greater than 5 days.
 
 select distinct f.film_id,f.title,f.rental_duration
 from film f
 join inventory i on f.film_id = i.film_id
 join rental r on i.inventory_id = r.inventory_id
where month(r.rental_date) = 5
 and f.rental_duration>5;

20--- Get the average rental rate for each film category, but only include categories with more than 50 films.

select c.name as category_name,
avg(f.rental_rate) as avg_rental_rate,
count(f.film_id) as total_films
from category c
join film_category fc on c.category_id = fc.category
join film f on fc.film_id = f.film_id
group by c.name
having count(f.film_id) > 50
order by avg_rental_rate desc;