import 'package:flutter/material.dart';
import 'package:projetopi/escrever_redacao_screen.dart';
import 'package:projetopi/temas/redacaotemaMulher.dart';
import '/materiais/texto_motivador_widget.dart';

class RedacaoTemaEticaPage extends StatelessWidget {
  const RedacaoTemaEticaPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<TextoMotivador> textosMotivadores = [
      TextoMotivador(
        titulo: 'Texto 01',
        conteudo:
            'A ética no serviço público é essencial para garantir a integridade, a transparência e a confiança da população nas instituições governamentais. A atuação de servidores públicos deve sempre priorizar o bem comum, a justiça social e o respeito às leis e à moralidade administrativa.',
      ),
      TextoMotivador(
        titulo: 'Texto 02',
        conteudo:
            'Casos de corrupção, desvio de verbas e favorecimento político enfraquecem a credibilidade do poder público. A ausência de ética no serviço público compromete não apenas a eficiência da máquina estatal, mas também o acesso da população a direitos básicos, como saúde, educação e segurança.',
      ),
      TextoMotivador(
        titulo: 'Texto 03',
        conteudo:
            'A promoção da ética no serviço público envolve não apenas o cumprimento de códigos de conduta, mas também o incentivo à formação cidadã dos servidores. Programas de capacitação e mecanismos de controle social são fundamentais para fortalecer uma cultura ética dentro da administração pública.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('O papel da ética no serviço público brasileiro'),
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
                'Tema: O papel da ética no serviço público brasileiro',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A proposta de redação solicita uma reflexão sobre a importância da ética no serviço público brasileiro. É fundamental discutir as causas e consequências da conduta antiética de agentes públicos e propor caminhos para fortalecer a responsabilidade e o compromisso com o interesse coletivo.',
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
                        tema: 'O papel da ética no serviço público brasileiro',
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
