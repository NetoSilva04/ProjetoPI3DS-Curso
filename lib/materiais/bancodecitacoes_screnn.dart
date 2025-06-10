import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CitacoesPage extends StatefulWidget {
  const CitacoesPage({super.key});

  @override
  State<CitacoesPage> createState() => _CitacoesPageState();
}

class _CitacoesPageState extends State<CitacoesPage> {
  final String videoURL = 'https://youtu.be/0RchrACkIPs?si=ON57HIe3rUh3zYzu';
  late YoutubePlayerController _controller;

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

  Widget _citacaoCard(String autor, String citacao, String aplicacao) {
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
                autor,
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
                  '“$citacao”',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10),
                Text(
                  'Aplicação: $aplicacao',
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

  Widget _buildYoutubePlayer() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = 600;
        double width = constraints.maxWidth > maxWidth ? maxWidth : constraints.maxWidth;

        return Center(
          child: SizedBox(
            width: width,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayerScaffold(
                controller: _controller,
                builder: (context, player) => player,
              ),
            ),
          ),
        );
      },
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
                'Videoaula: Como usar citações na redação',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: _buildYoutubePlayer(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'BANCO DE CITAÇÕES',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFB19CD9),
      ),
      body: ListView(
        children: [
          _videoCard(),
          _citacaoCard('Nelson Mandela', 'A educação é a arma mais poderosa que você pode usar para mudar o mundo.', 'Temas sobre educação e transformação social.'),
          _citacaoCard('Francis Bacon', 'Conhecimento é poder.', 'Temas sobre informação, tecnologia e educação.'),
          _citacaoCard('Nise da Silveira', 'Não se curem além da conta. Gente curada demais é gente chata.', 'Saúde mental e humanização dos tratamentos.'),
          _citacaoCard('Zygmunt Bauman', 'As redes sociais são uma armadilha.', 'Temas sobre saúde mental, redes sociais e relações humanas.'),
          _citacaoCard('Emmanuel Macron', 'Estamos perdendo a corrida para as mudanças climáticas.', 'Temas ambientais e sustentabilidade.'),
          _citacaoCard('Garrett Hardin', 'A liberdade é o reconhecimento da necessidade.', 'Discussão sobre regulação de recursos naturais.'),
          _citacaoCard('Declaração Universal dos Direitos Humanos', 'Todos os seres humanos nascem livres e iguais em dignidade e em direitos.', 'Temas de direitos civis, igualdade e justiça.'),
          _citacaoCard('Martin Luther King Jr.', 'A injustiça num lugar qualquer é uma ameaça à justiça em todo lugar.', 'Movimentos sociais e combate à desigualdade.'),
          _citacaoCard('Jean-Jacques Rousseau', 'O homem nasce livre, mas por toda parte encontra-se acorrentado.', 'Temas sobre liberdade e participação cidadã.'),
          _citacaoCard('Simone de Beauvoir', 'Não se nasce mulher: torna-se.', 'Feminismo e construção social de gênero.'),
          _citacaoCard('George Orwell', 'A linguagem política é projetada para fazer mentiras soarem verdadeiras.', 'Manipulação midiática e fake news.'),
          _citacaoCard('Leonardo DiCaprio', 'A mudança climática é real. É a ameaça mais urgente.', 'Responsabilidade ambiental e conscientização.'),
          _citacaoCard('Albert Einstein', 'O mundo é um lugar perigoso, não por causa dos maus, mas por causa dos que veem e não fazem nada.', 'Cidadania e responsabilidade coletiva.'),
          _citacaoCard('Bertolt Brecht', 'Nada deve parecer natural. Nada deve parecer impossível de mudar.', 'Crítica social e transformação.'),
          _citacaoCard('Cora Coralina', 'Feliz aquele que transfere o que sabe e aprende o que ensina.', 'Educação e valorização do conhecimento popular.'),
        ],
      ),
    );
  }
}
