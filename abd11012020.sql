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