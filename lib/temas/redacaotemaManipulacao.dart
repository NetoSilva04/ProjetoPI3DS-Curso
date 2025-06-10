import 'package:flutter/material.dart';
import 'package:projetopi/escrever_redacao_screen.dart';
import 'package:projetopi/temas/redacaotemaMulher.dart';
import '/materiais/texto_motivador_widget.dart';

class RedacaoTemaManipulacaoPage extends StatelessWidget {
  const RedacaoTemaManipulacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<TextoMotivador> textosMotivadores = [
      TextoMotivador(
        titulo: 'Texto 01',
        conteudo:
            'A manipulação do comportamento do usuário por meio do controle de dados pessoais na internet é um fenômeno crescente. A coleta massiva de informações sobre os hábitos online dos usuários permite que empresas e governos influenciem escolhas pessoais, como decisões de compra e até mesmo posicionamentos políticos. O uso indevido de dados pode gerar uma distorção da liberdade de escolha, onde o usuário passa a ser moldado por algoritmos e campanhas direcionadas.',
      ),
      TextoMotivador(
        titulo: 'Texto 02',
        conteudo:
            'Com o advento das redes sociais e das plataformas digitais, o comportamento dos indivíduos está cada vez mais vulnerável ao controle por parte de grandes corporações. A personalização de anúncios e conteúdos, alimentada pela coleta de dados, pode ter um impacto profundo sobre a forma como os indivíduos pensam e agem, criando bolhas informativas e manipulando opiniões.',
      ),
      TextoMotivador(
        titulo: 'Texto 03',
        conteudo:
            'Além disso, a manipulação de dados não se limita ao marketing, mas também afeta a política e as questões sociais. Casos como o uso de dados pessoais em campanhas eleitorais demonstram como o controle das informações pode ser usado para influenciar o comportamento dos eleitores, colocando em risco a integridade de processos democráticos.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('Manipulação do comportamento do usuário pelo controle de dados na internet'),
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
                'Tema: Manipulação do comportamento do usuário pelo controle de dados na internet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A redação deve ser dissertativo-argumentativa e abordar as questões relacionadas ao controle de dados pessoais, a manipulação do comportamento dos usuários e as consequências dessa prática para a sociedade. Você deve refletir sobre os impactos éticos, sociais e econômicos dessa realidade no mundo digital.',
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
                        tema: "Manipulação do comportamento do usuário pelo controle de dados na internet",
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
