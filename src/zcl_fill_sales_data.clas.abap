CLASS zcl_fill_sales_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_sales_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  " 1. Clear out any old data from BOTH tables
    DELETE FROM zsaleshdr110.
    DELETE FROM zsalesitm110.

    " 2. Internal tables for mock data
    DATA lt_mock_headers TYPE TABLE OF zsaleshdr110.
    DATA lt_mock_items   TYPE TABLE OF zsalesitm110.

    " 3. Get modern Cloud system variables (Replacing SY-DATUM and SY-UNAME)
    GET TIME STAMP FIELD DATA(lv_timestamp).
    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).

    TRY.
        " ==============================================================================
        " ORDER #1: One Header, One Item
        " ==============================================================================
        " Generate the shared UUID for Order 1
        DATA(lv_order1_uuid) = cl_system_uuid=>create_uuid_x16_static( ).

        " Append Header 1
        APPEND VALUE #(
          client              = '100'
          salesorderuuid      = lv_order1_uuid
          salesorder          = '1000000001'
          salesordertype      = 'OR'
          description         = 'First Cloud Sales Order'
          salesorganization   = '1000'
          soldtoparty         = 'CUST-001'
          distributionchannel = '10'
          documentreason      = '000'
          totalnetamount      = '150.50'
          transactioncurrency = 'USD'
          creationbyuser      = lv_user
          creationat          = lv_timestamp
          lastchangedbyuser   = lv_user
          lastchanged         = lv_timestamp
        ) TO lt_mock_headers.

        " Append Item 1 (Linked to Header 1)
        APPEND VALUE #(
          client                 = '100'
          salesitemuuid          = cl_system_uuid=>create_uuid_x16_static( )
          salesorderuuid         = lv_order1_uuid   " <-- The crucial link back to the header!
          salesorderitem         = '000010'
          material               = 'M-01'
          plant                  = '0001'
          orderquantity          = 10
          orderquantityunit      = 'ST'
          netamount              = '150.50'
          transactioncurrency    = 'USD'
          createdbyuser          = lv_user
          creationat             = lv_timestamp
          lastchangedbyuser      = lv_user
          lastchangedat          = lv_timestamp
          locallastchangedat     = lv_timestamp
        ) TO lt_mock_items.


        " ==============================================================================
        " ORDER #2: One Header, Two Items
        " ==============================================================================
        " Generate the shared UUID for Order 2
        DATA(lv_order2_uuid) = cl_system_uuid=>create_uuid_x16_static( ).

        " Append Header 2
        APPEND VALUE #(
          client              = '100'
          salesorderuuid      = lv_order2_uuid
          salesorder          = '1000000002'
          salesordertype      = 'OR'
          description         = 'Second Cloud Sales Order'
          salesorganization   = '1000'
          soldtoparty         = 'CUST-002'
          distributionchannel = '10'
          documentreason      = '000'
          totalnetamount      = '900.00'
          transactioncurrency = 'USD'
          creationbyuser      = lv_user
          creationat          = lv_timestamp
          lastchangedbyuser   = lv_user
          lastchanged         = lv_timestamp
        ) TO lt_mock_headers.

        " Append Item 1 (Linked to Header 2)
        APPEND VALUE #(
          client                 = '100'
          salesitemuuid          = cl_system_uuid=>create_uuid_x16_static( )
          salesorderuuid         = lv_order2_uuid
          salesorderitem         = '000010'
          material               = 'M-02'
          plant                  = '0002'
          orderquantity          = 2
          orderquantityunit      = 'ST'
          netamount              = '400.00'
          transactioncurrency    = 'USD'
          createdbyuser          = lv_user
          creationat             = lv_timestamp
          lastchangedbyuser      = lv_user
          lastchangedat          = lv_timestamp
          locallastchangedat     = lv_timestamp
        ) TO lt_mock_items.

        " Append Item 2 (Linked to Header 2)
        APPEND VALUE #(
          client                 = '100'
          salesitemuuid          = cl_system_uuid=>create_uuid_x16_static( )
          salesorderuuid         = lv_order2_uuid
          salesorderitem         = '000020'
          material               = 'M-03'
          plant                  = '0003'
          orderquantity          = 1
          orderquantityunit      = 'ST'
          netamount              = '500.00'
          transactioncurrency    = 'USD'
          createdbyuser          = lv_user
          creationat             = lv_timestamp
          lastchangedbyuser      = lv_user
          lastchangedat          = lv_timestamp
          locallastchangedat     = lv_timestamp
        ) TO lt_mock_items.

      CATCH cx_uuid_error INTO DATA(lx_uuid).
        out->write( |UUID Error: { lx_uuid->get_text( ) }| ).
        RETURN.
    ENDTRY.

    " 4. Insert everything into the database at once
    INSERT zsaleshdr110 FROM TABLE @lt_mock_headers.
    INSERT zsalesitm110 FROM TABLE @lt_mock_items.

    " 5. Output a success message
    IF sy-subrc = 0.
      out->write( 'Success! Headers and Items inserted into DB.' ).
    ELSE.
      out->write( 'Failed to insert data.' ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
