use employees;
-- 3.01 Wyszukaj wszystkich pracowników
select * from employees;

-- 3.02 Wyszukaj wśród pracowników wszystkich mężczyczn.
select * from employees where gender = 'M';

-- 3.02.01 Wyszukaj wśród pracowników wszystkie kobiety.
select * from employees where gender = 'F';

-- 3.02.02 Wyszukaj wśród pracowników wszystkich o nazwisku Lortz.
select * from employees where last_name = 'Lortz';

-- 3.02.03 Wyszukaj wśród pracowników wszystkich o imieniu Mary.
select * from employees where first_name = 'Mary';

-- Wyszukaj wśród pracowników wszystkich zatrudnionych 1 Stycznia 1991.
select * from employees where hire_date = '1991-01-01';

-- 3.03 I ogranicz wyniki do 10
select * from employees where hire_date > '1991-01-01' limit 10;

-- 3.04 Znajdź 30 najstarszych pracowników
select * from employees order by birth_date ASC limit 30;

-- 3.04.01 Znajdź 20 najmłodszych pracowników
select * from employees order by birth_date DESC limit 20;

-- 03.04.02 Wyświetl ich z informacją o ich wieku zamiast daty urodzenia. 
select * , floor(datediff(curdate(), birth_date)/365) as age from employees order by birth_date DESC limit 20;
select * , year(curdate()) - year(birth_date) as age from employees order by birth_date DESC limit 20;

-- 3.04.03 Znajdź 10 pracowników, którzy zostali zatrudnieni w firmie najdawniej.
select * from employees order by hire_date DESC Limit 10;

-- 03.05 Ile było i jest w firmie zatrudnionych pracowników?
select count(*) from employees.dept_emp;

-- 03.05.01 Ile było i jest w firmie zatrudnionych kobiet?
select count(*) from employees where gender = "F";

-- 03.05.01 Ile było i jest w firmie zatrudnionych mężczyzn zatrudnionych po 2000 roku?
select count(*) from employees where gender = "M" AND hire_date > '2000-01-01';

-- 03.06 Ilu inżynierów ('engineer') pracuje obecnie w firmie (tabela titles)?
select * from titles;
select count(*) from titles where title = "Engineer";

-- 03.06.01 Ilu starszych inżynierów (tytuł Senior Engineer)
select count(*) from titles where title = "Senior Engineer";

-- 03.07 Policz wszystkich pracujących mężczyzn i kobiety.
select count(*) from dept_emp where to_date = '9999-01-01';
select gender ,count(*) as 'liczba pracownikow' from employees group by gender;

-- 03.07.01 Dokonaj podobnego podziału na tytuł roli jaką wykonują i policz ilu pracowników było/jest zatrudnionych na danym stanowisku?
select title, count(*) as 'liczba pracownikow'  from titles group by title;

-- 03.07.02 Teraz dokonajmy podobnego zapytania dla nazwisk i wypisać najpopularniejsze nazwiska osób zatrudnionych kiedykolwiek w firmie.
select last_name
, count(*) as 'Liczba pracownikow'  from employees group by last_name;

-- 03.08 Policz wszystkich pracujących mężczyzn i kobiety urodzonych po 1960.
select count(*) "pracownicy urodzeni po 1960", gender from employees where year(birth_date) > 1960 group by gender;

-- 03.08.01 Policz wszystkich pracujących mężczyzn i kobiety zatrudnionych po 2000, zatrudnionych na stanowisku starszego inżyniera
-- select count(*) from employees e join titles t on e.emp_no = t.emp_no where title = 'Engineer'
select * from employees;
select * from titles order by emp_no;
select count(*)"pracownicy zatrudnieni po 1995 na stranowisku starszego inzyniera", gender from employees e join titles t on e.emp_no = t.emp_no where year(e.hire_date) > 1995 AND t.title = "Senior Engineer" group by gender;
select count(*)"starszy inzynier po 2000", gender  from employees e join titles t on t.emp_no = e.emp_no where year(t.from_date) > 2000 AND t.title = "Senior Engineer" group by gender;
  