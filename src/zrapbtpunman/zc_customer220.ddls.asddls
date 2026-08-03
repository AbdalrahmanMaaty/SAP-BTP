@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Customer'
//@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_CUSTOMER220
  provider contract transactional_query
  as projection on ZI_Customer220 as Customer
{
  key Customerno,
      @Search.defaultSearchElement: true
      Firstname,
      @Search.defaultSearchElement: true
      Lastname,
      Phone,
      @Semantics.user.createdBy: true
      Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      Creationat,
      @Semantics.user.lastChangedBy: true
      Lastchangedbyuser,
      @Semantics.systemDateTime.lastChangedAt: true
      Lastchangedat,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Locallastchangedat,
      /* Associations */
      _CustAddr : redirected to composition child ZC_CUSTADDR220
}
