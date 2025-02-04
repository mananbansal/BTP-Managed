@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection of item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZTMC_ITEM_11562 as projection on ZTMI_ITEM_11562
{
    key Docno,
    key ItemNo,
     @Consumption.valueHelpDefinition:
      [{ entity: { name : 'ZI_DOMAIN_FIX_VAL' , element: 'description' } ,
         additionalBinding: [{ element: 'domain_name',
                               localConstant: 'z_status', usage: #FILTER }]
                               , distinctValues: true
                               }]
    Status,
    @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CurrencyStdVH', element: 'Currency'}  }]
    Currency,
    Quantity,
    @Semantics.amount.currencyCode: 'Currency'
    Amount,
    @Semantics.amount.currencyCode: 'Currency'
    TaxAmt,
    ChangedAt,
    CreatedAt,
    CreatedBy,
    /* Associations */
    _header : redirected to parent ZTMC_HEADER_11562
}
