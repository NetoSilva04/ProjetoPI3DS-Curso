import 'package:flutter/material.dart';
import 'package:projetopi/escrever_redacao_screen.dart';
import 'package:projetopi/temas/redacaotemaMulher.dart';
import '/materiais/texto_motivador_widget.dart';

class RedacaoTemaMundoForaOrdemPage extends StatelessWidget {
  const RedacaoTemaMundoForaOrdemPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<TextoMotivador> textosMotivadores = [
      TextoMotivador(
        titulo: 'Texto 01',
        conteudo:
            'A frase “O mundo contemporâneo está fora da ordem” sugere um cenário de crise global. Desigualdades sociais crescentes, conflitos armados, mudanças climáticas e a instabilidade política em diversas regiões são alguns dos fatores que evidenciam a sensação de desordem e insegurança na atualidade.',
      ),
      TextoMotivador(
        titulo: 'Texto 02',
        conteudo:
            'Segundo o filósofo polonês Zygmunt Bauman, vivemos em uma modernidade líquida, onde os laços sociais são frágeis e as instituições perdem sua capacidade de oferecer estabilidade. Isso contribui para o sentimento de caos e a perda de referências no mundo contemporâneo.',
      ),
      TextoMotivador(
        titulo: 'Texto 03',
        conteudo:
            'Os avanços tecnológicos e a globalização trouxeram benefícios, mas também ampliaram desigualdades e desafios éticos. A disseminação de informações falsas, o individualismo exacerbado e a crise de valores afetam o convívio coletivo e agravam a sensação de desordem social.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('O mundo contemporâneo está fora da ordem'),
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
                'Tema: O mundo contemporâneo está fora da ordem',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A redação deve refletir criticamente sobre os elementos que tornam o mundo atual caótico ou desorganizado. É necessário analisar as causas dessa desordem e discutir possíveis caminhos para restaurar o equilíbrio social, ambiental e ético em escala local e global.',
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
            ...textosMotivadores.map((texto) {
              return TextoMotivadorWidget(
                titulo: texto.titulo,
                conteudo: texto.conteudo,
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
                        tema: 'O mundo contemporâneo está fora da ordem',
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
