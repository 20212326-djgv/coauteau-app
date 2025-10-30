//David Josue Guzman Vizcaino #2021-2326
import 'package:flutter/material.dart';
import '../services/api_servicio.dart';

class Clima extends StatefulWidget {
  const Clima({super.key});

  @override
  _climaEstado createState() => _climaEstado();
}

class _climaEstado extends State<Clima> {
  Map<String, dynamic>? climaDatos;
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    _cargarClima();
  }

  void _cargarClima() async {
    setState(() {
      _cargando = true;
    });

    try {
      final weather = await ApiServicio.getClima();
      setState(() {
        climaDatos = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _cargando = false;
      });
    }
  }

  String _descripcionClima(int clima_code) {
   
    if (clima_code == 0) return 'Despejado';
    if (clima_code < 50) return 'Parcialmente nublado';
    if (clima_code < 70) return 'Nublado';
    return 'Lluvioso';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima en República Dominicana'),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : climaDatos == null
              ? const Center(child: Text('No hay datos del clima'))
              : Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.wb_sunny, size: 64, color: Colors.orange),
                          const SizedBox(height: 20),
                          Text(
                            'Clima Actual',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 10),
                          if (climaDatos!['current'] != null)
                            Column(
                              children: [
                                Text(
                                  '${climaDatos!['current']['temperatura_2m'].toStringAsFixed(1)}°C',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                Text(
                                  _descripcionClima(
                                      climaDatos!['current']['clima_code']),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          Text(
                            'Ubicación: República Dominicana',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}