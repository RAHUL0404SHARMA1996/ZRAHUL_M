CLASS lhc_zi_book_suppll_m DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateCurrencyCode FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_BOOK_SUPPLL_M~validateCurrencyCode.

    METHODS validatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_BOOK_SUPPLL_M~validatePrice.

    METHODS validatesupplement FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_BOOK_SUPPLL_M~validatesupplement.
    METHODS calculatetotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_BOOK_SUPPLL_M~calculatetotalprice.

ENDCLASS.

CLASS lhc_zi_book_suppll_m IMPLEMENTATION.

  METHOD validateCurrencyCode.
  ENDMETHOD.

  METHOD validatePrice.
  ENDMETHOD.

  METHOD validatesupplement.
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
