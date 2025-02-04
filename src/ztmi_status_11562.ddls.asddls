@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZTMI_STATUS_11562 as select from ztm_status_11562
{
    key status as Status,
    language as Language,
    status_text as StatusText,
    created_at as CreatedAt,
    changed_at as ChangedAt
}
