import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ReferenciasPage extends StatefulWidget {
  const ReferenciasPage({super.key});

  @override
  State<ReferenciasPage> createState() => _ReferenciasPageState();
}

class _ReferenciasPageState extends State<ReferenciasPage> {
  final String videoURL = 'https://youtu.be/QmwFj5puT-U?si=zy01CuHkRCrpKwgN';
  late YoutubePlayerController _controller;
  String filtroSelecionado = 'Todos';
  String termoBusca = '';

  final List<Map<String, String>> referencias = [
    {'titulo': 'Filme "Clube da Luta"', 'descricao': 'Explora alienação, masculinidade e consumismo.', 'aplicacao': 'Útil para temas sobre identidade, sociedade de consumo e saúde mental.', 'categoria': 'Filme'},
    {'titulo': 'Livro "Ensaio Sobre a Cegueira" - José Saramago', 'descricao': 'Uma epidemia de cegueira branca revela o colapso moral da sociedade.', 'aplicacao': 'Aplicável a temas sobre empatia, ética e comportamento social.', 'categoria': 'Livro'},
    {'titulo': 'Série "Years and Years"', 'descricao': 'Mostra impactos de decisões políticas em uma família ao longo dos anos.', 'aplicacao': 'Temas como política, crise econômica e mudanças sociais.', 'categoria': 'Série'},
    {'titulo': 'Filme "Her" (2013)', 'descricao': 'Homem se apaixona por uma inteligência artificial.', 'aplicacao': 'Temas sobre inteligência artificial, solidão e relações modernas.', 'categoria': 'Filme'},
    {'titulo': 'Livro "Fahrenheit 451" - Ray Bradbury', 'descricao': 'Uma sociedade onde livros são proibidos e queimados.', 'aplicacao': 'Perfeito para temas sobre censura, alienação e liberdade de expressão.', 'categoria': 'Livro'},
    {'titulo': 'Série "Os 13 porquês"', 'descricao': 'Explora bullying, depressão e suicídio entre jovens.', 'aplicacao': 'Temas sobre saúde mental, escola e vulnerabilidade.', 'categoria': 'Série'},
    {'titulo': 'Filme "A Onda" (2008)', 'descricao': 'Professor realiza experimento sobre autoritarismo com alunos.', 'aplicacao': 'Reflete temas de manipulação, obediência e regimes autoritários.', 'categoria': 'Filme'},
    {'titulo': 'Livro "Capitães da Areia" - Jorge Amado', 'descricao': 'Retrata a vida de meninos marginalizados em Salvador.', 'aplicacao': 'Excelente para temas sobre infância, exclusão e desigualdade.', 'categoria': 'Livro'},
    {'titulo': 'Série "Merli"', 'descricao': 'Professor de filosofia usa o pensamento crítico para desafiar seus alunos.', 'aplicacao': 'Temas sobre educação, juventude e pensamento crítico.', 'categoria': 'Série'},
    {'titulo': 'Filme "O Show de Truman"', 'descricao': 'Homem vive sua vida inteira sendo filmado sem saber.', 'aplicacao': 'Discussões sobre privacidade, mídia e liberdade.', 'categoria': 'Filme'},
    {'titulo': 'Série "Black Mirror"', 'descricao': 'A série apresenta críticas às relações humanas mediadas pela tecnologia.', 'aplicacao': 'Pode ser usada em temas sobre tecnologia, redes sociais, privacidade e comportamento social.', 'categoria': 'Série'},
    {'titulo': 'Filme "O Poço" (2019)', 'descricao': 'Uma metáfora sobre desigualdade social e solidariedade em ambientes hierarquizados.', 'aplicacao': 'Aplicável em temas sobre desigualdade, egoísmo e estrutura social.', 'categoria': 'Filme'},
    {'titulo': 'Livro "1984" - George Orwell', 'descricao': 'Retrata um regime totalitário com vigilância constante e manipulação da informação.', 'aplicacao': 'Temas sobre fake news, censura, autoritarismo e controle social.', 'categoria': 'Livro'},
    {'titulo': 'Série "Anne with an E"', 'descricao': 'Mostra temas como preconceito, feminismo e liberdade de expressão.', 'aplicacao': 'Relacionável a temas de inclusão, igualdade de gênero e educação.', 'categoria': 'Série'},
    {'titulo': 'Filme "Estrelas Além do Tempo"', 'descricao': 'Conta a história de mulheres negras cientistas na NASA durante a segregação racial.', 'aplicacao': 'Excelente para temas sobre racismo, empoderamento feminino e meritocracia.', 'categoria': 'Filme'},
    {'titulo': 'Livro "A Revolução dos Bichos" - George Orwell', 'descricao': 'Uma fábula sobre o poder e a corrupção.', 'aplicacao': 'Temas de política, manipulação e estrutura de poder.', 'categoria': 'Livro'},
    {'titulo': 'Série "Euphoria"', 'descricao': 'Explora o impacto das drogas, redes sociais e saúde mental nos jovens.', 'aplicacao': 'Temas como saúde mental, juventude e vulnerabilidade social.', 'categoria': 'Série'},
    {'titulo': 'Filme "O Menino que Descobriu o Vento"', 'descricao': 'História de um jovem que, com criatividade, ajuda sua comunidade.', 'aplicacao': 'Aborda educação, superação e desigualdade regional.', 'categoria': 'Filme'},
    {'titulo': 'Livro "O Pequeno Príncipe" - Antoine de Saint-Exupéry', 'descricao': 'Obra filosófica que aborda temas como empatia, valores e crítica ao mundo adulto.', 'aplicacao': 'Temas de afetividade, sensibilidade, infância e relações humanas.', 'categoria': 'Livro'},
    {'titulo': 'Série "13 Reasons Why"', 'descricao': 'Aborda suicídio, bullying e abandono emocional.', 'aplicacao': 'Temas como saúde mental, bullying e sistema educacional.', 'categoria': 'Série'}
  ];

