CLASS LHC_ZR_TM_EMP_11562 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR INSTANCE AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrTmEmp11562
        RESULT result.
ENDCLASS.

CLASS LHC_ZR_TM_EMP_11562 IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
ENDCLASS.
