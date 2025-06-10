import 'package:flutter/material.dart';

class RedacoesCorrigidasPage extends StatelessWidget {
  const RedacoesCorrigidasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB39DDB),
        title: const Text('Redações Corrigidas'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lista de Redações Corrigidas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF512DA8),
                ),
              ),
              const SizedBox(height: 16),
              _buildListaRedacoesCorrigidas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListaRedacoesCorrigidas() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 0, 
      itemBuilder: (context, index) {
        return const SizedBox(); 
      },
    );
  }
}
