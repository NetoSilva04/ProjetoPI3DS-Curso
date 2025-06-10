import 'package:flutter/material.dart';
import 'package:projetopi/escrever_redacao_screen.dart';
import 'package:projetopi/temas/redacaotemaMulher.dart';
import '/materiais/texto_motivador_widget.dart';

class RedacaoTemaViolenciaPage extends StatelessWidget {
  const RedacaoTemaViolenciaPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<TextoMotivador> textosMotivadores = [
      TextoMotivador(
        titulo: 'Texto 01',
        conteudo:
            'A violência contra a mulher no Brasil é um fenômeno multifacetado e persistente, com raízes profundas nas desigualdades de gênero, na cultura machista e na falta de políticas públicas eficazes. O feminicídio, em particular, tem se tornado uma das formas mais extremas dessa violência, onde as mulheres se tornam vítimas de assassinatos motivados por questões de gênero.',
      ),
      TextoMotivador(
        titulo: 'Texto 02',
        conteudo:
            'Em diversos estados do Brasil, as mulheres ainda enfrentam uma realidade alarmante de abuso físico, psicológico e sexual. Além disso, a impunidade e a subnotificação desses casos contribuem para a perpetuação da violência. A construção de uma sociedade mais justa exige a erradicação dessa violência e a implementação de medidas de prevenção e conscientização.',
      ),
      TextoMotivador(
        titulo: 'Texto 03',
        conteudo:
            'Apesar dos avanços em algumas áreas, como a Lei Maria da Penha, a violência contra a mulher continua a ser um grande desafio. As mulheres precisam de mais apoio de políticas públicas que garantam proteção, acesso à justiça e educação para a prevenção desse problema social.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('A persistência da violência contra a mulher na sociedade brasileira'),
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
                'Tema: A persistência da violência contra a mulher na sociedade brasileira',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A redação deve ser dissertativo-argumentativa e abordar as questões sociais, culturais e históricas que envolvem a violência contra a mulher na sociedade brasileira, considerando seus impactos e as possíveis formas de enfrentamento.',
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
                        tema: "A persistência da violência contra a mulher na sociedade brasileira",
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
