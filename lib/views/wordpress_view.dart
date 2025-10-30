import 'package:flutter/material.dart';
import '../services/api_servicio.dart';
import '../models/wordpress_model.dart';

class WordPressNewsView extends StatefulWidget {
  const WordPressNewsView({super.key});

  @override
  _WordPressNewsViewState createState() => _WordPressNewsViewState();
}

class _WordPressNewsViewState extends State<WordPressNewsView> {
  List<WordPress> _news = [];
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  void _loadNews() async {
    setState(() {
      _cargando = true;
    });

    try {
      final news = await ApiServicio.getWordPress();
      setState(() {
        _news = news;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias de WordPress'),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                final newsItem = _news[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (newsItem.imageUrl.isNotEmpty)
                          Image.network(newsItem.imageUrl),
                        const SizedBox(height: 10),
                        Text(
                          newsItem.titulo,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(newsItem.summary),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                           
                          },
                          child: const Text('Visitar Noticia'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}