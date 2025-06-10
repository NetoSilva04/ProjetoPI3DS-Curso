import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetopi/models/redacao_model.dart';

class EmRevisaoPage extends StatefulWidget {
  const EmRevisaoPage({super.key});

  @override
  State<EmRevisaoPage> createState() => _EmRevisaoPageState();
}

class _EmRevisaoPageState extends State<EmRevisaoPage> {
  final List<Redacao> _todasAsRedacoes = [
    Redacao(aluno: 'Rafael Souza', tema: 'Manipulação de dados na internet', dataEnvio: DateTime(2025, 6, 8), status: 'Em Revisão'),
  ];

  List<Redacao> _redacoesFiltradas = [];
  final TextEditingController _searchController = TextEditingController();

   @override
  void initState() {
    super.initState();
    _redacoesFiltradas = _todasAsRedacoes;
    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _redacoesFiltradas = _todasAsRedacoes.where((redacao) {
          return redacao.aluno.toLowerCase().contains(query) ||
                 redacao.tema.toLowerCase().contains(query);
        }).toList();
      });
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
          Icon(Icons.pause_circle_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma Redação em Revisão',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'As correções que você salvar como rascunho aparecerão aqui.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildRedacaoCard(Redacao redacao) {
    final String dataFormatada = DateFormat('dd/MM/yyyy').format(redacao.dataEnvio);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(Icons.rate_review_outlined, color: Colors.blue.shade800),
        ),
        title: Text(redacao.aluno, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Tema: ${redacao.tema}\nIniciado em: $dataFormatada'),
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
        title: const Text('Redações em Revisão'),
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