@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Sales header'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@UI.headerInfo: {typeNamePlural: 'Sales Orders',
                  title.value: 'Salesorder',
                  description.value: 'Creationat'
                  }
define root view entity ZC_SalesOrder110
  provider contract transactional_query
  as projection on ZI_SalesOrder110 as SalesHdr
{

  key Salesorderuuid,
      @Search.defaultSearchElement: true    
      @EndUserText.label: 'Sales Order'
      Salesorder,      
      Salesordertype,
      @EndUserText.label: 'Order Description'
      Description,
      @Search.defaultSearchElement: true
      Salesorganization,
      @Search.defaultSearchElement: true
      Soldtoparty,
      Distributionchannel,
      Documentreason,
      TotalAmount,
      Transactioncurrency,
      Status,
      Creationbyuser,
      Creationat,
      Lastchangedbyuser,
      Lastchanged,
      /* Associations */
      _SalesItem : redirected to composition child ZC_SalesOrderItm11
}
