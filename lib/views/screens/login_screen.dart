import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news/services/firebase_service.dart';
import 'package:my_news/views/screens/home_screen.dart';
import 'package:my_news/views/widgets/common_app_bar.dart';
import 'package:my_news/views/widgets/common_button.dart';
import 'package:my_news/views/widgets/custom_text_form_field.dart';

import 'singup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? _validateEmail(String? value) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
    );
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: const CommonAppBar(
        title: 'MyNews',
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: 'Password',
                      validator: _validatePassword,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonButton(
                      isLoading: _isLoading,
                      text: 'Login',
                      onPressed: _onPressed,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'New here? ',
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: Colors.black, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: _onTap,
                          child: Text(
                            'Signup',
                            style: theme.textTheme.displayLarge?.copyWith(
                                color: theme.primaryColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed() async {
    if (_isLoading) return;

    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _isLoading = true;
      });
      try {
        await _firebaseService.loginUser(
            _emailController.text, _passwordController.text);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } on FirebaseAuthException catch (authError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(authError.code.toString())));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onTap() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
