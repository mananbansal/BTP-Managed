@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMI_HEADER_11562
  as select from ztm_header_11562
  composition [0..*] of ZTMI_ITEM_11562   as _item
  composition [0..*] of ZTMI_ADD_11562    as _add
  association [1] to ztm_status_11562 as _status on ztm_header_11562.status = _status.status
                                                and _status.language = $session.system_date
{
  key docno        as Docno,
      company_code as CompanyCode,
      currency     as Currency,
      supplier_no  as SupplierNo,
      status       as Status,
      purchase_org as PurchaseOrg,
      changed_at   as ChangedAt,
      created_at   as CreatedAt,
      created_by   as CreatedBy,
      _add,
      _item,
      _status
}
