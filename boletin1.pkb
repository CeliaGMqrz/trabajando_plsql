
--BOLETIN 1-- Boletín resuelto sobre el usuario scott.

-- Activamos la salida de errores.
set serveroutput on;
--1. Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es 7082--
-- Creamos el procedimiento y lo compilamos 
create or replace procedure ej1
is
  v_nombre emp.ename%TYPE;
  v_salario emp.sal%TYPE;
begin
  select ename, sal into v_nombre, v_salario
  from emp
  where empno='7900';
  dbms_output.put_line('Nombre: '||v_nombre||' Salario: '||v_salario);
end ej1;
/
exec ej1

--2. Hacer un procedimiento que reciba como parámetro un código de empleado y devuelva su nombre.

CREATE OR REPLACE PROCEDURE ej2 (p_codemp emp.empno%TYPE)
IS 
    v_nombre emp.ename%TYPE;
BEGIN
    SELECT ename into v_nombre
    FROM emp 
    WHERE empno = p_codemp;
    dbms_output.put_line('Nombre del empleado: '||v_nombre);
END ej2;
/
exec ej2(7844);

-- 3. Crear un procedimiento PL/SQL que cuente el número de filas que hay en la tabla EMP(de Scott),
-- deposita el resultado en una variable y visualiza su contenido.

CREATE OR REPLACE PROCEDURE ej3
IS 
    v_numerofilas NUMBER(2);
BEGIN 
    SELECT count(empno) into v_numerofilas
    FROM emp;
    dbms_output.put_line('Nº de filas: '||v_numerofilas);
END ej3;
/
exec ej3;




