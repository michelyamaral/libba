class Livro {
  final int? id;
  final String titulo;
  final String autor;
  final String formato;
  final String dataInicio;
  final int paginas;
  final int capitulos;
  final String temcapitulos;
  final int horasEstimadas;
  final int minutosEstimados;
  final double paginaspormin;
  final int meta;
  final String tipometa;
  final int paginaslidas;
  final int capituloslidos;
  final int porcentagem;
  final String dias;

  const Livro(
      {this.id,
      required this.titulo,
      required this.autor,
      required this.formato,
      required this.dataInicio,
      required this.paginas,
      required this.capitulos,
      required this.temcapitulos,
      required this.horasEstimadas,
      required this.minutosEstimados,
      required this.paginaspormin,
      required this.meta,
      required this.tipometa,
      required this.paginaslidas,
      required this.capituloslidos,
      required this.porcentagem,
      required this.dias});

  factory Livro.fromMap(Map<String, dynamic> json) => new Livro(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
      formato: json['formato'],
      dataInicio: json['dataInicio'],
      paginas: json['paginas'],
      capitulos: json['capitulos'],
      temcapitulos: json['temcapitulos'],
      horasEstimadas: json['horasEstimadas'],
      minutosEstimados: json['minutosEstimados'],
      paginaspormin: json['paginaspormin'],
      meta: json['meta'],
      tipometa: json['tipometa'],
      paginaslidas: json['paginaslidas'],
      capituloslidos: json['capituloslidos'],
      porcentagem: json['porcentagem'],
      dias: json['dias']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'formato': formato,
      'dataInicio': dataInicio,
      'paginas': paginas,
      'capitulos': capitulos,
      'temcapitulos': temcapitulos,
      'horasEstimadas': horasEstimadas,
      'minutosEstimados': minutosEstimados,
      'paginaspormin': paginaspormin,
      'meta': meta,
      'tipometa': tipometa,
      'paginaslidas': paginaslidas,
      'capituloslidos': capituloslidos,
      'porcentagem': porcentagem,
      'dias': dias
    };
  }
}
