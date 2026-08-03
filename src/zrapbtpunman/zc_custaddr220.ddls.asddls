@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Customer Address'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_CUSTADDR220
  as projection on ZI_CustAddr220 as CustAddr
{
  key Customerno,
      @EndUserText.label: 'Address Id'
  key Addressid,
      @EndUserText.label: 'City'
      City,
      @EndUserText.label: 'District'
      District,
      @EndUserText.label: 'Postal Code'
      Postalcode,
      @EndUserText.label: 'Country'
      Country,
      @EndUserText.label: 'Street'
      Street,
      @Semantics.user.createdBy: true
      Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      Creationat,
      @Semantics.user.lastChangedBy: true
      Lastchangedbyuser,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Locallastchangedat,
      /* Associations */
      _Customer : redirected to parent ZC_CUSTOMER220
}
