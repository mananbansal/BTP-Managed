@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_TM_EMP_11562
 // provider contract TRANSACTIONAL_QUERY
  as projection on ZR_TM_EMP_11562
{
  key Empno,
  Empname,
  Compcode,
  ContNo,
  Address,
  LocalLastChanged,
  LastChanged,
  CreationUser,
  ChangeUser
  
}
