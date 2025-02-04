@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for products'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTMI_PRODUCTS as select from ztm_products
association to parent ZTMI_SUPPLIER as _supplier on $projection.SupplierId = _supplier.SupplierId
{
    key supplier_id as SupplierId,
    key product_id as ProductId,
    key category_id as CategoryId,
    product_name as ProductName,
    currency as Currency,
    @Semantics.amount.currencyCode: 'Currency'
    rate as Rate,
    @Semantics.amount.currencyCode: 'Currency'
    tax_amaount as TaxAmaount,
    stock_quantity as StockQuantity,
    changed_at as ChangedAt,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed as LocalLastChanged,
    _supplier
}
