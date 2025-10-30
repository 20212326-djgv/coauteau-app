//David Josue Guzman Vizcaino #2021-2326
import 'package:flutter/material.dart';
import '../services/api_servicio.dart';
import '../models/universidad_model.dart';

class UniversitiesView extends StatefulWidget {
  const UniversitiesView({super.key});

  @override
  _UniversitiesViewState createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  final TextEditingController _countryController = TextEditingController();
  List<Universidad> _universidades = [];
  bool _estaCargando = false;

  void _buscarUniversidades() async {
    if (_countryController.text.isEmpty) return;
    
    setState(() {
      _estaCargando = true;
    });

    try {
      final universities = await ApiServicio.getUniversidades(_countryController.text);
      setState(() {
        _universidades = universities;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _estaCargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Ingresa un país (en inglés)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _estaCargando ? null : _buscarUniversidades,
              child: _estaCargando 
                  ? const CircularProgressIndicator()
                  : const Text('Buscar Universidades'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _estaCargando
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _universidades.length,
                      itemBuilder: (context, index) {
                        final university = _universidades[index];
                        return Card(
                          child: ListTile(
                            title: Text(university.nombre),
                            subtitle: Text(university.dominio),
                            trailing: IconButton(
                              icon: const Icon(Icons.open_in_new),
                              onPressed: () {
                                
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}