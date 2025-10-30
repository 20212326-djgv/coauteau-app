//David Josue Guzman Vizcaino #2021-2326
import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'views/genero_view.dart';
import 'views/edad_view.dart';
import 'views/universidades_view.dart';
import 'views/clima_view.dart';
import 'views/pokemon_view.dart';
import 'views/wordpress_view.dart';
import 'views/acerca_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caja de Herramientas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _views = [
    const HomeView(),
    const PredecirGenero(),
    const AgePredictorView(),
    const UniversitiesView(),
    const Clima(),
    const PokemonView(),
    const WordPressNewsView(),
    const AboutView(),
  ];

  final List<String> _titles = [
    'Inicio',
    'Género',
    'Edad',
    'Universidades',
    'Clima RD',
    'Pokémon',
    'Noticias',
    'Acerca de',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _views[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Género',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Edad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Universidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokémon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Noticias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Acerca de',
          ),
        ],
      ),
    );
  }
}