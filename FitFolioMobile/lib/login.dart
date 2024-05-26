import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'login2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'url.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> loginUser() async {
    final Map<String, dynamic> requestBody = {
      'email': _emailController .text,
      'motDePasse': _passwordController.text
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
      final String telephone = userData['telephone'];
      final String email = userData['email'];
      final String motDePasse = userData['motDePasse'];
      final int age = userData['age'];
      final String sexe = userData['sexe'];
      final double poids = userData['poids'];
      final double taille = userData['taille'];
      final String objectif = userData['objectif'];
      final int matricule = userData['matricule'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessRegistration(
            matricule: matricule,
            nom: nom,
            prenom: prenom,
            telephone: telephone,
            email: email,
            motDePasse: motDePasse,
            age: age,
            sexe: sexe,
            poids: poids,
            taille: taille,
            objectif: objectif,
          ),
        ),
      );
    } else {
      _showErrorDialog(
        context,
        'Error',
        'Email or password incorrect.',

      );
      print('Échec de l\'enregistrement');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375,
        height: 812,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 20,
                top: 0,
                child: Container(
                  width: 375,
                  height: 812,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEFEFF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 145,
                        top: 216,
                        child: Text(
                          'Hey there,',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: Colors.black,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 108,
                        top: 245,
                        child: Text(
                          'Welcome Back',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        top: 600,
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: Colors.black,
                              fontSize: 14,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(text: 'Don’t have an account yet? '),
                              TextSpan(
                                text: 'Register',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFF4A9FDB),
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Tapped on Login');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegisterPage1()),
                                    );                                      },
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 29,
                        top: 318,
                        child: SizedBox(
                          width: 315,
                          height: 48,
                          child: TextFormField(
                            key: Key('emailField'),
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF7F8F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Email',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: const Color(0xFFACA3A5),
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 29,
                        top: 381,
                        child: SizedBox(
                          width: 315,
                          height: 48,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF7F8F8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.getFont(
                                    'Poppins',
                                    color: const Color(0xFFACA3A5),
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 29,
                        top: 450,
                        child: SizedBox(
                          width: 315,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                                if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                  _showErrorDialog(
                                    context,
                                    'Error',
                                    'Email and password are required. Please fill them in.',
                                  );
                                } else {
                                  loginUser();
                                }
                              },

                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF9DCEFF),
                              backgroundColor: const Color(0xFF4A9FDB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox.square(
                                  dimension: 24,
                                  child: Image.network(
                                    'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F1e4897674f9892d0423e5ff36ef1186a.png',
                                    width: 19,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Login',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
