import 'package:flutter/material.dart';
import '../services/api_servicio.dart';

class AgePredictorView extends StatefulWidget {
  const AgePredictorView({super.key});

  @override
  _AgePredictorViewState createState() => _AgePredictorViewState();
}

class _AgePredictorViewState extends State<AgePredictorView> {
  final TextEditingController _nameController = TextEditingController();
  int _age = 0;
  bool _isLoading = false;

  void _predictAge() async {
    if (_nameController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ApiServicio.predecirEdad(_nameController.text);
      setState(() {
        _age = result['edad'] ?? 0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getAgeCategory() {
    if (_age < 30) return 'Joven';
    if (_age < 60) return 'Adulto';
    return 'Anciano';
  }

  String _getAgeImage() {
    if (_age < 30) return 'assets/imagenes/young.png';
    if (_age < 60) return 'assets/imagenes/adult.png';
    return 'assets/imagenes/elderly.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predecir de Edad'),
      ),
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
              onPressed: _isLoading ? null : _predictAge,
              child: _isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('Predecir Edad'),
            ),
            const SizedBox(height: 20),
            if (_age > 0)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.asset(
                        _getAgeImage(),
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Edad: $_age años',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Categoría: ${_getAgeCategory()}',
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