import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/api_servicio.dart';
import '../models/pokemon_model.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({super.key});

  @override
  _PokemonViewState createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  final TextEditingController _nameController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  Pokemon? _pokemon;
  bool _cargando = false;

  void _searchPokemon() async {
    if (_nameController.text.isEmpty) return;
    
    setState(() {
      _cargando = true;
    });

    try {
      final pokemon = await ApiServicio.getPokemon(_nameController.text);
      setState(() {
        _pokemon = pokemon;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Pokémon no encontrado')),
      );
    } finally {
      setState(() {
        _cargando = false;
      });
    }
  }

  void _playCry() async {
    if (_pokemon?.sonidoUrl != null) {
      await _audioPlayer.play(UrlSource(_pokemon!.sonidoUrl));
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Pokémon',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cargando ? null : _searchPokemon,
              child: _cargando 
                  ? const CircularProgressIndicator()
                  : const Text('Buscar Pokémon'),
            ),
            const SizedBox(height: 20),
            if (_pokemon != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(_pokemon!.imagenUrl),
                      const SizedBox(height: 10),
                      Text(
                        _pokemon!.nombre.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Experiencia base: ${_pokemon!.baseExperiencia}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Habilidades:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ..._pokemon!.habilidades.map(
                        (ability) => Text(ability),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _playCry,
                        child: const Text('Reproducir Sonido'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}