@AbapCatalog.sqlViewName: 'ZV_LIBROS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Libros'
@Metadata.allowExtensions: true
@Search.searchable: true
define view zc_libros
  as select from    ztb_libros   as libros
    inner join      ztb_catego   as catego on libros.bi_categ = catego.bi_categ
    left outer join zc_clnts_lib as ventas on libros.id_libro = ventas.id_libro
  association [0..*] to zc_clientes as _Clientes on $projection.IdLibro = _Clientes.IdLibro

{
      //libros
  key libros.id_libro as IdLibro,
      titulo          as Titulo,
      libros.bi_categ as Categoria,
      autor           as Autor,
      editorial       as Editorial,
      idioma          as Idioma,
      paginas         as Paginas,
      @Semantics.amount.currencyCode: 'moneda'
      precio          as Precio,
      case
      when ventas.Ventas < 1 then 0
      when ventas.Ventas = 1 then 1
      when ventas.Ventas = 2 then 2
      when ventas.Ventas > 2 then 3
      else 0
      end             as Ventas,
      case ventas.Ventas
      when 0 then ''
      else ''
      end             as Text,
      @Semantics.currencyCode
      moneda          as Moneda,
      formato         as Formato,
      descripcion     as Descripcion,
      url             as Imagen,
      _Clientes
}
