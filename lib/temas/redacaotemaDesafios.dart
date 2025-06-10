import 'package:flutter/material.dart';
import 'package:projetopi/escrever_redacao_screen.dart';
import 'package:projetopi/temas/redacaotemaMulher.dart';
import '/materiais/texto_motivador_widget.dart';

class RedacaoTemaDesafiosPage extends StatelessWidget {
  const RedacaoTemaDesafiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<TextoMotivador> textosMotivadores = [
      TextoMotivador(
        titulo: 'Texto 01',
        conteudo:
            'As comunidades tradicionais, como quilombolas, indígenas, ribeirinhos e caiçaras, desempenham um papel fundamental na preservação ambiental e na diversidade cultural do Brasil. No entanto, muitas dessas comunidades enfrentam desafios relacionados ao reconhecimento de seus direitos, acesso a políticas públicas e valorização de seus modos de vida.',
      ),
      TextoMotivador(
        titulo: 'Texto 02',
        conteudo:
            'Segundo relatório do Instituto Socioambiental (ISA), a falta de demarcação de territórios tradicionais e o avanço de atividades econômicas, como mineração e agronegócio, ameaçam a sobrevivência dessas comunidades. Além disso, o preconceito e a invisibilidade social dificultam o fortalecimento das identidades coletivas desses povos.',
      ),
      TextoMotivador(
        titulo: 'Texto 03',
        conteudo:
            'Apesar dos obstáculos, diversas organizações sociais e lideranças comunitárias têm buscado estratégias para promover a valorização e o protagonismo dos povos tradicionais. Isso inclui ações de educação intercultural, produção agrícola sustentável e mobilização política para garantir direitos constitucionais e respeito às tradições culturais.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('Desafios para a valorização de comunidades e povos tradicionais no Brasil'),
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
                'Tema: Desafios para a valorização de comunidades e povos tradicionais no Brasil',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A proposta de redação solicita uma reflexão crítica sobre os obstáculos enfrentados pelas comunidades e povos tradicionais no Brasil. É essencial abordar questões relacionadas à cultura, ao território, aos direitos sociais e à identidade, além de propor soluções viáveis para promover sua valorização e inclusão social.',
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
                        tema: 'Desafios para a valorização de comunidades e povos tradicionais no Brasil',
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
