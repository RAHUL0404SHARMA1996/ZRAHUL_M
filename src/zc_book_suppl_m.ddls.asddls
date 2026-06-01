@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BOOK_SUPPL_M
  as projection on ZI_BOOK_SUPPLL_M
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      @ObjectModel.text.element: [ 'SupplementText' ]
      SupplementId,
      _supptext.Description as SupplementText : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LastChangedAt,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      /* Associationss */
      _booking : redirected to parent ZC_BOOKINGG_M,
      _Supp,
      _supptext,
      _travel  : redirected to ZC_TRAVELL_M
}
