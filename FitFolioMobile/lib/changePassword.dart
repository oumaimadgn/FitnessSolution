import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'editProfile.dart';
import 'url.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'bar_chart.dart';

class PasswordTextField extends StatefulWidget {
  final bool isConfirm;
  final TextEditingController controller;

  const PasswordTextField(
      {Key? key, required this.isConfirm, required this.controller})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();

  String getPassword() {
    return controller.text;
  }
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    String hintText = widget.isConfirm ? 'Confirm Password' : 'New Password';

    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      onChanged: (value) {
        // You might want to handle the onChanged logic here
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF7F8F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.getFont(
          'Poppins',
          color: const Color(0xFFACA3A5),
          fontSize: 18,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class changePassword extends StatefulWidget {
  final int matricule;
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final String motDePasse;
  final int age;
  final String sexe;
  final double poids;
  final double taille;
  final String objectif;

  const changePassword({
    Key? key,
    required this.matricule,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.motDePasse,
    required this.age,
    required this.sexe,
    required this.poids,
    required this.taille,
    required this.objectif,
  }) : super(key: key);

  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //newPasswordController.text = widget.motDePasse;
  }

  Future<void> passUser() async {
    final Map<String, dynamic> requestBody = {
      'matricule': widget.matricule,
      'nom': widget.nom,
      'prenom':  widget.prenom,
      'email': widget.email,
      'poids': widget.poids,
      'taille': widget.taille,
      'objectif': widget.objectif,
      "telephone": widget.telephone,
      "motDePasse":  confirmPasswordController.text,
      "age": widget.age,
      "sexe": widget.sexe

    };

    final response = await http.put(
      Uri.parse(editurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    print('Statut de la réponse: ${response.statusCode}');
    print('Corps de la réponse: ${response.body}');
    print('Corps de la réponse: ${editurl}');
    print('passe ${confirmPasswordController.text}');

    if (response.statusCode == 200) {
      print('Enregistrement réussi');
    } else {
      print('Échec de l\'enregistrement');
    }
  }

  void _checkPasswordMatch() {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      _showErrorDialog(
          context, 'Error', 'Please make sure the passwords match.');
    } else {
      passUser();
      Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => editProfile(
            matricule: widget.matricule,
        nom: widget.nom,
        prenom: widget.prenom,
        telephone: widget.telephone,
        email: widget.email,
        motDePasse: confirmPasswordController.text,
        age: widget.age,
        sexe: widget.sexe,
        poids: widget.poids,
        taille: widget.taille,
        objectif: widget.objectif,
      ),
    ),);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => editProfile(
                                      matricule: widget.matricule,
                                      nom: widget.nom,
                                      prenom: widget.prenom,
                                      telephone: widget.telephone,
                                      email: widget.email,
                                      motDePasse: confirmPasswordController.text,
                                      age: widget.age,
                                      sexe: widget.sexe,
                                      poids: widget.poids,
                                      taille: widget.taille,
                                      objectif: widget.objectif,
                                    ),
                                  ),
                                );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Color.fromRGBO(221, 246, 250, 1);
                                  }
                                  return Colors.transparent;
                                },
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero,
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: Transform.rotate(
                              angle: 90 * pi / 180,
                              child: Image.network(
                                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F4551e0900365bba6afd0d84c7ba16c8f.png',
                                width: 12,
                                height: 20,
                                fit: BoxFit.contain,
                                color: Color.fromRGBO(121, 121, 121, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 44,
                          height: 44,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 70, 15, 0),
                  child: Center(
                    child: Container(
                      width: screenWidth,
                      height: 400,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x111D1617),
                            spreadRadius: 0,
                            offset: Offset(0, 10),
                            blurRadius: 40,
                          )
                        ],
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 27, top: 19, right: 27),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Change password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 40),
                            PasswordTextField(
                              isConfirm: false,
                              controller: newPasswordController,
                            ),
                            SizedBox(height: 30),
                            PasswordTextField(
                              isConfirm: true,
                              controller: confirmPasswordController,
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF75B7E7),
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _checkPasswordMatch,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(99),
                                        ),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 130),
                MyBarChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
