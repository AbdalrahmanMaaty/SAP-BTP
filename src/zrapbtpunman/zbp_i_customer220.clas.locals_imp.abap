CLASS lhc_ZI_Customer220 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Customer.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Customer.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Customer.

    METHODS read FOR READ
      IMPORTING keys FOR READ Customer RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Customer.

    METHODS rba_Custaddr FOR READ
      IMPORTING keys_rba FOR READ Customer\_Custaddr FULL result_requested RESULT result LINK association_links.

    METHODS cba_Custaddr FOR MODIFY
      IMPORTING entities_cba FOR CREATE Customer\_Custaddr.

ENDCLASS.

CLASS lhc_ZI_Customer220 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA ls_cust TYPE Zcustomer220.

    LOOP at entities ASSIGNING FIELD-SYMBOL(<entity>).

        MOVE-CORRESPONDING <entity> TO ls_cust.

        DATA(customerno) = zcl_customer220=>get_instance(  )->cust_create( EXPORTING i_customer = ls_cust ).

        APPEND VALUE #( %cid = <entity>-%cid customerno = customerno  ) to mapped-customer.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.

    LOOP AT KEYS ASSIGNING FIELD-SYMBOL(<key>).

        DATA(check_delete) = zcl_customer220=>get_instance(  )->cust_delete( i_customerno = <key>-Customerno ).

        if check_delete = abap_false.

            APPEND value #( %tky =  <key>-%tky ) to failed-customer.

            APPEND VALUE #( %tky = <key>-%tky

                            %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = |Failed to delete Customer { <key>-customerno }.| ) ) to reported-customer.

        ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Custaddr.
  ENDMETHOD.

  METHOD cba_Custaddr.

        Data ls_custAddr Type Zcustaddr220.

        LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<entity>).

            Data(customerno) = <entity>-Customerno.

            LOOP AT <entity>-%target ASSIGNING FIELD-SYMBOL(<target>).


              MOVE-CORRESPONDING <target> to ls_custAddr.

              DATA(lv_addressid) = zcl_customer220=>get_instance(  )->mo_instance->custaddr_create( i_custaddr = ls_custAddr
              i_customerno = customerno ).

              INSERT value #(

                %cid = <target>-%cid
                customerno = customerno
                addressid = lv_addressid

               ) INTO table mapped-custaddr.

            ENDLOOP.

        ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_CustAddr220 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE CustAddr.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE CustAddr.

    METHODS read FOR READ
      IMPORTING keys FOR READ CustAddr RESULT result.

    METHODS rba_Customer FOR READ
      IMPORTING keys_rba FOR READ CustAddr\_Customer FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_CustAddr220 IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.

    LOOP AT KEYS ASSIGNING FIELD-SYMBOL(<key>).

        DATA(check_delete) = zcl_customer220=>get_instance(  )->custaddr_delete( i_cutaddrid = <key>-Addressid ).

         if check_delete = abap_false.

            APPEND value #( %tky =  <key>-%tky ) to failed-custaddr.

            APPEND VALUE #( %tky = <key>-%tky

                            %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = |Failed to delete Address { <key>-customerno }.| ) ) to reported-custaddr.
        ENDIF.


    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Customer.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_CUSTOMER220 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_CUSTOMER220 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    zcl_customer220=>get_instance(  )->save(  ).

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
