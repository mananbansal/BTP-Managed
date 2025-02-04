@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTMI_ADD_11562 as select from ztm_add_11562
association to parent ZTMI_HEADER_11562 as _header on $projection.Docno= _header.Docno
{
    key docno as Docno,
    add_no as AddNo,
    name as Name,
    st_add as StAdd,
    city as City,
    country as Country,
    cont_no as ContNo,
   _header
}
