use employees;
-- 04.01 Znajdź największe wynagrodzenie.
select MAX(salary) from salaries;

-- 04.01.01 Wypisz do kogo należy.
select first_name, last_name, salary from employees e join salaries s on e.emp_no = s.emp_no where salary in(select max(salary) from salaries);
select * from salaries order by salary desc;
select * from employees where emp_no = 43624;

-- 04.02 Znajdź najmniejsze wynagrodzenie.
select MIN(salary) from salaries;

-- 04.02.01 Wypisz do kogo należy.
select first_name, last_name, salary from employees e join salaries s on e.emp_no = s.emp_no where salary in(select min(salary) from salaries);

-- 04.03 Wyświetl imię i nazwisko pracownika w kolumnie zapisanej jako ‘rekin biznesu’ mężczyzn urodzonych po 1954 roku
select concat(first_name, " ", last_name) as "Rekin Biznesu" from employees where gender = "M" AND year(birth_date) > 1954;

-- 04.04 Policz ilu rekinów biznesu pracuje i zapisz wartość w kolumnie o takiej nazwie.
select count(concat(first_name, " ", last_name)) as "Rekin Biznesu" from employees where gender = "M" AND year(birth_date) > 1954;

-- 04.05 Wyświetlić mężczyznę i kobietę, którzy zarabiają najwięcej

SELECT *
FROm employees e
INNER JOIN salaries s on e.emp_no = s.emp_no
WHERE s.salary IN (SELECT max(salary) FROm salaries s2 INNER JOIN employees e2 on s2.emp_no = e2.emp_no GROUP BY e2.gender);

 
 -- 04.05.01 Wyświetl największe zarobki per rok wypłacanej pensji.
 select max(salary), year(from_date) as "Rok" from salaries group by year(from_date);
 
 -- 04.05.02 Pobierz dane i zaprezentuj je w formie wykresu używając np. excela albo google calc drive.
 select 
 e.emp_no,
 first_name,
 last_name,
 salary,
 from_date,
 to_date from employees e inner join salaries s on e.emp_no = s.emp_no where e.emp_no = 10001 
 INTO OUTFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data.csv"
 fields terminated by ","
 LINES TERMINATED BY '\n';
 
 SHOW VARIABLES LIKE "secure_file_priv";
 -- /////////////////////// TODO //////////////////
 
 -- 04.06 Wyświetl zarobki, imie i nazwisko pracownika wraz płcią w formie jednej kolumny, którzy zarabiają powyżej 150000 w konstrukcjach z JOIN
 select concat(first_name, " ", last_name, "(", gender,")"," ",salary) as Pracownik from employees e inner join salaries s on e.emp_no = s.emp_no where salary > 150000;
 
 -- 04.06.01 Wyświetl zarobki, imię i nazwisko pracownika wraz płcią, którzy zarabiają pomiędzy 145000 a 150000
  select concat(first_name, " ", last_name, "(", gender,")"," ",salary) as Pracownik from employees e inner join salaries s on e.emp_no = s.emp_no where salary > 145000 AND salary < 150000 ;
  
  -- 04.06.02 Wyświetl zarobki, imię i nazwisko pracownika wraz płcią, którzy zarabiają powyżej średniej
  select avg(salary) from salaries; -- 63810.75;
select concat(first_name, " ", last_name, "(", gender,")"," ",salary) as Pracownik from employees e inner join salaries s on e.emp_no = s.emp_no where salary > (select avg(salary) from salaries);

-- 04.07 Wyświetlić płeć, liczbę pracowników, średnie wynagrodzenie, sumę wynagrodzenia i maksymalne wynagrodzenie dla danej płci.
select gender, count(gender), avg(salary), sum(salary), max(salary) from employees e inner join salaries s on e.emp_no = s.emp_no group by gender;

-- 04.08 Wyświetl sumę zarobków danego pracownika na przestrzeni wszystkich lat.
select e.emp_no, first_name, last_name, sum(salary) from employees e inner join salaries s on e.emp_no = s.emp_no group by emp_no; 
