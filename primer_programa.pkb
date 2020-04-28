-- Haciendo mi primer programa plsql--

-- Para compilar usamos: /
-- Para ver los errores: show err 
-- Para ejecutar programa: exec nombreprograma(listadeparatmetros, separados, porcomas)
-- Para mostrar por pantalla: set severoutput on (Variable de sesion, si cierras la sesión se pone en off. Se puede automatizar, investiga).

-- Programa --

-- Haz un procedimiento que muestre el nombre del empleado 7082. -- 

-- Activamos la salida de errores.
set serveroutput on;
-- Creamos el procedimiento y lo compilamos 
create or replace procedure MostrarNom7082
is v_nombre emp.ename%type;
begin 
    select ename into v_nombre
    from emp 
    where empno=7082;
    dbms_output.put_line(v_nombre);
end MostrarNom7082;
/
-- Ejecutamos el procedimiento
exec MostrarNom7082


-- De momento no vamos a poner zona de excepciones o de errores.

