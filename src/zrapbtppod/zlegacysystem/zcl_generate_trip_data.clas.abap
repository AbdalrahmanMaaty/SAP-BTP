CLASS zcl_generate_trip_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_generate_trip_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lt_head TYPE TABLE OF ztrip_head,
          lt_item TYPE TABLE OF ztrip_item.

    " Clear existing data for a fresh start
    DELETE FROM ztrip_head.
    DELETE FROM ztrip_item.

    " Generate UUIDs for the Headers
    DATA(lv_trip1_uuid) = cl_system_uuid=>create_uuid_x16_static( ).
    DATA(lv_trip2_uuid) = cl_system_uuid=>create_uuid_x16_static( ).

    " Create Trip 1 (Downtown Route)
    APPEND VALUE #(
      trip_uuid     = lv_trip1_uuid
      trip_id       = 'TRP-2026-001'
      driver_id     = 'D-8042'
      vehicle_id    = 'TRK-99'
      trip_date     = cl_abap_context_info=>get_system_date( )
      route_status  = 'Pending'
      currency_code = 'EGP'
    ) TO lt_head.

    " Create Trip 1 Items
    APPEND VALUE #(
      item_uuid     = cl_system_uuid=>create_uuid_x16_static( )
      trip_uuid     = lv_trip1_uuid
      delivery_id   = '80001020'
      customer_name = 'Hypermarket Downtown'
      material_id   = 'MAT-A100'
      expected_qty  = 50
      uom           = 'PC'
      item_status   = 'Pending'
    ) TO lt_item.

    APPEND VALUE #(
      item_uuid     = cl_system_uuid=>create_uuid_x16_static( )
      trip_uuid     = lv_trip1_uuid
      delivery_id   = '80001021'
      customer_name = 'City Grocers'
      material_id   = 'MAT-B200'
      expected_qty  = 120
      uom           = 'PC'
      item_status   = 'Pending'
    ) TO lt_item.

    " Insert into DB
    INSERT ztrip_head FROM TABLE @lt_head.
    INSERT ztrip_item FROM TABLE @lt_item.

    out->write( 'Successfully simulated ERP morning trip sync to BTP tables!' ).
  ENDMETHOD.
ENDCLASS.
