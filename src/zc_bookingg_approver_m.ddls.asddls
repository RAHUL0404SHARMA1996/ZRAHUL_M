@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Booking'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
    typeName: 'BookingDetail',
    typeNamePlural: 'BookingDetails',
    title: {
        type: #STANDARD,
        label: 'Booking',
        value: 'BookingId'
    },
    description: {
        type: #STANDARD,
        label: 'Booking Description',
        value: 'BookingDate'
}
    }
@Search.searchable: true
define view entity ZC_BOOKINGG_APPROVER_M
  as projection on ZI_BOOKINGG_M
{
      @UI.facet: [{
           id: 'Booking',
           purpose: #STANDARD,
           position:10,
           label: 'Booking Information',
           type: #IDENTIFICATION_REFERENCE

       } ]
      @Search.defaultSearchElement: true
  key TravelId,
      @Search.defaultSearchElement: true
      @UI : { lineItem: [{ position: 20 , importance: #HIGH }],
      identification: [{  position: 20 }]}

  key BookingId,
      @UI : { lineItem: [{ position: 30, importance: #HIGH }],
      identification: [{  position: 30 }] }
      BookingDate,
      @UI : { lineItem: [{ position: 40, importance: #HIGH }],
      identification: [{  position: 40 }],
      selectionField: [{ position: 10  }] }
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _customer.LastName  as CustomerName,
      @UI : { lineItem: [{ position: 50, importance: #HIGH }],
      identification: [{  position: 50 }]}
      @ObjectModel.text.element: [ 'CarrierName' ]
      CarrierId,
      _carrier.Name       as CarrierName,
      @UI : { lineItem: [{ position: 60, importance: #HIGH }],
      identification: [{  position: 60 }] }
      ConnectionId,
      @UI : { lineItem: [{ position: 70 , importance: #HIGH }],
      identification: [{  position: 70 }] }
      FlightDate,
      @UI : { lineItem: [{ position: 80 , importance: #HIGH }],
      identification: [{  position: 80 }] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @UI : { lineItem: [{ position: 90 , importance: #HIGH }],
      identification: [{  position: 90 }],
      textArrangement: #TEXT_ONLY }
      @Consumption.valueHelpDefinition: [{
       entity: {
           name: '/DMO/I_Booking_Status_VH',
           element: 'BookingStatus'
       } } ]
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      BookingStatus,
      @UI.hidden: true
      _booking._Text.Text as BookingStatusText : localized,
      @UI.hidden: true
      LastChangedAt,
      /* Associations */
      _booking,
      _booksupp,
      _carrier,
      _connection,
      _customer,
      _Travel : redirected to parent ZC_TRAVELL_APPROVER_M
}
