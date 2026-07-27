@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Sales item'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_SalesOrderItm11 
as projection on ZI_SalesOrderItm11 as SalesItm
{
    key Salesitemuuid,
    Salesorderuuid,
    @UI.identification: [{  position: 10 }]
    Salesorderitem,
    @UI.identification: [{  position: 10 }]
    Salesorderitemcategory,
    @UI.identification: [{  position: 10 }]
    Salesorderitemtext,
    @UI.identification: [{  position: 10 }]
    Material,
    @UI.identification: [{  position: 10 }]
    Plant,
    Orderquantityunit,
    Orderquantity,
    Netamount,
    Transactioncurrency,
    Createdbyuser,
    Creationat,
    Lastchangedbyuser,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _SalesHDR : redirected to parent ZC_SalesOrder110
}
