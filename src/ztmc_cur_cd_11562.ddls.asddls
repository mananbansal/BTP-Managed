@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection of currency code'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMC_CUR_CD_11562 as projection on ZTMI_CUR_CD_11562
{
    key CurrCd,
    CurrTxt
}
