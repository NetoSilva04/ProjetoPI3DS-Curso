import 'package:flutter/material.dart';
import 'redacaorecebida_page.dart';
import 'emrevisao_page.dart';
import 'pendentes_page.dart';
import 'redacoescorrigidas_page.dart';
import 'package:projetopi/teladelogin_screen.dart';

class CorretorHomePage extends StatefulWidget {
  const CorretorHomePage({super.key});

  @override
  State<CorretorHomePage> createState() => _CorretorHomePageState();
}

class _CorretorHomePageState extends State<CorretorHomePage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _showNotificationPanel = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOut));
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

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const RedacoesRecebidasPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmRevisaoPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PendentesPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const RedacoesCorrigidasPage()),
        );
        break;
      default:
        break;
    }
  }

  // MÉTODO NOVO: Constrói um card de métrica individual
  Widget _buildMetricaCard(String titulo, String valor, IconData icone, Color cor) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icone, size: 30, color: cor),
              const SizedBox(height: 10),
              Text(valor, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(titulo, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  // MÉTODO NOVO: Constrói a lista de atividades recentes
  Widget _buildAtividadesRecentes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Atividade Recente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => _onItemTapped(0),
              child: const Text('Ver todas'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                title: const Text('Redação de "Maria Clara"'),
                subtitle: const Text('Tema: O futuro da inteligência artificial'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {},
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                title: const Text('Redação de "Lucas Andrade"'),
                subtitle: const Text('Tema: Desafios da sustentabilidade no Brasil'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
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
        title: const Text('Painel do Corretor'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: _toggleNotificationPanel,
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFB39DDB),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Pierre-Person.jpg/220px-Pierre-Person.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nome do Corretor',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Especialidade: Língua Portuguesa',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Painel'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment),
                    title: const Text('Redações Recebidas'),
                    onTap: () => _onItemTapped(0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Sair'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // AQUI ESTÁ A NOVA ESTRUTURA DO CORPO DA TELA
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Olá, Corretor!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Aqui está um resumo do seu dia.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildMetricaCard('A Corrigir', '12', Icons.pending_actions_outlined, Colors.orange.shade700),
                  const SizedBox(width: 16),
                  _buildMetricaCard('Corrigidas Hoje', '5', Icons.check_circle_outline, Colors.green.shade600),
                ],
              ),
              const SizedBox(height: 24),
              _buildAtividadesRecentes(),
            ],
          ),
          if (_showNotificationPanel)
            SlideTransition(
              position: _offsetAnimation,
              child: _buildNotificationPanel(),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_late_outlined),
            activeIcon: Icon(Icons.assignment_late),
            label: 'Recebidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review_outlined),
             activeIcon: Icon(Icons.rate_review),
            label: 'Em Revisão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_outlined),
            activeIcon: Icon(Icons.pending_actions),
            label: 'Pendentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            activeIcon: Icon(Icons.assignment_turned_in),
            label: 'Corrigidas',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF512DA8),
        unselectedItemColor: Colors.grey[500],
        elevation: 8,
      ),
    );
  }

  Widget _buildNotificationPanel() {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        elevation: 10,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notificações',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _toggleNotificationPanel),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),
              const ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.info_outline, color: Colors.white)),
                title: Text("Bem-vindo(a) ao seu painel!"),
                subtitle: Text("Nenhuma nova notificação no momento."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}