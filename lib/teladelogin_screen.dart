import 'package:flutter/material.dart';
import 'package:projetopi/main.dart';
import 'package:projetopi/pagCorretor/home_page.dart';
import 'package:projetopi/teladecadastro_screen.dart';
import 'package:projetopi/teladousuario_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final String _usuarioEmail = 'joao@example.com';
  final String _usuarioSenha = '123456';
  final String _corretorEmail = 'corretor@example.com';
  final String _corretorSenha = 'abcdef';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (!mounted) return;

    if (email == _usuarioEmail && password == _usuarioSenha) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserPage(
            nome: 'João da Silva',
            email: _usuarioEmail,
          ),
        ),
      );
    } else if (email == _corretorEmail && password == _corretorSenha) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CorretorHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail ou senha inválidos')),
      );
    }

    if(mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text('Entrar', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _isLoading ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CadastroPage()),
                  );
                },
                child: const Text('Criar uma conta'),
              ),
              TextButton(
                onPressed: _isLoading ? null : () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const PaginaPrincipal()),
                    (route) => false,
                  );
                },
                child: const Text('Voltar à tela inicial'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}