import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projetopi/teladelogin_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

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

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late Future<void> _userDataFuture;
  String _avatarUrl = '';
  List<dynamic> _redacoes = [];

  late AnimationController _animationController;
  late Animation<Offset> offsetAnimation;
  bool _showNotificationPanel = false;

  final List<String> _avatarList = [
    'https://img.icons8.com/?size=96&id=13527&format=png',
    'https://i.postimg.cc/NMyM4nS2/avatar-2.png',
    'https://i.postimg.cc/L85XQWk6/avatar-3.png',
    'https://i.postimg.cc/W12vM6VT/avatar-4.png',
  ];

  @override
  void initState() {
    super.initState();
    _userDataFuture = _carregarDadosDoUsuario();
  }

  void toggleNotificationPanel() {
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
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _redacoes = [
          {
            "id": 1,
            "tema": "Impacto da tecnologia na educação",
            "status": "Corrigida",
            "nota_final": 920,
            "created_at": "2025-06-10T12:00:00.000000Z"
          },
          {
            "id": 2,
            "tema": "Desafios do meio ambiente no século XXI",
            "status": "Pendente",
            "nota_final": null,
            "created_at": "2025-06-15T18:30:00.000000Z"
          }
        ];
        _avatarUrl = _avatarList.first;
      });
    }
  }

  Future<void> _logout() async {
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  Future<void> _excluirRedacao(int id) async {
    setState(() {
      _redacoes.removeWhere((redacao) => redacao['id'] == id);
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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _redacoes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar dados: ${snapshot.error}'));
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
                const Text('Histórico de Redações',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                if (_redacoes.isEmpty)
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: Text("Nenhuma redação encontrada.")))
                else
                  ...List.generate(_redacoes.length,
                      (index) => _buildRedacaoCard(_redacoes[index])),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricas() {
    final notas = _redacoes
        .where((r) => r['status'] == 'Corrigida' && r['nota_final'] != null)
        .map((r) => r['nota_final'] as int);
    final media =
        notas.isEmpty ? 0 : notas.reduce((a, b) => a + b) / notas.length;

    return Row(children: [
      Expanded(
          child: Card(
              elevation: 0,
              color: Colors.deepPurple[50],
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Text(_redacoes.length.toString(),
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                    const Text('Enviadas',
                        style: TextStyle(color: Colors.deepPurple))
                  ])))),
      const SizedBox(width: 16),
      Expanded(
          child: Card(
              elevation: 0,
              color: Colors.green[50],
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Text(media.toStringAsFixed(0),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800])),
                    Text('Média de Nota',
                        style: TextStyle(color: Colors.green[800]))
                  ])))),
    ]);
  }

  Widget _buildRedacaoCard(Map<String, dynamic> redacao) {
    bool isCorrigida = redacao['status'] == 'Corrigida';
    IconData statusIcon = isCorrigida
        ? Icons.check_circle
        : (redacao['status'] == 'Pendente'
            ? Icons.hourglass_top
            : Icons.rate_review);
    Color statusColor = isCorrigida
        ? Colors.green
        : (redacao['status'] == 'Pendente' ? Colors.orange : Colors.blue);
    final dataFormatada =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(redacao['created_at']));

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor, size: 30),
        title: Text(redacao['tema'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            '${redacao['status']} - $dataFormatada\nNota: ${isCorrigida ? redacao['nota_final'] : "N/A"}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'excluir') _excluirRedacao(redacao['id']);
            if (value == 'ver')
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Abrindo correção...')));
          },
          itemBuilder: (_) => [
            PopupMenuItem<String>(
                value: 'ver',
                enabled: isCorrigida,
                child: const Text('Ver Correção')),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
                value: 'excluir',
                child: Text('Excluir', style: TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }

  Widget _buildPerfilView() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Stack(alignment: Alignment.bottomRight, children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: _avatarUrl.isNotEmpty
                    ? CachedNetworkImageProvider(_avatarUrl)
                    : null,
                child:
                    _avatarUrl.isEmpty ? const Icon(Icons.person, size: 35) : null,
              ),
              InkWell(
                  onTap: _showAvatarPicker,
                  child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.edit, size: 14, color: Colors.white))),
            ]),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(widget.nome,
                      style: const
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(widget.email,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ])),
          ])),
    );
  }

  Widget _buildChartCard() {
    final List<FlSpot> spots = [];
    final corrigidas = _redacoes
        .where((r) => r['status'] == 'Corrigida' && r['nota_final'] != null)
        .toList();
    for (int i = 0; i < corrigidas.length; i++) {
      spots.add(
          FlSpot(i.toDouble(), (corrigidas[i]['nota_final'] as int).toDouble()));
    }

    if (spots.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 20, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Evolução das Notas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false))),
                  borderData: FlBorderData(show: false),
                  minY: 0,
                  maxY: 1000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.deepPurple,
                      barWidth: 4,
                      belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                              colors: [
                                Colors.deepPurple.withOpacity(0.3),
                                Colors.deepPurple.withOpacity(0.0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
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
        content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: _avatarList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() => _avatarUrl = _avatarList[index]);
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(_avatarList[index])),
              ),
            )),
      ),
    );
  }
}