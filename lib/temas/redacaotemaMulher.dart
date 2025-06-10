import 'package:flutter/material.dart';
import 'package:projetopi/escrever_redacao_screen.dart';
import '/materiais/texto_motivador_widget.dart';

class TextoMotivador {
  final String titulo;
  final String conteudo;

  TextoMotivador({required this.titulo, required this.conteudo});
}

class RedacaoTemaMulher extends StatelessWidget {
  const RedacaoTemaMulher({super.key});

  @override
  Widget build(BuildContext context) {
    List<TextoMotivador> textosMotivadores = [
      TextoMotivador(
        titulo: 'Texto 01',
        conteudo:
            'É fato que as conquistas femininas ao longo dos anos surgiram como um protesto de igualdade nas relações trabalhistas, familiares e sociais. Hoje, é possível observar a inserção feminina nos mais diversos setores da sociedade, incluindo os espaços de poder e decisão.\n\nFonte: https://www.jusbrasil.com.br/artigos/o-papel-da-mulher-na-sociedade-contemporanea/859757616',
      ),
      TextoMotivador(
        titulo: 'Texto 02',
        conteudo:
            'A importância da mulher na sociedade contemporânea é vista na imensidão de campos sociais onde elas atuam com protagonismo. Esses espaços são enriquecidos por sua diversidade e pela luta contínua por equidade de gênero.',
      ),
      TextoMotivador(
        titulo: 'Texto 03',
        conteudo:
            'Além disso, a luta das mulheres por direitos igualitários fortaleceu políticas públicas e avanços legislativos. Contudo, ainda existem desafios como a desigualdade salarial, a violência de gênero e a sub-representação política.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('A mulher e a sociedade contemporânea'),
        backgroundColor: const Color(0xFFB19CD9),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              color: Colors.deepPurple.shade50,
              padding: const EdgeInsets.all(12),
              child: const Text(
                'Tema: A mulher e a sociedade contemporânea',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A redação deve ser dissertativo-argumentativa e abordar as questões sociais, históricas e culturais que envolvem o papel da mulher na sociedade atual.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            const Text(
              'INSTRUÇÕES PARA REDAÇÃO',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              '''
• A redação deve ter no máximo 30 linhas.\n
• O texto deve ser escrito em prosa, do tipo dissertativo-argumentativa.\n
• Cópias dos textos motivadores serão desconsideradas.\n
• Será atribuída nota zero à redação que:\n
  - Apresentar menos de 8 linhas;\n
  - Fugir ao tema proposto;\n
  - Desrespeitar os direitos humanos;\n
  - Não apresentar estrutura dissertativa-argumentativa.\n
''',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              'Textos motivadores',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 16),
            // Exibindo os textos motivadores
            ...textosMotivadores.map((texto) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextoMotivadorWidget(
                  titulo: texto.titulo,
                  conteudo: texto.conteudo,
                ),
              );
            }).toList(),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EscreverRedacaoPage(
                        tema: "A mulher e a sociedade contemporânea",
                        textosMotivadores: textosMotivadores,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Escrever Redação',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
