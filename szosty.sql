-- 06.01 Dodaj 250 pracowników do tabeli pracowników
-- desktop/bazy/res/employees.sql

-- 06.02 Dokonać operacji zmiany płci na kilku pracownikach
select * from employees where emp_no < 1000;

update employees set gender = "M" where emp_no = 1;
update employees set gender = "F" where first_name = "Al" AND last_name = "Elmar"; -- not working // safe mode

-- 06.03 Dokonać odwrotnej operacji zmiany płci w celu przywrócenia danych pierwotnych
update employees set gender = "F" where emp_no = 1;


-- 06.04 Wykorzystaj instrukcję DATEDIFF i TIMEDIFF
-- policz osoby ktore pracowaly mniej niz 30 dni na jednym stanowisku

SELECT 
    title AS Stanowisko,
    COUNT(*) 'Liczba osob pracujących mniej niz 30 dni na jednym stanowisku'
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    to_date < CURDATE()
        AND DATEDIFF(to_date, from_date) < 30
GROUP BY title;


-- 06.05 Awansuj kilku pracowników
select s.emp_no, s.first_name, s.last_name, t.title, t.from_date, t.to_date from employees s inner join titles t on s.emp_no = t.emp_no ;
-- '10001', 'Georgi', 'Facello', 'Senior Engineer', '1986-06-26', '9999-01-01'
select * from titles;
-- '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'
update titles set to_date = sysdate() where emp_no = 10001;
insert into titles(emp_no, title, from_date, to_date) values(10001, "Master Engineer", curdate(), '9999-01-01');

update titles set to_date = curdate() where emp_no = 10002;
insert into titles(emp_no, title, from_date, to_date) values(10002, "Senior Staff", curdate(), '9999-01-01');


-- 06.08 Dodaj siebie do tabeli pracowników.
select * from employees;
insert into employees(emp_no, birth_date, first_name, last_name, gender, hire_date) values(500000,'1992-12-05', 'Radek', 'Janus', 'M', curdate());
-- 06.08.01 Zatrudnij się w dziale Development
select * from dept_emp;
select* from departments;
insert into dept_emp(emp_no, dept_no, from_date, to_date) values(500000, 'd005', curdate(), '9999-01-01');

-- 06.08.02 Nadaj sobie tytuł Engineer obowiązujący od dnia dzisiajeszego na okres 3 miesiecy
select * from titles;
insert into titles(emp_no, title, from_date, to_date) values(500000, "Engineer", curdate(), DATE_ADD(curdate(), INTERVAL 3 MONTH));

-- 06.08.02 Zdefiniuj pensję od dnia dzisiajeszego do roku następnego w wysokości 100000$
select * from salaries;
insert into salaries(emp_no, salary, from_date, to_date) values(500000, 100000, curdate(), DATE_ADD(curdate(), INTERVAL 1 year));

--  06.09 Podnieś pensję o 10% wszystkim osobom spełniającym następujące kryteria:
	-- piastujący obecnie stanowisko Technique Leader //ok
	-- urodzonych przed 1953 rokiem //ok
	-- którzy do aktualnego roku (2019) przepracowali na ostatniej pozycji 34 lub więcej lat //ok 
	-- pamiętaj aby zmienić tylko ostatnią pensję nie historyczne (data to_date powinna wynosić 9999-01-01 lub > curdate() ) //ok
    
SELECT 
    e.emp_no,
    birth_date,
    first_name,
    last_name,
    title,
    salary
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
        INNER JOIN
    salaries s ON t.emp_no = s.emp_no
WHERE
    (t.title = 'Technique Leader'  AND t.to_date > curdate())
    AND YEAR(e.birth_date) < 1953
    AND (YEAR(curdate()) - YEAR(t.from_date)) >= 34
    AND(s.to_date = '9999-01-01' OR s.to_date > CURDATE());
        
UPDATE employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
        INNER JOIN
    salaries s ON t.emp_no = s.emp_no 
SET 
    s.salary = s.salary + ((s.salary * 10) / 100)
WHERE
    (t.title = 'Technique Leader' AND t.to_date > CURDATE())
        AND YEAR(e.birth_date) < 1953
        AND (YEAR(CURDATE()) - YEAR(t.from_date)) >= 34
        AND (s.to_date = '9999-01-01' OR s.to_date > CURDATE()); 
        
