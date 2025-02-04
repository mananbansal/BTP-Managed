@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'proj for supplier'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZTMC_SUPPLIER as projection on ZTMI_SUPPLIER
{
    key SupplierId,
    @Semantics.eMail.address: true
    ContactEmail,
    @Semantics.name.fullName: true
    SupplierName,
    PhoneNumber,
    SupplierAddress,
    City,
    @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CountryVH', element: 'Country'}  }]
    Country,
    @Semantics.systemDateTime.lastChangedAt: true
    ChangedAt,
    @Semantics.systemDateTime.createdAt: true
    CreatedAt,
    @Semantics.user.createdBy: true
    CreatedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LocalLastChanged,
    /* Associations */
    _products : redirected to composition child ZTMC_PRODUCTS
}
