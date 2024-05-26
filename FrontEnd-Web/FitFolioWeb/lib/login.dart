import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'url.dart';
import 'dart:convert';
import 'home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> loginUser() async {
      final Map<String, dynamic> requestBody = {
        'email': _emailController.text,
        'motDePasse': _passwordController.text,
      };

      final response = await http.post(
        Uri.parse(apilogin),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      print('Statut de la réponse: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');
      print('En-têtes de la réponse: ${response.headers}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final String nom = userData['nom'];
        final String prenom = userData['prenom'];
        final int matricule = userData['matricule'];
        final String telephone = userData['telephone'];
        final String email = userData['email'];
        final String motDePasse = userData['motDePasse'];
        final int age = userData['age'];
        final String sexe = userData['sexe'];
        final double poids = userData['poids'];
        final double taille = userData['taille'];
        final String objectif = userData['objectif'];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                processData: {
                  'matricule': matricule,
                  'nom': nom,
                  'prenom': prenom,
                  'telephone': telephone,
                  'email': email,
                  'motDePasse': motDePasse,
                  'age': age,
                  'sexe': sexe,
                  'poids': poids,
                  'taille': taille,
                  'objectif': objectif,
                },
              ),
            )

        );

      } else {
        print('Échec de l\'enregistrement');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email or password incorrect.')));
      }}

    bool _validateInputs() {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      return email.isNotEmpty && password.isNotEmpty;
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F3FD),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0x89F3F3FD),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(34),
                              bottomRight: Radius.circular(34),
                            ),
                          ),
                          child: Image.network(
                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Ff064a4b5c14696efcf2a08a0f885d247.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2FPXACK4v7n7g5wZeLK3Hv%2F3c2983ffcd053908542fff26a86d6a458e8df971Logo%201.png?alt=media&token=b77302eb-b1a1-4620-af70-843f57ef733a',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 200,
                        top: 300,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.black,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'If you don’t have an account\nyou can ',
                                  ),
                                  TextSpan(
                                    text: 'Register here!',
                                    style: TextStyle(
                                      color: Color(0xFF3694D7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Register()),
                                        );
                                      },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(200, 250, 200, 1),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            children: [
                              const Center(
                                child: Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Column(
                                children: [
                                  TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: GoogleFonts.inter(
                                        color: const Color(0xFF4F555A),
                                        fontSize: 15,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFEAF0F7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  PasswordTextField(passwordController: _passwordController),
                                  const SizedBox(height: 50.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_validateInputs()) {
                                        loginUser();
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('All fields are required'),
                                          ),
                                        );
                                      }
                                    },

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3694D7),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 80, vertical: 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordTextField({Key? key, required this.passwordController}) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF4F555A),
          fontSize: 15,
        ),
        suffixIcon: IconButton(
          key: Key('password_toggle'),
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          padding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        filled: true,
        fillColor: const Color(0xFFEAF0F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      obscureText: _obscureText,
    );
  }
}
