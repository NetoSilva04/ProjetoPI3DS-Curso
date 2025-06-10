import 'package:flutter/material.dart';

class CompetenciasPage extends StatefulWidget {
  const CompetenciasPage({super.key});

  @override
  State<CompetenciasPage> createState() => _CompetenciasPageState();
}

class _CompetenciasPageState extends State<CompetenciasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'COMPETÊNCIAS DO ENEM',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        backgroundColor: const Color(0xFFB19CD9),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _competenciaCard(
            'Competência 1: Demonstrar domínio da norma culta da língua escrita',
            'O candidato deve demonstrar seu domínio da norma culta da língua escrita, utilizando-a de forma correta e adequada, sem cometer erros gramaticais ou ortográficos. Isso inclui a utilização correta da pontuação, concordância verbal e nominal, além de uma boa estruturação das frases.',
          ),
          _competenciaCard(
            'Competência 2: Compreender a proposta de redação e aplicar os conceitos de acordo com a necessidade',
            'Nesta competência, o candidato deve ser capaz de compreender a proposta de redação, reconhecendo a necessidade de um texto dissertativo-argumentativo. Isso envolve entender o tema, identificar os textos motivadores e aplicar os conhecimentos adquiridos para desenvolver a redação de forma coerente.',
          ),
          _competenciaCard(
            'Competência 3: Selecionar, organizar, relacionar, argumentar e finalizar com clareza',
            'A competência exige que o candidato saiba selecionar e organizar as ideias de forma lógica e coesa. O texto precisa ter uma introdução clara, desenvolvimento bem estruturado, argumentos pertinentes e uma conclusão que sintetize as ideias de maneira objetiva e convincente.',
          ),
          _competenciaCard(
            'Competência 4: Demonstrar conhecimento dos mecanismos de coesão e coerência textual',
            'É fundamental que o candidato utilize os mecanismos de coesão textual, como pronomes, conjunções, advérbios, entre outros, para garantir que o texto tenha fluidez e lógica. A coerência textual se refere à capacidade de manter um raciocínio contínuo e consistente ao longo do desenvolvimento do texto.',
          ),
          _competenciaCard(
            'Competência 5: Demonstrar domínio da linguagem argumentativa',
            'O candidato deve ser capaz de apresentar argumentos sólidos, bem fundamentados e desenvolvidos. O uso de exemplos concretos e de fontes confiáveis é essencial para convencer o leitor sobre a validade das ideias apresentadas. Além disso, o texto deve ser persuasivo e ter uma estrutura argumentativa consistente.',
          ),
        ],
      ),
    );
  }

  Widget _competenciaCard(String titulo, String descricao) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFB19CD9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              descricao,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
