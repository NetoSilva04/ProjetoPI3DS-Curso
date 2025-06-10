import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DesenvolvimentoPage extends StatefulWidget {
  const DesenvolvimentoPage({super.key});

  @override
  State<DesenvolvimentoPage> createState() => _DesenvolvimentoPageState();
}

class _DesenvolvimentoPageState extends State<DesenvolvimentoPage> {
  final String videoURL = 'https://youtu.be/tDwcYr_-j0g?si=Z9A2W_wH8uwX9H2k';
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

  Widget _contentCard(String titulo, String descricao) {
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
                'Videoaula: Como fazer a conclusão da redação',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double maxWidth = width > 650 ? 600 : width;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: maxWidth,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: YoutubePlayerScaffold(
                        controller: _controller,
                        builder: (context, player) => player,
                      ),
                    ),
                  ),
                ),
              );
            },
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
        title: const Text(
          'DESENVOLVIMENTO DA REDAÇÃO',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFB19CD9),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _contentCard(
            'O que é o desenvolvimento?',
            'É a parte central da redação. Aqui você deve apresentar e argumentar sobre os pontos de vista relacionados ao tema proposto.',
          ),
          _contentCard(
            'O que deve conter?',
            'Deve conter argumentos bem fundamentados, uso de repertório sociocultural, dados e exemplos que sustentem a tese apresentada na introdução.',
          ),
          _contentCard(
            'Como organizar os parágrafos?',
            'Cada parágrafo deve tratar de um argumento específico. Use conectivos para garantir coesão e coerência. Ex: "Em primeiro lugar", "Além disso", "Por outro lado".',
          ),
          _contentCard(
            'Por que ter dois parágrafos de desenvolvimento?',
            'Ter dois parágrafos permite aprofundar melhor o tema com dois argumentos distintos. Isso demonstra domínio do conteúdo, articulação de ideias e garante maior pontuação nas competências do ENEM.',
          ),
          _contentCard(
            'Desenvolvimento 1: primeiro argumento',
            'No primeiro parágrafo de desenvolvimento, apresente seu argumento principal. Justifique com fatos, dados, citações ou contextos históricos. Construa uma ideia sólida e bem conectada com a tese.',
          ),
          _contentCard(
            'Desenvolvimento 2: contraponto ou segundo argumento',
            'No segundo parágrafo, você pode reforçar sua tese com outro argumento ou apresentar um contraponto, desde que o refute de forma crítica. Isso demonstra repertório e pensamento analítico.',
          ),
          _videoCard(),
        ],
      ),
    );
  }
}
