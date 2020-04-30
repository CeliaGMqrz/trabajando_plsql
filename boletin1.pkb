
--BOLETIN 1--

--1. Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es 7082--

-- Activamos la salida de errores.
set serveroutput on;
-- Creamos el procedimiento y lo compilamos 
create or replace procedure bol1
is
  v_nombre emp.ename%TYPE;
  v_salario emp.sal%TYPE;
begin
  select ename, sal into v_nombre, v_salario
  from emp
  where empno='7900';
  dbms_output.put_line('Nombre: '||v_nombre||' Salario: '||v_salario);
end bol1;
/
-- Ejecutamos el procedimiento
exec bol1



