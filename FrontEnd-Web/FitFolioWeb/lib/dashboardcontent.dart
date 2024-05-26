import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'exercises.dart';
import 'dart:convert';
import 'url.dart';
import 'package:http/http.dart' as http;

class Dashboard2 extends StatefulWidget {
  final int matricule;
  final String nom;
  final String prenom;
  final double poids;
  final double taille;

  const Dashboard2({
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

class _DashboardState extends State<Dashboard2> {

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
  String activityDesc = "";

  Future<void> fetchMealDay() async {
    DateTime now = DateTime.now();
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);

    final Map<String, dynamic> requestBody = {
      "matricule": widget.matricule,
      "date": formattedCurrentDate
    };

    final response = await http.post(
      Uri.parse(fetchRepas),
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
    DateTime now = DateTime.now();
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);

    final Map<String, dynamic> requestBody = {
      "matricule": widget.matricule,
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
        String desc = activities[0]['description'];
        setState(() {
          activityTitle = title;
          activityDesc = desc;
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

    final String Name = widget.nom;
    final double Calories = totalCalories;
    final String TodaysActivity = activityTitle;
    final String ActivityDesc = activityDesc;

    return Scaffold(
        body: Container(
            width: screenWidth,
            height: screenHeight,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F3FD),
            ),
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                    children: [
                      Center(
                        child:Container(
                          width: screenWidth*0.9,
                          height: screenHeight,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF3F3FD),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 33, top: 45),
                                child: Text(
                                  'Welcome Back,',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.black45,
                                    fontSize: 25,
                                    height: 0.5,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 35,
                                top: 68,
                                child: Text(
                                  '$Name',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: const Color(0xFF1D1517),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 150, left: 0),
                                  child: Center(
                                    child: Container(
                                      width: screenWidth*0.85,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: Column(
                                                    children: [
                                                      IntrinsicHeight(
                                                        child: Container(
                                                          width: screenWidth * 0.18,
                                                          clipBehavior: Clip.hardEdge,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(12),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 3,
                                                                blurRadius: 7,
                                                                offset: Offset(0, 3),
                                                              ),
                                                            ],
                                                          ),
                                                          padding: EdgeInsets.all(30),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Image.network(
                                                                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F3a565b949e5ec0cfb2295d2d89d797c4.png',
                                                                width: 37,
                                                                height: 50,
                                                                fit: BoxFit.contain,
                                                              ),
                                                              SizedBox(height: 10),
                                                              SizedBox(
                                                                height: 24,
                                                                child: Text(
                                                                  '2L',
                                                                  style: GoogleFonts.getFont(
                                                                    'Poppins',
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                child: Text(
                                                                  'Water Intake',
                                                                  style: GoogleFonts.getFont(
                                                                    'Poppins',
                                                                    color: const Color(0xFF7B6F72),
                                                                    fontSize: 14,
                                                                    height: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: Column(
                                                    children: [
                                                      IntrinsicHeight(
                                                        child: Container(
                                                          width: screenWidth * 0.18,
                                                          clipBehavior: Clip.hardEdge,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(12),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 3,
                                                                blurRadius: 7,
                                                                offset: Offset(0, 3),
                                                              ),
                                                            ],
                                                          ),
                                                          padding: EdgeInsets.all(30),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Image.network(
                                                                'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/e4j5ycvLX5a2AzGmlOiqWlziemN2%2Fuploads%2Fimages%2F960eb10c_d5d0_4d15_a578_a82b0b999abb.png?alt=media',
                                                                width: 45,
                                                                height: 50,
                                                                fit: BoxFit.contain,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                height: 24,
                                                                child: Text(
                                                                  '10,000',
                                                                  style: GoogleFonts.getFont(
                                                                    'Poppins',
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                child: Text(
                                                                  'Foot Steps',
                                                                  style: GoogleFonts.getFont(
                                                                    'Poppins',
                                                                    color: const Color(0xFF7B6F72),
                                                                    fontSize: 14,
                                                                    height: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: Column(
                                                    children: [
                                                      IntrinsicHeight(
                                                        child: Container(
                                                          width: screenWidth * 0.18,
                                                          clipBehavior: Clip.hardEdge,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(12),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 3,
                                                                blurRadius: 7,
                                                                offset: Offset(0, 3),
                                                              ),
                                                            ],
                                                          ),
                                                          padding: EdgeInsets.all(30),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Image.network(
                                                                'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/e4j5ycvLX5a2AzGmlOiqWlziemN2%2Fuploads%2Fimages%2F8e82b948_d5fd_4671_ba68_da24e02cf425.png?alt=media',
                                                                width: 65,
                                                                height: 50,
                                                                fit: BoxFit.contain,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                height: 24,
                                                                child: Text(
                                                                  '8H',
                                                                  style: GoogleFonts.getFont(
                                                                    'Poppins',
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                child: Text(
                                                                  'Sleep Needed',
                                                                  style: GoogleFonts.getFont(
                                                                    'Poppins',
                                                                    color: const Color(0xFF7B6F72),
                                                                    fontSize: 14,
                                                                    height: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                               ],
                                            ),

                                          ),
                                          SizedBox(height: 35,),
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 0.0),
                                                  child: Column(
                                                    children: [
                                                      IntrinsicHeight(
                                                        child: Container(
                                                          width: screenWidth*0.287,
                                                          height: 180,
                                                          child: CalorieGraph(Calories),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 0.0),
                                                  child: Column(
                                                    children: [
                                                      IntrinsicHeight(
                                                        child: Container(
                                                          width: screenWidth * 0.26,
                                                          height: 180,
                                                          child: BMIGraph(widget.poids, widget.taille),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.00),
                                                  child: Column(
                                                    children: [
                                                      IntrinsicHeight(
                                                        child: Container(
                                                          width: screenWidth * 0.26,
                                                          height: 180,
                                                          child: Container(
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
                                                                  right: 30,
                                                                  top: 20,
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(builder: (context) => ExerciseTracker(matricule: widget.matricule)),
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
                                                                  top : 77,
                                                                  child: SizedBox(
                                                                    child: Text(
                                                                      '$TodaysActivity',
                                                                      style: GoogleFonts.getFont(
                                                                        'Poppins',
                                                                        color: Colors.black,
                                                                        fontSize: 16,
                                                                        height: 1.5,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 30,
                                                                  top: 120,
                                                                  right: 30,
                                                                  child: SizedBox(
                                                                    width: double.infinity,
                                                                    child: Text(
                                                                      '$ActivityDesc',
                                                                      style: GoogleFonts.getFont(
                                                                        'Poppins',
                                                                        color: Colors.grey,
                                                                        fontSize: 14,
                                                                        height: 1.5,
                                                                      ),
                                                                      softWrap: true,
                                                                    ),
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
                                              ],
                                            ),

                                          ),


                                        ],
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                    ]
                )
            )
        )
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
     return Positioned(
      right: 50,
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
              left: 10,
              top: 0,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fda8523192c153eaf7f1aa127e9acfac2.png',
                width: 331,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 23,
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
              left: 23,
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
              right: 30,
              child: SizedBox(
                height: 21,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _getBMIStatus(bmiValue),
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
            ),
            Positioned(
              left: 270,
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
              left: 280,
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
              right: 32,
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
            top: 20,
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
            top: 50,
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
            top: 80,
            child: SizedBox(
              child: Text(
                'Here are the calories you\nshould consume today.',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.grey,
                  fontSize: 15,
                  height: 1.5,
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