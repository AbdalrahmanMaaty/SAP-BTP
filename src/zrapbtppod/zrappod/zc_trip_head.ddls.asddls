@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Trip Head'
define root view entity ZC_TRIP_HEAD as projection on ZI_TRIP_HEAD
{
    key TripUuid,
    TripId,
    DriverId,
    VehicleId,
    TripDate,
    RouteStatus,
    TotalCashCollected,
    CurrencyCode,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _TripITM: redirected to composition child ZC_TRIP_ITEM 
}
