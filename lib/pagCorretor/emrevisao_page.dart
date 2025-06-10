import 'package:flutter/material.dart';

class EmRevisaoPage extends StatelessWidget {
  const EmRevisaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB39DDB),
        title: const Text('Redações em Revisão'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Aqui estão as redações que estão em revisão:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF512DA8),
                ),
              ),
              const SizedBox(height: 24),
              _buildRedacoesEmRevisao(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRedacoesEmRevisao() {
    final List<String> redacoes = []; 

    if (redacoes.isEmpty) {
      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Nenhuma redação em revisão no momento.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF512DA8),
            ),
          ),
        ),
      );
    } else {
      
      return Container(); 
    }
  }
}
