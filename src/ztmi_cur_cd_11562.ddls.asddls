@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for currency code'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMI_CUR_CD_11562 as select from ztm_cur_cd_11562
{
    key curr_cd as CurrCd,
    curr_txt as CurrTxt
}
