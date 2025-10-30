class Universidad{
  final String nombre;
  final String dominio;
  final String sitioWeb;


  Universidad({
    required this.nombre,
    required this.dominio,
    required this.sitioWeb,
  });

factory Universidad.fromJson(Map<String, dynamic> json) {
    return Universidad(
      nombre: json['nombre'],
      dominio: json['dominio'],
      sitioWeb: json['pagina_web'],
    );
  }
}