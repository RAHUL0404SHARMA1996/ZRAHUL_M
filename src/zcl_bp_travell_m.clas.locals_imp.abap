CLASS lsc_zi_travell_m DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zi_travell_m IMPLEMENTATION.

  METHOD save_modified.

    DATA : lt_travel_log   TYPE STANDARD TABLE OF zlog_travell_m,
           lt_travel_log_c TYPE STANDARD TABLE OF zlog_travell_m,
           lt_travel_log_U TYPE STANDARD TABLE OF zlog_travell_m.

    IF Create-zi_travell_m IS NOT INITIAL.

      lt_travel_log = CORRESPONDING #( Create-zi_travell_m ).

      LOOP AT lt_travel_log ASSIGNING FIELD-SYMBOL(<fs_lt_travel_log>).

        <fs_lt_travel_log>-changing_operation = 'CREATE'.
        GET TIME STAMP FIELD <fs_lt_travel_log>-created_at.

        READ TABLE Create-zi_travell_m ASSIGNING FIELD-SYMBOL(<ls_travel>)
                              WITH TABLE KEY entity
                              COMPONENTS  TravelId = <fs_lt_travel_log>-travelid.

        IF sy-subrc EQ 0.

          IF <ls_travel>-%control-BookingFee = cl_abap_behv=>flag_changed.

            <fs_lt_travel_log>-changing_field_name = 'BookingFee'.
            <fs_lt_travel_log>-changed_value = <ls_travel>-BookingFee.
            TRY.
                <fs_lt_travel_log>-chnage_id  = cl_system_uuid=>create_uuid_x16_static( ).
              CATCH cx_uuid_error.
                "handle exception
            ENDTRY.


            APPEND <fs_lt_travel_log> TO lt_travel_log_c.
          ENDIF.

          IF <ls_travel>-%control-OverallStatus = cl_abap_behv=>flag_changed.

            <fs_lt_travel_log>-changing_field_name = 'OverallStatus'.
            <fs_lt_travel_log>-changed_value = <ls_travel>-BookingFee.
            TRY.
                <fs_lt_travel_log>-chnage_id  = cl_system_uuid=>create_uuid_x16_static( ).
              CATCH cx_uuid_error.
                "handle exception
            ENDTRY.


            APPEND <fs_lt_travel_log> TO lt_travel_log_c.
          ENDIF.

        ENDIF.

      ENDLOOP.

      INSERT zlog_travell_m FROM TABLE @lt_travel_log_c.

    ENDIF.

    IF Update-zi_travell_m IS NOT INITIAL.

      lt_travel_log = CORRESPONDING #( update-zi_travell_m ).


      LOOP AT update-zi_travell_m ASSIGNING FIELD-SYMBOL(<fs_LOG_UPDATE>).

        ASSIGN lt_travel_log[ travelid = <fs_LOG_UPDATE>-TravelId ] TO FIELD-SYMBOL(<ls_log_u>).

        <ls_log_u>-changing_operation = 'UPDATE'.
        GET TIME STAMP FIELD <ls_log_u>-created_at.

        IF <fs_LOG_UPDATE>-%control-CustomerId = if_abap_behv=>mk-on.

          <ls_log_u>-changed_value = <fs_LOG_UPDATE>-CustomerId.
          TRY.
              <ls_log_u>-chnage_id = cl_system_uuid=>create_uuid_x16_static( ).
            CATCH cx_uuid_error.
          ENDTRY.

          <ls_log_u>-changing_field_name = 'CustomerId'.
          APPEND <ls_log_u> TO lt_travel_log_u.

        ENDIF.

        IF <fs_LOG_UPDATE>-%control-Description = if_abap_behv=>mk-on.

          <ls_log_u>-changed_value = <fs_LOG_UPDATE>-Description.
          TRY.
              <ls_log_u>-chnage_id = cl_system_uuid=>create_uuid_x16_static( ).
            CATCH cx_uuid_error.
          ENDTRY.

          <ls_log_u>-changing_field_name = 'Description'.
          APPEND <ls_log_u> TO lt_travel_log_u.

        ENDIF.

      ENDLOOP.
      INSERT zlog_travell_m FROM TABLE @lt_travel_log_u.
    ENDIF.

    IF Delete-zi_travell_m IS NOT INITIAL.

      lt_travel_log = CORRESPONDING #( delete-zi_travell_m ).

      LOOP AT lt_travel_log ASSIGNING FIELD-SYMBOL(<fs_log_del>).

        <fs_log_del>-changing_operation = 'DELETE'.
        GET TIME STAMP FIELD <fs_log_del>-created_at.
        TRY.
            <fs_log_del>-chnage_id  = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error.
        ENDTRY.

      ENDLOOP.
      INSERT zlog_travell_m FROM TABLE @lt_travel_log.
    ENDIF.

