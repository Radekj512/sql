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