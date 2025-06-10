import 'package:flutter/material.dart';
import 'package:projetopi/temas/redacaoenemLivre.dart';
import 'package:projetopi/temas/redacaotemaDesafios.dart';
import 'package:projetopi/temas/redacaotemaEtica.dart';
import 'package:projetopi/temas/redacaotemaManipulacao.dart';
import 'package:projetopi/temas/redacaotemaMulher.dart';
import 'package:projetopi/temas/redacaotemaMulherViolencia.dart';
import 'package:projetopi/temas/redacaoVestibularLivre.dart';
import 'package:projetopi/temas/redacaoConcursoLivre.dart';
import 'package:projetopi/temas/redacaotemaMundoForaOrdem.dart';

class TemaPage extends StatefulWidget {
  final String tipoInicial;

  const TemaPage({super.key, this.tipoInicial = ''});

  @override
  State<TemaPage> createState() => _TemaPageState();
}

class _TemaPageState extends State<TemaPage> {
  late String tipoSelecionado;
  String filtroTitulo = '';
  String? _hoveredItem;

  final List<Map<String, String>> temas = [
    {"titulo": "Redação Enem - Livre", "tipo": "Enem"},
    {"titulo": "Redação Vestibular - Livre", "tipo": "Vestibular"},
    {"titulo": "Redação Concurso - Livre", "tipo": "Concurso"},
    {"titulo": "A Mulher e a Sociedade Contemporânea", "tipo": "Enem", "apoio": "Ver textos motivadores completos na página."},
    {"titulo": "A persistência da violência contra a mulher na sociedade brasileira", "tipo": "Enem", "apoio": "Ver textos motivadores completos na página."},
    {"titulo": "Manipulação do comportamento do usuário pelo controle de dados na internet", "tipo": "Enem", "apoio": "Ver textos motivadores completos na página."},
    {"titulo": "Desafios para a valorização de comunidades e povos tradicionais no Brasil", "tipo": "Enem", "apoio": "Ver textos motivadores completos na página."},
    {"titulo": "O papel da ética no serviço público brasileiro", "tipo": "Concurso", "apoio": "Ver textos motivadores completos na página."},
    {"titulo": "O mundo contemporâneo está fora da ordem", "tipo": "Vestibular", "apoio": "Ver textos motivadores completos na página."},
  ];

  final Map<String, Widget> temaPageMap = {
    "A Mulher e a Sociedade Contemporânea": RedacaoTemaMulher(),
    "A persistência da violência contra a mulher na sociedade brasileira": RedacaoTemaViolenciaPage(),
    "Manipulação do comportamento do usuário pelo controle de dados na internet": RedacaoTemaManipulacaoPage(),
    "Redação Enem - Livre": RedacaoTemaEnemPage(),
    "Redação Vestibular - Livre": RedacaoTemaVestibularPage(),
    "Redação Concurso - Livre": RedacaoTemaConcursoPage(),
    "Desafios para a valorização de comunidades e povos tradicionais no Brasil": RedacaoTemaDesafiosPage(),
    "O papel da ética no serviço público brasileiro": RedacaoTemaEticaPage(),
    "O mundo contemporâneo está fora da ordem": RedacaoTemaMundoForaOrdemPage()
  };

  @override
  void initState() {
    super.initState();
    tipoSelecionado = widget.tipoInicial;
  }

  @override
  Widget build(BuildContext context) {
    final temasFiltrados = temas.where((tema) {
      final tipoOk = tipoSelecionado.isEmpty || tema['tipo'] == tipoSelecionado;
      final tituloOk = tema['titulo']!.toLowerCase().contains(filtroTitulo.toLowerCase());
      return tipoOk && tituloOk;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'BANCOS DE TEMAS',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFB19CD9),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar por título',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (valor) {
                    setState(() {
                      filtroTitulo = valor;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: tipoSelecionado.isNotEmpty ? tipoSelecionado : null,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar por tipo',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Enem', 'Vestibular', 'Concurso']
                      .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      tipoSelecionado = value ?? '';
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1;
                if (constraints.maxWidth >= 1400) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth >= 1000) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth >= 600) {
                  crossAxisCount = 2;
                } else {
                  crossAxisCount = 1;
                }
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: crossAxisCount == 1 ? 3 / 1 : 3 / 2,
                  children: temasFiltrados.map((tema) {
                    return GestureDetector(
                      onTap: () {
                        if (temaPageMap.containsKey(tema['titulo'])) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => temaPageMap[tema['titulo']]!,
                            ),
                          );
                        }
                      },
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredItem = tema['titulo'];
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredItem = null;
                          });
                        },
                        cursor: SystemMouseCursors.click,
                        child: AnimatedScale(
                          scale: _hoveredItem == tema['titulo'] ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Card(
                            elevation: 4,
                            color: Colors.deepPurple.shade50,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.book, size: 48, color: Colors.deepPurple),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tema['titulo']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}