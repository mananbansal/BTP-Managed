@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection for status'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMC_STATUS as projection on ZTMI_STATUS_11562
{
    key Status,
    Language,
    StatusText,
    CreatedAt,
    ChangedAt
}
