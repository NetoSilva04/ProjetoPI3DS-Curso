import 'package:flutter/material.dart';
import 'correcaoredacao_page.dart'; 

class RedacoesRecebidasPage extends StatelessWidget {
  const RedacoesRecebidasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final List<Map<String, String>> redacoes = [
      {
        'aluno': 'João Silva',
        'tema': 'Desafios da Educação no Brasil',
        'data': '10/05/2025',
        'texto': 'Texto da redação do João sobre os desafios...',
      },
      {
        'aluno': 'Maria Oliveira',
        'tema': 'A influência das redes sociais',
        'data': '09/05/2025',
        'texto': 'Texto da redação da Maria sobre redes sociais...',
      },
      {
        'aluno': 'Lucas Santos',
        'tema': 'Violência urbana e suas causas',
        'data': '08/05/2025',
        'texto': 'Texto da redação do Lucas sobre violência urbana...',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Redações Recebidas'),
        backgroundColor: const Color(0xFFB39DDB),
      ),
      backgroundColor: const Color(0xFFEDE7F6),
      body: ListView.builder(
        itemCount: redacoes.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final redacao = redacoes[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(redacao['tema'] ?? ''),
              subtitle: Text('Aluno: ${redacao['aluno']}\nData: ${redacao['data']}'),
              isThreeLine: true,
              leading: const Icon(Icons.description, color: Color(0xFF7E57C2)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, 
                  foregroundColor: Color(0xFF512DA8), 
                  side: const BorderSide(color: Color(0xFF512DA8)), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CorrecaoRedacaoPage(
                        aluno: redacao['aluno']!,
                        tema: redacao['tema']!,
                        data: redacao['data']!,
                        texto: redacao['texto']!, 
                      ),
                    ),
                  );
                },
                child: const Text('Corrigir'),
              ),
            ),
          );
        },
      ),
    );
  }
}
