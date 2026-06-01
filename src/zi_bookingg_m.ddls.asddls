@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Interface View Managed'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_BOOKINGG_M
  as select from zbookingg_m
  association        to parent ZI_TRAVELL_M      as _Travel     on $projection.TravelId = _Travel.TravelId
  composition [0..*] of ZI_BOOK_SUPPLL_M          as _booksupp
  association [1..1] to /DMO/I_Carrier           as _carrier    on $projection.CarrierId = _carrier.AirlineID
  association [1..1] to /DMO/I_Customer          as _customer   on $projection.CustomerId = _customer.CustomerID
  association [1..*] to /DMO/I_Connection        as _connection on $projection.ConnectionId = _connection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _booking    on $projection.BookingStatus = _booking.BookingStatus
{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      //The Persistent field last_changed_at plays a Special Role as a field Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,
      //Associationn
      _carrier,
      _customer,
      _connection,
      _booking,
      _Travel,
      _booksupp
}
