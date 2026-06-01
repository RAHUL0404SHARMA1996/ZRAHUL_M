CLASS zcl_modify_practicee DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MODIFY_PRACTICEE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    DATA : lt_book TYPE TABLE FOR CREATE ZI_Travel_M\_booking_m.
*    MODIFY ENTITY zi_travell_m
*      CREATE
*      FROM VALUE #( (
*                 %cid = 'cid1'
*                 %data-BeginDate = '20260329'
*                 %control-BeginDate = if_abap_behv=>mk-on
*                 ) )
*
*CREATE BY \_booking
*FROM VALUE #( ( %cid_ref = 'cid1'
*                %target = VALUE #( (  %cid = 'cid11'
*                                  %data-BookingDate = '20260101'
*                                  %control-BookingDate = if_abap_behv=>mk-on ) )
*                                  ) )
*
*
*                 FAILED FINAL(it_failed)
*                 MAPPED FINAL(it_mapped)
*                 REPORTED FINAL(it_result).
*
*    IF it_failed IS NOT INITIAL.
*      out->write( it_failed ).
*    ELSE.
*      COMMIT ENTITIES.
*    ENDIF.

*    MODIFY ENTITY zi_bookingg_m
*      DELETE FROM VALUE #( ( %key-TravelId = '00004409'
*                             %key-BookingId = '0010' ) )
*      FAILED FINAL(it_failed1)
*                    MAPPED FINAL(it_mapped1)
*                    REPORTED FINAL(it_result1).
*
*    IF it_failed1 IS NOT INITIAL.
*      out->write( it_failed1 ).
*    ELSE.
*      COMMIT ENTITIES.
*    ENDIF.
*//2nd part  |{ AUTO FILL CID WIH fields_tab }
*    MODIFY ENTITY zi_travell_m
*      CREATE AUTO FILL CID WITH  VALUE #( (
**                 %cid = 'cid1'
*                 %data-BeginDate = '20260329'
*                 %control-BeginDate = if_abap_behv=>mk-on
*                 ) )
*
**CREATE BY \_booking
**FROM VALUE #( ( %cid_ref = 'cid1'
**                %target = VALUE #( (  %cid = 'cid11'
**                                  %data-BookingDate = '20260101'
**                                  %control-BookingDate = if_abap_behv=>mk-on ) )
**                                  ) )
*
*
*                 FAILED FINAL(it_failed)
*                 MAPPED FINAL(it_mapped)
*                 REPORTED FINAL(it_result).
*
*    IF it_failed IS NOT INITIAL.
*      out->write( it_failed ).
*    ELSE.
*      COMMIT ENTITIES.
*    ENDIF.

*    MODIFY ENTITIES OF zi_travell_m
*    ENTITY ZI_Travell_M
*    UPDATE FIELDS ( BeginDate )
*    WITH VALUE #( ( %key-TravelId = '00004413'
*                     BeginDate = '20260223' ) )
*
*      ENTITY ZI_TRAVELL_M
*      DELETE FROM VALUE #( ( %key-TravelId = '00004410' ) )
*    FAILED FINAL(it_failed).
**    COMMIT ENTITIES.
*    IF it_failed IS NOT INITIAL.
*      out->write( it_failed ).
*    ELSE.
*      COMMIT ENTITIES.
*    ENDIF.

  MODIFY
    ENTITY ZI_Travell_M
    UPDATE SET FIELDS WITH VALUE #( ( %key-TravelId = '00004413'
                     BeginDate = '20260225' ) )

*      ENTITY ZI_TRAVELL_M
*      DELETE FROM VALUE #( ( %key-TravelId = '00004410' ) )
    FAILED FINAL(it_failed).
*    COMMIT ENTITIES.
    IF it_failed IS NOT INITIAL.
      out->write( it_failed ).
    ELSE.
      COMMIT ENTITIES.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