*/////////////////////////////////////////////s
* Unmanaged save Implementation

    DATA : lt_book_suppl TYPE STANDARD TABLE OF zbook_suppll_m. "persistanet table name

    IF Create-zi_book_suppll_m IS NOT INITIAL.

      lt_book_suppl = VALUE #( FOR ls_booksup IN Create-zi_book_suppll_m (
                                       travel_id = ls_booksup-TravelId
                                       booking_id = ls_booksup-BookingId
                                       booking_supplement_id = ls_booksup-BookingSupplementId
                                       supplement_id = ls_booksup-SupplementId
                                       price = ls_booksup-Price
                                       currency_code = ls_booksup-CurrencyCode
                                       last_changed_at = ls_booksup-LastChangedAt
                                       local_created_by = ls_booksup-LocalCreatedBy
                                       local_created_at = ls_booksup-LocalCreatedAt
                                       local_last_changed_by = ls_booksup-LocalLastChangedBy
                                       local_last_changed_at = ls_booksup-LocalLastChangedAt
                                       ) ).

**       call FUNCTION '/DMO/FLIGHT_BOOKSUPPL_C'
**         EXPORTING
**           values = lt_book_suppl
**         .
      INSERT zbook_suppll_m FROM TABLE @lt_book_suppl.

    ENDIF.

    IF Update-zi_book_suppll_m IS NOT INITIAL.


      lt_book_suppl = VALUE #( FOR ls_booksup IN Update-zi_book_suppll_m (
                                       travel_id = ls_booksup-TravelId
                                       booking_id = ls_booksup-BookingId
                                       booking_supplement_id = ls_booksup-BookingSupplementId
                                       supplement_id = ls_booksup-SupplementId
                                       price = ls_booksup-Price
                                       currency_code = ls_booksup-CurrencyCode
                                       last_changed_at = ls_booksup-LastChangedAt
                                       local_created_by = ls_booksup-LocalCreatedBy
                                       local_created_at = ls_booksup-LocalCreatedAt
                                       local_last_changed_by = ls_booksup-LocalLastChangedBy
                                       local_last_changed_at = ls_booksup-LocalLastChangedAt
                                       ) ).

      UPDATE zbook_suppll_m FROM TABLE @lt_book_suppl.

    ENDIF.

    IF delete-zi_book_suppll_m IS NOT INITIAL.
          lt_book_suppl = VALUE #( FOR ls_del IN delete-zi_book_suppll_m (
                                       travel_id = ls_del-TravelId
                                       booking_id = ls_del-BookingId
                                       booking_supplement_id = ls_del-BookingSupplementId

                                       ) ).
      delete zbook_suppll_m FROM TABLE @lt_book_suppl.

    ENDIF.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_TRAVELL_M DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travell_m RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_travell_m RESULT result.
    METHODS accepttravel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travell_m~accepttravel RESULT result.

    METHODS copytravel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travell_m~copytravel.

    METHODS recalctoprice FOR MODIFY
      IMPORTING keys FOR ACTION zi_travell_m~recalctoprice.

    METHODS rejecttravel FOR MODIFY
      IMPORTING keys FOR ACTION zi_travell_m~rejecttravel RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_travell_m RESULT result.
    METHODS validatecustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_travell_m~validatecustomer.
    METHODS validatebookingfee FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_travell_m~validatebookingfee.

    METHODS validatecurrencycode FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_travell_m~validatecurrencycode.

    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_travell_m~validatedates.

    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_travell_m~validatestatus.
    METHODS calculatetotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_travell_m~calculatetotalprice.
    METHODS earlynumbering_cba_booking FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travell_m\_booking.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travell_m.

ENDCLASS.

