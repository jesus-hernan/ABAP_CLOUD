@AbapCatalog.sqlViewName: 'ZV_CATEGORIAS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Categorias'
define view zc_categorias
  as select from ztb_catego
{
      //ztb_catego
      @UI.hidden: true
  key bi_categ    as Categoria,
      descripcion as Descripcion
}
