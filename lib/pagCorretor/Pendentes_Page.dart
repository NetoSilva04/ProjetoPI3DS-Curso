import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetopi/models/redacao_model.dart';

class PendentesPage extends StatefulWidget {
  const PendentesPage({super.key});

  @override
  State<PendentesPage> createState() => _PendentesPageState();
}

class _PendentesPageState extends State<PendentesPage> {
  final List<Redacao> _todasAsRedacoes = [
    Redacao(aluno: 'Mariana Lima', tema: 'A persistência da violência contra a mulher', dataEnvio: DateTime(2025, 6, 9), status: 'Pendente'),
    Redacao(aluno: 'Pedro Álvares', tema: 'Democratização do acesso ao cinema no Brasil', dataEnvio: DateTime(2025, 6, 10), status: 'Pendente'),
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
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma Redação Pendente',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Você está em dia! Novas redações aparecerão aqui.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildRedacaoCard(Redacao redacao) {
    final String dataFormatada = DateFormat('dd/MM/yyyy \'às\' HH:mm').format(redacao.dataEnvio);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          child: Icon(Icons.pending_actions_outlined, color: Colors.orange.shade800),
        ),
        title: Text(redacao.aluno, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Tema: ${redacao.tema}\nEnviado em: $dataFormatada'),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Corrigir'),
        ),
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
        title: const Text('Redações Pendentes'),
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