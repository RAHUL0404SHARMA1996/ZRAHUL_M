@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Approval Projection Travel'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travels',
    title: {
        type: #STANDARD,
        label: 'Travel',
        value: 'TravelId'
    }
}
define root view entity ZC_TRAVELL_APPROVER_M
  provider contract transactional_query
  as projection on ZI_TRAVELL_M
{
      @UI.facet: [{
          id: 'Travel',
          purpose: #STANDARD,
          position: 10,
          label: 'Travel',
          type: #IDENTIFICATION_REFERENCE
      },
       {
          id: 'Booking',
          purpose: #STANDARD,
          position: 20,
          label: 'Booking Infomation',
          type: #LINEITEM_REFERENCE,
          targetElement: '_booking'
      }
       ]

      @UI : { lineItem: [{ position: 10 , importance: #HIGH  }],
      identification: [{ position: 10 }]
      }
      @Search.defaultSearchElement: true
  key TravelId,
      @UI : { lineItem: [{ position: 20 , importance: #HIGH }],
      selectionField: [{ position: 10 }],
      identification: [{  position: 20 }]
        }
      @Consumption.valueHelpDefinition: [{
      entity: {
        name: '/DMO/I_Agency',
        element: 'AgencyID'
      } } ]
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'AgencyName' ]
      AgencyId,
      _agency.Name       as AgencyName,
      @UI : { lineItem: [{ position: 30, importance: #HIGH }],
      selectionField: [{ position: 20 }],
       identification: [{  position: 30 }]
      }
      @Consumption.valueHelpDefinition: [{
          entity: {
      name: '/DMO/I_Customer',
      element: 'CustomerID'
          } } ]

      @ObjectModel.text.element: [ 'CustomerName' ]
      @Search.defaultSearchElement: true
      CustomerId,
      _customer.LastName as CustomerName,
      @UI : {
      identification: [{  position: 40 }]
       }
      BeginDate,
      @UI : {
      identification: [{  position: 41 }]
      }
      EndDate,
      @UI : { lineItem: [{ position: 42 , importance: #MEDIUM }],
      identification: [{  position: 42 }]
      }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @UI : { lineItem: [{ position: 43 , importance: #MEDIUM }],
      identification: [{  position: 43, label : 'Total price' }]
      }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      @Consumption.valueHelpDefinition: [{
      entity: {
          name: 'I_Currency',
          element: 'Currency'
      } } ]
      CurrencyCode,
      @UI : { lineItem: [{ position: 44 , importance: #MEDIUM }],
      identification: [{  position: 44 }]
      }
      Description,
      @UI: { lineItem: [{ position: 15 , importance: #HIGH },
              { type : #FOR_ACTION, dataAction: 'acceptTravel', label: 'AcceptTravel'},
              { type : #FOR_ACTION, dataAction: 'rejectTravel', label: 'RejectTravel'} ],
      selectionField: [{ position: 40 }],
      identification: [{  position: 15 },
                  { type : #FOR_ACTION, dataAction: 'acceptTravel', label: 'AcceptTravel'},
              { type : #FOR_ACTION, dataAction: 'rejectTravel', label: 'RejectTravel'}],
      textArrangement: #TEXT_ONLY
      }
      @Consumption.valueHelpDefinition: [{
        entity: {
            name: '/DMO/I_Overall_Status_VH',
            element: 'OverallStatus'
        } } ]
      @EndUserText.label: 'Overall Status'
      @ObjectModel.text.element: [ 'OverallStatusText' ]

      OverallStatus,
      @UI.hidden: true
      _Status._Text.Text as OverallStatusText : localized,
      @UI.hidden: true
      Createdby,
      @UI.hidden: true
      Createdat,
      @UI.hidden: true
      Lastchangedby,
      @UI.hidden: true
      Lastchangedat,
      /* Associations */
      _agency,
      _booking : redirected to composition child ZC_BOOKINGG_APPROVER_M,
      _currency,
      _customer,
      _Status
}
