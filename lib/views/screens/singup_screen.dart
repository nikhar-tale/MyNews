import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_news/services/firebase_service.dart';
import 'package:my_news/views/screens/login_screen.dart';
import 'package:my_news/views/widgets/common_app_bar.dart';
import 'package:my_news/views/widgets/common_button.dart';
import 'package:my_news/views/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FirebaseService _firebaseService = FirebaseService();

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

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor, // Use theme background color
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
                      controller: nameController,
                      labelText: 'Name',
                      validator: _validateName,
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      labelText: 'Email',
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
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
                      text: 'Signup',
                      onPressed: _onPressed,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: Colors.black, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: _onTap,
                          child: Text(
                            'Login',
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
      try {
        setState(() {
          _isLoading = true;
        });
        await _firebaseService.registerUser(
            emailController.text, passwordController.text, nameController.text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Congratulations, your account has been successfully created')));
        _onTap();
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
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
