import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'bar_chart.dart';
import 'mealDetails.dart';
import 'url.dart';
import 'package:http/http.dart' as http;

class MealPlanner extends StatefulWidget {
  final int matricule;

  const MealPlanner({
    Key? key,
    required this.matricule,
  }) : super(key: key);


  @override
  _MealPlannerState createState() => _MealPlannerState();
}

class _MealPlannerState extends State<MealPlanner> {
  List<String> titres = [];
  List<String> descs = [];

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
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

    List<dynamic> jsonResponse = jsonDecode(response.body);
    for (var item in jsonResponse) {
      String titre = item['titre'];
      titres.add(titre);
    }

    List<dynamic> jsonResponse2 = jsonDecode(response.body);
    for (var item in jsonResponse2) {
      String desc = item['description'];
      descs.add(desc);
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
        child: FutureBuilder(
        future: fetchMeals(),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
        } else {
        return SingleChildScrollView(
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
                          width: 30,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                        Text(
                          'Meal planner',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedMealDetails(
                          day: 'Monday',
                          breakfast: titres[0],
                          lunch: titres[1],
                          dinner: titres[2],
                          breakfastDetails: descs[0],
                          lunchDetails: descs[1],
                          dinnerDetails: descs[2],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 370,
                          height: 220,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Monday',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF75B7E7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(text: 'Breakfast: '),
                                      TextSpan(
                                        text: titres[0],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lunch: '),
                                      TextSpan(
                                        text: titres[1],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Dinner: '),
                                      TextSpan(
                                        text: titres[2],
                                        style: const TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedMealDetails(
                          day: 'Tuesday',
                          breakfast: titres[3],
                          lunch: titres[4],
                          dinner: titres[5],
                          breakfastDetails: descs[3],
                          lunchDetails: descs[4],
                          dinnerDetails: descs[5],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 370,
                          height: 220,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tuesday',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF75B7E7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(text: 'Breakfast: '),
                                      TextSpan(
                                        text: titres[3],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lunch: '),
                                      TextSpan(
                                        text: titres[4],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Dinner: '),
                                      TextSpan(
                                        text: titres[5],
                                        style: const TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedMealDetails(
                          day: 'Wednesday',
                          breakfast: titres[6],
                          lunch: titres[7],
                          dinner: titres[8],
                          breakfastDetails: descs[6],
                          lunchDetails: descs[7],
                          dinnerDetails: descs[8],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 370,
                          height: 220,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Wednesday',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF75B7E7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(text: 'Breakfast: '),
                                      TextSpan(
                                        text: titres[6],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lunch: '),
                                      TextSpan(
                                        text: titres[7],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Dinner: '),
                                      TextSpan(
                                        text: titres[8],
                                        style: const TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedMealDetails(
                          day: 'Thursday',
                          breakfast: titres[9],
                          lunch: titres[10],
                          dinner: titres[11],
                          breakfastDetails: descs[9],
                          lunchDetails: descs[10],
                          dinnerDetails: descs[11],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 370,
                          height: 220,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Thursday',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF75B7E7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(text: 'Breakfast: '),
                                      TextSpan(
                                        text: titres[9],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lunch: '),
                                      TextSpan(
                                        text: titres[10],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Dinner: '),
                                      TextSpan(
                                        text: titres[11],
                                        style: const TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedMealDetails(
                          day: 'Friday',
                          breakfast: titres[12],
                          lunch: titres[13],
                          dinner: titres[14],
                          breakfastDetails: descs[12],
                          lunchDetails: descs[13],
                          dinnerDetails: descs[14],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 370,
                          height: 220,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Friday',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF75B7E7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(text: 'Breakfast: '),
                                      TextSpan(
                                        text: titres[12],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lunch: '),
                                      TextSpan(
                                        text: titres[13],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Dinner: '),
                                      TextSpan(
                                        text: titres[14],
                                        style: const TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedMealDetails(
                          day: 'Saturday',
                          breakfast: titres[15],
                          lunch: titres[16],
                          dinner: titres[17],
                          breakfastDetails: descs[15],
                          lunchDetails: descs[16],
                          dinnerDetails: descs[17],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 370,
                          height: 220,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Saturday',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF75B7E7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(text: 'Breakfast: '),
                                      TextSpan(
                                        text: titres[15],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lunch: '),
                                      TextSpan(
                                        text: titres[16],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Dinner: '),
                                      TextSpan(
                                        text: titres[17],
                                        style: const TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedMealDetails(
                          day: 'Sunday',
                          breakfast: titres[18],
                          lunch: titres[19],
                          dinner: titres[20],
                          breakfastDetails: descs[18],
                          lunchDetails: descs[19],
                          dinnerDetails: descs[20],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 370,
                          height: 220,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sunday',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF75B7E7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(text: 'Breakfast: '),
                                      TextSpan(
                                        text: titres[18],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lunch: '),
                                      TextSpan(
                                        text: titres[19],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFAB8DA8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Dinner: '),
                                      TextSpan(
                                        text: titres[20],
                                        style: const TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                MyBarChart(),
              ],
            ),
          ),
        );
        }
        },
        ),
      ),
    );
  }}