@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for company code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZTMI_CMPCD_11562 as select from ztm_compcd_11562
{
    key com_code as ComCode,
    prch_org as PrchOrg,
    comp_code_txt as CompCodeTxt
}
