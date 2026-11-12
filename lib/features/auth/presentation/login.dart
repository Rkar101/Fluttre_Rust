// lib/features/auth/presentation/views/auth_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rust_flutter/core/database/secure_const.dart';
import 'package:rust_flutter/core/database/secure_db.dart';

import '../../../../core/network/dio_client.dart';
import '../../../routes/page_router.dart';
import '../data/auth_data.dart';
import '../domain/login_usecase.dart';
import '../repositories/auth_repo_impl.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Login'), Tab(text: 'Register')],
          ),
        ),
        body: const TabBarView(children: [LoginFormView(), RegisterFormView()]),
      ),
    );
  }
}

// ==================== LOGIN FORM VIEW ====================
class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AuthUseCase _authUseCase;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final dioClient = DioClient();
    final remoteDataSource = AuthRemoteDataSourceImpl(dioClient: dioClient);
    final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
    _authUseCase = AuthUseCase(repository);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _authUseCase.loginCase(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;
      if (result.state == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome back, ${_emailController.text.trim()}! 🎉'),
            backgroundColor: Colors.green,
          ),
        );
        SecureStorage.secureWrite(
          SecureConst.loginFlag,
          result.state.toString(),
        );
        SecureStorage.secureWrite(SecureConst.accessToken, result.token);
        SecureStorage.secureWrite(SecureConst.empRole, result.role);
        globalAuthNotifier.value = true;
        context.go(PageRouter.posLoading);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.msg),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            ],
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Enter an email' : null,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator:
                    (value) => value!.length < 6 ? 'Password too short' : null,
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text('Login'),
                ),
          ],
        ),
      ),
    );
  }
}

// ==================== REGISTER FORM VIEW ====================
class RegisterFormView extends StatefulWidget {
  const RegisterFormView({super.key});

  @override
  State<RegisterFormView> createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userNameController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  late final AuthUseCase _authUseCase;

  @override
  void initState() {
    super.initState();
    final dioClient = DioClient();
    final remoteDataSource = AuthRemoteDataSourceImpl(dioClient: dioClient);
    final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
    _authUseCase = AuthUseCase(repository);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _authUseCase.regCase(
        _userNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;
      if (result.state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account created for ${_emailController.text.trim()}! 🎉',
            ),
            backgroundColor: Colors.green,
          ),
        );

        SecureStorage.secureWrite(
          SecureConst.empName,
          _userNameController.text.trim(),
        );

        SecureStorage.secureWrite(
          SecureConst.email,
          _emailController.text.trim(),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.msg), backgroundColor: Colors.black),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            ],
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'UserName'),
              obscureText: false,
              validator: (value) => value!.isEmpty ? 'Enter an ' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty ? 'Enter an email' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator:
                  (value) =>
                      value!.length < 6
                          ? 'Password must be at least 6 chars'
                          : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value != _passwordController.text)
                  return 'Passwords do not match';
                return null;
              },
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _handleSignUp,
                  child: const Text('Create Account'),
                ),
          ],
        ),
      ),
    );
  }
}
