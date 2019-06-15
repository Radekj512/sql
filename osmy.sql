delimiter // 

CREATE FUNCTION HelloWorld () RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
	RETURN 'Hello World';
END
//

CREATE PROCEDURE all_employees ()
SELECT * FROM employees;
//
delimiter ;

-- delimiter // ignoruje srednik | delimiter ; przywraca dzialanie srednika

Select HelloWorld();
CALL all_employees();

-- 08.01 Stwórz funkcje yearsSince(dateFrom DATE) zwracającą jako rezultat ilość lat które minęły od podanej daty. Funkcję wykorzystaj aby wyświetlić dane o pracownikach i zamień dwa pola:
	-- birth_date - zamień na pole age wykorzystując w tym celu twoją funkcję yearsSince
	-- hire_date - zamień na pole hiredAgo wykorzystując w tym celu twoją funkcję yearsSince
delimiter //
DROP FUNCTION yearsSince//
CREATE function yearsSince(dateFrom DATE) returns int deterministic
BEGIN
	return  year(curdate()) - year(dateFrom);
END
//
delimiter ;
SELECT yearssince(date('2016-05-01'));
ALTER TABLE employees ADD COLUMN age int;
ALTER TABLE employees ADD COLUMN hired_ago int;

UPDATE employees 
SET 
    age = YEARSSINCE(birth_date);
    
UPDATE employees
SET
	hired_ago = yearsSince(hire_date);
    
-- ALTER TABLE employees DROP COLUMN birth_date;
-- ALTER TABLE employees DROP COLUMN hire_date;

-- 08.02 Stwórz funkcję pozwalającą na prezentację miesięcznych zarobków pracownika (dla przypomnienia, obecne dane w tabeli salaries zapisane są jako informacje roczne)
delimiter //
DROP PROCEDURE monthlyEarnings//
CREATE PROCEDURE monthlyEarnings(empno INT)
BEGIN
	select salary/12 as monthly_salary from salaries where emp_no = empno AND to_date > curdate();
END
//
delimiter ;
CALL monthlyEarnings(10001);

-- 08.03 Stwórz funkcję prezentującą ilość lat zatrudnienia dla dwóch parametrów from_date i to_date z tabeli dept_emp
	-- 08.03.01 Niektóe wpisy w kolumnie to_date mają zapisaną wartość 9999-01-01 oznacza ona zatrudnienie na czas nieokreślony,
    -- dla takich dat chcielibyśmy aby funkcja prezentowała wartośc dla aktualnego roku
delimiter //
DROP FUNCTION countYears//
CREATE function countYears(dateFrom DATE, dateTo DATE) returns int deterministic
BEGIN
	IF year(dateTo) > year(curdate()) THEN
		RETURN year(curdate()) - year(dateFrom);
	ELSE
		RETURN year(dateTo) - year(dateFrom);
	END IF;
END
//
delimiter ;

select from_date, to_date, countYears(from_date, to_date) from dept_emp;


-- 08.04 Stwórz procedurę o nazwie employees_with_current_salaries() prezentującą pracowników, z ostatnią wypłatą i tytułem. Pojedynczy wiersz powinien wyglądać jak poniżej:
-- 10001	Senior Engineer	1953-09-02	Georgi	Facello	M	1986-06-26	60117	2002-06-22
delimiter //
DROP PROCEDURE employees_with_current_salaries//
CREATE PROCEDURE employees_with_current_salaries() 
begin
SELECT 
    e.emp_no,    t.title,    e.birth_date,    e.first_name,    e.last_name,    e.gender,    e.hire_date,    s.salary,    s.from_date
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
        INNER JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
t.to_date > curdate()
and 
    s.from_date IN (SELECT 
            MAX(from_date)
        FROM
            salaries
        WHERE
            emp_no = s.emp_no);
end 
//
delimiter ;
call employees_with_current_salaries() ;


-- Stwórz procedurę o nazwie get_employees_be_title() prezentującą pracowników z podanym  tytułem. Tytuł powinien być podany jako argument procedury

delimiter //
drop PROCEDURE get_employees_by_title//
CREATE PROCEDURE get_employees_by_title(title VARCHAR(100))
BEGIN
	SELECT e.first_name, e.last_name, t.title
		FROM employees e 
        INNER JOIN titles t 
        ON e.emp_no = t.emp_no 
        WHERE t.title = title;
END
//
delimiter ;
call get_employees_by_title('engineer');


-- TRIGGERY

CREATE TABLE new_employees_counter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action_date DATETIME DEFAULT NULL
);
SELECT * FROM new_employees_counter;

-- Teraz tworzymy trigger, który będzie wyzwalany w przypadku dodania nowej osoby do bazy:

DELIMITER //
CREATE TRIGGER before_employee_insert
    BEFORE INSERT ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO new_employees_counter
    SET action_date = NOW();
END//
DELIMITER ;

INSERT INTO employees.employees (emp_no, birth_date, first_name, last_name, gender, hire_date) VALUES (20401122, '1988-04-20', 'Joanna', 'Kowalska', 'F', '2005-06-02');
SELECT * FROM new_employees_counter;

-- 08.05 Stwórz trigger który będzie zapisywał modyfikacje danych użytkowników i przechowywał je w specjalnej tabeli audytowej o nazwie employee_audit Będziemy w niej przechowywać:
	-- id
	-- employee_number
	-- first_name
	-- last_name
	-- modify_date aby dostać się do tych pól, można skorzystać z przedrostka OLD np. OLD.first_name co zwróci dane przez operacją.
    
Create table employee_audit(
	id INT AUTO_INCREMENT,
    employee_number INT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    modify_date DATE,
    PRIMARY KEY (id, employee_number)
);

select * from employee_audit;

DELIMITER //
CREATE TRIGGER before_employee_update
    BEFORE UPDATE ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO employee_audit(employee_number, first_name, last_name, modify_date) values(OLD.emp_no, OLD.first_name, OLD.last_name, NOW());
END//
DELIMITER ;
SELECT * from employees;
Update employees set gender = 'M' where emp_no = 1;