  List<String> categorias = ['Todos', 'Livro', 'Filme', 'Série'];

  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayerController.convertUrlToId(videoURL);
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoID ?? '',
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Widget _referenciaCard(Map<String, String> ref) {
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
            decoration: const BoxDecoration(
              color: Color(0xFFB19CD9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Text(
                ref['titulo']!,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref['descricao']!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Aplicação: ${ref['aplicacao']}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoCard() {
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
            decoration: const BoxDecoration(
              color: Color(0xFFB19CD9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child: Text(
                'Videoaula: Como usar referências socioculturais',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double maxPlayerWidth = 600;
                double playerWidth = constraints.maxWidth > maxPlayerWidth
                    ? maxPlayerWidth
                    : constraints.maxWidth;
                double playerHeight = playerWidth / (16 / 9);

                return Center(
                  child: SizedBox(
                    width: playerWidth,
                    height: playerHeight,
                    child: YoutubePlayerScaffold(
                      controller: _controller,
                      builder: (context, player) => player,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final referenciasFiltradas = referencias.where((ref) {
      final correspondeCategoria = filtroSelecionado == 'Todos' || ref['categoria'] == filtroSelecionado;
      final correspondeBusca = termoBusca.isEmpty ||
          ref['titulo']!.toLowerCase().contains(termoBusca.toLowerCase()) ||
          ref['descricao']!.toLowerCase().contains(termoBusca.toLowerCase()) ||
          ref['aplicacao']!.toLowerCase().contains(termoBusca.toLowerCase());
      return correspondeCategoria && correspondeBusca;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'BANCO DE REFERÊNCIAS',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFB19CD9),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar por palavra-chave',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (valor) {
                    setState(() {
                      termoBusca = valor;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: filtroSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar por categoria',
                    border: OutlineInputBorder(),
                  ),
                  items: categorias.map((categoria) {
                    return DropdownMenuItem<String>(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() {
                      filtroSelecionado = valor!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _videoCard(),
                ...referenciasFiltradas.map(_referenciaCard).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
