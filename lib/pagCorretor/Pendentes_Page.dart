import 'package:flutter/material.dart';

class PendentesPage extends StatelessWidget {
  const PendentesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB39DDB),
        title: const Text('Redações Pendentes'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Conteúdo da página Pendentes estará aqui.',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      ),
    );
  }
}
