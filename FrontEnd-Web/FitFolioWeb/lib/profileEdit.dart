import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
import 'url.dart';
import 'home.dart';

class Profile extends StatelessWidget {
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

  const Profile({
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
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Profile'),
          ),
          body:  HomePage(profile: Profile(
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
          ))
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  final Profile profile;

  const HomePage({Key? key, required this.profile}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _backgroundColor = Colors.transparent;
  bool _isFocused = false;
  Color _selectedColor = Color.fromRGBO(240, 248, 255, 1);
  Color _defaultColor = Colors.transparent;
  List<bool> _isHovered = [false, false, false, false, false];

  DateTime? _selectedDate;
  String? _selectedGoal;
  late String _telephone;
  late String _motDePasse;
  late int _age;
  late String _sexe;
  late int _matricule;

  int _selectedIndex = 0;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  String? _passwordError;
  String? _confirmPasswordError;
  String? _MismatchPasswordError;
  bool _passwordsMatch() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.profile.prenom);
    _lastNameController = TextEditingController(text: widget.profile.nom);
    _emailController = TextEditingController(text: widget.profile.email);
    _heightController = TextEditingController(text: widget.profile.taille.toString());
    _weightController = TextEditingController(text: widget.profile.poids.toString());
    _selectedGoal = widget.profile.objectif;
    _phoneController = TextEditingController(text: widget.profile.telephone);
    _motDePasse = widget.profile.motDePasse;
    _age = widget.profile.age;
    _sexe = widget.profile.sexe;
    _matricule = widget.profile.matricule;
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
    double height = double.tryParse(_heightController.text) ?? 1.0;
    double weight = double.tryParse(_weightController.text) ?? 1.0;
    String phone = _phoneController.text;

    final Map<String, dynamic> requestBody = {
      "matricule": widget.profile.matricule,
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


  Future<void> editUserWithPassword() async {
    String password = _passwordController.text;
    final Map<String, dynamic> requestBody = {
      "matricule": widget.profile.matricule,
      "nom": widget.profile.nom,
      "prenom":  widget.profile.prenom,
      "email":  widget.profile.email,
      "poids":  widget.profile.poids,
      "taille":  widget.profile.taille,
      "objectif": _selectedGoal,
      "telephone":  widget.profile.telephone,
      "motDePasse": password,
      "age": widget.profile.age,
      "sexe": widget.profile.sexe
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

    if (response.statusCode == 200) {
      print('Enregistrement réussi');
    } else {
      print('Échec de l\'enregistrement');
    }
  }


  Future<void> deleteMeal() async {

    final Map<String, dynamic> requestBody = {
      "matricule": widget.profile.matricule,
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
      print('Échec de delete repas');
    }
  }

  Future<void> deleteAct() async {
    final Map<String, dynamic> requestBody = {
      'matricule': widget.profile.matricule,
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
      "matricule": widget.profile.matricule,
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
      "matricule": widget.profile.matricule,
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



  bool _validateEmail(String email) {
    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  bool isStrongPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  bool _validateInputs() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword && confirmPassword.isNotEmpty) {
      setState(() {
        _MismatchPasswordError = "Passwords don't match";
      });
    } else {
      setState(() {
        _MismatchPasswordError = null; // Clear error if passwords match
      });
    }

    // Check if other fields are not empty and there are no confirmation password errors
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        _MismatchPasswordError == null;
  }

  bool _showChangePassword = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3FD),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: screenWidth * 0.18,
            height: screenHeight * 0.8,
            margin: EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 39, left: 15, right: 15),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _buildTile(0, 'User profile'),
                        const SizedBox(height: 10.0),
                        _buildTile(1, 'Terms & Conditions'),
                        const SizedBox(height: 10.0),
                        _buildTile(2, 'Contact Us'),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 23),
                    child: Container(
                      width: screenWidth * 0.1,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE9E9),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 11),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Logout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Main content
          Expanded(
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(130, 40, 150, 1),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: screenWidth,
                    child: _selectedIndex == 1 // If "Terms & Conditions" is selected
                        ? _buildTermsConditionsForm()
                        : (_selectedIndex == 2
                        ? _buildContactUsForm() // If "Contact Us" is selected
                        : _buildUserProfileForm()), // Default is user profile
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTermsConditionsForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontFamily: 'Roboto',
          ),
          children: [
            TextSpan(
              text: 'Terms and Conditions\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.0,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: '\n\nBy accessing, you agree to be bound by these Terms and Conditions.\n\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: 'Use Limitation\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Color.fromRGBO(81, 81, 119, 1),
                // Crimson red color for subheadings
              ),
            ),
            TextSpan(
              text: '\n\t\tYou may use FitFolio for your personal, non-commercial use only. You may not use the app for any illegal or unauthorized purpose.\n\n',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,

              ),
            ),
            TextSpan(
              text: 'Responsibility\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Color.fromRGBO(81, 81, 119, 1),
              ),
            ),
            TextSpan(
              text: '\n\t\tYou are responsible for maintaining the confidentiality of your account and password and for restricting access to your account. You agree to accept responsibility for all activities that occur under your account.\n\n',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: 'Disclaimer\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Color.fromRGBO(81, 81, 119, 1),
              ),
            ),
            TextSpan(
              text: '\n\t\tThe activities, meals, and other content provided are for informational purposes only and should not be considered medical advice. Consult with a healthcare provider before starting any fitness program.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildContactUsForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Want to get in touch?\nHere\'s how you can reach us ...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '123-456-7890',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'example@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w100,

            ),
          ),
        ],
      ),
    );
  }


  Widget _buildUserProfileForm() {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _showChangePassword ? "Change Password" : "Edit Profile",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20.0),
        if (!_showChangePassword) ...[
          // Edit Profile Form
          DropdownButtonFormField<String>(
            value: _selectedGoal,
            onChanged: (newValue) {
              setState(() {
                _selectedGoal = newValue;
              });
            },
            items: <String>['Improve Shape', 'Lean & Tone']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              hintText: "Selected Goal",
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Border radius when focused
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),

          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: 'First name',
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last name",
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              hintText: "Phone number",
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          const SizedBox(height: 10.0),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: "Height",
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: "Weight",
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _showChangePassword = true;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color.fromRGBO(75, 159, 220, 1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                   padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),

                ),
                child: Text(
                  'Change Password',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: const Color(0xFF0A83DB),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async{
                  editUser();
                  if(_selectedGoal!=widget.profile.objectif){
                    await deleteMeal();
                    await deleteAct();
                    print(widget.profile.matricule);
                    await AddRepas();
                    await AddActivity();
                  }
                  else print('error');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(
                          processData: {
                            'matricule': _matricule,
                            'nom': _lastNameController.text,
                            'prenom':  _firstNameController.text,
                            'telephone':  _phoneController.text,
                            'email':  _emailController.text,
                            'motDePasse': widget.profile.motDePasse,
                            'age': _age,
                            'sexe': _sexe,
                            'poids': double.parse(_weightController.text),
                            'taille': double.parse(_heightController.text),
                            'objectif': _selectedGoal ?? '',
                          },
                        ),
                      )
                  );                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(75, 159, 220, 1),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
                child: Text(
                  'Save changes AYA',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),



        ] else ...[
          // Change Password Form
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_MismatchPasswordError != null) Text(_MismatchPasswordError!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 5),
                PasswordTextField(passwordController: _passwordController),
                if (_passwordError != null) Text(_passwordError!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 10),
                ConfirmPasswordTextField(confirmPasswordController: _confirmPasswordController),
                if (_confirmPasswordError != null) Text(_confirmPasswordError!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 20),

                ElevatedButton(
                    onPressed: () {
                      editUserWithPassword();
                      setState(() {
                        // Reset error messages
                        _passwordError = null;
                        _confirmPasswordError = null;
                        _MismatchPasswordError= null;
                        if (!_validateInputs()) {
                          // Input validation failed
                          if (_passwordController.text.isEmpty) {
                            _passwordError = 'Please enter your password';
                          }
                          if (_confirmPasswordController.text.isEmpty) {
                            _confirmPasswordError = 'Please confirm your password';
                          }
                        } else if (!_passwordsMatch()) {
                          // Passwords don't match
                          _MismatchPasswordError = 'Passwords do not match';
                        } else {
                          editUserWithPassword();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(
                                  processData: {
                                    'matricule': widget.profile.matricule,
                                    'nom': widget.profile.nom,
                                    'prenom': widget.profile.prenom,
                                    'telephone': widget.profile.telephone,
                                    'email': widget.profile.email,
                                    'motDePasse': widget.profile.motDePasse,
                                    'age': widget.profile.age,
                                    'sexe':widget.profile.sexe,
                                    'poids': widget.profile.poids,
                                    'taille': widget.profile.taille,
                                    'objectif': widget.profile.objectif,
                                  },
                                ),
                              )

                          );

                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(75, 159, 220, 1),
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    child: Text(
                      'Save changes',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.3,
                      ),)
                ),
                SizedBox(height: 10),


              ],
            ),
          ),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              setState(() {
                _showChangePassword = false;
              });
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
          ),
        ],
      ],
    );
  }
  Widget _buildTile(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _selectedIndex == index ? _selectedColor : (_isHovered[index] ? _selectedColor : _defaultColor),
          borderRadius: BorderRadius.circular(45),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            if (_selectedIndex != index) {
              setState(() {
                _isHovered[index] = true;
              });
            }
          },
          onExit: (_) {
            setState(() {
              _isHovered[index] = false;
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                _getImageUrl(index),
                width: _getImageWidth(index),
              ),
              SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
String _getImageUrl(int index) {
  switch (index) {
    case 0:
      return 'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2Fadaaa4aa723f429c7ecd4ccae16dc7e3.png';
    case 1:
      return 'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F5a9c6d8a1e3f3174cfdff6342c4df219.png';
    case 2:
      return 'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F1b6afb028c43c2ee8a2fdfc16c6ade7c.png';
    case 3:
      return 'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F42ff23444973e734d60c0357954990c7.png';
    case 4:
      return 'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2Ffd4b84599bcf3da9db3275173af4e85e.png';
    default:
      return '';
  }
}

double _getImageWidth(int index) {
  return index == 0 ? 13 : 15;
}
class NavButton extends StatelessWidget {
  final String title;
  final Color color;

  const NavButton({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your navigation logic here
      },
      child: Text(
        title,
        style: TextStyle(color: color),
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


class ConfirmPasswordTextField extends StatefulWidget {
  final TextEditingController confirmPasswordController;

  const ConfirmPasswordTextField({Key? key, required this.confirmPasswordController}) : super(key: key);

  @override
  State<ConfirmPasswordTextField> createState() => _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.confirmPasswordController,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF4F555A),
          fontSize: 15,
        ),
        suffixIcon: IconButton(
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


