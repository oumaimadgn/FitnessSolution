import 'dart:convert';
import 'main.dart';
import 'url.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'activityPlanner.dart';
import 'bar_chart.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final int matricule;
  final String nom;
  final String prenom;
  final double poids;
  final double taille;

  const Dashboard({
    Key? key,
    required this.matricule,
    required this.nom,
    required this.prenom,
    required this.poids,
    required this.taille,
  }) : super(key: key);


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    fetchMealDay().then((_) {
      fetchActivityDay();
    });
  }

  List<double> meals = [];
  late double totalCalories = 1;
  String activityTitle = "";

  Future<void> fetchMealDay() async {
    DateTime now = DateTime.now();
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);

    final Map<String, dynamic> requestBody = {
      "matricule": BarChart.processedData?['matricule'],
      "date": formattedCurrentDate
    };

    final response = await http.post(
      Uri.parse(FetchRepasJour),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    List<dynamic> meals = jsonDecode(response.body);
    meals.forEach((meal) {
      print(meal['nbrCalories']);
    });
    double total = meals.fold(0, (sum, meal) => sum + meal['nbrCalories']);
    setState(() {
      totalCalories = total;
    });
  }

  Future<void> fetchActivityDay() async {
    print('ok acti');

    DateTime now = DateTime.now();
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);

    final Map<String, dynamic> requestBody = {
      "matricule": BarChart.processedData?['matricule'],
      "date": formattedCurrentDate
    };

    final response = await http.post(
      Uri.parse(FetchActiviteJour),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      List<dynamic> activities = jsonDecode(response.body);
      if (activities.isNotEmpty) {
        String title = activities[0]['titre'];
        setState(() {
          activityTitle = title;
        });
      } else {
        print('No activity found');
      }
    } else {
      print('Failed to fetch activity: ${response.statusCode}');
    }

  }


    @override
    Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final String Name = BarChart.processedData?['nom'];
    final double Calories = totalCalories;
    final String TodaysActivity = activityTitle;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight*1.3,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 33, top: 40),
                      child: Text(
                        'Welcome Back,',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: const Color(0xFFACA3A5),
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 33,
                      top: 61,
                      child: Text(
                        '$Name',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: const Color(0xFF1D1517),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 106,
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          width: 350,
                          height: 254,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                            ),
                          ),
                          child: Container(
                            color: const Color(0x33000000),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 51,
                      top: 134,
                      child: SizedBox(
                        height: 24,
                        child: Text(
                          'Today\'s Target',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF1D1517),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 51,
                      top: 175,
                      child: Container(
                        width: 138,
                        height: 70,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      top: 188,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F3a565b949e5ec0cfb2295d2d89d797c4.png',
                        width: 27,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 95,
                      top: 186,
                      child: SizedBox(
                        height: 24,
                        child: Text(
                          '2L',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 95,
                      top: 210,
                      child: SizedBox(
                        height: 23,
                        child: Text(
                          'Water Intake',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF7B6F72),
                            fontSize: 12,
                            height: 1.7,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 200,
                      top: 175,
                      child: Container(
                        width: 138,
                        height: 70,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 210,
                      top: 188,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/e4j5ycvLX5a2AzGmlOiqWlziemN2%2Fuploads%2Fimages%2F960eb10c_d5d0_4d15_a578_a82b0b999abb.png?alt=media',
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 260,
                      top: 186,
                      child: SizedBox(
                        height: 24,
                        child: Text(
                          '10,000',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 260,
                      top: 210,
                      child: SizedBox(
                        height: 23,
                        child: Text(
                          'Foot Steps',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF7B6F72),
                            fontSize: 12,
                            height: 1.7,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 52,
                      top: 256,
                      child: Container(
                        width: 292,
                        height: 69,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x111D1617),
                              spreadRadius: 0,
                              offset: Offset(0, 10),
                              blurRadius: 40,
                            )
                          ],),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 13,
                              top: 13,
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/e4j5ycvLX5a2AzGmlOiqWlziemN2%2Fuploads%2Fimages%2F8e82b948_d5fd_4671_ba68_da24e02cf425.png?alt=media',
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 119,
                      top: 267,
                      child: SizedBox(
                        width: 37,
                        height: 24,
                        child: Text(
                          '8H',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 120,
                      top: 287,
                      child: SizedBox(
                        width: 170,
                        height: 23,
                        child: Text(
                          'Sleep Need',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF7B6F72),
                            fontSize: 12,
                            height: 1.7,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 33,
                      top: 380,
                      child: Container(
                        width: screenWidth - 60,
                        height: 200,
                        child: BMIGraph(widget.poids, widget.taille),
                      ),
                    ),

                    Positioned(
                      left: 33,
                      top: 600,
                      child: Container(
                        width: screenWidth - 60,
                        height: 200,
                        child: CalorieGraph(Calories),
                      ),
                    ),

                    Positioned(
                      left: 33,
                      top: 830,
                      child: Container(
                        width: screenWidth - 60,
                        height: 150,
                        child: TodayActivity(TodaysActivity),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyBarChart(),
            ],
          ),
        ),
      ),
    );
  }
}


class BMIGraph extends StatelessWidget {
  final double weight;
  final double height;

  const BMIGraph(this.weight, this.height);

  double _calculateBMI(double weight, double height) {
    double heightInMeters = height / 100.0; // Convert cm to meters
    return weight / (heightInMeters * heightInMeters);
  }

  String _getBMIStatus(double bmiValue) {
    if (bmiValue < 18.5) {
      return 'Underweight';
    } else if (bmiValue >= 18.5 && bmiValue < 24.9) {
      return 'Normal weight';
    } else if (bmiValue >= 24.9 && bmiValue < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmiValue = _calculateBMI(weight, height);
    String bmiStatus = _getBMIStatus(bmiValue);
    return Positioned(
      left: 32,
      top: 370,
      child: Container(
        width: 331,
        height: 150,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4C95ADFE),
              spreadRadius: 0,
              offset: Offset(0, 10),
              blurRadius: 22,
            )
          ],
          gradient: const LinearGradient(
            colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fda8523192c153eaf7f1aa127e9acfac2.png',
                width: 331,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 16,
              top: 49,
              child: SizedBox(
                width: 172,
                height: 24,
                child: Text(
                  'BMI (Body Mass Index)',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 76,
              child: SizedBox(
                width: 166,
                height: 21,
                child: Text(
                  'Your Result :',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 95,
              child: SizedBox(
                width: 166,
                height: 21,
                child: Text(
                  bmiStatus,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 208,
              top: 40,
              child: Container(
                width: 102,
                height: 100,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x111D1617),
                      spreadRadius: 0,
                      offset: Offset(0, 10),
                      blurRadius: 40,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 217,
              top: 37,
              child: Container(
                width: 125,
                height: 90,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F2e8bf8ac295842d76ae295ca83792d73.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x4CC58BF2),
                      spreadRadius: 0,
                      offset: Offset(0, 10),
                      blurRadius: 22,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 262,
              top: 60,
              child: SizedBox(
                child: Text(
                  bmiValue.toStringAsFixed(1),
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalorieGraph extends StatelessWidget {
  final double caloriesConsumed;

  const CalorieGraph(this.caloriesConsumed);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x111D1617),
            spreadRadius: 0,
            offset: Offset(0, 10),
            blurRadius: 50,
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center.add(const Alignment(0, 0)),
        children: [
          Positioned(
            left: 20,
            top: 40,
            child: SizedBox(
              child: Text(
                'Calories',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 70,
            child: SizedBox(
              child: Text(
                '$caloriesConsumed Cal',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Color(0xFF92A3FD),
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 100,
            child: SizedBox(
              child: Text(
                'Here are the calories\nyou should consume\ntoday.',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.grey,
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            width: 110,
            height: 110,
            right: 19,
            child: CircularProgressIndicator(
              value: (2000 - caloriesConsumed) / 2000,
              backgroundColor: Color(0xFF92A3FD),
              strokeWidth: 10,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          Positioned(
            width: 90,
            height: 90,
            right: 28,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                ),
              ),
            ),
          ),
          Positioned(
            right: 45,
            child:
              Text(
                '$caloriesConsumed',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
          )
        ],
      ),
    );
  }
}

class TodayActivity extends StatelessWidget {
  final String TodaysActivity;
  const TodayActivity(this.TodaysActivity);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x111D1617),
            spreadRadius: 0,
            offset: Offset(0, 10),
            blurRadius: 50,
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center.add(const Alignment(0, 0)),
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: SizedBox(
              child: Text(
                'Today\'s Activity',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 230,
            top: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityPlanner(matricule: BarChart.processedData?['matricule'],)),
                );
              },
              child: SizedBox(
                child: Text(
                  'See more',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.grey,
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            width: 50,
            height: 40,
            left: 25,
            top : 70,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 90,
            top : 75,
            child: SizedBox(
              child: Text(
                '$TodaysActivity',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.grey,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}