Create or REPLACE TYPE t_lek as OBJECT(
  lek_id NUMBER(7,0),
  lek_nazwa VARCHAR2(70),
  lek_wymagana_spec_lekarza NUMBER(3,0) ,
  lek_cena_calosc NUMBER(8,2),
  lek_procent_refundacji NUMBER(3,2),
  MEMBER FUNCTION SHOW RETURN VARCHAR2
);