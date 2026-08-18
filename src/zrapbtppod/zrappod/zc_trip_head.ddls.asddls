@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Trip Head'
@Metadata.allowExtensions: true
define root view entity ZC_TRIP_HEAD as projection on ZI_TRIP_HEAD
{
    key TripUuid,
    @Consumption.filter.selectionType: #INTERVAL
    @EndUserText.label: 'Triper ID'
    TripId,
    @EndUserText.label: 'Driver ID'
    DriverId,
    @EndUserText.label: 'Vehicle ID'
    VehicleId,
    @EndUserText.label: 'Trip Date'
    TripDate,
    @EndUserText.label: 'Route Status'
    RouteStatus,
    @EndUserText.label: 'Cash Collected'
    TotalCashCollected,
    CurrencyCode,
    CreatedBy,
    @Consumption.filter.selectionType: #INTERVAL
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _TripITM: redirected to composition child ZC_TRIP_ITEM 
}
