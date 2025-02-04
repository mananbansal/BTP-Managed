@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection of address'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZTMC_Add as projection on ZTMI_ADD_11562
{
    key Docno,
    AddNo,
    Name,
    StAdd,
    City,
    @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CountryVH', element: 'Country'}  }]
    Country,
    @Semantics.telephone: { type: [ #CELL ]}
    ContNo,
    /* Associations */
    _header : redirected to parent ZTMC_HEADER_11562
}
