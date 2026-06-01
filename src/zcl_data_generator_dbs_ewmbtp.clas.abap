CLASS zcl_data_generator_dbs_ewmbtp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DATA_GENERATOR_DBS_EWMBTP IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " delete existing entries in the database table
    DELETE FROM ztravell_m.
    DELETE FROM zBOOKINGg_m.
    DELETE FROM zbook_suppll_m.
    COMMIT WORK.
    " insert travel demo data
    INSERT ztravell_m FROM (
        SELECT *
          FROM /dmo/travel_m
      ).
    COMMIT WORK.

    " insert booking demo data
    INSERT zBOOKINGg_m FROM (
        SELECT *
          FROM   /dmo/booking_m
*            JOIN ytravel_tech_m AS y
*            ON   booking~travel_id = y~travel_id

      ).
    COMMIT WORK.
    INSERT zbook_suppll_m FROM (
        SELECT *
          FROM   /dmo/booksuppl_m
*            JOIN ytravel_tech_m AS y
*            ON   booking~travel_id = y~travel_id

      ).
    COMMIT WORK.

    out->write( 'Travel and booking demo data inserted.' ).


  ENDMETHOD.
ENDCLASS.
