CLASS zcl_fill_customer_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_customer_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lt_customers TYPE TABLE OF zcustomer220.
    DATA lt_addresses TYPE TABLE OF zcustaddr220.

    " 2. Declare Work Areas (Structures) to build individual rows
    DATA ls_customer  TYPE zcustomer220.
    DATA ls_address   TYPE zcustaddr220.

    " 3. Variables for Cloud-compliant timestamps and user info
    DATA lv_timestamp TYPE timestamp.
    GET TIME STAMP FIELD lv_timestamp.

    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).

    " =========================================================================
    " DATA GENERATION LOGIC
    " =========================================================================

    " Loop 5 times to create 5 Header Records
    DO 5 TIMES.
      CLEAR ls_customer.

      " Format the customer number with leading zeros (e.g., 0000000001)
      ls_customer-customerno         = |{ sy-index WIDTH = 10 ALIGN = RIGHT PAD = '0' }|.
      ls_customer-firstname          = |TestUser{ sy-index }|.
      ls_customer-lastname           = |AssetBuyer|.
      ls_customer-phone              = |+2010000000{ sy-index }|.
      ls_customer-createdbyuser      = lv_user.
      ls_customer-creationat         = lv_timestamp.
      ls_customer-lastchangedbyuser  = lv_user.
      ls_customer-lastchangedat      = lv_timestamp.
      ls_customer-locallastchangedat = lv_timestamp.

      APPEND ls_customer TO lt_customers.

      " Inner Loop: For EACH customer, loop 2 times to create 2 Address Records
      DO 2 TIMES.
        CLEAR ls_address.

        " Link the item table to the header table using the foreign key
        ls_address-customerno = ls_customer-customerno.
        ls_address-addressid  = |{ sy-index WIDTH = 10 ALIGN = RIGHT PAD = '0' }|.

        " Create distinct addresses for the first and second iteration
        IF sy-index = 1.
          ls_address-city       = 'Cairo'.
          ls_address-district   = 'Maadi'.
          ls_address-street     = 'Street 9'.
          ls_address-postalcode = '11431'.
        ELSE.
          ls_address-city       = 'El Sheikh Zayed'.
          ls_address-district   = 'Beverly Hills'.
          ls_address-street     = 'Al Nuzha St'.
          ls_address-postalcode = '12588'.
        ENDIF.

        ls_address-country            = 'EG'.
        ls_address-createdbyuser      = lv_user.
        ls_address-creationat         = lv_timestamp.
        ls_address-lastchangedbyuser  = lv_user.
        ls_address-locallastchangedat = lv_timestamp.

        APPEND ls_address TO lt_addresses.
      ENDDO. " End of Address Loop

    ENDDO. " End of Customer Loop


    " =========================================================================
    " DATABASE OPERATIONS
    " =========================================================================

    " 1. Clear existing data to prevent duplicate primary key dumps if run multiple times
    DELETE FROM zcustomer220.
    DELETE FROM zcustaddr220.

    " 2. Perform Array Inserts (Writing the internal tables to the database)
    INSERT zcustomer220 FROM TABLE @lt_customers.
    INSERT zcustaddr220 FROM TABLE @lt_addresses.

    " 3. Output the result to the Eclipse Console
    IF sy-subrc = 0.
      out->write( 'Success: 5 Customers and 10 Addresses inserted into the database.' ).
    ELSE.
      out->write( 'Error: Database insertion failed.' ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
