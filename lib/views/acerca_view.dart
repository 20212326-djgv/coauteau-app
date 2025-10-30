//David Josue Guzman Vizcaino #2021-2326
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/imagenes/yo.png'),
              ),
              const SizedBox(height: 20),
              const Text(
                'David Josue Guzman Vizcaino',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Desarrollador Flutter',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('20212326@itla.edu.do'),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('+1 829-369-5519'),
                      ),
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text('https://github.com/20212326-djgv'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}