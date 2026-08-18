@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Trip head'
define root view entity ZI_TRIP_HEAD as select from ztrip_head as TripHDR
composition [1..*] of ZI_TRIP_ITEM as _TripITM
{
    key trip_uuid as TripUuid,
    trip_id as TripId,
    driver_id as DriverId,
    vehicle_id as VehicleId,
    trip_date as TripDate,
    route_status as RouteStatus,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    total_cash_collected as TotalCashCollected,
    currency_code as CurrencyCode,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    _TripITM // Make association public
}
