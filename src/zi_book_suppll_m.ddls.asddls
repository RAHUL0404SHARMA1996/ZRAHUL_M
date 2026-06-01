@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_BOOK_SUPPLL_M
  as select from zbook_suppll_m
  association        to parent ZI_BOOKINGG_M  as _booking  on  $projection.TravelId  = _booking.TravelId
                                                           and $projection.BookingId = _booking.BookingId
  association [1..1] to /DMO/I_Supplement     as _Supp     on  $projection.SupplementId = _Supp.SupplementID
  association [1..*] to /DMO/I_SupplementText as _supptext on  $projection.SupplementId = _supptext.SupplementID
  association [1..1] to ZI_TRAVELL_M          as _travel   on  $projection.TravelId = _travel.TravelId
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      //The Persistent field last_changed_at plays a Special Role as a field Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      local_created_by      as LocalCreatedBy,
      local_created_at      as LocalCreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      //Association
      _Supp,
      _supptext,
      _booking,
      _travel

}
