@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection of supplier no'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMC_SUPPNO_11562 as projection on ZTMI_SUPPNO_11562
{
    key SuppNo,
    Name,
    CompCode,
    Country,
    Grp,
    ValidUpto
}
