import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ConceitosBasicosPage extends StatefulWidget {
  const ConceitosBasicosPage({super.key});

  @override
  State<ConceitosBasicosPage> createState() => _ConceitosBasicosPageState();
}

class _ConceitosBasicosPageState extends State<ConceitosBasicosPage> {
  final String videoURL = 'https://youtu.be/MeKHJVPNV30?si=Ot7fQQeTTCl2udTr';
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
                'Videoaula: Fundamentos da Redação do ENEM',
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
          'CONCEITOS BÁSICOS DA REDAÇÃO',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB19CD9),
      ),
      body: ListView(
        children: [
          _contentCard(
            'O que é uma redação dissertativa-argumentativa?',
            'É um tipo de texto que apresenta uma tese (opinião sobre um tema) e desenvolve argumentos para defendê-la de forma lógica, coesa e coerente.',
          ),
          _contentCard(
            'Quais são as partes da redação?',
            'A redação é composta por introdução, desenvolvimento (1 e 2) e conclusão. Cada parte tem uma função específica e deve estar bem conectada à tese central.',
          ),
          _contentCard(
            'Competências avaliadas no ENEM',
            'São cinco competências que avaliam desde o domínio da norma culta, a estrutura do texto, até a proposta de intervenção para o problema apresentado.',
          ),
          _contentCard(
            'Dicas essenciais para uma boa redação',
            '1. Leia e compreenda o tema.\n2. Planeje antes de escrever.\n3. Use conectivos.\n4. Evite repetições e fuja do senso comum.\n5. Revise sua redação antes de entregar.',
          ),
          _videoCard(),
        ],
      ),
    );
  }
}
