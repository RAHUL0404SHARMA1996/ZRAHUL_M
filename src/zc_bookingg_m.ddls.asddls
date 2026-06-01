@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BOOKINGG_M
  as projection on ZI_BOOKINGG_M
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'CustomerText' ]
      CustomerId,
      _customer.LastName  as CustomerText,
      @ObjectModel.text.element: [ 'CarrierText' ]
      CarrierId,
      _carrier.Name       as CarrierText,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'BookingText' ]
      BookingStatus,
      _booking._Text.Text as BookingText : localized,
      LastChangedAt,
      /* Associations */
      _booking,
      _booksupp : redirected to composition child ZC_BOOK_SUPPL_M,
      _carrier,
      _connection,
      _customer,
      _Travel   : redirected to parent ZC_TRAVELL_M
}
