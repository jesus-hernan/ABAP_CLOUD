"!@testing ZC_CATEGORIAS
CLASS ltc_ZC_CATEGORIAS
DEFINITION FINAL FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.
  PRIVATE SECTION.

    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      "! In CLASS_SETUP, corresponding doubles and clone(s) for the CDS view under test and its dependencies are created.
      class_setup RAISING cx_static_check,
      "! In CLASS_TEARDOWN, Generated database entities (doubles & clones) should be deleted at the end of test class execution.
      class_teardown.

    DATA:
      act_results   TYPE STANDARD TABLE OF zc_categorias WITH EMPTY KEY,
      lt_ztb_catego TYPE STANDARD TABLE OF ztb_catego WITH EMPTY KEY.

    METHODS:
      "! SETUP method creates a common start state for each test method,
      "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
      setup RAISING cx_static_check,
      prepare_testdata_set,
      "!  In this method test data is inserted into the generated double(s) and the test is executed and
      "!  the results should be asserted with the actuals.
      main FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltc_ZC_CATEGORIAS IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'ZC_CATEGORIAS' ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD main.
    prepare_testdata_set( ).
    SELECT * FROM zc_categorias WHERE categoria = 'A' INTO TABLE @act_results.

    cl_abap_unit_assert=>assert_subrc(
      EXPORTING
        exp              = 0
        act              = sy-subrc
        msg              = 'No fue posible asignar valores a la tabla interna'
        level            = if_abap_unit_constant=>severity-low
        quit             = if_abap_unit_constant=>quit-no ).

*    CLEAR act_results[].

    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = act_results
        msg              = 'La tabla está vacía'
        level            = if_abap_unit_constant=>severity-low
        quit             = if_abap_unit_constant=>quit-no ).

    SELECT * FROM zc_categorias WHERE categoria = 'A' INTO TABLE @DATA(act_results1).

    cl_abap_unit_assert=>assert_equals( act     = act_results
                                        exp     = act_results1
                                        msg     = 'Las estructuras no coinciden'
                                        level   = if_abap_unit_constant=>severity-medium
                                        quit    = if_abap_unit_constant=>quit-no ).

  ENDMETHOD.



  METHOD prepare_testdata_set.

    "Prepare test data for 'ztb_catego'
    lt_ztb_catego = VALUE #(
      (
        client = sy-mandt
        bi_categ = 'A'
        descripcion = 'Filosofía'
      ) ).
    environment->insert_test_data( i_data =  lt_ztb_catego ).

  ENDMETHOD.

ENDCLASS.
