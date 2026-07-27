CLASS lhc_salesitm DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validatePlant FOR VALIDATE ON SAVE
      IMPORTING keys FOR SalesITM~validatePlant.

ENDCLASS.

CLASS lhc_salesitm IMPLEMENTATION.

  METHOD validatePlant.

        READ ENTITIES OF ZI_SalesOrder110 in LOCAL MODE
        ENTITY SalesITM
        FIELDS ( Plant ) WITH CORRESPONDING #( keys )
        RESULT data(SalesItems).

        SELECT FROM zsalesitm110 WITH PRIVILEGED ACCESS
        FIELDS plant
        FOR ALL ENTRIES IN @SalesItems
        WHERE plant = @SalesItems-Plant
        INTO table @DATA(plants).

        LOOP AT SalesItems into DATA(SalesItem).

            READ TABLE plants with key plant = SalesItem-Plant TRANSPORTING NO FIELDS.

            if sy-subrc <> 0.

                APPEND value #( %tky = salesitem-%tky ) to Failed-salesitm.

                APPEND value #( %tky = salesitem-%tky
                                %msg = new_message_with_text(
                                severity = if_abap_behv_message=>severity-error
                                text = 'Plant does not exist'
                                )
                                ) to reported-salesitm.

            ENDIF.

        ENDLOOP.

  ENDMETHOD.


ENDCLASS.

CLASS lhc_SalesHDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR SalesHDR RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR SalesHDR RESULT result.
    METHODS calcSalesOrderID FOR DETERMINE ON SAVE
      IMPORTING keys FOR SalesHDR~calcSalesOrderID.
    METHODS setComplete FOR MODIFY
      IMPORTING keys FOR ACTION SalesHDR~setComplete RESULT result.

ENDCLASS.

CLASS lhc_SalesHDR IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD calcSalesOrderID.

    READ ENTITIES OF ZI_SalesOrder110 IN LOCAL MODE
    ENTITY SalesHDR
    FIELDS ( Salesorder ) WITH CORRESPONDING #( keys )
    RESULT DATA(sales).

    DELETE Sales WHERE Salesorder is Not INITIAL.

    if sales is NOT INITIAL.

        Select single FROM zsaleshdr110
        FIELDS MAX( salesorder ) as salesorderid
        into @DATA(max_salesorderid).

        LOOP AT sales into DATA(sales_wa).

        MODIFY ENTITIES OF ZI_SalesOrder110 IN LOCAL MODE
        ENTITY SalesHDR
        UPDATE
            FIELDS ( Salesorder )
            WITH VALUE #( (
                         %tky = sales_wa-%tky
                         Salesorder = max_salesorderid + 1

             ) ).
        endloop.

    ENDIF.



  ENDMETHOD.

  METHOD setComplete.

    MODIFY ENTITIES OF ZI_SalesOrder110 IN LOCAL MODE
    ENTITY SalesHDR
    UPDATE FIELDS ( Status )
    WITH VALUE #( FOR key in keys (
        %tky = key-%tky
        Status = 'C'
    ) ).

    READ ENTITIES OF ZI_SalesOrder110 IN LOCAL MODE
    ENTITY SalesHDR
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Sales).

    result = VALUE #( for sale in sales (
            %tky = sale-%tky
            %param = Sale

    ) ).
  ENDMETHOD.

ENDCLASS.
