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

class _CorretorHomePageState extends State<CorretorHomePage> with SingleTickerProviderStateMixin {
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

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RedacoesRecebidasPage()),
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
          MaterialPageRoute(builder: (context) => const RedacoesCorrigidasPage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB39DDB),
        title: const Text('Painel do Corretor'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Pierre-Person.jpg/220px-Pierre-Person.jpg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Nome do Corretor',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RedacoesRecebidasPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Perfil'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configurações'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Sair'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bem-vindo ao Painel do Corretor!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF512DA8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aqui estão suas tarefas e informações mais recentes:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  _buildNotificacoesImportantes(),
                  const SizedBox(height: 24),
                  _buildTarefasDoDia(),
                  const SizedBox(height: 24),
                  _buildResumoCorrecoesRecentes(),
                  const SizedBox(height: 24),
                  _buildCalendarioEntregas(),
                ],
              ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, color: Colors.orange),
            label: 'Redações Recebidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review, color: Colors.blue),
            label: 'Em Revisão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions, color: Colors.orange),
            label: 'Pendentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in, color: Colors.green),
            label: 'Corrigidas',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFB39DDB),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
      ),
    );
  }

  Widget _buildNotificacoesImportantes() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notificações Importantes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Novo prazo de correção para amanhã!'),
              subtitle: const Text('Lembre-se de revisar todas as redações até amanhã.'),
              leading: const Icon(Icons.notifications, color: Colors.orange),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Novo aluno cadastrado'),
              subtitle: const Text('Um novo aluno enviou redação para correção.'),
              leading: const Icon(Icons.person_add, color: Colors.blue),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTarefasDoDia() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarefas do Dia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Corrigir redação de João'),
              subtitle: const Text('Data de envio: 01/05/2025'),
              leading: const Icon(Icons.assignment, color: Colors.orange),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Revisar redação de Ana'),
              subtitle: const Text('Data de envio: 02/05/2025'),
              leading: const Icon(Icons.assignment_late, color: Colors.blue),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumoCorrecoesRecentes() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo das Correções Recentes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.assignment_turned_in, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  '10 Redações Corrigidas',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.timer, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Média de 15 min por correção',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarioEntregas() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calendário de Tarefas/Entregas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Próximos prazos:'),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.orange),
              title: const Text('Entrega de redação - 05/05/2025'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.orange),
              title: const Text('Revisão final - 10/05/2025'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
