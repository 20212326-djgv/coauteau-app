import 'package:flutter/material.dart';
import '../services/api_servicio.dart';

class PredecirGenero extends StatefulWidget {
  const PredecirGenero({super.key});

  @override
  _PredecirGeneroEstado createState() => _PredecirGeneroEstado();
}

class _PredecirGeneroEstado extends State<PredecirGenero> {
  final TextEditingController _nameController = TextEditingController();
  String _genero = '';
  double _probabilidad = 0.0;
  bool _estaCargando = false;

  void _PredecirGenero() async {
    if (_nameController.text.isEmpty) return;
    
    setState(() {
      _estaCargando = true;
    });

    try {
      final result = await ApiServicio.predecirGenero(_nameController.text);
      setState(() {
        _genero = result['gender'] ?? 'DESCONOCIDO';
        _probabilidad = (result['probabilidad'] ?? 0.0).toDouble();
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
    Color backgroundColor = Colors.grey;
    if (_genero == 'male') {
      backgroundColor = Colors.blue;
    } else if (_genero == 'female') {
      backgroundColor = Colors.pink;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictor de Género'),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ingresa un nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _estaCargando ? null : _PredecirGenero,
              child: _estaCargando 
                  ? const CircularProgressIndicator()
                  : const Text('Predecir Género'),
            ),
            const SizedBox(height: 20),
            if (_genero.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Género: ${_genero == 'male' ? 'Masculino' : 'Femenino'}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Probabilidad: ${(_probabilidad * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 16),
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