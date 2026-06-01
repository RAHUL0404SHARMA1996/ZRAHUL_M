@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Connection Id'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'

}
@Search.searchable: true
define root view entity ZI_CONNECTION_ID
  as select from /dmo/connection
  association [1..*] to ZI_FLIGHT_CONN_R   as _flight  on  $projection.CarrierId    = _flight.CarrierId
                                                       and $projection.ConnectionId = _flight.ConnectionId
  association [1..1] to ZI_CARRIER_TECHH_R as _carrier on  $projection.CarrierId = _carrier.CarrierId
{

      @UI.facet: [{ id: 'Connection',
                    purpose: #STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10,
                    label: 'Connection Detail' },
                    {
                    id: 'Flight',
                    purpose: #STANDARD,
                    type: #LINEITEM_REFERENCE,
                    position: 20,
                    label: 'Flight Detail',
                    targetElement: '_flight'
                    }
                    ]
      @UI.lineItem: [{ position: 10 , label: 'Airline'}]
      @UI.identification: [{ position: 10, label: 'Airline' }]
      @ObjectModel.text.association: '_carrier'
      @Search.defaultSearchElement: true
  key carrier_id                         as CarrierId,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id                      as ConnectionId,
      @UI.lineItem: [{ position: 30, label: 'Departure Airport ID' }]
      @UI.identification: [{ position: 30, label: 'Departure Airport ID' }]
      @UI.selectionField: [{ position: 10}]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
       name: 'ZI_AIRPORTT_VH',
       element: 'AirportId'
      } }]
      airport_from_id                    as AirportFromId,
      @UI.identification: [{ position: 40 }]
      @UI.lineItem: [{ position: 40 }]
      @UI.selectionField: [{ position: 20 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
          name: 'ZI_AIRPORTT_VH',
          element: 'AirportId'
      } }]
      @EndUserText.label: 'Destination Airport ID'
      airport_to_id                      as AirportToId,
      @UI.identification: [{ position: 50, label: 'Departure Time' }]
      @UI.lineItem: [{ position: 50, label: 'Departure Time' }]
      departure_time                     as DepartureTime,
      @UI.identification: [{ position: 60,  label: 'Arrival Time' }]
      @UI.lineItem: [{ position: 60 , label: 'Arrival Time'}]
      arrival_time                       as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.identification: [{ position: 70 }]
      //      distance        as Distance,
      cast( distance as abap.dec(15,2) ) as Distance,
      distance_unit                      as DistanceUnit,
      //association
      @Search.defaultSearchElement: true
      _flight,
      @Search.defaultSearchElement: true
      _carrier

}
