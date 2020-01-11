DROP TABLE lek_objs;
DROP TABLE table2;

Create or REPLACE TYPE t_lek as OBJECT(
  lek_id NUMBER(7,0),
  lek_nazwa VARCHAR2(70),
  lek_wymagana_spec_lekarza NUMBER(3,0) ,
  lek_cena_calosc NUMBER(8,2),
  lek_procent_refundacji NUMBER(3,2),
  MEMBER FUNCTION SHOW RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY t_lek AS MEMBER FUNCTION SHOW RETURN VARCHAR2 AS
v_all VARCHAR2(150);
  BEGIN 
  v_all := lek_id||' '||lek_nazwa||' '||lek_wymagana_spec_lekarza||' '||lek_cena_calosc||' '||lek_procent_refundacji;
  RETURN v_all;
  END;
  END;
  /
  
CREATE TABLE lek_objs of t_lek;

INSERT INTO lek_objs VALUES(t_lek(1,'Gripex',2,5.99,0.51));

SELECT * FROM lek_objs;

CREATE TABLE table2(
  id_table2 NUMBER(8),
  example_field VARCHAR2(50),
  t_lek_field t_lek
);

INSERT INTO table2 VALUES(1,'test',t_lek(1,'Gripex',2,5.99,0.51));

SELECT * FROM table2;
SELECT example_field, c.t_lek_field.lek_nazwa FROM table2 c;

CREATE OR REPLACE TYPE t_rodzic AS OBJECT(
  rodzic_id NUMBER(7,0),
  rodzic_imie VARCHAR2(70),
  rodzic_nazwisko VARCHAR2(70),
  FINAL MAP MEMBER FUNCTION getID RETURN NUMBER,
  NOT FINAL MEMBER FUNCTION show RETURN VARCHAR2
)NOT FINAL;
/

CREATE OR REPLACE TYPE BODY t_rodzic AS
  FINAL MAP MEMBER FUNCTION getID RETURN NUMBER IS
    BEGIN
      RETURN rodzic_id;
    END;
    MEMBER FUNCTION show RETURN VARCHAR2 IS
    v_out VARCHAR2(130);
    BEGIN 
      v_out := rodzic_id||' '||rodzic_imie||' '||rodzic_nazwisko;
    RETURN v_out;
  END;
END;
/

CREATE OR REPLACE TYPE t_rodzic_pracujacy UNDER t_rodzic(
  miejsce_pracy VARCHAR2(130),
  com_t_rodzic t_rodzic,
  overriding MEMBER FUNCTION show RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY t_rodzic_pracujacy AS
  overriding MEMBER FUNCTION show RETURN VARCHAR2 AS
  BEGIN
    RETURN (self AS t_rodzic).show||' '||miejsce_pracy;
  END;
END;
/

CREATE OR REPLACE TYPE t_shape AS OBJECT(
name VARCHAR2(30),
len Number(6,2),
wid Number(6,2),
hig Number(6,2),
area Number(12,2),
MAP MEMBER FUNCTION surface RETURN NUMBER,
MEMBER FUNCTION volume RETURN NUMBER,
MEMBER FUNCTION display RETURN VARCHAR2,
CONSTRUCTOR FUNCTION t_shape(SELF IN OUT NOCOPY t_shape, name VARCHAR2)
RETURN SELF AS RESULT
);
/

CREATE OR REPLACE
TYPE BODY T_SHAPE AS

  MAP MEMBER FUNCTION surface RETURN NUMBER AS
  BEGIN
   RETURN 2*(len*wid+len*hig+wid*hig);
  END surface;

  MEMBER FUNCTION volume RETURN NUMBER AS
  BEGIN
    RETURN 0;
  END volume;

  MEMBER FUNCTION display RETURN VARCHAR2 AS
  BEGIN
    RETURN 'todo';
  END display;

  CONSTRUCTOR FUNCTION t_shape(SELF IN OUT NOCOPY t_shape, name VARCHAR2)
RETURN SELF AS RESULT AS
  BEGIN
    SELF.name :=NAME;
    SELF.len :=0;
    SELF.wid :=0;
    SELF.hig :=0;
    SELF.area :=0;
    RETURN;
  END;

END;
/
CREATE TABLE  shapes_obj of t_shape;
INSERT INTO  shapes_obj VALUES (t_shape('rectangle'));
select * from shapes_obj;

CREATE OR REPLACE TYPE t_phone AS OBJECT(
  country_code NUMBER(2),
  area_code NUMBER(2),
  phone NUMBER(9),
  in_number NUMBER(4)
);
/

CREATE OR REPLACE TYPE t_phones AS VARRAY(5) OF t_phone;
/

CREATE TABLE dep_phones(
    dep_id NUMBER(4),
    phones t_phones

);

Insert Into dep_phones Values (10,t_phones(t_phone(48,65,578595,10),t_phone(49,66,578595,20)));

select * from dep_phones;

CREATE TYPE nested_phones AS TABLE OF t_phone;


  