@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Item Basic view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_SalesOrderItm11
  as select from zsalesitm110
  association to parent ZI_SalesOrder110 as _SalesHDR on $projection.Salesorderuuid = _SalesHDR.Salesorderuuid
{
  key salesitemuuid          as Salesitemuuid,
      salesorderuuid         as Salesorderuuid,
      salesorderitem         as Salesorderitem,
      salesorderitemcategory as Salesorderitemcategory,
      salesorderitemtext     as Salesorderitemtext,
      material               as Material,
      plant                  as Plant,
      orderquantityunit      as Orderquantityunit,
      @Semantics.quantity.unitOfMeasure: 'orderquantityunit'
      orderquantity          as Orderquantity,
      @Semantics.amount.currencyCode: 'transactioncurrency'
      netamount              as Netamount,
      transactioncurrency    as Transactioncurrency,
      @Semantics.user.createdBy: true
      createdbyuser          as Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      creationat             as Creationat,
      @Semantics.user.lastChangedBy: true
      lastchangedbyuser      as Lastchangedbyuser,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat          as Lastchangedat,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat     as Locallastchangedat,
      _SalesHDR

}
