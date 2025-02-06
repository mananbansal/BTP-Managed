CLASS lsc_ztmi_header_11562 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_ztmi_header_11562 IMPLEMENTATION.

  METHOD save_modified.

  DATA : ls_old_data   TYPE ztm_header_11562,
         ls_new_data   TYPE ztm_header_11562,
         lt_new_data   TYPE STANDARD TABLE OF ztm_header_11562,
         lt_new        TYPE STANDARD TABLE OF ztm_header_11562,
         lt_old_data   TYPE STANDARD TABLE OF ztm_header_11562,
         docno         TYPE z_doc_number.

  DATA:lt_txt_header   TYPE if_chdo_object_tools_rel=>ty_cdtxt_tab,
       ls_txt_header   TYPE if_chdo_object_tools_rel=>ty_cdtxt_line.

  DATA upd_txt_doc     TYPE if_chdo_object_tools_rel=>ty_cdchngindh.
  DATA upd_doc         TYPE if_chdo_object_tools_rel=>ty_cdchngindh.
  DATA changenumber    TYPE if_chdo_object_tools_rel=>ty_cdchangenr.
  DATA:objectid        TYPE if_chdo_object_tools_rel=>ty_cdobjectv,
       utime           TYPE if_chdo_object_tools_rel=>ty_cduzeit,
       udate           TYPE if_chdo_object_tools_rel=>ty_cddatum,
       username        TYPE if_chdo_object_tools_rel=>ty_cdusername,
       cdoc_upd_object TYPE if_chdo_object_tools_rel=>ty_cdchngindh VALUE 'I'.


  DATA:lt_txt_doc      TYPE if_chdo_object_tools_rel=>ty_cdtxt_tab,
       ls_txt_doc      LIKE LINE OF lt_txt_doc.

  DATA dref_emp        TYPE REF TO data.
  DATA:lcl_table       TYPE REF TO cl_abap_tabledescr,
       lcl_struc       TYPE REF TO cl_abap_structdescr,
       it_fields       TYPE abap_compdescr_tab.

       FIELD-SYMBOLS: <itab> TYPE any.

       CREATE DATA dref_emp TYPE STANDARD TABLE OF ztm_header_11562.

       TRY.
        username = cl_abap_context_info=>get_user_technical_name( ). "get_user_description(  ).
        utime = cl_abap_context_info=>get_system_time(  ).
        udate = cl_abap_context_info=>get_system_date(  ).
      CATCH cx_abap_context_info_error.
        "handle exception
    ENDTRY.

    IF create-ZTMI_HEADER_11562 IS NOT INITIAL.

    lt_new_data = CORRESPONDING  #( create-ZTMI_HEADER_11562 MAPPING FROM ENTITY ).
      READ TABLE lt_new_data ASSIGNING FIELD-SYMBOL(<fs_create>) INDEX 1.

      objectid = <fs_create>-docno.
      <fs_create>-client = sy-mandt.
      CONDENSE objectid.

       upd_doc = 'I'.
      upd_txt_doc = 'I'.

      ls_txt_doc-teilobjid = objectid.
      ls_txt_doc-textart = 'CHAR'.
      ls_txt_doc-textspr = 'E'.
      ls_txt_doc-updkz = 'I'.

      APPEND ls_txt_doc TO lt_txt_doc.
      CLEAR:ls_txt_doc.

      TRY.

          zcl_ztm_header_cd_chdo=>write(
          EXPORTING

                    objectid                = objectid
                    utime                   = utime
                    udate                   = udate
                    username                = username
                    object_change_indicator = cdoc_upd_object
                    planned_or_real_changes = 'R'
                    o_ztm_header_11562         = ls_old_data
                    n_ztm_header_11562        = <fs_create>
                    upd_ztm_header_11562        = upd_doc
                  IMPORTING
                    changenumber            = changenumber
           ).
           CATCH cx_chdo_write_error INTO DATA(lx_root).

          DATA(lv_tesxt) =  |Exception occurred: { lx_root->get_text( ) }|.

      ENDTRY.

      ELSEIF update-ZTMI_HEADER_11562 IS NOT INITIAL.

      lt_new = CORRESPONDING  #( update-ZTMI_HEADER_11562 MAPPING FROM ENTITY ).
      READ TABLE lt_new ASSIGNING FIELD-SYMBOL(<fs_update>) INDEX 1.

      DATA(lv_docno) = <fs_update>-docno.

      ASSIGN dref_emp->* TO <itab>.
* Get the Table details
      lcl_table ?= cl_abap_typedescr=>describe_by_data( <itab> ).
* Get the table line type i.e., structure details
      lcl_struc ?= lcl_table->get_table_line_type( ).
