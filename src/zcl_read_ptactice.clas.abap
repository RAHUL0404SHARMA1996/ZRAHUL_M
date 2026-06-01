CLASS zcl_read_ptactice DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_READ_PTACTICE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    "sort form Read
*
*    READ ENTITY zi_travell_m
*    FROM VALUE #( ( %key-TravelId = '00000002'
*                    %control = VALUE #( AgencyId = if_abap_behv=>mk-on
*                                         CustomerId = if_abap_behv=>mk-on
*                                         BeginDate = if_abap_behv=>mk-on )
*                                        ) )
*    RESULT DATA(lt_result_sort)
*    FAILED DATA(lt_failed_sort).
*
*    IF lt_failed_sort IS NOT INITIAL.
*
*      out->write( 'Read Failed' ).
*
*    ELSE.
*      out->write( lt_result_sort ).
*    ENDIF.
    "sort form Read

*    READ ENTITY zi_travell_m
**    FIELDS ( AgencyId Createdat BeginDate CustomerId )
*BY \_booking
*ALL FIELDS
*    WITH VALUE #( ( %key-TravelId = '00000002' )
*                     ( %key-TravelId = '00000003'
*                                        ) )
*    RESULT DATA(lt_result_sort)
*    FAILED DATA(lt_failed_sort).
*
*    IF lt_failed_sort IS NOT INITIAL.
*
*      out->write( 'Read Failed' ).
*
*    ELSE.
*      out->write( lt_result_sort ).
*    ENDIF.

*    /// read Entities with Longer form

*    READ ENTITIES OF zi_travell_m
*    ENTITY zi_travell_m
*  ALL FIELDS
*   WITH VALUE #( ( %key-TravelId = '00000002' )
*                    ( %key-TravelId = '00000003'
*                                       ) )
*   RESULT DATA(lt_result_travel)
*   "read 2nd Entity
*     ENTITY zi_bookingg_m
*     ALL FIELDS
*   WITH VALUE #( ( %key-TravelId = '00000002'
*                   %key-BookingId = '0002'
*                    )
*                    ( %key-TravelId = '00000003'
*                    %key-BookingId = '0003'
*                     ) )
*   RESULT DATA(lt_result_booking)
*   FAILED DATA(lt_failed_sort).
*
*    IF lt_failed_sort IS NOT INITIAL.
*
*      out->write( 'Read Failed' ).
*
*    ELSE.
*      out->write( lt_result_travel ).
*      out->write( lt_result_booking ).
*    ENDIF.

    DATA : it_optab          TYPE abp_behv_retrievals_tab,
           it_travel         TYPE TABLE FOR READ IMPORT zi_travell_m,
           it_travel_result  TYPE TABLE FOR READ RESULT zi_travell_m,
           it_booking        TYPE TABLE FOR READ IMPORT zi_travell_m\_booking,
           it_booking_result TYPE TABLE FOR READ RESULT zi_travell_m\_booking.

    it_travel = VALUE #( ( %key-TravelId = '00000002'
             %control = VALUE #( AgencyId = if_abap_behv=>mk-on
                                  CustomerId = if_abap_behv=>mk-on
                                  BeginDate = if_abap_behv=>mk-on ) ) ).

    it_booking = VALUE #( ( %key-TravelId = '00000002'
                %control = VALUE #( BookingId = if_abap_behv=>mk-on
                                     BookingStatus = if_abap_behv=>mk-on
                                    BookingDate = if_abap_behv=>mk-on ) ) ).

    it_optab = VALUE #( ( op = if_abap_behv=>op-r-read
                          entity_name = 'ZI_TRAVELL_M'
                          instances = REF #( it_travel )
                          results = REF #( it_travel_result ) )
                          ( op = if_abap_behv=>op-r-read_ba
                          entity_name = 'ZI_TRAVELL_M'
                          sub_name = '_BOOKING'
                          instances = REF #( it_booking )
                          results = REF #( it_booking_result ) )
                           ).

    READ ENTITIES OPERATIONS it_optab
    FAILED DATA(lt_failed_dynamic).

    IF lt_failed_dynamic IS NOT INITIAL.
      out->write( 'Read Failed' ).
    ELSE.
      out->write( it_travel_result ).
      out->write( it_booking_result ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
