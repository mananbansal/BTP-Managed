@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'proj for products'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZTMC_PRODUCTS as projection on ZTMI_PRODUCTS
{
    key SupplierId,
    key ProductId,
    key CategoryId,
    ProductName,
    @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CurrencyStdVH', element: 'Currency'}  }]
    Currency,
    @Semantics.amount.currencyCode: 'Currency'
    Rate,
    @Semantics.amount.currencyCode: 'Currency'
    TaxAmaount,
    StockQuantity,
    @Semantics.systemDateTime.lastChangedAt: true
    ChangedAt,
    @Semantics.systemDateTime.createdAt: true
    CreatedAt,
    @Semantics.user.createdBy: true
    CreatedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LocalLastChanged,
    /* Associations */
    _supplier : redirected to parent ZTMC_SUPPLIER
}
