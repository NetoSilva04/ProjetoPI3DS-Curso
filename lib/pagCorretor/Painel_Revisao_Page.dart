import 'package:flutter/material.dart';
import 'package:projetopi/pagCorretor/correcaoredacao_page.dart';
import 'package:intl/intl.dart';

class PainelRevisaoPage extends StatefulWidget {
  final String aluno;
  final String tema;
  final String texto;
  final String notaFinal;
  final List<Map<String, dynamic>> comentarios;

  const PainelRevisaoPage({
    super.key,
    
    required this.aluno,
    required this.tema,
    required this.texto,
    required this.notaFinal,
    required this.comentarios,
  });

  @override
  PainelRevisaoPageState createState() => PainelRevisaoPageState();
}

class PainelRevisaoPageState extends State<PainelRevisaoPage> {
  bool emRevisao = false;


void _marcarEmRevisao() {
  setState(() {
    emRevisao = true;
  });

  final dataFormatada = DateFormat('dd/MM/yyyy').format(DateTime.now());

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CorrecaoRedacaoPage(
        aluno: widget.aluno,
        tema: widget.tema,
        data: dataFormatada,
        texto: widget.texto,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Revisão'),
        backgroundColor: const Color(0xFFB39DDB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Aluno: ${widget.aluno}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Tema: ${widget.tema}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Texto da Redação:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(widget.texto, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            const Text('Comentários do Corretor:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (var item in widget.comentarios)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(
                      color: item['cor'] == 'red'
                          ? Colors.red
                          : item['cor'] == 'green'
                              ? Colors.green
                              : Colors.blue,
                      width: 5,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trecho: "${item['texto']}"', style: const TextStyle(fontStyle: FontStyle.italic)),
                    const SizedBox(height: 4),
                    Text('Comentário: ${item['comentario']}'),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            Text('Nota Final: ${widget.notaFinal}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text('Enviar para o Aluno'),
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF512DA8),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              icon: const Icon(Icons.hourglass_empty),
              label: const Text('Marcar como Em Revisão'),
              onPressed: _marcarEmRevisao,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            if (emRevisao) ...[
              const Text(
                'Status: Em Revisão',
                style: TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