CLASS lhc_ZI_TRAVELL_M IMPLEMENTATION.

  METHOD get_instance_authorizations.


  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA(lt_entities) = entities.

    DELETE lt_entities WHERE TravelId IS NOT INITIAL.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*        ignore_buffer     =
            nr_range_nr       = '01'
            object            = '/dmo/trv_m'
            quantity          = CONV #( lines( lt_entities ) )
*        subobject         =
*        toyear            =
          IMPORTING
            number            = DATA(lv_latest_num)
            returncode        = DATA(lv_code)
            returned_quantity = DATA(lv_qty)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).
        LOOP AT lt_entities INTO DATA(ls_entities).
          APPEND  VALUE #( %cid = ls_entities-%cid
                             %key =  ls_entities-%key ) TO failed-zi_travell_m.
          APPEND  VALUE #( %cid = ls_entities-%cid
                            %key =  ls_entities-%key
                            %msg =  lo_error ) TO reported-zi_travell_m.
        ENDLOOP.
        EXIT.
    ENDTRY.

    ASSERT lv_qty = lines( lt_entities ).

    DATA : lt_travell_m TYPE TABLE FOR MAPPED EARLY zi_travell_m,
           ls_travell_m LIKE LINE OF lt_travell_m.

    DATA(lv_curr_num) = lv_latest_num - lv_qty.

    LOOP AT lt_entities INTO ls_entities.

      lv_curr_num = lv_curr_num + 1.

*      ls_travell_m = VALUE #( %cid = ls_entities-%cid
*                             TravelId =  lv_curr_num ).
*
*      APPEND ls_travell_m TO mapped-zi_travell_m.

      APPEND  VALUE #( %cid = ls_entities-%cid
                                   TravelId =  lv_curr_num ) TO mapped-zi_travell_m.

    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.

    DATA : Lv_max_booking TYPE /dmo/booking_id.

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m BY \_booking
    FROM CORRESPONDING #( entities )
    LINK DATA(lt_link_data).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_group_entities>)
                                        GROUP BY <ls_group_entities>-TravelId.

      Lv_max_booking = REDUCE #( INIT lv_max = CONV /dmo/booking_id( '0' )
                                   FOR ls_link IN lt_link_data USING KEY entity
                                    WHERE ( source-TravelId = <ls_group_entities>-TravelId )
                                    NEXT lv_max = COND /dmo/booking_id( WHEN lv_max < ls_link-target-BookingId
                                                                       THEN ls_link-target-BookingId
                                                                       ELSE lv_max )  ).

      lv_max_booking = REDUCE #( INIT lv_max = Lv_max_booking
                        FOR ls_entity IN entities USING KEY entity
                         WHERE ( TravelId = <ls_group_entities>-TravelId )
                         FOR ls_booking IN ls_entity-%target
                         NEXT lv_max = COND /dmo/booking_id( WHEN lv_max < ls_booking-BookingId
                                                                   THEN ls_booking-BookingId
                                                                   ELSE lv_max )
                          ) .

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entities>) USING KEY entity
                                             WHERE TravelId = <ls_group_entities>-TravelId.

        LOOP AT <fs_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_booking>).
          APPEND CORRESPONDING #( <ls_booking> ) TO mapped-zi_bookingg_m ASSIGNING FIELD-SYMBOL(<ls_new_map_book>).
          IF <ls_booking>-BookingId IS INITIAL.
            lv_max_booking += 10.


            <ls_new_map_book>-BookingId = lv_max_booking.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD acceptTravel.

    MODIFY ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    UPDATE FIELDS ( OverallStatus )
    WITH  VALUE #( FOR ls_keys IN keys ( %tky = ls_keys-%tky
                                         OverallStatus = 'A' ) ).
**    REPORTED DATA(lt_travel).

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result ( %tky = ls_result-%tky
                                                   %param = ls_result ) ).


  ENDMETHOD.

  METHOD copyTravel.

    DATA : it_travel       TYPE TABLE FOR CREATE zi_travell_m,
           it_booking_cba  TYPE TABLE FOR CREATE zi_travell_m\_booking,
           it_booksupp_cba TYPE TABLE FOR CREATE zi_bookingg_m\_booksupp.

    READ TABLE keys ASSIGNING FIELD-SYMBOL(<fs_keys>) WITH KEY %cid = ' '.

    ASSERT <fs_keys> IS NOT ASSIGNED.

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result_r)
    FAILED DATA(lt_failed).

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m BY \_booking
    ALL FIELDS WITH CORRESPONDING #( lt_result_r )
    RESULT DATA(lt_booking_r).

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_bookingg_m BY \_booksupp
    ALL FIELDS WITH CORRESPONDING #( lt_booking_r )
    RESULT DATA(lt_booksupp_r).



    LOOP AT lt_result_r ASSIGNING FIELD-SYMBOL(<fs_Travel>).

