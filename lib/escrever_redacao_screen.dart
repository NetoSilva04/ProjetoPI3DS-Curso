import 'package:flutter/material.dart';
import 'package:projetopi/temas/redacaotemaMulher.dart';

class EscreverRedacaoPage extends StatefulWidget {
  final String tema;
  final List<TextoMotivador> textosMotivadores;

  const EscreverRedacaoPage({
    super.key,
    required this.tema,
    required this.textosMotivadores,
  });

  @override
  EscreverRedacaoPageState createState() => EscreverRedacaoPageState();
}

class EscreverRedacaoPageState extends State<EscreverRedacaoPage> {
  final TextEditingController _controller = TextEditingController();
  int _caracteresRestantes = 2550;

  void _atualizarContagem() {
    setState(() {
      _caracteresRestantes = 2550 - _controller.text.length;
    });
  }

  void _exibirTextoMotivador(BuildContext context, String titulo, String conteudo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: SingleChildScrollView(
            child: Text(
              conteudo,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  int _contarLinhas() {
    final texto = _controller.text.trim();
    final linhasReais = texto.split('\n').where((linha) => linha.trim().isNotEmpty).length;
    final linhasEstimadas = (texto.length / 87).ceil();
    return linhasReais > linhasEstimadas ? linhasReais : linhasEstimadas;
  }

  void _enviarRedacao() {
    final texto = _controller.text.trim();
    final caracteres = texto.length;
    final linhasTotais = _contarLinhas();

    if (linhasTotais < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A redação deve ter no mínimo 8 linhas.')),
      );
    } else if (caracteres < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A redação deve ter no mínimo 300 caracteres.')),
      );
    } else if (caracteres > 2550) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A redação deve ter no máximo 2550 caracteres.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Redação salva com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('Escrever Redação'),
        backgroundColor: const Color(0xFFB19CD9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: tamanhoTela.height - kToolbarHeight - 32),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Redação ENEM - Tema:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.tema,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'A redação do ENEM exige uma reflexão crítica sobre o tema, com apresentação de uma proposta de intervenção para o problema abordado.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: tamanhoTela.height * 0.35,
                    child: TextField(
                      controller: _controller,
                      onChanged: (_) => _atualizarContagem(),
                      maxLength: 2550,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        labelText: 'Escreva sua redação aqui',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        border: OutlineInputBorder(),
                        hintText: 'Escreva seu texto aqui...',
                        hintStyle: TextStyle(color: Colors.grey),
                        alignLabelWithHint: true,
                      ),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Caracteres restantes: $_caracteresRestantes',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Linhas: ${_contarLinhas()}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ...widget.textosMotivadores.map(
                    (texto) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            _exibirTextoMotivador(
                              context,
                              texto.titulo,
                              texto.conteudo,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size(double.infinity, 40),
                          ),
                          child: Text(
                            'Ver ${texto.titulo}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: _enviarRedacao,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Enviar Redação',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
