import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'changePassword.dart';
import 'profile.dart';
import 'url.dart';
import 'dart:convert';
import 'bar_chart.dart';
import 'package:http/http.dart' as http;

class editProfile extends StatefulWidget {
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

  const editProfile({
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
  _editProfileState createState() => _editProfileState();
}
class _editProfileState extends State<editProfile> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedGoal;
  late String _telephone;
  late String _motDePasse;
  late int _age;
  late String _sexe;
  late int _matricule;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.prenom);
    _lastNameController = TextEditingController(text: widget.nom);
    _emailController = TextEditingController(text: widget.email);
    _heightController = TextEditingController(text: widget.taille.toString());
    _weightController = TextEditingController(text: widget.poids.toString());
    _selectedGoal = widget.objectif;
    _phoneController = TextEditingController(text: widget.telephone);
    _motDePasse = widget.motDePasse;
    _age = widget.age;
    _sexe = widget.sexe;
    _matricule = widget.matricule;
  }
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> editUser() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String height = _heightController.text;
    String weight = _weightController.text;
    String phone = _phoneController.text;

    final Map<String, dynamic> requestBody = {
      "matricule": widget.matricule,
      "nom": lastName,
      "prenom": firstName,
      "email": email,
      "poids": weight,
      "taille": height,
      "objectif": _selectedGoal,
      "telephone": phone,
      "motDePasse": _motDePasse,
      "age": _age,
      "sexe": _sexe
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

    if (response.statusCode == 200) {
      print('edit reussi');
    } else {
      print('Échec de l\'enregistrement edit');
    }
  }

  Future<void> deleteMeal() async {

    final Map<String, dynamic> requestBody = {
      "matricule": widget.matricule,
    };

    final response = await http.post(
      Uri.parse(deleteRepas),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    print('Statut de la réponse: ${response.statusCode}');
    print('Corps de la réponse: ${response.body}');
    print('Corps de la réponse: ${editurl}');

    if (response.statusCode == 200) {
      print('delete repas réussi');
    } else {
      print('Échec de delete pas');
    }
  }

  Future<void> deleteAct() async {
    final Map<String, dynamic> requestBody = {
      'matricule': widget.matricule,
    };

    final response = await http.post(
      Uri.parse(deleteActivite),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    print('Statut de la réponse: ${response.statusCode}');
    print('Corps de la réponse: ${response.body}');
    print('Corps de la réponse: ${editurl}');

    if (response.statusCode == 200) {
      print('delete act reussi');
    } else {
      print('Échec de delete act');
    }
  }

  Future<void> AddRepas() async {
    final Map<String, dynamic> requestBody = {
      "matricule": widget.matricule,
    };

    final response = await http.post(
      Uri.parse(Repas),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('add repas réussi');
    } else {
      print('Échec de add repas');
    }
  }

  Future<void> AddActivity() async {
    final Map<String, dynamic> requestBody = {
      "matricule": widget.matricule,
    };

    final response = await http.post(
      Uri.parse(Activite),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('add act reussi');
    } else {
      print('echec add act ');
    }
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
                Stack(
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
                              height: 100,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
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
                              width: 40,
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
                      padding: EdgeInsets.fromLTRB(15, 80, 15, 0),
                      child: Center(
                        child: Container(
                          width: screenWidth,
                          height: 650,
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
                            padding: const EdgeInsets.only(left: 27, top: 19, right: 27),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your information',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF7F8F8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'First Name',
                                    hintStyle: GoogleFonts.getFont(
                                      'Poppins',
                                      color: const Color(0xFFACA3A5),
                                      fontSize: 18,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF7F8F8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Last Name',
                                    hintStyle: GoogleFonts.getFont(
                                      'Poppins',
                                      color: const Color(0xFFACA3A5),
                                      fontSize: 18,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
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
                                      fontSize: 18,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF75B7E7),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 11,
                                            top: 13,
                                            child: Text(
                                              'CM',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _heightController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          // Only allow digits
                                        ],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFF7F8F8),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: 'Height',
                                          hintStyle: GoogleFonts.getFont(
                                            'Poppins',
                                            color: const Color(0xFFACA3A5),
                                            fontSize: 18,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 45,
                                      height: 45,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF75B7E7),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 11,
                                            top: 13,
                                            child: Text(
                                              'KG',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _weightController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          // Only allow digits
                                        ],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFF7F8F8),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: 'Weight',
                                          hintStyle: GoogleFonts.getFont(
                                            'Poppins',
                                            color: const Color(0xFFACA3A5),
                                            fontSize: 18,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                DropdownButtonFormField<String>(
                                  value: _selectedGoal,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedGoal = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Improve Shape',
                                    'Lean & Tone',

                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF7F8F8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Select Goal',
                                    hintStyle: GoogleFonts.getFont(
                                      'Poppins',
                                      color: const Color(0xFFACA3A5),
                                      fontSize: 18,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    // Only allow digits
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF7F8F8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Phone number',
                                    hintStyle: GoogleFonts.getFont(
                                      'Poppins',
                                      color: const Color(0xFFACA3A5),
                                      fontSize: 18,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
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
                                          onPressed: () async{
                                            editUser();
                                            if(_selectedGoal!=widget.objectif){
                                              await deleteMeal();
                                              await deleteAct();
                                              print(widget.matricule);
                                              await AddRepas();
                                              await AddActivity();
                                            }
                                            else print('test no');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profile(
                                                    matricule: widget.matricule,
                                                    nom: _firstNameController.text,
                                                    prenom: _lastNameController.text,
                                                    telephone: _phoneController.text,
                                                    email: _emailController.text,
                                                    motDePasse: _motDePasse,
                                                    age: _age,
                                                    sexe: _sexe,
                                                    poids: double.parse(_weightController.text),
                                                    taille: double.parse(_heightController.text),
                                                    objectif: _selectedGoal ?? ''
                                                ),
                                              ),
                                            );
                                            BarChart.processData(
                                                matricule: widget.matricule,
                                                nom: _firstNameController.text,
                                                prenom: _lastNameController.text,
                                                telephone: _phoneController.text,
                                                email: _emailController.text,
                                                motDePasse: _motDePasse,
                                                age: _age,
                                                sexe: _sexe,
                                                poids: double.parse(_weightController.text),
                                                taille: double.parse(_heightController.text),
                                                objectif: _selectedGoal ?? ''
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(99),
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
                                SizedBox(height: 40),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => changePassword(
                                                matricule: widget.matricule,
                                                nom: _lastNameController.text,
                                                prenom: _firstNameController.text,
                                                telephone: widget.telephone,
                                                email: _emailController.text,
                                                motDePasse: widget.motDePasse,
                                                age: widget.age,
                                                sexe: widget.sexe,
                                                poids: double.tryParse(_weightController.text) ?? 0.0,
                                                taille: double.tryParse(_heightController.text) ?? 0.0,
                                                objectif:  _selectedGoal ?? "",
                                              ),
                                            ),
                                          );

                                        },
                                        icon: Icon(
                                          Icons.person,
                                          color: const Color(0xFF75B7E7),
                                        ),
                                        label: Text(
                                          'Change password',
                                          style: TextStyle(
                                            color: const Color(0xFF7B6F72),
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                MyBarChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }}
