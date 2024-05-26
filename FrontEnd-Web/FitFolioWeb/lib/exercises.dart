import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'url.dart';

class ExerciseTracker extends StatefulWidget {
  final int matricule;

  const ExerciseTracker({
    Key? key,
    required this.matricule,
  }) : super(key: key);


  @override
  _ExerciseTrackerState createState() => _ExerciseTrackerState();
}

class _ExerciseTrackerState extends State<ExerciseTracker>  {

  List<String> titres = [];
  List<String> descs = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    DateTime now = DateTime.now();
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);

    final Map<String, dynamic> requestBody = {
      "matricule": widget.matricule,
      "date": formattedCurrentDate
    };

    final response = await http.post(
      Uri.parse(fetchActivites),
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
    double containerWidth = MediaQuery.of(context).size.width / 8;

    return Material(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Color(0xFFF3F3FD),
        ),
        child: FutureBuilder(
          future: fetchActivities(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Container(
                  color: const Color(0xFFF3F3FD),
                  child: Column(
                    children: [
                      SizedBox(height: 20), // Add space between image and main content
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28), // Add horizontal inside padding
                        margin: EdgeInsets.fromLTRB(8, 76, 8, 10),  // Add horizontal margin
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Monday',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, descs[0]);
                                  },
                                  child: Container(
                                    width: containerWidth,
                                    height: 100,
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue[100],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(105, 105, 105, 0.1),
                                          spreadRadius: 0,
                                          offset: Offset(1, 0),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        titres[0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, descs[1]);
                                  },
                                  child: Container(
                                    width: containerWidth,
                                    height: 100,
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen[100],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(105, 105, 105, 0.1),
                                          spreadRadius: 0,
                                          offset: Offset(1, 0),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        titres[1],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Wednesday',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, descs[2]);
                                  },
                                  child: Container(
                                    width: containerWidth,
                                    height: 100,
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.purple[100],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(105, 105, 105, 0.1),
                                          spreadRadius: 0,
                                          offset: Offset(1, 0),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        titres[2],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Thursday',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, descs[3]);
                                  },
                                  child: Container(
                                    width: containerWidth,
                                    height: 100,
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.pink[100],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(105, 105, 105, 0.1),
                                          spreadRadius: 0,
                                          offset: Offset(1, 0),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        titres[3],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Friday',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, descs[4]);
                                  },
                                  child: Container(
                                    width: containerWidth,
                                    height: 100,
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[100],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(105, 105, 105, 0.1),
                                          spreadRadius: 0,
                                          offset: Offset(1, 0),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        titres[4],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Saturday',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, descs[5]);
                                  },
                                  child: Container(
                                    width: containerWidth,
                                    height: 100,
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple[100],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(105, 105, 105, 0.1),
                                          spreadRadius: 0,
                                          offset: Offset(1, 0),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        titres[5],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Sunday',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, descs[6]);
                                  },
                                  child: Container(
                                    width: containerWidth,
                                    height: 100,
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(105, 105, 105, 0.1),
                                          spreadRadius: 0,
                                          offset: Offset(1, 0),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        titres[6],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Color getRowColor(String day) {
    switch (day) {
      case 'Monday':
        return Color.fromRGBO(230, 255, 255, 1);
      case 'Tuesday':
        return Color.fromRGBO(237, 255, 242, 1);
      case 'Wednesday':
        return Color.fromRGBO(249, 243, 255, 1);
      case 'Thursday':
        return Color.fromRGBO(255, 243, 251, 1);
      case 'Friday':
        return Color.fromRGBO(254, 255, 243, 1);
      case 'Saturday':
        return Color.fromRGBO(243, 243, 255, 1);
      case 'Sunday':
        return Color.fromRGBO(255, 247, 243, 1);
      default:
        return Colors.white;
    }
  }



  String fetchDescription(String exercise) {
    return '$exercise ';
  }

   void _showDescriptionModal(BuildContext context, String exercise) {
    String description = fetchDescription(exercise);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exercise Description'),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

}