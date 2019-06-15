-- 07.01 Policz ile jest oddziałów
select count(*) as liczba_oddzialow from departments;

-- 07.02 Znajdź wszystkich managerów działu Development.
select * from dept_manager;
-- emp_no	dept_no	from_time	to_time
-- 10022	d001	1985-01-01	1991-10-01
select * from departments;
-- 	d005	Development

SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS manager,
    d.dept_name,
    dm.from_date,
    dm.to_date
FROM
    employees e
        INNER JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        INNER JOIN
    departments d ON dm.dept_no = d.dept_no
WHERE
    d.dept_name = 'Development';
    
-- 07.03 Który dział zatrudnia obecnie najwięcej osób?
ALTER VIEW counted_employees_in_departments AS
    SELECT 
        d.dept_name, COUNT(*) AS liczba
    FROM
        dept_emp de
            INNER JOIN
        departments d ON de.dept_no = d.dept_no
    GROUP BY d.dept_name
     order by liczba desc;

select * from counted_employees_in_departments limit 1;
    
-- 07.04 Stwórz raport zarobków obecnych managerów od najmniej zarabiających do najlepiej zarabiających podając działy w których pracują. (Nazwa działu, Imię, Nazwisko, Wynagrodzenie)
SELECT 
    CONCAT(d.dept_name,
            '    |     ',
            e.first_name,
            ' ',
            e.last_name,
            '    |     ',
            s.salary) 'Dział     |     Imie i naziwsko     |     wynagrodzenie'
FROM
    employees e
        INNER JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        INNER JOIN
    departments d ON dm.dept_no = d.dept_no
        INNER JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    dm.to_date > CURDATE()
        AND s.to_date > CURDATE()
ORDER BY s.salary ASC;

-- 07.05 Który dział miał najwięcej managerów?
ALTER VIEW count_of_managers_in_departments AS
    SELECT 
        dm.dept_no,
        d.dept_name,
        COUNT(dm.emp_no) AS liczba_managerow
    FROM
        dept_manager dm
            INNER JOIN
        departments d ON dm.dept_no = d.dept_no
    GROUP BY dm.dept_no;
    
SELECT 
    *
FROM
    count_of_managers_in_departments
WHERE
    liczba_managerow IN (SELECT 
            MAX(liczba_managerow)
        FROM
            count_of_managers_in_departments);

