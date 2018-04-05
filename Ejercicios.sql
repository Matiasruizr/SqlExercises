set serveroutput on;

/* 1) Indique cual es la suma de las ventas ingresadas en la base de datos,
además, también muestre cual en la el valor de la venta más pequeña, el
valor de la venta más alta y el valor promedio de las ventas.*/

DECLARE 
  suma number := 0;
  maxima number := 0;
  minima number := 0;
  promedio number := 0;
BEGIN
   select sum(total) into suma from factura;
   select max(total) into maxima from factura;
   select min(total) into minima from factura;
   select avg(total) into promedio from factura;
  
   DBMS_OUTPUT.PUT_LINE('Lla suma de todas las ventas fue: '||suma);
   DBMS_OUTPUT.PUT_LINE('La venta más alta fue: '||maxima);
   DBMS_OUTPUT.PUT_LINE('La venta más baja fue: '||minima);
   DBMS_OUTPUT.PUT_LINE('La venta promedio fue: '||promedio);
END;
/

/* 2) Indique cual es el nombre de la empresa que hizo la venta más alta y el
nombre de la empresa que hizo la venta más baja indicando en ambos
casos cuantos productos poseen en el detalle de cada venta. */
DECLARE
  maxima number := 0;
  minima number := 0;
  alta VARCHAR2(30) := ' ';
  baja VARCHAR2(30) := ' ';
BEGIN
  select max(total) into maxima from factura;
  select min(total) into minima from factura;
  
  select  empresa.NOMBRE_FANTASIA
  into alta
  from factura 
  join empresa on EMPRESA_VENDEDORA = empresa.RUT
  where total = (select max(total) from factura)
  and ROWNUM <= 1;
  
  select  empresa.NOMBRE_FANTASIA
  into baja
  from factura 
  join empresa on EMPRESA_VENDEDORA = empresa.RUT
  where total = (select min(total) from factura)
  and ROWNUM <= 1;

   DBMS_OUTPUT.PUT_LINE('La venta más alta fue: '||maxima);
   DBMS_OUTPUT.PUT_LINE('La tuvo la empresa: '||alta);
   DBMS_OUTPUT.PUT_LINE('------------------------------');
   DBMS_OUTPUT.PUT_LINE('La venta más baja fue: '||minima);
   DBMS_OUTPUT.PUT_LINE('La tuvo la empresa: '||baja);
END;
/

rf
   
/* 3) Indique cuantos chilenos hay en la base de datos que trabajen en
empresas extranjeras. */


4) Muestre todos los datos de la empresa que tiene más empleados, si hubieran más entonces muestre solo una empresa.
*/
DECLARE
    var_maxEmpleados number := 0; 
    var_empresa varchar2(20) := ' ';
    var_datosEmpresa varchar2(500) := ' ';
BEGIN
    select MAX(count(emp.ID)) as nEmpleados
    into var_maxEmpleados
    from empresa e
    join empleado emp on e.rut = emp.RUT_EMPRESA
    group by e.NOMBRE_FANTASIA;
    
    select e.NOMBRE_FANTASIA
    into var_empresa
    from empresa e
    join empleado emp on e.rut = emp.RUT_EMPRESA
    group by e.NOMBRE_FANTASIA, e.RUT
    having count(emp.ID) = var_maxEmpleados;
    
    select 'Datos de la empresa: '||NOMBRE_FANTASIA||', Rut:'||RUT||'-'||DV||', Razon Social:'||RAZON_SOCIAL||', Giro:'||GIRO||' Nro empleados: '||var_maxEmpleados
    into var_datosEmpresa 
    from empresa
    where NOMBRE_FANTASIA = var_empresa ;
       
    SYS.DBMS_OUTPUT.PUT_LINE(var_datosEmpresa);
END;
/

/* 5) Muestre todos los datos de la empresa que tenga menos empleados.*/
DECLARE
    var_minEmpleados number := 0; 
    var_empresa varchar2(20) := ' ';
     var_datosEmpresa varchar2(500) := ' ';
BEGIN
    select MIN(count(emp.ID)) as nEmpleados
    into var_minEmpleados
    from empresa e
    join empleado emp on e.rut = emp.RUT_EMPRESA
    group by e.NOMBRE_FANTASIA;
    
    select e.NOMBRE_FANTASIA
    into var_empresa
    from empresa e
    join empleado emp on e.rut = emp.RUT_EMPRESA
    group by e.NOMBRE_FANTASIA, e.RUT
    having count(emp.ID) = var_minEmpleados;
    
    select 'Datos de la empresa: '||NOMBRE_FANTASIA||', Rut:'||RUT||'-'||DV||', Razon Social:'||RAZON_SOCIAL||', Giro:'||GIRO ||' Nro empleados: '||var_minEmpleados
    into var_datosEmpresa 
    from empresa
    where NOMBRE_FANTASIA = var_empresa ;
    SYS.DBMS_OUTPUT.PUT_LINE(var_datosEmpresa);
END;
/


/* 6) Indique cuantas empresas se encuentren en Chile 
fuera de la región metropolitana de Santiago.*/

DECLARE
  var_empresasFueraDeSantiago number := 0;
BEGIN
  select count(e.NOMBRE_FANTASIA)
  into var_empresasFueraDeSantiago
  from empresa e
  join comuna c on e.comuna = c.id
  join region r on c.ID_REGION = r.ID
  where r.NOMBRE not like 'REGIÓN METROPOLITANA DE SANTIAGO';
  
  DBMS_OUTPUT.PUT_LINE('El numero de empresas que están fuera de santiago es de: '||var_empresasFueraDeSantiago);
END;
/

/* 7) Indique cuantas empresas poseen al menos 2 empleados
los que adicionalmente deben tener su dirección fuera de la región metropolitana.*/

select * from empleado emp join;

select e.NOMBRE_FANTASIA, count(emp.id) from empresa e join empleado emp on e.RUT = emp.RUT_EMPRESA
group by e.NOMBRE_FANTASIA
having count(emp.id) >= 2;

