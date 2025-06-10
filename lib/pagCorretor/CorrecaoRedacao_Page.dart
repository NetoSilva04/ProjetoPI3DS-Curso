import 'package:flutter/material.dart';
import 'painel_revisao_page.dart';

class CorrecaoRedacaoPage extends StatefulWidget {
  final String aluno;
  final String tema;
  final String data;
  final String texto;

  const CorrecaoRedacaoPage({
    super.key,
    required this.aluno,
    required this.tema,
    required this.data,
    required this.texto,
  });

  @override
  State<CorrecaoRedacaoPage> createState() => _CorrecaoRedacaoPageState();
}

class _CorrecaoRedacaoPageState extends State<CorrecaoRedacaoPage> {
  final TextEditingController notaClarezaController = TextEditingController();
  final TextEditingController notaArgumentacaoController = TextEditingController();
  final TextEditingController notaCoerenciaController = TextEditingController();
  final TextEditingController notaEstruturaController = TextEditingController();
  final TextEditingController notaGramaticaController = TextEditingController();
  final TextEditingController notaTotalController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();

  final List<Map<String, dynamic>> marcadores = [];
  String? textoSelecionado;
  Color corSelecionada = Colors.red;

  void _calcularNotaTotal() {
    double clareza = double.tryParse(notaClarezaController.text) ?? 0;
    double argumentacao = double.tryParse(notaArgumentacaoController.text) ?? 0;
    double coerencia = double.tryParse(notaCoerenciaController.text) ?? 0;
    double estrutura = double.tryParse(notaEstruturaController.text) ?? 0;
    double gramatica = double.tryParse(notaGramaticaController.text) ?? 0;

    clareza = clareza.clamp(0, 200);
    argumentacao = argumentacao.clamp(0, 200);
    coerencia = coerencia.clamp(0, 200);
    estrutura = estrutura.clamp(0, 200);
    gramatica = gramatica.clamp(0, 200);

    final total = clareza + argumentacao + coerencia + estrutura + gramatica;

    setState(() {
      notaTotalController.text = total.toStringAsFixed(0);
    });
  }

  void _adicionarMarcador(Color cor, String comentario) {
    String corNome;
    if (cor == Colors.red) {
      corNome = 'red';
    } else if (cor == Colors.green) {
      corNome = 'green';
    } else {
      corNome = 'blue';
    }

    if (textoSelecionado != null && comentario.isNotEmpty) {
      setState(() {
        marcadores.add({
          'texto': textoSelecionado!,
          'cor': corNome,
          'comentario': comentario,
        });
      });
      comentarioController.clear();
      textoSelecionado = null;
    }
  }

  void _enviarCorrecao() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PainelRevisaoPage(
          aluno: widget.aluno,
          tema: widget.tema,
          texto: widget.texto,
          notaFinal: notaTotalController.text,
          comentarios: marcadores,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Correção da Redação'),
        backgroundColor: const Color(0xFFB39DDB),
      ),
      backgroundColor: const Color(0xFFEDE7F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info('Aluno', widget.aluno),
            _info('Tema', widget.tema),
            _info('Data de envio', widget.data),
            const SizedBox(height: 16),
            const Text(
              'Texto da Redação:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                widget.texto,
                style: const TextStyle(fontSize: 16),
                onSelectionChanged: (selection, cause) {
                  setState(() {
                    textoSelecionado = widget.texto.substring(
                      selection.baseOffset,
                      selection.extentOffset,
                    );
                    comentarioController.text = "Comentando sobre: \"$textoSelecionado\"";
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            if (textoSelecionado != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Comentário para o Trecho Selecionado:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: comentarioController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Comentário',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _colorPickerButton(Colors.red, 'Vermelho'),
                  _colorPickerButton(Colors.green, 'Verde'),
                  _colorPickerButton(Colors.blue, 'Azul'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _adicionarMarcador(corSelecionada, comentarioController.text);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  child: const Text('Adicionar Comentário'),
                ),
              ),
            ],
            const SizedBox(height: 24),
            _competenciaInput('Competência 1: Clareza', 'Avalie a clareza e objetividade do texto', notaClarezaController),
            const SizedBox(height: 16),
            _competenciaInput('Competência 2: Argumentação', 'Avalie a consistência e solidez dos argumentos', notaArgumentacaoController),
            const SizedBox(height: 16),
            _competenciaInput('Competência 3: Coerência', 'Avalie a organização lógica das ideias', notaCoerenciaController),
            const SizedBox(height: 16),
            _competenciaInput('Competência 4: Estrutura', 'Avalie a introdução, desenvolvimento e conclusão do texto', notaEstruturaController),
            const SizedBox(height: 16),
            _competenciaInput('Competência 5: Gramática', 'Avalie a correção gramatical e ortográfica', notaGramaticaController),
            const SizedBox(height: 16),
            const Text(
              'Nota Total (Soma das competências)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: notaTotalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nota Total',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              readOnly: true,
            ),
            const SizedBox(height: 24),
            if (marcadores.isNotEmpty) ...[
              const Text(
                'Comentários adicionados:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
              ),
              const SizedBox(height: 8),
              for (var marcador in marcadores) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: marcador['cor'] == 'red'
                        ? Colors.red.withOpacity(0.2)
                        : marcador['cor'] == 'green'
                            ? Colors.green.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Texto Selecionado: "${marcador['texto']}"',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Comentário: ${marcador['comentario']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Enviar Correção'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF512DA8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _enviarCorrecao,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _competenciaInput(String titulo, String descricao, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
        ),
        const SizedBox(height: 8),
        Text(
          descricao,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Nota (0 a 200)',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (_) {
            _calcularNotaTotal();
          },
        ),
      ],
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _colorPickerButton(Color color, String nomeCor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          corSelecionada = color;
        });
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 8),
          Text(nomeCor),
        ],
      ),
    );
  }
}
