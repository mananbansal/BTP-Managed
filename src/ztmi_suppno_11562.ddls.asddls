@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for supplier no'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMI_SUPPNO_11562 as select from ztm_suppno_11562
{
    key supp_no as SuppNo,
    name as Name,
    comp_code as CompCode,
    country as Country,
    grp as Grp,
    valid_upto as ValidUpto
}
