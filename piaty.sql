-- 05.01 Policz ile osób pracuje na danym stanowisku
SELECT 
    dept_name, COUNT(*) AS pracownicy
FROM
    employees e
        INNER JOIN
    dept_emp de ON e.emp_no = de.emp_no
        INNER JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name;
SELECT 
    title, COUNT(*) AS ilosc_pracownikow
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    YEAR(t.to_date) > 2019
GROUP BY title;


-- 05.02 Policz ile osób pracuje na danym stanowisku, gdzie min zatrudnienia to 1000 osob
SELECT 
    dept_name, COUNT(*) AS pracownicy
FROM
    employees e
        INNER JOIN
    dept_emp de ON e.emp_no = de.emp_no
        INNER JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name
HAVING pracownicy > 20000;
SELECT 
    title, COUNT(*) AS ilosc_pracownikow
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    YEAR(t.to_date) > 2019
GROUP BY title
HAVING ilosc_pracownikow > 20000;


-- 05.03 Policz ile kobiet i ile mężczyzn pracuje na danym stanowisku.
SELECT 
    dept_name, COUNT(*) AS pracownicy, gender
FROM
    employees e
        INNER JOIN
    dept_emp de ON e.emp_no = de.emp_no
        INNER JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name , gender;
SELECT 
    title, COUNT(*) AS ilosc_pracownikow, gender
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    YEAR(t.to_date) > 2019
GROUP BY title , gender;


-- 05.04 Policz ile kobiet i ile mężczyzn pracuje na danym stanowisku gdzie max zatrudnienia to 100 osob // za malo
SELECT 
    dept_name, COUNT(*) AS pracownicy, gender
FROM
    employees e
        INNER JOIN
    dept_emp de ON e.emp_no = de.emp_no
        INNER JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name , gender
HAVING pracownicy < 10000;

SELECT 
    title, COUNT(*) AS ilosc_pracownikow, gender
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    YEAR(t.to_date) > 2019
GROUP BY title , gender
HAVING ilosc_pracownikow < 100;


-- 05.05 Na których stanowiskach pracuje więcej niż 100 000 osób? (HAVING) // za duzo
SELECT 
    dept_name, COUNT(*) AS pracownicy
FROM
    employees e
        INNER JOIN
    dept_emp de ON e.emp_no = de.emp_no
        INNER JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name
HAVING pracownicy > 20000;
SELECT 
    title, COUNT(*) AS ilosc_pracownikow, gender
FROM
    employees e
        INNER JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    YEAR(t.to_date) > 2019
GROUP BY title , gender
HAVING ilosc_pracownikow > 10000;


-- 05.06 Dla wszystkich skończonych okresów pracy (to_date < sysdate()) na danym stanowisku (title) wyświetl średnią ilość dni jaką ludzie przepracowali na danym stanowisku.
SELECT 
    title, AVG(DATEDIFF(to_date, from_date))
FROM
    titles
WHERE
    to_date < SYSDATE()
GROUP BY title;