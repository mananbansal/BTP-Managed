@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection of header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZTMC_HEADER_11562 as projection on ZTMI_HEADER_11562
{
    key Docno,
    CompanyCode,
    @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CurrencyStdVH', element: 'Currency'}  }]
    Currency,
    SupplierNo,
    @Consumption.valueHelpDefinition:
      [{ entity: { name : 'ZI_DOMAIN_FIX_VAL' , element: 'description' } ,
         additionalBinding: [{ element: 'domain_name',
                               localConstant: 'z_status', usage: #FILTER }]
                               , distinctValues: true
                               }]

    Status,
    PurchaseOrg,
    ChangedAt,
    CreatedAt,
    CreatedBy,
    /* Associations */
    _add : redirected to composition child ZTMC_Add,
    _item : redirected to composition child ZTMC_ITEM_11562
}
