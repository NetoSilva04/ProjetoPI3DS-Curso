import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projetopi/teladelogin_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class UserPage extends StatefulWidget {
  final String nome;
  final String email;

  const UserPage({
    required this.nome,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin {
  late Future<void> _userDataFuture;
  String _avatarUrl = '';
  List<Map<String, dynamic>> _redacoes = [];
  
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _showNotificationPanel = false;

  final List<String> _avatarList = [
    'https://i.postimg.cc/yN0wLz5K/avatar-1.png',
    'https://i.postimg.cc/NMyM4nS2/avatar-2.png',
    'https://i.postimg.cc/L85XQWk6/avatar-3.png',
    'https://i.postimg.cc/W12vM6VT/avatar-4.png',
    'https://i.postimg.cc/Bv2B5C8f/avatar-5.png',
    'https://i.postimg.cc/TPgP8v6K/avatar-6.png',
    'https://i.postimg.cc/J0k7pW02/avatar-7.png',
    'https://i.postimg.cc/Pry241tS/avatar-8.png',
    'https://i.postimg.cc/W4N6n5p5/avatar-9.png',
    'https://i.postimg.cc/Kz4jgy7M/avatar-10.png',
    'https://i.postimg.cc/x8PjDSHx/avatar-11.png',
    'https://i.postimg.cc/50pC5YVw/avatar-12.png',
  ];

  @override
  void initState() {
    super.initState();
    _userDataFuture = _carregarDadosDoUsuario();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
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

  Future<void> _carregarDadosDoUsuario() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _redacoes = [];
        _avatarUrl = _avatarList.first;
      });
    }
  }

  Future<void> _excluirRedacao(int index) async {
    setState(() {
      _redacoes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Painel do Estudante'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: _toggleNotificationPanel,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false)
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _userDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
              }
              return RefreshIndicator(
                onRefresh: _carregarDadosDoUsuario,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildPerfilView(),
                    const SizedBox(height: 24),
                    _buildMetricas(),
                    const SizedBox(height: 24),
                    _buildChartCard(),
                    const SizedBox(height: 24),
                    Row(children: [const Text('Histórico de Redações', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
                    const SizedBox(height: 10),
                    if (_redacoes.isEmpty) 
                      const Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Center(child: Text("Nenhuma redação encontrada.")))
                    else
                      ...List.generate(_redacoes.length, (index) => _buildRedacaoCard(_redacoes[index], index)),
                  ],
                ),
              );
            },
          ),
          if (_showNotificationPanel)
            SlideTransition(
              position: _offsetAnimation,
              child: _buildNotificationPanel(),
            ),
        ],
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
                  const Text('Notificações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close), onPressed: _toggleNotificationPanel),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),
              const ListTile(
                leading: CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.info_outline, color: Colors.white)),
                title: Text("Bem-vindo(a) ao seu painel!"),
                subtitle: Text("Nenhuma nova notificação no momento."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricas() {
    final notas = _redacoes.where((r) => r['status'] == 'Corrigida' && r['nota'] != null).map((r) => r['nota'] as int);
    final media = notas.isEmpty ? 0 : notas.reduce((a, b) => a + b) / notas.length;

    return Row(children: [
      Expanded(child: Card(elevation: 0, color: Colors.deepPurple[50], child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [Text(_redacoes.length.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)), const Text('Enviadas', style: TextStyle(color: Colors.deepPurple))])))),
      const SizedBox(width: 16),
      Expanded(child: Card(elevation: 0, color: Colors.green[50], child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [Text(media.toStringAsFixed(0), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[800])), Text('Média de Nota', style: TextStyle(color: Colors.green[800]))])))),
    ]);
  }

  Widget _buildRedacaoCard(Map<String, dynamic> redacao, int index) {
    bool isCorrigida = redacao['status'] == 'Corrigida';
    IconData statusIcon = isCorrigida ? Icons.check_circle : Icons.hourglass_top;
    Color statusColor = isCorrigida ? Colors.green : Colors.orange;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor, size: 30),
        title: Text(redacao['titulo'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${redacao['status']} - ${redacao['data']}\nNota: ${isCorrigida ? redacao['nota'] : "N/A"}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'excluir') _excluirRedacao(index);
            if (value == 'ver') ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abrindo correção...')));
          },
          itemBuilder: (_) => [
            PopupMenuItem<String>(value: 'ver', enabled: isCorrigida, child: const Text('Ver Correção')),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(value: 'excluir', child: const Text('Excluir', style: TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }

  Widget _buildPerfilView() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(padding: const EdgeInsets.all(16.0), child: Row(children: [
        Stack(alignment: Alignment.bottomRight, children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: _avatarUrl.isNotEmpty ? CachedNetworkImageProvider(_avatarUrl) : null,
            child: _avatarUrl.isEmpty ? const Icon(Icons.person, size: 35) : null,
          ),
          InkWell(onTap: _showAvatarPicker, child: const CircleAvatar(radius: 12, backgroundColor: Colors.deepPurple, child: Icon(Icons.edit, size: 14, color: Colors.white))),
        ]),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(widget.email, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ])),
      ])),
    );
  }

  Widget _buildChartCard() {
    final List<FlSpot> spots = [];
    final corrigidas = _redacoes.where((r) => r['status'] == 'Corrigida').toList().reversed.toList();
    for(int i = 0; i < corrigidas.length; i++) {
        spots.add(FlSpot(i.toDouble(), corrigidas[i]['nota'].toDouble()));
    }

    if(spots.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 20, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Evolução das Notas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(height: 150, child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
              borderData: FlBorderData(show: false),
              minY: 0,
              maxY: 1000,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.deepPurple,
                  barWidth: 4,
                  belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: [Colors.deepPurple.withOpacity(0.3), Colors.deepPurple.withOpacity(0.0)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
              ],
            ),
          )),
        ]),
      ),
    );
  }
  
  void _showAvatarPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Escolher Avatar"),
        content: SizedBox(width: double.maxFinite, child: GridView.builder(
          shrinkWrap: true,
          itemCount: _avatarList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() => _avatarUrl = _avatarList[index]);
              Navigator.of(context).pop();
            },
            child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(_avatarList[index])),
          ),
        )),
      ),
    );
  }
}