* Get the components(fields) of the table line
      it_fields = lcl_struc->components.
      DATA: lv_fieldname TYPE string.
      DATA st_var TYPE string.
      LOOP AT update-ZTMI_HEADER_11562 ASSIGNING FIELD-SYMBOL(<fs_header>).

        LOOP AT it_fields INTO DATA(ls_compnents).

          lv_fieldname = ls_compnents-name.

          ASSIGN COMPONENT lv_fieldname OF STRUCTURE <fs_header>-%control TO FIELD-SYMBOL(<lv_control_value>).
          IF ls_compnents-name EQ 'CLIENT'.
            CONTINUE.
          ENDIF.
          IF <lv_control_value> = '01'.

            IF st_var IS NOT INITIAL.

              st_var = |{ st_var }, { ls_compnents-name }|.
            ENDIF.

          ELSE.
            CONTINUE.

          ENDIF.
        ENDLOOP.

      ENDLOOP.
      SELECT (st_var) FROM @lt_new AS lt_new WHERE docno = @lv_docno INTO TABLE @lt_new_data.

      SELECT (st_var) FROM ztm_header_11562 WHERE docno = @lv_docno INTO TABLE @lt_old_data.

      ls_old_data = lt_old_data[ 1 ].
      ls_new_data = lt_new_data[ 1 ].

      objectid = <fs_update>-docno.
      CONDENSE Objectid.

      upd_doc = 'U'.
      upd_txt_doc = 'U'.

      ls_txt_doc-teilobjid = objectid.
      ls_txt_doc-textart = 'CHAR'.
      ls_txt_doc-textspr = 'E'.
      ls_txt_doc-updkz = 'U'.

      APPEND ls_txt_doc TO lt_txt_doc.
      CLEAR:ls_txt_doc.

      TRY.

          zcl_ztm_header_cd_chdo=>write(
          EXPORTING
                    objectid                = objectid
                    utime                   = utime
                    udate                   = udate
                    username                = username
                    object_change_indicator = cdoc_upd_object
                    planned_or_real_changes = 'R'
                    o_ztm_header_11562         = ls_old_data
                    n_ztm_header_11562         = ls_new_data
                    upd_ztm_header_11562       = upd_doc
                  IMPORTING
                    changenumber            = changenumber
           ).
        CATCH cx_chdo_write_error.
      ENDTRY.


    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZTMI_HEADER_11562 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ztmi_header_11562 RESULT result.

    METHODS validateCurrency FOR VALIDATE ON SAVE
      IMPORTING keys FOR ztmi_header_11562~validateCurrency.
    METHODS changeStatus FOR MODIFY
      IMPORTING keys FOR ACTION ZTMI_HEADER_11562~changeStatus RESULT result.

ENDCLASS.

CLASS lhc_ZTMI_HEADER_11562 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  validation method for currency
  METHOD validateCurrency.
  READ ENTITIES OF ZTMI_HEADER_11562 IN LOCAL MODE
  ENTITY ZTMI_HEADER_11562
  FIELDS ( Currency ) with CORRESPONDING #( keys )
  RESULT DATA(lv_currency).

  LOOP AT lv_currency INTO DATA(currencies).
      SELECT SINGLE * FROM i_currency
          WHERE currency = @currencies-Currency
          INTO @DATA(ls_currrency).

          IF sy-subrc NE 0.
        APPEND VALUE #( %tky = currencies-%tky ) TO failed-ztmi_header_11562.
        APPEND VALUE #( %tky = currencies-%tky
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text = 'Currency Code is not valid' )
                       ) TO reported-ztmi_header_11562.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD changeStatus.
  READ ENTITIES OF ztmi_header_11562 IN LOCAL MODE
            ENTITY ztmi_header_11562 ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(lt_hdr)
            FAILED Data(lt_fld).

    LOOP AT lt_hdr ASSIGNING FIELD-SYMBOL(<fs_hdr>).
        <fs_hdr>-Status = 'Confirmed'.
    ENDLOOP.

    MODIFY ENTITIES OF ztmi_header_11562 IN LOCAL MODE
        ENTITY  ztmi_header_11562
         UPDATE FIELDS ( Status ) " The fields which we are updating will come here
         WITH VALUE #( FOR ls_result IN lt_hdr INDEX INTO i (
                            %key-Docno = <fs_hdr>-%key-Docno
                                Status = <fs_hdr>-Status

                          %control = VALUE #(
                          Status = if_abap_behv=>mk-on
                          )
         ) )
      FAILED lt_fld
      REPORTED DATA(lt_rpt)
      MAPPED DATA(lt_mpd).
  ENDMETHOD.

ENDCLASS.
