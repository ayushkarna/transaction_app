import 'package:flutter/material.dart';
import 'package:transaction_app/screens/sign_up.dart';
import 'package:transaction_app/services/auth_service.dart';
import 'package:transaction_app/utils/app_validator.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  bool isLoader = false;
  var authService = AuthService();
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await authService.login(data, context);

      setState(() {
        isLoader = false;
      });
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 250,
                  child: Text(
                    "Login Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: appValidator.validateEmail,
                  decoration: _buildInputDecoration("Email", Icons.email),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: appValidator.validatePassword,
                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration("Password", Icons.lock),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF15900),
                    ),
                    onPressed: () {
                      isLoader ? print("Loading") : _submitForm();
                    },
                    child: isLoader
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpView()));
                    },
                    child: const Text(
                      "Create New Account",
                      style: TextStyle(
                        color: Color(0xFFF15900),
                        fontSize: 20,
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}

InputDecoration _buildInputDecoration(
  String label,
  IconData suffixIcon,
) {
  return InputDecoration(
    fillColor: const Color(0xAA494A59),
    filled: true,
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0x35949494))),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.white,
    )),
    labelStyle: const TextStyle(color: Color(0xFF949494)),
    suffixIcon: Icon(
      suffixIcon,
      color: const Color(0xFF949494),
    ),
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
