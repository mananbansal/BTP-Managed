CLASS lhc_ztmi_item_11562 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateCurrency FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZTMI_ITEM_11562~validateCurrency.
    METHODS calculateTax FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZTMI_ITEM_11562~calculateTax.

ENDCLASS.

CLASS lhc_ztmi_item_11562 IMPLEMENTATION.

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

  METHOD calculateTax.

  READ ENTITIES OF ZTMI_HEADER_11562 IN LOCAL MODE
  ENTITY ZTMI_ITEM_11562
  FIELDS ( Docno Amount ) with VALUE #( for key IN keys
                                            ( %key = key-%key
                                              %control = value #( Docno = if_abap_behv=>mk-on
                                                                    Amount = if_abap_behv=>mk-on )
                                            )
                                      )
  RESULT DATA(lt_TaxAmt).

  LOOP AT lt_TaxAmt ASSIGNING FIELD-SYMBOL(<fs_item>).
  CONSTANTS: lc_tax_rate TYPE p LENGTH 5 DECIMALS 2 VALUE '0.18'.
  <fs_item>-TaxAmt = <fs_item>-Amount * lc_tax_rate.
  ENDLOOP.

  MODIFY ENTITIES OF ZTMI_HEADER_11562 in LOCAL MODE
  ENTITY ZTMI_ITEM_11562
  UPDATE FIELDS ( TaxAmt )
  with VALUE #(  for ls_result in lt_TaxAmt INDEX INTO i
                 (
                 %key = keys[ i ]-%key
                        TaxAmt = <fs_item>-TaxAmt
                  %control = VALUE  #( TaxAmt = if_abap_behv=>mk-on )
                 )
              )
              REPORTED DATA(lt_rpt)
              FAILED Data(lt_fld)
              Mapped DATA(lt_mpd).

  ENDMETHOD.

ENDCLASS.
