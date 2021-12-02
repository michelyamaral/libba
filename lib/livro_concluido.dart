class LivroConcluido {
  final int? id;
  final String titulo;
  final String autor;
  final String formato;
  final String dataInicio;
  final String dataFinal;
  final String tempoFinal;
  final int dias;
  const LivroConcluido({
    this.id,
    required this.titulo,
    required this.autor,
    required this.formato,
    required this.dataInicio,
    required this.dataFinal,
    required this.tempoFinal,
    required this.dias,
  });

  factory LivroConcluido.fromMap(Map<String, dynamic> json) =>
      new LivroConcluido(
        id: json['id'],
        titulo: json['titulo'],
        autor: json['autor'],
        formato: json['formato'],
        dataInicio: json['dataInicio'],
        dataFinal: json['dataFinal'],
        tempoFinal: json['tempoFinal'],
        dias: json['dias'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'formato': formato,
      'dataInicio': dataInicio,
      'dataFinal': dataFinal,
      'tempoFinal': tempoFinal,
      'dias': dias
    };
  }
}
