@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'supplier cds view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZTMI_SUPPLIER as select from ztm_supplier
composition [0..*] of ZTMI_PRODUCTS as _products
{
    key supplier_id as SupplierId,
    contact_email as ContactEmail,
    supplier_name as SupplierName,
    phone_number as PhoneNumber,
    supplier_address as SupplierAddress,
    city as City,
    country as Country,
    changed_at as ChangedAt,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed as LocalLastChanged,
    _products
}
