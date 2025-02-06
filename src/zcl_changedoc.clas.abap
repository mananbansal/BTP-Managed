CLASS zcl_changedoc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_changedoc IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
  DATA: lt_change_doc TYPE TABLE OF ZTMI_READ_CD_HEADER,
          ls_change_doc TYPE ZTMI_READ_CD_HEADER.

    DATA: rt_cdredadd TYPE cl_chdo_read_tools=>tt_cdredadd_tab,
          lr_err      TYPE REF TO cx_chdo_read_error.

    DATA: lt_objectid TYPE TABLE OF cl_chdo_read_tools=>ty_r_objectid_line,
          ls_objectid TYPE cl_chdo_read_tools=>ty_r_objectid_line.

    DATA : lv_objclass TYPE if_chdo_object_tools_rel=>ty_cdobjectcl,
           lv_objectid TYPE STANDARD TABLE OF cl_chdo_read_tools=>ty_r_objectid_line.

             TRY.

        io_request->is_data_requested( ).
        DATA(entityid)     = io_request->get_entity_id( ).
        DATA(lv_top)       = io_request->get_paging( )->get_page_size( ).
        DATA(lv_skip)      = io_request->get_paging( )->get_offset( ).
        DATA(lt_fields)    = io_request->get_requested_elements( ).
        DATA(lt_sort)      = io_request->get_sort_elements( ).
        DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
        DATA(lv_max_rows)  = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited THEN 0 ELSE lv_page_size ).

        DATA(lt_condition) =  io_request->get_filter( )->get_as_ranges( iv_drop_null_comparisons = abap_true ).
        SORT lt_condition BY name ASCENDING.

          READ TABLE lt_condition WITH KEY name = 'OBJECTCLASS' INTO DATA(ls_objcls_key) BINARY SEARCH.
        IF sy-subrc = 0.
          LOOP AT ls_objcls_key-range INTO DATA(ls_objcls_option).
            IF ls_objcls_option-low IS NOT INITIAL.
              CLEAR lv_objclass.
              lv_objclass = ls_objcls_option-low.
            ENDIF.
          ENDLOOP.
        ENDIF.

***FETCHING THE OBJECTID FROM FILTER
        READ TABLE lt_condition WITH KEY name = 'OBJECTID' INTO DATA(ls_objectid_key) BINARY SEARCH.
        IF sy-subrc = 0.
          LOOP AT ls_objectid_key-range INTO DATA(ls_objectid_option).
            IF ls_objectid_option-low IS NOT INITIAL.
              CLEAR ls_objectid.
              ls_objectid-sign = ls_objectid_option-sign.
              ls_objectid-option = ls_objectid_option-option.
              ls_objectid-low = ls_objectid_option-low.
              ls_objectid-high = ls_objectid_option-high.
              APPEND ls_objectid TO lt_objectid.
              CLEAR ls_objectid.
            ENDIF.

          ENDLOOP.
        ENDIF.

***GETTING THE CHANGE DOCUMENT
        TRY.
            cl_chdo_read_tools=>changedocument_read(
                 EXPORTING
                  i_objectclass    = lv_objclass  " change document object name
                  it_objectid      = lt_objectid
                 IMPORTING
                   et_cdredadd_tab  = rt_cdredadd    " result returned in table
               ).
          CATCH cx_chdo_read_error INTO lr_err.
        ENDTRY.

*        Delete ADJACENT DUPLICATES FROM rt_cdredadd COMPARING changenr.

        lt_change_doc = CORRESPONDING #( rt_cdredadd ).

***setting the OUTPUT NUMBER OF records
            io_response->set_total_number_of_records( lines( lt_change_doc ) ).
***SETTING THE OUTPUT INTERNAL TABLE
        io_response->set_data( lt_change_doc ).

      CATCH cx_root INTO DATA(lx_root).
        DATA(lv_text) = lx_root->get_text(  ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
