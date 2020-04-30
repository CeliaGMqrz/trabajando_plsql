
--BOLETIN 1-- 

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

--4. Codificar un procedimiento que reciba una cadena y la visualice al revés. 
--(Se puede hacer también omitiendo el reverse y poniendo el índice negativo).

CREATE OR REPLACE PROCEDURE ej4(p_cadena VARCHAR2) 
IS 
    v_cadenareves VARCHAR2(10):='';
BEGIN 
    FOR i IN REVERSE 1..LENGTH(p_cadena) LOOP
        v_cadenareves:=v_cadenareves||SUBSTR(p_cadena,i,1);
    END LOOP;
    dbms_output.put_line('Cadena al revés: '||v_cadenareves);
END ej4;
/
exec ej4('Celia')

--5. Escribir un procedimiento que reciba una fecha y escriba el año, en número, correspondiente a esa fecha.

CREATE OR REPLACE PROCEDURE ej5(p_fecha DATE)
IS 
    v_anio NUMBER(4):='';
BEGIN 
    v_anio := TO_NUMBER(TO_CHAR(p_fecha, 'YYYY'));
    dbms_output.put_line('Año: '||v_anio);
END ej5;
/

exec ej5(to_date('04/10/1995'))

-- 8. Codificar un procedimiento que permita borrar un empleado cuyo número se pasará en la llamada.

CREATE OR REPLACE PROCEDURE ej8(p_empno emp.empno%TYPE)
IS 
BEGIN 
    DELETE FROM emp 
    WHERE empno=p_empno;
END ej8;
/

exec ej8(7902)

-- 9. Escribir un procedimiento que modifique la localidad de un departamento. El procedimiento recibirá como parámetros el número del departamento y la localidad nueva.
-- Nota: Los update no generan errores si no se encuentran los parametros introducidos, por lo que usaremos un if , si se ha modificado o no algun registro nos mostrará un mensaje.
-- Hay que recordar que para que putline funcione tenemos que hacer un set serveroutput on al inicio de la sesión.

CREATE OR REPLACE PROCEDURE ej9(p_numdep dept.deptno%TYPE, p_locnueva dept.loc%TYPE)
IS 
BEGIN 
    UPDATE dept 
    SET loc = p_locnueva
    WHERE deptno = p_numdep;
    if SQL%ROWCOUNT=1 then 
        dbms_output.put_line('Se ha modificado la fila.');
    else
        dbms_output.put_line('Departamento no encontrado, no se ha modificado nada.');
    end if;
END ej9;
/

exec ej9(10,'Sevilla')

-- 11. Realizar un procedimiento que reciba un número y muestre su tabla de multiplicar.

CREATE OR REPLACE PROCEDURE ej11(p_numero NUMBER)
IS
    v_resultado NUMBER(4):='';
BEGIN 
    for i in 1..10 loop
    v_resultado := i*p_numero;
    dbms_output.put_line(i||' X '||p_numero||' = '||v_resultado);
    end loop;
END ej11;
/
exec ej11(3)

--CORRECCIÓN-- Está bien pero no era necesario una variable auxiliar.

CREATE OR REPLACE PROCEDURE ej11(p_numero NUMBER)
IS
BEGIN 
    for i in 1..10 loop
    dbms_output.put_line(i||' X '||p_numero||' = '||p_numero*i);
    end loop;
END ej11;
/
exec ej11(3)

-- 13. Procedimiento que recibe una letra e imprima si es vocal o consonante.

CREATE OR REPLACE PROCEDURE ej13(p_letra VARCHAR2)
IS 
BEGIN 
    if upper(p_letra) in ('A','E','I','O','U') then 
      dbms_output.put_line(p_letra||' es vocal');
    else
      dbms_output.put_line(p_letra||' es consonante');
    end if;
END ej13;
/
exec ej13(a)

-- Manera más eficiente 

create or replace procedure MostrarVocaloConsonante (p_letra CHAR)
is
  v_resultado VARCHAR2(10):='Consonante';
begin
  if p_letra in ('A','E','I','O','U') then
    v_resultado := 'Vocal';
  end if;
  dbms_output.put_line(p_letra||' es una '||v_resultado);
end MostrarVocaloConsonante;