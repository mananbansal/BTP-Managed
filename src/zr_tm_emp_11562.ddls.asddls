@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Core Data Service Entity'
define root view entity ZR_TM_EMP_11562
  as select from ztm_emp_11562
{
  key empno as Empno,
  empname as Empname,
  compcode as Compcode,
  cont_no as ContNo,
  address as Address,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed as LastChanged,
  @Semantics.user.createdBy: true
  creation_user as CreationUser,
  @Semantics.user.lastChangedBy: true
  change_user as ChangeUser
  
}
