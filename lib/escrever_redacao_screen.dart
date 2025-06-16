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
  bool _isLoading = false;

  void _exibirTextoMotivador(
      BuildContext context, String titulo, String conteudo) {
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
    if (texto.isEmpty) return 0;
    return texto.split('\n').length;
  }

  Future<void> _enviarRedacao() async {
    final texto = _controller.text.trim();
    final caracteres = texto.length;
    final linhasTotais = _contarLinhas();

    if (linhasTotais < 7 || caracteres < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('A redação deve ter no mínimo 7 linhas e 300 caracteres.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Redação enviada com sucesso!')),
    );
    Navigator.of(context).pop();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: const Text('Escrever Redação'),
        backgroundColor: const Color(0xFFB19CD9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tema: ${widget.tema}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                maxLines: 15,
                decoration: const InputDecoration(
                  labelText: 'Escreva sua redação aqui',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  hintText: 'Comece a digitar...',
                ),
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              ...widget.textosMotivadores.map(
                (texto) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _exibirTextoMotivador(
                          context,
                          texto.titulo,
                          texto.conteudo,
                        );
                      },
                      child: Text('Ver ${texto.titulo}'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  onPressed: _isLoading ? null : _enviarRedacao,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  label: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 3),
                        )
                      : const Text(
                          'Enviar Redação',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}