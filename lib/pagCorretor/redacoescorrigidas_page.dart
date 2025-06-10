import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetopi/models/redacao_model.dart';

class RedacoesCorrigidasPage extends StatefulWidget {
  const RedacoesCorrigidasPage({super.key});

  @override
  State<RedacoesCorrigidasPage> createState() => _RedacoesCorrigidasPageState();
}

class _RedacoesCorrigidasPageState extends State<RedacoesCorrigidasPage> {
  final List<Redacao> _todasAsRedacoes = [
    Redacao(aluno: 'Ana Beatriz', tema: 'Impacto das redes sociais na sociedade', dataEnvio: DateTime(2025, 6, 8), status: 'Corrigida', nota: 920),
    Redacao(aluno: 'Carlos Eduardo', tema: 'Desafios da educação a distância', dataEnvio: DateTime(2025, 6, 7), status: 'Corrigida', nota: 880),
    Redacao(aluno: 'Juliana Martins', tema: 'A importância da vacinação em massa', dataEnvio: DateTime(2025, 6, 5), status: 'Corrigida', nota: 960),
    Redacao(aluno: 'Fernando Costa', tema: 'Sustentabilidade e o futuro do planeta', dataEnvio: DateTime(2025, 6, 4), status: 'Corrigida', nota: 780),
  ];

  List<Redacao> _redacoesFiltradas = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _redacoesFiltradas = _todasAsRedacoes;
    _searchController.addListener(_filtrarRedacoes);
  }

  void _filtrarRedacoes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _redacoesFiltradas = _todasAsRedacoes.where((redacao) {
        return redacao.aluno.toLowerCase().contains(query) ||
               redacao.tema.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma Redação Corrigida',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'As redações que você corrigir aparecerão aqui.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildRedacaoCard(Redacao redacao) {
    final String dataFormatada = DateFormat('dd/MM/yyyy').format(redacao.dataEnvio);

    Color corNota = Colors.grey;
    if (redacao.nota != null) {
        if (redacao.nota! >= 800) corNota = Colors.green.shade600;
        else if (redacao.nota! >= 600) corNota = Colors.orange.shade700;
        else corNota = Colors.red.shade600;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: corNota,
          foregroundColor: Colors.white,
          child: Text(
            redacao.nota.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        title: Text(redacao.aluno, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Tema: ${redacao.tema}\nCorrigido em: $dataFormatada'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: const Text('Redações Corrigidas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              controller: _searchController,
              hintText: 'Buscar por aluno ou tema...',
              leading: const Icon(Icons.search),
              elevation: const MaterialStatePropertyAll(1),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _redacoesFiltradas.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: _redacoesFiltradas.length,
                      itemBuilder: (context, index) {
                        return _buildRedacaoCard(_redacoesFiltradas[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}