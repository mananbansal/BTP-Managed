@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTMI_ITEM_11562 as select from ztm_item_11562
association to parent ZTMI_HEADER_11562 as _header on $projection.Docno= _header.Docno
{
    key docno as Docno,
    key item_no as ItemNo,
    status as Status,
    currency as Currency,
    
    quantity as Quantity,
    
    @Semantics.amount.currencyCode: 'Currency'
    amount as Amount,
    
    @Semantics.amount.currencyCode: 'Currency'
    tax_amt as TaxAmt,
    
    changed_at as ChangedAt,
    created_at as CreatedAt,
    created_by as CreatedBy,  
    _header
}
