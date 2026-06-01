@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View  travel managed Scenarios'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TRAVELL_M
  as select from ztravell_m
  composition [0..*] of ZI_BOOKINGG_M            as _booking
  association [0..1] to /DMO/I_Agency            as _agency   on $projection.AgencyId = _agency.AgencyID
  association [0..1] to /DMO/I_Customer          as _customer on $projection.CustomerId = _customer.CustomerID
  association [1..1] to I_Currency               as _currency on $projection.CurrencyCode = _currency.Currency
  association [1..1] to /DMO/I_Overall_Status_VH as _Status   on $projection.OverallStatus = _Status.OverallStatus
{
  key travel_id      as TravelId,
      agency_id      as AgencyId,
      customer_id    as CustomerId,
      begin_date     as BeginDate,
      end_date       as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee    as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price    as TotalPrice,
      currency_code  as CurrencyCode,
      description    as Description,
      overall_status as OverallStatus,
      @Semantics.user.createdBy: true
      createdby      as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat      as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby  as Lastchangedby,
      //The Persistent field last_changed_at plays a Special Role as a field Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedat  as Lastchangedat,
      //association
      _agency,
      _customer,
      _currency,
      _Status,
      _booking
}