*      APPEND INITIAL LINE TO it_travel ASSIGNING FIELD-SYMBOL(<fs_travel1>).
*      <fs_travel1>-%cid = keys[ KEY entity TravelId =  <fs_Travel>-travelId ]-%cid.
*      <fs_travel1>-%data = CORRESPONDING #( <fs_Travel> EXCEPT TravelId ).

      APPEND VALUE #( %cid = keys[ KEY entity TravelId =  <fs_Travel>-travelId ]-%cid
                    %data = CORRESPONDING #( <fs_Travel> EXCEPT TravelId ) )
                    TO it_travel ASSIGNING FIELD-SYMBOL(<fs_travel1>).

      "todays date
      <fs_travel1>-BeginDate = cl_abap_context_info=>get_system_date( ).
      "end date
      <fs_travel1>-EndDate = cl_abap_context_info=>get_system_date( ) + 30.
      <fs_travel1>-OverallStatus = 'O'.

      APPEND VALUE #( %cid_ref = <fs_travel1>-%cid )
      TO it_booking_cba ASSIGNING FIELD-SYMBOL(<fs_booking>).

      LOOP AT lt_booking_r ASSIGNING FIELD-SYMBOL(<ls_booking_r>)
                                              USING KEY entity
                                              WHERE travelId EQ <fs_Travel>-TravelId.

        APPEND VALUE #( %cid = <fs_travel1>-%cid && <ls_booking_r>-BookingId
                        %data = CORRESPONDING #( <ls_booking_r> EXCEPT TravelId ) )
                        TO <fs_booking>-%target  ASSIGNING FIELD-SYMBOL(<ls_booking_n>).

        <ls_booking_n>-BookingStatus = 'N'.


        APPEND VALUE #( %cid_ref = <ls_booking_n>-%cid )
    TO it_booksupp_cba ASSIGNING FIELD-SYMBOL(<ls_booksupp>).

        LOOP AT lt_booksupp_r ASSIGNING FIELD-SYMBOL(<ls_booksupp_r>)
                                         USING KEY entity
                                           WHERE travelId EQ <fs_Travel>-TravelId
                                           AND BookingId EQ <ls_booking_r>-BookingId.

          APPEND VALUE #( %cid = <fs_travel1>-%cid && <ls_booking_r>-BookingId && <ls_booksupp_r>-BookingSupplementId
                  %data = CORRESPONDING #( <ls_booksupp_r> EXCEPT TravelId BookingId ) )
                  TO <ls_booksupp>-%target .

        ENDLOOP.
      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zi_travell_m  IN LOCAL MODE
        ENTITY zi_travell_m
        CREATE FIELDS ( AgencyId CustomerId BeginDate EndDate BookingFee
                           TotalPrice CurrencyCode OverallStatus Description )
             WITH it_travel
             ENTITY zi_travell_m
             CREATE BY \_booking
             FIELDS ( BookingId BookingDate CustomerId CarrierId ConnectionId FlightDate FlightPrice
                   CurrencyCode BookingStatus )  WITH it_booking_cba
                   ENTITY zi_bookingg_m
                   CREATE BY \_booksupp
                   FIELDS (  BookingSupplementId SupplementId Price CurrencyCode )
                   WITH it_booksupp_cba
                   MAPPED DATA(it_mapped).

    mapped-zi_travell_m = it_mapped-zi_travell_m.
  ENDMETHOD.

  METHOD recalcToPrice.

    TYPES : BEGIN OF ty_total,
              Price TYPE /dmo/flight_price,
              curr  TYPE /dmo/currency_code,
            END OF ty_total.

    DATA : lt_total      TYPE TABLE OF ty_total,
           lv_conv_price TYPE ty_total-price.

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    FIELDS ( BookingFee CurrencyCode  )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).

    DELETE lt_travel WHERE CurrencyCode IS INITIAL.


    READ ENTITIES OF zi_travell_m IN LOCAL MODE
 ENTITY zi_travell_m BY \_booking
 FIELDS ( FlightPrice CurrencyCode  )
 WITH CORRESPONDING #( lt_travel )
 RESULT DATA(lt_ba_booking).

