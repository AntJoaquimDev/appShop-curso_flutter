// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';

import '../models/auth.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Map<String, String> _autData = {
    'email': '',
    'password': '',
  };
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSingnup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  void _showErroDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um [ERRO]!'),
        content: Text(msg),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tente novamente')),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(
          _autData['email']!,
          _autData['password']!,
        );
      } else {
        await auth.signup(
          _autData['email']!,
          _autData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErroDialog(error.toString());
    } catch (error) {
      _showErroDialog('Desculpa ocorreu um erro inesperado no sistema');
    }

    setState(() => _isLoading = false);
    // _formKey
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: _isLogin() ? 300 : 370,
        width: deviceSize.width * 75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _autData['email'] = email ?? '',
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Informe um e-mail válido';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: _passwordController,
              onSaved: (password) => _autData['password'] = password ?? '',
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Informe uma senha Válida.';
                }
                return null;
              },
            ),
            if (_isSingnup())
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirmar Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: _isLogin()
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController.text) {
                          return 'Senhas informadas não conferem.';
                        }
                        return null;
                      },
              ),
            SizedBox(height: 15),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _submit,
                child:
                    Text(_authMode == AuthMode.Login ? 'Entrar' : 'Registrar'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                ),
              ),
            Spacer(),
            TextButton(
              onPressed: _switchAuthMode,
              child:
                  Text(_isLogin() ? 'DESEJA REGISTRAR ?' : 'JÁ POSSUI CONTA?'),
            ),
          ]),
        ),
      ),
    );
  }
}
