@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic view for ZI_SalesOrder110'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SalesOrder110
  as select from zsaleshdr110
  composition [0..*] of ZI_SalesOrderItm11 as _SalesItem
{
  key salesorderuuid      as Salesorderuuid,
      salesorder          as Salesorder,
      salesordertype      as Salesordertype,
      description         as Description,
      salesorganization   as Salesorganization,
      soldtoparty         as Soldtoparty,
      distributionchannel as Distributionchannel,
      documentreason      as Documentreason,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      totalnetamount      as TotalAmount,
      transactioncurrency as Transactioncurrency,
      status              as Status,
      @Semantics.user.createdBy: true
      creationbyuser      as Creationbyuser,
      @Semantics.systemDateTime.createdAt: true
      creationat          as Creationat,
      @Semantics.user.lastChangedBy: true
      lastchangedbyuser   as Lastchangedbyuser,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchanged         as Lastchanged,
      _SalesItem
}