* booking Supplement
    READ ENTITIES OF zi_travell_m IN LOCAL MODE
  ENTITY zi_bookingg_m BY \_booksupp
  FIELDS ( Price CurrencyCode  )
  WITH CORRESPONDING #( lt_ba_booking )
  RESULT DATA(lt_ba_booksuppl).


    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<ls_travel>).

      lt_total = VALUE #( ( price = <ls_travel>-BookingFee curr = <ls_travel>-CurrencyCode ) ).

      LOOP AT  lt_ba_booking ASSIGNING FIELD-SYMBOL(<ls_booking>)
                                                 USING KEY Entity
                                                 WHERE travelId = <ls_travel>-TravelId
                                                 AND CurrencyCode IS NOT INITIAL.

        APPEND VALUE #( price = <ls_booking>-FlightPrice curr = <ls_booking>-CurrencyCode )
        TO lt_total.


        LOOP AT lt_ba_booksuppl ASSIGNING FIELD-SYMBOL(<ls_booksuppl>)
                                         USING KEY entity
                                         WHERE travelid = <ls_booking>-travelid
                                         AND Bookingid = <ls_booking>-BookingId
                                         AND CurrencyCode IS NOT INITIAL.

          APPEND VALUE #( price = <ls_booksuppl>-Price curr = <ls_booksuppl>-CurrencyCode )
       TO lt_total.

        ENDLOOP.

      ENDLOOP.

      LOOP AT lt_total ASSIGNING FIELD-SYMBOL(<ls_total>).

        IF <ls_total>-curr = <ls_travel>-CurrencyCode.
*          <ls_travel>-TotalPrice = <ls_total>-price.
          lv_conv_price = <ls_total>-price.
        ELSE.

          /dmo/cl_flight_amdp=>convert_currency(
            EXPORTING
              iv_amount               = <ls_total>-price
              iv_currency_code_source = <ls_total>-curr
              iv_currency_code_target = <ls_travel>-CurrencyCode
              iv_exchange_rate_date   = cl_abap_context_info=>get_system_date( )
            IMPORTING
              ev_amount               = lv_conv_price
          ).
        ENDIF.
        <ls_travel>-TotalPrice = <ls_travel>-TotalPrice + lv_conv_price.
      ENDLOOP.
    ENDLOOP.

    MODIFY ENTITIES OF zi_travell_m IN LOCAL MODE
      ENTITY zi_travell_m
      UPDATE FIELDS ( TotalPrice )
      WITH CORRESPONDING #( lt_travel ).

  ENDMETHOD.

  METHOD rejectTravel.

    MODIFY ENTITIES OF zi_travell_m IN LOCAL MODE
   ENTITY zi_travell_m
   UPDATE FIELDS ( OverallStatus )
   WITH  VALUE #( FOR ls_keys IN keys ( %tky = ls_keys-%tky
                                        OverallStatus = 'X' ) ).
