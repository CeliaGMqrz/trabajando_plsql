
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

--16. Diseñar un procedimiento que recibe por parámetros dos valores numéricos que representan la
--base y el exponente de una potencia donde el exponente es un número entero positivo o negativo. El
--procedimiento visualiza el valor de la potencia, teniendo en cuenta las siguientes consideraciones:
--1) Si la base y el exponente son cero, se mostrará un mensaje de error que diga "Datos erróneos".
--2) Si el exponente es cero la potencia es 1.
--3) Si el exponente es negativo la fórmula matemática de la potencia es pot = 1/base^exp. En este caso,
--si la base es cero escribir un mensaje de "Datos erróneos".
--Nota: No utilizar ninguna función que calcule la potencia.

-- Para ello necesitamos dos funciones, una que calcule una potencia postiva, y una potencia negativa, después llamamos a las funciones en el procedimiento.

--Función potencia positiva.

CREATE OR REPLACE function potenciapositiva(p_base NUMBER, p_exponente NUMBER)
RETURN FLOAT
IS 
        v_resultado FLOAT:=1.0;
BEGIN 
        for i in 1..p_exponente loop
            v_resultado:=p_base*v_resultado;
        end loop;
        return v_resultado;
END potenciapositiva;

--Para probar la función:
select potenciapositiva(2,3) from dual;

-- Función potencia negativa.

CREATE OR REPLACE function potencianegativa(p_base NUMBER, p_exponente NUMBER)
RETURN FLOAT
IS 
        v_resultado FLOAT:=1.0;
BEGIN 
        if p_base = 0 then
            raise_application_error(-20001,'Datos Erróneos');
        end if;
        if p_exponente < 0 then
        v_resultado:=1/potenciapositiva(p_base,-1*p_exponente);
        return v_resultado;
        end if;
END potencianegativa;

-- Procedimiento potencia
CREATE OR REPLACE procedure Potencia (p_base NUMBER, p_exponente NUMBER)
IS
  v_resultado FLOAT:=1.0;
BEGIN
  if p_base = 0 and p_exponente = 0 then
    raise_application_error(-20001,'Datos Erróneos');
   elsif p_exponente < 0 then
    v_resultado:= potencianegativa(p_base, p_exponente);
   elsif p_exponente > 0 then
    v_resultado:= potenciapositiva(p_base, p_exponente);
  end if;
  dbms_output.put_line('Resultado= '||v_resultado);
END Potencia;















--19. Cree una tabla Tabla_Articulos con los siguientes atributos: código,
--nombre, precio e IVA. Introduzca datos de prueba utilizando la sentencia
--INSERT.
--CREATE TABLE Tabla_Articulos (
--codigo VARCHAR(5) PRIMARY KEY,
--nombre VARCHAR(20),
--precio NUMBER,
--IVA NUMBER);

--a) Construya un procedimiento que compruebe si el precio del artículo cuyo código es ‘A001’ es
--mayor que 10 euros y en caso afirmativo, imprima el nombre y el precio del artículo por pantalla.

--b) Construya un procedimiento que seleccione el artículo de mayor precio que esté almacenado en la
--tabla, almacene su valor en una variable y luego imprímalo.

--c) Construya un procedimiento que actualice el precio del artículo cuyo código es ‘A005’ según las
--siguientes indicaciones:
--− Si el artículo tiene un precio menor de 1 euro, su precio debe ser aumentado en 25 céntimos.
--− Si está comprendido entre 1 euro y 10 euros su precio aumentará un 10 % .Si excede los 10
--euros su precio aumentará en un 20 %.
--− Si el precio es NULL, el aumento es 0.

--d) Construya un procedimiento similar al del apartado c donde el usuario introduzca como
--parámetroel código del artículo que desee modificar su precio.

--20. Crear un procedimiento que en la tabla emp incrementar el salario el 10% a los empleados que
--tengan una comisión superior al 5% del salario.

--21. Crear un procedimiento que inserte un empleado en la tabla EMP. Su número será superior a los
--existentes y la fecha de incorporación a la empresa será la actual.