@AbapCatalog.sqlViewName: 'ZV_CLNTS_LIB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Ventas'
define view zc_clnts_lib
  as select from ztb_clnts_lib
{
      //ztb_clnts_lib
  key id_libro,
      // key id_libro,
      count(distinct id_cliente) as Ventas
}
group by
  id_libro
