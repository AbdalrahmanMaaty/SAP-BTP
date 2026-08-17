@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Trip Item'
@Metadata.allowExtensions: true
define view entity ZC_TRIP_ITEM as projection on ZI_TRIP_ITEM
{
    key ItemUuid,
    TripUuid,
    DeliveryId,
    CustomerName,
    MaterialId,
    ExpectedQty,
    DeliveredQty,
    ReturnedQty,
    ReturnReason,
    Uom,
    ItemStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _TripHDR: redirected to parent ZC_TRIP_HEAD
}
