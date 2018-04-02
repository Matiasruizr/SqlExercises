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


   
/* 3) Indique cuantos chilenos hay en la base de datos que trabajen en
empresas extranjeras. */

