import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';
import '../models/universidad_model.dart';
import '../models/wordpress_model.dart';

class ApiServicio {
  static const String _genderizeUrl = 'https://api.genderize.io';
  static const String _agifyUrl = 'https://api.agify.io';
  static const String _universidadesUrl = 'https://adamix.net/proxy.php';
  static const String _pokeApiUrl = 'https://pokeapi.co/api/v2/pokemon';
  static const String _climaUrl = 'https://api.open-meteo.com/v1/forecast';

  // Predecir género
  static Future<Map<String, dynamic>> predecirGenero(String name) async {
    final response = await http.get(Uri.parse('$_genderizeUrl?name=$name'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No puedo saber tu genero');
    }
  }

  // Predecir edad
  static Future<Map<String, dynamic>> predecirEdad(String name) async {
    final response = await http.get(Uri.parse('$_agifyUrl?name=$name'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('No pudimos predecir tu edad');
    }
  }

  // Obtener universidades
  static Future<List<Universidad>> getUniversidades(String country) async {
    final response = await http.get(
        Uri.parse('$_universidadesUrl?pais=${country.replaceAll(' ', '+')}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['datos'] != null) {
        List<dynamic> universidadesJson = data['datos'];
        return universidadesJson
            .map((json) => Universidad.fromJson(json))
            .toList();
      }
      return [];
    } else {
      throw Exception('Fallo al cargar las Universidades');
    }
  }

  //clima en RD
  static Future<Map<String, dynamic>> getClima() async {
    // Coordenadas de República Dominicana
    final response = await http.get(Uri.parse(
        '$_climaUrl?latitude=18.7357&longitude=-70.1627&current=temperature_2m,weather_code'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fallo al cargar clima');
    }
  }

  // Obtener información de Pokémon
  static Future<Pokemon> getPokemon(String name) async {
    final response = await http.get(Uri.parse('$_pokeApiUrl/${name.toLowerCase()}'));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fallo al cargar Pokémon');
    }
  }

  //noticias de WordPress
  static Future<List<WordPress>> getWordPress() async {
    // Ejemplo
    final response = await http.get(Uri.parse(
        'https://kinsta.com/wp-json/wp/v2/posts?per_page=3&_embed'));
    
    if (response.statusCode == 200) {
      List<dynamic> newsJson = json.decode(response.body);
      return newsJson.map((json) => WordPress.fromJson(json)).toList();
    } else {
      throw Exception('Fallo al cargar WordPress');
    }
  }
}