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
