import 'package:flutter/material.dart';
import 'package:projetopi/teladelogin_screen.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  CadastroPageState createState() => CadastroPageState();
}

class CadastroPageState extends State<CadastroPage> {
  // Controladores gerais
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userType = 'Estudante';

  final TextEditingController _escolaController = TextEditingController();
  final TextEditingController _serieController = TextEditingController();

  final TextEditingController _formacaoController = TextEditingController();
  final TextEditingController _experienciaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _escolaController.dispose();
    _serieController.dispose();
    _formacaoController.dispose();
    _experienciaController.dispose();
    super.dispose();
  }

  void _cadastro() {
    final nome = _nomeController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    bool camposEstudanteValidos = false;
    if (_userType == 'Estudante') {
      camposEstudanteValidos = _escolaController.text.isNotEmpty && _serieController.text.isNotEmpty;
    }

    bool camposCorretorValidos = false;
    if (_userType == 'Corretor') {
      camposCorretorValidos = _formacaoController.text.isNotEmpty && _experienciaController.text.isNotEmpty;
    }

    if (nome.isNotEmpty && email.isNotEmpty && password.isNotEmpty && (camposEstudanteValidos || camposCorretorValidos)) {
      print('Cadastro realizado com sucesso!');
      print('Nome: $nome, Email: $email, Tipo: $_userType');
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
    }
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
              // --- Campos Comuns ---
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder()),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              const Text('Eu sou:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

              // --- Botões ---
              ElevatedButton(
                onPressed: _cadastro,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Criar Conta', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
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

  // Constrói os campos para o perfil de Estudante
  List<Widget> _buildEstudanteFields() {
    return [
      TextField(
        controller: _escolaController,
        decoration: const InputDecoration(labelText: 'Escola', border: OutlineInputBorder()),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _serieController,
        decoration: const InputDecoration(labelText: 'Série/Ano', border: OutlineInputBorder()),
      ),
    ];
  }

  // Constrói os campos para o perfil de Corretor
  List<Widget> _buildCorretorFields() {
    return [
      TextField(
        controller: _formacaoController,
        decoration: const InputDecoration(labelText: 'Formação Acadêmica', border: OutlineInputBorder()),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _experienciaController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Anos de Experiência', border: OutlineInputBorder()),
      ),
    ];
  }
}