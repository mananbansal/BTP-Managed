@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection of company code'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMC_CMPCD_11562 as projection on ZTMI_CMPCD_11562
{
    key ComCode,
    PrchOrg,
    CompCodeTxt
}
