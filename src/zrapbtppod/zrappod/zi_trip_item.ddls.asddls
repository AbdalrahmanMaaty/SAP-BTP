@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Trip item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TRIP_ITEM as select from ztrip_item as TripItm
association to parent ZI_TRIP_HEAD as _TripHDR
    on $projection.TripUuid = _TripHDR.TripUuid
{
    key item_uuid as ItemUuid,
    trip_uuid as TripUuid,
    delivery_id as DeliveryId,
    customer_name as CustomerName,
    material_id as MaterialId,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    expected_qty as ExpectedQty,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    delivered_qty as DeliveredQty,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    returned_qty as ReturnedQty,
    return_reason as ReturnReason,
    uom as Uom,
    item_status as ItemStatus,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt,
    _TripHDR // Make association public
}
