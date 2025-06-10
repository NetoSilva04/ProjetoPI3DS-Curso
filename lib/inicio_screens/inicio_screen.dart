import 'package:flutter/material.dart';
import 'package:projetopi/inicio_screens/conceitos_basicos_page.dart';
import 'package:projetopi/inicio_screens/desenvolvimento_page.dart';
import 'package:projetopi/inicio_screens/conclusao_page.dart';
import 'package:projetopi/inicio_screens/dicasExtras_page.dart';
import 'package:projetopi/inicio_screens/introducao_page.dart';
import 'package:projetopi/inicio_screens/competencias_page.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String? _hoveredItem;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _showNotificationPanel = false;

  final List<Map<String, String>> cards = [
    {'title': 'Conceitos Básicos', 'icon': '1'},
    {'title': '5 Competências', 'icon': '2'},
    {'title': 'Introdução', 'icon': '3'},
    {'title': 'Desenvolvimento', 'icon': '4'},
    {'title': 'Conclusão', 'icon': '5'},
    {'title': 'Dicas Extras', 'icon': '6'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  void _toggleNotificationPanel() {
    setState(() {
      _showNotificationPanel = !_showNotificationPanel;
      if (_showNotificationPanel) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Olá, estudante :)',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: _toggleNotificationPanel,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 800;
                        final crossAxisCount = isWide ? 3 : 2;
                        final spacing = isWide ? 26.0 : 12.0;
                        final childAspectRatio = isWide ? 1.6 : 0.9;

                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          childAspectRatio: childAspectRatio,
                          children: cards.map((card) {
                            return MouseRegion(
                              onEnter: (_) {
                                setState(() {
                                  _hoveredItem = card['title'];
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  _hoveredItem = null;
                                });
                              },
                              cursor: SystemMouseCursors.click,
                              child: AnimatedScale(
                                scale: _hoveredItem == card['title'] ? 1.05 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: InkWell(
                                  onTap: () {
                                    Widget nextPage;
                                    switch (card['title']) {
                                      case 'Conceitos Básicos':
                                        nextPage = ConceitosBasicosPage();
                                        break;
                                      case '5 Competências':
                                        nextPage = CompetenciasPage();
                                        break;
                                      case 'Introdução':
                                        nextPage = IntroPage();
                                        break;
                                      case 'Desenvolvimento':
                                        nextPage = DesenvolvimentoPage();
                                        break;
                                      case 'Conclusão':
                                        nextPage = ConclusaoPage();
                                        break;
                                      case 'Dicas Extras':
                                        nextPage = DicasExtrasPage();
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFB3A5D2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _getIconForCard(card['title']!),
                                          const SizedBox(height: 8),
                                          Text(
                                            card['title']!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
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
            ),
            if (_showNotificationPanel)
              SlideTransition(
                position: _offsetAnimation,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Notificações',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const Text('Nenhuma notificação disponível no momento.'),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: _toggleNotificationPanel,
                          child: const Text('Fechar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForCard(String title) {
    IconData iconData;
    switch (title) {
      case 'Conceitos Básicos':
        iconData = Icons.book;
        break;
      case '5 Competências':
        iconData = Icons.school;
        break;
      case 'Introdução':
        iconData = Icons.insert_drive_file;
        break;
      case 'Desenvolvimento':
        iconData = Icons.create;
        break;
      case 'Conclusão':
        iconData = Icons.check_circle;
        break;
      case 'Dicas Extras':
        iconData = Icons.lightbulb;
        break;
      default:
        iconData = Icons.help_outline;
        break;
    }
    return Icon(iconData, size: 40, color: Colors.yellowAccent);
  }
}
