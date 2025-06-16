import 'package:flutter/material.dart';
import 'package:projetopi/teladelogin_screen.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  CadastroPageState createState() => CadastroPageState();
}

class CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _escolaController = TextEditingController();
  final TextEditingController _serieController = TextEditingController();
  final TextEditingController _formacaoController = TextEditingController();
  final TextEditingController _experienciaController = TextEditingController();
  final TextEditingController _outraEspecialidadeController =
      TextEditingController();

  String _userType = 'Estudante';
  String _especialidadeSelecionada = 'Língua Portuguesa';
  String? _sexoSelecionado;
  bool _isLoading = false;

  final List<String> _especialidades = [
    'Língua Portuguesa',
    'Redação',
    'Literatura',
    'História',
    'Geografia',
    'Sociologia',
    'Filosofia',
    'Outra'
  ];
  final List<String> _sexos = ['Masculino', 'Feminino'];

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _escolaController.dispose();
    _serieController.dispose();
    _formacaoController.dispose();
    _experienciaController.dispose();
    _outraEspecialidadeController.dispose();
    super.dispose();
  }

  Future<void> _cadastro() async {
    final nome = _nomeController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_sexoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione o seu sexo.')),
      );
      return;
    }

    bool camposEspecificosValidos = false;
    if (_userType == 'Estudante') {
      camposEspecificosValidos = _escolaController.text.isNotEmpty &&
          _serieController.text.isNotEmpty;
    } else {
      camposEspecificosValidos = _formacaoController.text.isNotEmpty &&
          _experienciaController.text.isNotEmpty;
      if (_especialidadeSelecionada == 'Outra') {
        camposEspecificosValidos = camposEspecificosValidos &&
            _outraEspecialidadeController.text.isNotEmpty;
      }
    }

    if (nome.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        !camposEspecificosValidos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, preencha todos os campos obrigatórios.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro realizado com sucesso!')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                    labelText: 'Nome Completo', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'E-mail', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Senha', border: OutlineInputBorder()),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sexoSelecionado,
                hint: const Text('Sexo'),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _sexoSelecionado = newValue;
                  });
                },
                items: _sexos.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Eu sou:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _userType,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _userType = newValue!;
                  });
                },
                items: <String>['Estudante', 'Corretor'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              if (_userType == 'Estudante')
                ..._buildEstudanteFields()
              else
                ..._buildCorretorFields(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _cadastro,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 3, color: Colors.white),
                      )
                    : const Text('Criar Conta',
                        style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Já tenho uma conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEstudanteFields() {
    return [
      TextField(
        controller: _escolaController,
        decoration: const InputDecoration(
            labelText: 'Escola', border: OutlineInputBorder()),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _serieController,
        decoration: const InputDecoration(
            labelText: 'Série/Ano', border: OutlineInputBorder()),
      ),
    ];
  }

  List<Widget> _buildCorretorFields() {
    return [
      TextField(
        controller: _formacaoController,
        decoration: const InputDecoration(
            labelText: 'Formação Acadêmica', border: OutlineInputBorder()),
      ),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        value: _especialidadeSelecionada,
        decoration: const InputDecoration(
            labelText: 'Especialidade Principal',
            border: OutlineInputBorder()),
        onChanged: (String? newValue) {
          setState(() {
            _especialidadeSelecionada = newValue!;
          });
        },
        items: _especialidades.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      if (_especialidadeSelecionada == 'Outra')
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextField(
            controller: _outraEspecialidadeController,
            decoration: const InputDecoration(
                labelText: 'Qual a sua especialidade?',
                border: OutlineInputBorder()),
          ),
        ),
      const SizedBox(height: 16),
      TextField(
        controller: _experienciaController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            labelText: 'Anos de Experiência', border: OutlineInputBorder()),
      ),
    ];
  }
}