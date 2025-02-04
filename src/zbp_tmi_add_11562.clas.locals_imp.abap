CLASS lhc_ztmi_add_11562 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateCountry FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZTMI_ADD_11562~validateCountry.

ENDCLASS.

CLASS lhc_ztmi_add_11562 IMPLEMENTATION.

  METHOD validateCountry.
  READ ENTITIES OF ZTMI_HEADER_11562 IN LOCAL MODE
  ENTITY ZTMI_ADD_11562
  FIELDS ( country ) with CORRESPONDING #( keys )
  RESULT DATA(lv_country).

  LOOP AT lv_country INTO DATA(countries).
      SELECT SINGLE * FROM I_CountryVH
          WHERE Country = @countries-Country
          INTO @DATA(ls_currrency).

          IF sy-subrc NE 0.
        APPEND VALUE #( %tky = countries-%tky ) TO failed-ztmi_add_11562.
        APPEND VALUE #( %tky = countries-%tky
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text = 'Country is not valid' )
                       ) TO reported-ztmi_add_11562.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
