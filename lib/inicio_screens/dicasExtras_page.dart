import 'package:flutter/material.dart';

class DicasExtrasPage extends StatefulWidget {
  const DicasExtrasPage({super.key});

  @override
  State<DicasExtrasPage> createState() => _DicasExtrasPageState();
}

class _DicasExtrasPageState extends State<DicasExtrasPage> {
  String filtroTipo = 'Todos';
  String busca = '';

  final List<Map<String, String>> dicas = [
    {
      'titulo': 'Estrutura da Redação',
      'descricao': 'A redação deve ser bem estruturada: introdução, desenvolvimento e conclusão.',
      'tipo': 'Redação',
      'tema': 'Estrutura'
    },
    {
      'titulo': 'Use Conectivos',
      'descricao': 'Conectivos fazem a ligação entre as ideias e ajudam na fluidez da redação.',
      'tipo': 'Redação',
      'tema': 'Coesão'
    },
    {
      'titulo': 'Pesquise Antes de Escrever',
      'descricao': 'Pesquise sobre o tema para garantir que você tenha informações precisas.',
      'tipo': 'Estudo',
      'tema': 'Preparação'
    },
    {
      'titulo': 'Controle o Tempo',
      'descricao': 'Divida o tempo de forma equilibrada entre a leitura, escrita e revisão.',
      'tipo': 'Estudo',
      'tema': 'Gestão de Tempo'
    },
    {
      'titulo': 'Leia Artigos e Textos Relevantes',
      'descricao': 'A leitura constante ajuda a melhorar vocabulário e habilidades argumentativas.',
      'tipo': 'Estudo',
      'tema': 'Leitura'
    },
    {
      'titulo': 'Revise Sua Redação',
      'descricao': 'Após escrever, revise sua redação para corrigir erros de gramática e ortografia.',
      'tipo': 'Redação',
      'tema': 'Revisão'
    },
    {
      'titulo': 'Use Exemplos Relevantes',
      'descricao': 'Sempre que possível, utilize exemplos concretos e atuais para enriquecer seu texto.',
      'tipo': 'Redação',
      'tema': 'Argumentação'
    },
    {
      'titulo': 'Fique Atento ao Tema Proposto',
      'descricao': 'Não fuja do tema! Sempre procure responder diretamente ao que foi pedido.',
      'tipo': 'Redação',
      'tema': 'Foco no Tema'
    },
    {
      'titulo': 'Faça Simulados',
      'descricao': 'Simulados ajudam a praticar o tempo e o tipo de redação que será exigido.',
      'tipo': 'Estudo',
      'tema': 'Simulados'
    },
    {
      'titulo': 'Organize seu Ambiente de Estudo',
      'descricao': 'Um ambiente limpo e organizado favorece a concentração e produtividade.',
      'tipo': 'Estudo',
      'tema': 'Ambiente'
    },
    {
      'titulo': 'Pratique a Escrita Regularmente',
      'descricao': 'A prática constante da escrita ajuda a melhorar a fluência e a clareza.',
      'tipo': 'Estudo',
      'tema': 'Prática'
    },
    {
      'titulo': 'Descanse e Durma Bem',
      'descricao': 'O descanso é fundamental para manter a mente fresca e melhorar a concentração.',
      'tipo': 'Estudo',
      'tema': 'Saúde'
    },
    {
      'titulo': 'Leia Modelos de Redação',
      'descricao': 'Estude redações nota 1000 para entender os pontos que mais agradam na avaliação.',
      'tipo': 'Redação',
      'tema': 'Exemplos'
    },
    {
      'titulo': 'Comece pelo Desenvolvimento',
      'descricao': 'Começar pela parte mais difícil pode ajudar a desenvolver uma melhor introdução.',
      'tipo': 'Redação',
      'tema': 'Estratégia'
    },
    {
      'titulo': 'Controle a Ansiedade',
      'descricao': 'Fazer exercícios de respiração pode ajudar a diminuir a ansiedade na hora de escrever.',
      'tipo': 'Estudo',
      'tema': 'Bem-estar'
    },
    {
      'titulo': 'Use Sinônimos para Diversificar',
      'descricao': 'Evite repetições e use sinônimos para tornar seu texto mais rico e fluido.',
      'tipo': 'Redação',
      'tema': 'Vocabulário'
    },
  ];

  List<Map<String, String>> get dicasFiltradas {
    return dicas.where((dica) {
      final correspondeTipo = filtroTipo == 'Todos' || dica['tipo'] == filtroTipo;
      final correspondeBusca = dica['titulo']!.toLowerCase().contains(busca.toLowerCase()) ||
          dica['descricao']!.toLowerCase().contains(busca.toLowerCase()) ||
          dica['tema']!.toLowerCase().contains(busca.toLowerCase());
      return correspondeTipo && correspondeBusca;
    }).toList();
  }

  Widget _dicaCard(String titulo, String descricao, String tema) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFB19CD9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                titulo,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('$descricao\n\n📌 Tema: $tema'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB19CD9),
        title: const Text(
          'DICAS EXTRAS PARA REDAÇÃO',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Buscar dica...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => setState(() => busca = value),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: filtroTipo,
                  items: ['Todos', 'Redação', 'Estudo']
                      .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
                      .toList(),
                  onChanged: (value) => setState(() => filtroTipo = value!),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dicasFiltradas.length,
              itemBuilder: (context, index) {
                final dica = dicasFiltradas[index];
                return _dicaCard(dica['titulo']!, dica['descricao']!, dica['tema']!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
