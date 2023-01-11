/*
 Завдання на SQL до лекції 03.
 */


/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.
*/
-- SQL code goes here...

SELECT category.name, COUNT(1) as film_count
FROM film
JOIN film_category on film.film_id = film_category.film_id
JOIN category on film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY (2) DESC;

/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/
-- SQL code goes here...

SELECT CONCAT(actor.last_name, ', ', actor.first_name) AS actor_name, COUNT(1) as rental_count
FROM rental
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film ON inventory.film_id = film.film_id
    JOIN film_actor ON film.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY CONCAT(actor.last_name, ', ', actor.first_name)
ORDER BY (2) DESC
LIMIT (10);

/*
3.
Вивести категорію фільмів, на яку було витрачено найбільше грошей
в прокаті
*/
-- SQL code goes here...

SELECT category.name as category_name, SUM(payment.amount) as payment_amount
FROM rental
    JOIN payment ON payment.rental_id = rental.rental_id
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film ON inventory.film_id = film.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY (2) DESC
LIMIT (1);

/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/
-- SQL code goes here...

SELECT DISTINCT film.title
FROM film
    LEFT JOIN inventory ON inventory.film_id = film.film_id
    WHERE inventory.film_id IS NULL;

SELECT DISTINCT film.title
FROM film
    WHERE NOT exists(SELECT film_id FROM inventory WHERE film_id = film.film_id)

/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/
-- SQL code goes here...

SELECT CONCAT(actor.last_name, ', ', actor.first_name) AS actor_name, COUNT(1) as top_count
FROM film
    JOIN film_actor ON film.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
GROUP BY CONCAT(actor.last_name, ', ', actor.first_name)
ORDER BY (2)DESC
LIMIT (3);