**    REPORTED DATA(lt_travel).

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result ( %tky = ls_result-%tky
                                                   %param = ls_result ) ).

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    FIELDS ( TravelId OverallStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).

    result = VALUE #( FOR ls_travel IN lt_travel
                      ( %tky = ls_travel-%tky
                      %features-%action-acceptTravel = COND #( WHEN ls_travel-OverallStatus = 'A'
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE if_abap_behv=>fc-o-enabled )
                       %features-%action-rejectTravel = COND #( WHEN ls_travel-OverallStatus = 'X'
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE if_abap_behv=>fc-o-enabled )
                       %features-%assoc-_booking = COND #( WHEN ls_travel-OverallStatus = 'X'
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE if_abap_behv=>fc-o-enabled )

                                                               ) ).

  ENDMETHOD.

  METHOD ValidateCustomer.

    READ ENTITY IN LOCAL MODE zi_travell_m
          FIELDS ( CustomerId )
          WITH CORRESPONDING #( keys )
          RESULT DATA(lt_travel).

    DATA : lt_cust TYPE SORTED TABLE OF /dmo/customer WITH UNIQUE KEY customer_id.

    lt_cust = CORRESPONDING #( lt_travel DISCARDING DUPLICATES MAPPING customer_id = CustomerId ).
    DELETE lt_cust WHERE customer_id IS INITIAL.

    SELECT FROM /dmo/customer
    FIELDS customer_id
    FOR ALL ENTRIES IN @lt_cust
    WHERE customer_id EQ @lt_cust-customer_id
    INTO TABLE @DATA(lt_cust_db).

    IF sy-subrc EQ 0.

    ENDIF.

    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

      IF <fs_travel>-CustomerId IS INITIAL
      OR NOT line_exists( lt_cust_db[ customer_id = <fs_travel>-CustomerId ] ).

        APPEND VALUE #( %tky = <fs_travel>-%tky )
        TO failed-zi_travell_m .

        APPEND VALUE #( %tky = <fs_travel>-%tky
                        %msg = NEW /dmo/cm_flight_messages(
          textid                = /dmo/cm_flight_messages=>customer_unkown
          customer_id           = <fs_travel>-CustomerId
          severity              = if_abap_behv_message=>severity-error
        )
        %element-customerid = if_abap_behv=>mk-on
        )
        TO reported-zi_travell_m .

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateBookingFee.
  ENDMETHOD.

  METHOD validateCurrencyCode.
  ENDMETHOD.

  METHOD validateDates.
    READ ENTITY IN LOCAL MODE zi_travell_m
           FIELDS ( BeginDate EndDate )
           WITH CORRESPONDING #( keys )
           RESULT DATA(lt_travel).

    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

      IF <fs_travel>-EndDate < <fs_travel>-BeginDate. " end date before begin date

        APPEND VALUE #( %tky = <fs_travel>-%tky )
        TO failed-zi_travell_m .

        APPEND VALUE #( %tky = <fs_travel>-%tky
                        %msg = NEW /dmo/cm_flight_messages(
          textid                = /dmo/cm_flight_messages=>begin_date_bef_end_date
          travel_id           = <fs_travel>-TravelId
          begin_date        = <fs_travel>-BeginDate
          end_date         = <fs_travel>-EndDate
          severity              = if_abap_behv_message=>severity-error
        )
        %element-BeginDate = if_abap_behv=>mk-on
        %element-EndDate = if_abap_behv=>mk-on
        )
        TO reported-zi_travell_m .

      ELSEIF <fs_travel>-BeginDate < cl_abap_context_info=>get_system_date( ). "  begin date must be in the Future

        APPEND VALUE #( %tky = <fs_travel>-%tky )
        TO failed-zi_travell_m .

        APPEND VALUE #( %tky = <fs_travel>-%tky
                      %msg = NEW /dmo/cm_flight_messages(
        textid                = /dmo/cm_flight_messages=>begin_date_on_or_bef_sysdate
        severity              = if_abap_behv_message=>severity-error
      )
      %element-BeginDate = if_abap_behv=>mk-on
      %element-EndDate = if_abap_behv=>mk-on
      )
      TO reported-zi_travell_m .

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateStatus.

    READ ENTITY IN LOCAL MODE zi_travell_m
           FIELDS ( OverallStatus )
           WITH CORRESPONDING #( keys )
           RESULT DATA(lt_travel).

    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

      CASE <fs_travel>-OverallStatus.

        WHEN 'O'.   "OPEN
        WHEN 'X'. "cancelled
        WHEN 'A'.  "accepted
        WHEN OTHERS.
          APPEND VALUE #( %tky = <fs_travel>-%tky )
          TO failed-zi_travell_m .
          APPEND VALUE #( %tky = <fs_travel>-%tky
                          %msg = NEW /dmo/cm_flight_messages(
            textid                = /dmo/cm_flight_messages=>status_invalid
            Status =  <fs_travel>-OverallStatus
            severity              = if_abap_behv_message=>severity-error
          )
          %element-OverallStatus = if_abap_behv=>mk-on
          )
          TO reported-zi_travell_m .
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculatetotalprice.

    MODIFY ENTITIES OF zi_travell_m IN LOCAL MODE
    ENTITY zi_travell_m
    EXECUTE recalcToPrice
    FROM CORRESPONDING #( keys ).

  ENDMETHOD.

ENDCLASS.
