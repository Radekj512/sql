use sakila;
show tables;

SELECT * FROM actor;
SELECT * FROM actor_info;
SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM customer_list;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM film_list;
SELECT * FROM film_text;
SELECT * FROM inventory;
SELECT * FROM language;
SELECT * FROM nicer_but_slower_film_list;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM sales_by_film_category;
SELECT * FROM sales_by_store;
SELECT * FROM staff;
SELECT * FROM staff_list;
SELECT * FROM store;


-- 10.2. Przygotuj odpowiednie zapytanie odpowiadające na następujące pytanie:

-- 10.2.1 Podaj pełne dane aktorów mających na imię ‘Scarlett’
select * from actor where first_name = 'Scarlett';

-- 10.2.2 Podaj pełne dane aktorów mających na nazwisko ‘Johansson’
select * from actor where last_name = 'Johansson';

-- 10.2.3 Ile niepowtarzalnych nazwisk aktorów zawiera baza?
select count(DISTINCT last_name) from actor;

-- 10.2.4 Które z nazwisk niepowtarzają się w bazie?
select DISTINCT last_name from actor;

-- 10.2.5 Które z nazwisk potwarzają się więcej niż raz?
select last_name, count(*) as number_of_duplikates from actor GROUP BY last_name HAVING COUNT(*) > 1;

-- 10.2.6 Który aktor wystąpił w największej ilości filmów? Ile było to filmów?
select actor_id, count(*) as number_of_films from film_actor GROUP BY actor_id;

-- 10.2.7 Jaka jest średnia długość filmu w bazie?
select * from film;
select avg(length) from film;

-- 10.2.8 Jaka jest średnia długość filmu w bazie per kategoria?
select category, avg(length) from film_list GROUP BY category;

-- 10.2.9 Pobierz filmy z kategorii family
select * from film_list where category = "family";

-- 10.2.10 Pobierz najchętniej wypożyczane filmy

-- 10.2.11 Wyświetl ile piniędzy zarobił łącznie każdy ze sklepów

-- 10.2.12 Wyświetl miasto i kraj dla wszystkich sklepów
select * from store;
select * from address;
select * from country;
select * from city;
SELECT 
    c.city, co.country
FROM
    address a
        INNER JOIN
    store s ON a.address_id = s.address_id
        INNER JOIN
    city c ON a.city_id = c.city_id
        INNER JOIN
    country co ON c.country_id = co.country_id;
    
-- 10.2.13 Wyświetl informacje o kategoriach filmów i ich łącznych zyskach jakie wygenerowały
select * from sales_by_film_category;

-- 10.2.15 Wyświetl wszystkich aktorów którzy w nazwisku posiadają litery LI

select * from actor where last_name like '%li%';

-- 10.2.16 Wykorzystując wbudowane funckje geometryczne typu ST_AS_TEXT(geo) i ST_X(geo), ST_Y(geo) wygeneruj gotowe dane do przeklejenia z tabeli danych adresowych,
-- którą będzie można przekleić w serwisie http://dwtkns.com/pointplotter/

select st_astext(location) from address;
select concat(st_x(location), ",",st_y(location)) coordinates from address where st_x(location) <> 0 AND st_y(location) <> 0;
