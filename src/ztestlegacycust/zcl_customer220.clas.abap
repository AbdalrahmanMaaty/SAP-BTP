CLASS zcl_customer220 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA mt_customers TYPE STANDARD TABLE OF zcustomer220.

    DATA mt_custaddr TYPE STANDARD TABLE OF zcustaddr220.

    CLASS-DATA mo_instance TYPE REF TO zcl_customer220.



    METHODS cust_create
      IMPORTING
                i_customer          TYPE zcustomer220
      RETURNING VALUE(r_customerno) TYPE kunnr.

    METHODS save.

    CLASS-METHODS Get_instance
      RETURNING VALUE(r_instance) TYPE REF TO zcl_customer220.

    METHODS custaddr_create
      IMPORTING
                i_customerno       TYPE kunnr
                i_custaddr         TYPE zcustaddr220
      RETURNING VALUE(r_addressid) TYPE ad_addrnum.

    Methods cust_delete
        IMPORTING
                i_customerno TYPE kunnr
        RETURNING
                VALUE(r_success) TYPE abap_bool.

    METHODS custaddr_delete
        IMPORTING
                i_cutaddrid TYPE ad_addrnum
        RETURNING
                VALUE(r_success) TYPE abap_bool.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_customer220 IMPLEMENTATION.
  METHOD cust_create.

    DATA ls_customer TYPE zcustomer220.

    MOVE-CORRESPONDING i_customer TO ls_customer.

    ls_customer-createdbyuser = sy-uname.
    GET TIME STAMP FIELD ls_customer-creationat.
    ls_customer-lastchangedbyuser = sy-uname.
    GET TIME STAMP FIELD ls_customer-lastchangedat.
    GET TIME STAMP FIELD ls_customer-locallastchangedat.

    SELECT SINGLE MAX( customerno )
    FROM zcustomer220
    INTO @DATA(max_custno).

    IF sy-subrc = 0 AND max_custno IS NOT INITIAL.

      data(lv_next_num) = CONV i( max_custno ) + 1.

    ls_customer-customerno = |{ lv_next_num ALIGN = RIGHT WIDTH = 10 PAD = '0' }|.

    ELSE.
      ls_customer-customerno = '0000000001'.

    ENDIF.

    APPEND ls_customer TO mt_customers.

    r_customerno = ls_customer-customerno.


  ENDMETHOD.

  METHOD save.

    IF mt_customers IS NOT INITIAL.
      INSERT zcustomer220 FROM TABLE @mt_customers.
    ENDIF.

    if mt_custaddr is not INITIAL.
      INSERT zcustaddr220 FROM TABLE @mt_custaddr.
    ENDIF.

  ENDMETHOD.

  METHOD get_instance.

    IF mo_instance IS INITIAL.
      CREATE OBJECT mo_instance.
    ENDIF.

    r_instance = mo_instance.

  ENDMETHOD.

  METHOD custaddr_create.

    DATA ls_custaddr TYPE zcustaddr220.

    MOVE-CORRESPONDING i_custaddr TO ls_custaddr.

    SELECT SINGLE MAX( addressid )
    FROM zcustaddr220
    WHERE customerno = @i_customerno
    INTO @DATA(max_id).

    IF sy-subrc = 0 AND max_id IS NOT INITIAL.

      data(lv_next_num) = CONV i( max_id ) + 1.

      ls_custaddr-addressid = |{ lv_next_num ALIGN = RIGHT WIDTH = 10 PAD = '0' }|.

    ELSE.
      ls_custaddr-addressid = '0000000001'.

    ENDIF.

    ls_custaddr-createdbyuser = sy-uname.
    GET TIME STAMP FIELD ls_custaddr-creationat.
    GET TIME STAMP FIELD ls_custaddr-locallastchangedat.
    ls_custaddr-lastchangedbyuser = sy-uname.

    APPEND ls_custaddr TO mt_custaddr.



  ENDMETHOD.

  METHOD cust_delete.

    r_success = abap_false.

    DELETE FROM zcustaddr220 where customerno = @i_customerno.

    DELETE FROM zcustomer220 where customerno = @i_customerno.

    if sy-subrc = 0.
        r_success = abap_true.
    else.
        r_success = abap_false.
    endif.

  ENDMETHOD.

  METHOD custaddr_delete.

    r_success = abap_false.

    DELETE FROM zcustaddr220 where addressid = @i_cutaddrid.

    if sy-subrc = 0.
        r_success = abap_true.
    else.
        r_success = abap_false.
    endif.

  ENDMETHOD.

ENDCLASS.
