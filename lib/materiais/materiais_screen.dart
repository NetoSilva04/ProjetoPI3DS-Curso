import 'package:flutter/material.dart';
import 'package:projetopi/materiais/bancodecitacoes_screnn.dart';
import 'package:projetopi/materiais/bancodereferencias_screen.dart';
import 'package:projetopi/materiais/bancodetemas_screen.dart';
import 'package:projetopi/materiais/bandodealusoes_screen.dart';
import 'package:projetopi/materiais/redaçoesnota1000_screen.dart';

class MateriaisPage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'title': 'Banco de Alusões', 'icon': Icons.account_balance},
    {'title': 'Banco de Citações', 'icon': Icons.menu_book},
    {'title': 'Banco de Referências', 'icon': Icons.movie},
    {'title': 'Banco de Temas', 'icon': Icons.topic},
    {'title': 'Redações Nota 1000', 'icon': Icons.emoji_events},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apoio para Redações',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore materiais e escreva redações para praticar e receber correções.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(height: 16),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: Icon(item['icon'], color: Colors.deepPurple),
                      title: Text(
                        item['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Widget nextPage;

                        switch (item['title']) {
                          case 'Banco de Alusões':
                            nextPage = AlusoesHistoricasPage();
                            break;
                          case 'Banco de Citações':
                            nextPage = CitacoesPage();
                            break;
                          case 'Banco de Referências':
                            nextPage = ReferenciasPage();
                            break;
                          case 'Banco de Temas':
                            nextPage = TemaPage();
                            break;
                          case 'Redações Nota 1000':
                            nextPage = RedacoesNota1000Page();
                            break;
                          default:
                            nextPage = Scaffold(
                              body: Center(child: Text('Página não encontrada')),
                            );
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => nextPage),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, size: 40, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Comece agora!',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Aproveite os bancos de temas e escreva a sua primeira redação!',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TemaPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Ver Temas'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
