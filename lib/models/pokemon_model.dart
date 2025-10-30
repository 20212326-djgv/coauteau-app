class Pokemon {
  final String nombre;
  final String imagenUrl;
  final int baseExperiencia;
  final List<String> habilidades;
  final String sonidoUrl;

  Pokemon({
    required this.nombre,
    required this.imagenUrl,
    required this.baseExperiencia,
    required this.habilidades,
    required this.sonidoUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json){
  return Pokemon(
    nombre: json['nombre'],
    imagenUrl: json['sprites']['front_default'],
    baseExperiencia: json['base_experiencia'],
    habilidades: List<String>.from( json['habilidades'].map((habilidad) => habilidad['habilidad']['nombre'])),
    sonidoUrl: json['lloro']['latencia'],

  );
}


}