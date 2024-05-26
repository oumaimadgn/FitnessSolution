import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../register.dart';
import 'url.dart';
import 'dart:convert';
import 'bar_chart.dart';
import 'package:intl/intl.dart';

class RegisterPage3 extends StatefulWidget {
  final String? selectedGender;
  final DateTime? selectedDate;
  final String weight;
  final String height;

  const RegisterPage3({
    Key? key,
    required this.selectedGender,
    required this.selectedDate,
    required this.weight,
    required this.height,
  }) : super(key: key);


  @override
  _RegisterPage3State createState() => _RegisterPage3State();
}

int calculateAge(DateTime? selectedDate) {
  if (selectedDate == null) {
    return 0;
  }
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - selectedDate.year;

  bool isBeforeBirthday =
      currentDate.month < selectedDate.month ||
          (currentDate.month == selectedDate.month && currentDate.day < selectedDate.day);
  if (isBeforeBirthday) {
    age--;
  }

  return age;
}


class _RegisterPage3State extends State<RegisterPage3> {
  String? selectedGoal;
  int matricule=0;
  int idDate=0;

  Future<void> registerUser() async {
    final Map<String, dynamic> requestBody = {
      'matricule': '0',
      'nom': RegisterPage1.lastNameController.text,
      'prenom': RegisterPage1.firstNameController.text,
      'telephone': RegisterPage1.phoneNumberController.text,
      'email': RegisterPage1.emailController.text,
      'motDePasse': RegisterPage1.passwordController.text,
      'sexe': widget.selectedGender ?? '',
      'age': calculateAge(widget.selectedDate),
      'poids': widget.weight,
      'taille': widget.height,
      'objectif': selectedGoal
    };

    final response = await http.post(
      Uri.parse(apiregister),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    print('Statut de la réponse: ${response.statusCode}');
    matricule = jsonDecode(response.body)['matricule'];
    print('Matricule: $matricule');
    print('En-têtes de la réponse: ${response.headers}');
    print('Âge: ${calculateAge(widget.selectedDate)} ans');


    if (response.statusCode == 200) {
      print('Enregistrement1 réussi');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
              matricule: matricule,
              nom: RegisterPage1.lastNameController.text,
              prenom:  RegisterPage1.firstNameController.text,
              poids: double.parse(widget.weight),
              taille: double.parse(widget.height),
            )),
      );
      BarChart.processData(
        matricule: matricule,
        nom: RegisterPage1.lastNameController.text,
        prenom: RegisterPage1.firstNameController.text,
        telephone: RegisterPage1.phoneNumberController.text,
        email:  RegisterPage1.emailController.text,
        motDePasse: RegisterPage1.passwordController.text,
        age: calculateAge(widget.selectedDate),
        sexe: widget.selectedGender ?? '',
        poids: double.parse(widget.weight),
        taille: double.parse(widget.height),
        objectif: selectedGoal!,
      );
    } else {
      print('Échec de l\'enregistrement1');
    }
  }

  Future<void> registerDate() async {
    DateTime now = DateTime.now();
    DateTime futureDate = now.add(Duration(days: 3 * 30));

    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedFutureDate = DateFormat('yyyy-MM-dd').format(futureDate);

    final Map<String, dynamic> requestBody = {
       "matricule": matricule,
       "dateDebut": formattedCurrentDate,
       "dateFin": formattedFutureDate
    };

      final response = await http.post(
        Uri.parse(dateUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      idDate = jsonDecode(response.body)['idDate'];

      if (response.statusCode == 200) {
        print('Enregistrement2 réussi');
      } else {
        print('Échec de l\'enregistrement2');
      }
  }

  Future<void> updateDate() async {
    final Map<String, dynamic> requestBody = {
      "matricule": matricule,
      "dateE": idDate
    };

    final response = await http.post(
      Uri.parse(dateE),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Enregistrement3 réussi');
    } else {
      print('Échec de l\'enregistrement3');
    }
  }

  Future<void> AddRepas() async {
    final Map<String, dynamic> requestBody = {
      "matricule": matricule,
    };

    final response = await http.post(
      Uri.parse(Repas),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Enregistrement4 réussi');
    } else {
      print('Échec de l\'enregistrement4');
    }
  }

  Future<void> AddActivity() async {
    final Map<String, dynamic> requestBody = {
      "matricule": matricule,
    };

    final response = await http.post(
      Uri.parse(Activite),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Enregistrement4 réussi');
    } else {
      print('Échec de l\'enregistrement4');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFF),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 39),
            child: Text(
              'What is your goal ?',
              style: GoogleFonts.getFont(
                'Poppins',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: SizedBox(
              width: 184,
              child: Text(
                'It will help us to choose a best program for you',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: const Color(0xFF7B6F72),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ),
          Expanded(
            child: CarouselSlider(
              items: [
                _buildGoalContainer(
                  image: 'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F783c93d90542853a534d14247db60f09.png',
                  title: 'Improve Shape',
                  description: 'I have a low amount of body fat and need / want to build more muscle',
                  onTap: () {
                    setState(() {
                      selectedGoal = 'Improve Shape';
                    });
                  },
                ),
                _buildGoalContainer(
                  image: 'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fe8d96d89e75ed47b71a53e729852aa04.png',
                  title: 'Lean & Tone',
                  description: 'I’m “skinny fat”. look thin but have no shape. I want to add learn muscle in the right way',
                  onTap: () {
                    setState(() {
                      selectedGoal = 'Lean & Tone';
                    });
                  },
                ),
              ],
              options: CarouselOptions(
                height: 500,
                aspectRatio: 400 / 478,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 30),
            child: Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4C95ADFE),
                    spreadRadius: 0,
                    offset: Offset(0, 10),
                    blurRadius: 22,
                  )
                ],
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A9FDB), Color(0xFF9DCEFF)],
                  stops: [0.40, 1],
                ),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedGoal == 'Improve Shape') {
                    print('Selected Goal: Improve Shape');
                    await registerUser();
                    await registerDate();
                    await updateDate();
                    await AddRepas();
                    await AddActivity();
                  } else if (selectedGoal == 'Lean & Tone') {
                    await registerUser();
                    await registerDate();
                    await updateDate();
                    await AddRepas();
                    await AddActivity();
                    print('Selected Goal: Lean & Tone');
                  } else {
                    print('No goal selected');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalContainer({
    required String image,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 300,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4CC58BF2),
              spreadRadius: 0,
              offset: Offset(0, 10),
              blurRadius: 22,
            )
          ],
          gradient: const LinearGradient(
            colors: [Color(0xFF3694D7), Color(0xFF9DCEFF)],
          ),
        ),
        child: Column(
          children: [
            Image.network(
              image,
              width: 210,
              height: 400,
              fit: BoxFit.contain,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Poppins',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Poppins',
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
