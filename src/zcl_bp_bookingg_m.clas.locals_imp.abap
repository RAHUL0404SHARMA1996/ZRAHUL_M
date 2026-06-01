CLASS lhc_zi_bookingg_m DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_cba_Booksupp FOR NUMBERING
      IMPORTING entities FOR CREATE zi_bookingg_m\_Booksupp.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_bookingg_m RESULT result.
    METHODS validateconnection FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_bookingg_m~validateconnection.

    METHODS validatecurrencycode FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_bookingg_m~validatecurrencycode.

    METHODS validatecustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_bookingg_m~validatecustomer.

    METHODS validateflightprice FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_bookingg_m~validateflightprice.

    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_bookingg_m~validatestatus.
    METHODS calculatetotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_bookingg_m~calculatetotalprice.

ENDCLASS.

CLASS lhc_zi_bookingg_m IMPLEMENTATION.

  METHOD earlynumbering_cba_Booksupp.

    DATA : Lv_max_booking TYPE /dmo/booking_supplement_id.

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_bookingg_m BY \_booksupp
    FROM CORRESPONDING #( entities )
    LINK DATA(lt_link_data).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_group_entities>)
                                        GROUP BY <ls_group_entities>-%tky.

      Lv_max_booking = REDUCE #( INIT lv_max = CONV /dmo/booking_supplement_id( '0' )
                                   FOR ls_link IN lt_link_data USING KEY entity
                                    WHERE ( source-TravelId = <ls_group_entities>-TravelId
                                    AND source-BookingId = <ls_group_entities>-BookingId )
                                    NEXT lv_max = COND /dmo/booking_supplement_id( WHEN lv_max < ls_link-target-BookingSupplementId
                                                                       THEN ls_link-target-BookingSupplementId
                                                                       ELSE lv_max )  ).

      lv_max_booking = REDUCE #( INIT lv_max = Lv_max_booking
                        FOR ls_entity IN entities USING KEY entity
                         WHERE ( TravelId = <ls_group_entities>-TravelId
                         AND BookingId = <ls_group_entities>-BookingId  )
                         FOR ls_booking IN ls_entity-%target
                         NEXT lv_max = COND /dmo/booking_supplement_id( WHEN lv_max < ls_booking-BookingSupplementId
                                                                   THEN ls_booking-BookingSupplementId
                                                                   ELSE lv_max )
                          ) .

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entities>) USING KEY entity
                                             WHERE TravelId = <ls_group_entities>-TravelId
                                              AND BookingId = <ls_group_entities>-BookingId.
        LOOP AT <fs_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_booking>).
          APPEND CORRESPONDING #( <ls_booking> ) TO mapped-zi_book_suppll_m ASSIGNING FIELD-SYMBOL(<ls_new_map_book>).
          IF <ls_booking>-BookingSupplementId IS INITIAL.
            lv_max_booking += 10.


            <ls_new_map_book>-BookingSupplementId = lv_max_booking.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
     ENTITY zi_travell_m BY \_booking
     FIELDS ( TravelId BookingStatus )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_booking).

    result = VALUE #( FOR ls_booking IN lt_booking
                      ( %tky = ls_booking-%tky

                       %features-%assoc-_booksupp = COND #( WHEN ls_booking-BookingStatus = 'X'
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE if_abap_behv=>fc-o-enabled )

                                                               ) ).

  ENDMETHOD.

  METHOD validateConnection.
  ENDMETHOD.

  METHOD validateCurrencyCode.
  ENDMETHOD.

  METHOD ValidateCustomer.
  ENDMETHOD.

  METHOD validateFlightPrice.
  ENDMETHOD.

  METHOD validateStatus.
  ENDMETHOD.

  METHOD calculatetotalprice.

  data : it_travel type standard TABLE of zi_travell_m WITH UNIQUE HASHED KEY KEY COMPONENTS TravelId.

  it_travel = CORRESPONDING #( keys DISCARDING DUPLICATES MAPPING TravelId = TravelId ).

    MODIFY ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    EXECUTE recalcToPrice
    FROM CORRESPONDING #( it_travel ).

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
