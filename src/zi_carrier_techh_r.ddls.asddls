@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View FOR Carrier Information'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity ZI_CARRIER_TECHH_R as select from /dmo/carrier
{
    key carrier_id as CarrierId,
    @Semantics.text: true
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    name as Name,
    currency_code as CurrencyCode

}
