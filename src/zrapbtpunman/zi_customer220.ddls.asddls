@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Interface view'
//@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_Customer220
  as select from zcustomer220
  composition [0..*] of ZI_CustAddr220 as _CustAddr
{

      @EndUserText.label: 'Customer No'
  key customerno         as Customerno,
      @EndUserText.label: 'First Name'
      firstname          as Firstname,
      @EndUserText.label: 'Last Name'
      lastname           as Lastname,
      @EndUserText.label: 'Mobile Number'
      phone              as Phone,
      @Semantics.user.createdBy: true
      createdbyuser      as Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      creationat         as Creationat,
      @Semantics.user.lastChangedBy: true
      lastchangedbyuser  as Lastchangedbyuser,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat      as Lastchangedat,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as Locallastchangedat,
      _CustAddr
}
