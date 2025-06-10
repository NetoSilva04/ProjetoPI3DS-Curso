import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final String videoURL = 'https://youtu.be/WfP2bl5xb5E?si=pbTJ2_zrXbLSTcJq';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoID = YoutubePlayerController.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    if (videoID != null) {
      _controller.cueVideoById(videoId: videoID);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Widget _introCard(String titulo, String descricao) {
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
                'Videoaula: Como fazer a introdução da redação',
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'INTRODUÇÃO DA REDAÇÃO',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        backgroundColor: const Color(0xFFB19CD9),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _introCard(
            'O que é a introdução da redação?',
            'A introdução é a primeira parte da redação. Nela, o candidato deve apresentar o tema de forma clara e objetiva, introduzindo o assunto que será discutido ao longo do texto.',
          ),
          _introCard(
            'O que deve conter na introdução?',
            'Ela deve conter: contextualização, problematização e tese. Isso ajuda a guiar o texto com coerência e foco.',
          ),
          _introCard(
            'Como começar uma introdução?',
            'Use citações, dados, fatos históricos ou perguntas retóricas. Exemplo: "Apesar dos avanços sociais, o preconceito ainda é um desafio no Brasil atual."',
          ),
          _videoCard(),
        ],
      ),
    );
  }
}
