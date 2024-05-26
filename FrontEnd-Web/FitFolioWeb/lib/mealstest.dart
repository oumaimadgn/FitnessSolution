import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'url.dart';

class MealsTracker extends StatefulWidget {
  final int matricule;

  const MealsTracker({
    Key? key,
    required this.matricule,
  }) : super(key: key);

  @override
  _MealsTrackerState createState() => _MealsTrackerState();
}

class _MealsTrackerState extends State<MealsTracker> {
  List<String>? titres;
  List<String>? descs;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    setState(() {
      _isLoading = true;
    });

    try {
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

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        titres = [];
        descs = [];
        for (var item in jsonResponse) {
          String titre = item['titre'];
          titres!.add(titre);
        }

        for (var item in jsonResponse) {
          String desc = item['description'];
          descs!.add(desc);
        }
      } else {
        // Handle HTTP error
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : titres == null || descs == null || titres!.isEmpty || descs!.isEmpty
          ? Center(child: Text('No data available'))
          : Container(
            height: screenHeight,
            color: const Color(0xFFF3F3FD),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "This week's meal planner",
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 2),
                    DataTable(
                      dividerThickness: 0.5,
                      dataRowHeight: 40.0,
                      columns: [
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: Text(''),
                          ),
                        ),
                        ...['Breakfast', 'Lunch', 'Dinner'].map((meal) => DataColumn(
                          label: Container(
                              alignment: Alignment.center,
                              child:Center(
                                child: Text(
                                  meal,
                                  textAlign: TextAlign.center,
                                ),
                            ),
                          )
                        )).toList(),
                      ],
                      rows: mealDescriptions.keys.map((day) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                day,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ...['Breakfast', 'Lunch', 'Dinner'].map((meal) {
                              Color? rowColor;
                              Color? borderColor;
                              if (day == 'Monday') {
                                rowColor = Color.fromRGBO(230, 255, 255, 1);
                                borderColor = Colors.lightBlue[100];
                              } else if (day == 'Tuesday') {
                                rowColor = Color.fromRGBO(237, 255, 242, 1);
                                borderColor = Colors.lightGreen[100];
                              } else if (day == 'Wednesday') {
                                rowColor = Color.fromRGBO(249, 243, 255, 1);
                                borderColor = Colors.purple[100];
                              } else if (day == 'Thursday') {
                                rowColor = Color.fromRGBO(255, 243, 251, 1);
                                borderColor = Colors.pink[100];
                              } else if (day == 'Friday') {
                                rowColor = Color.fromRGBO(254, 255, 243, 1);
                                borderColor = Colors.yellow[100];
                              } else if (day == 'Saturday') {
                                rowColor = Color.fromRGBO(243, 243, 255, 1);
                                borderColor = Colors.deepPurple[100];
                              } else if (day == 'Sunday') {
                                rowColor = Color.fromRGBO(255, 247, 243, 1);
                                borderColor = Colors.orange[100];
                              }
                              return DataCell(
                                GestureDetector(
                                  onTap: () {
                                    _showDescriptionModal(context, mealDescriptions[day]![meal]!);
                                  },
                                  child: Container(
                                    color: rowColor,
                                    child: Center(
                                      child: Text(
                                        mealDescriptions[day]![meal]!.split(' - ')[0],
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }



  Map<String, Map<String, String>> get mealDescriptions {
    Map<String, Map<String, String>> mealDescriptions = {};
    if (titres != null && descs != null && titres!.isNotEmpty && descs!.isNotEmpty) {
      mealDescriptions = {
        "Monday": {
          "Breakfast": "${titres![0]} - ${descs![0]}",
          "Lunch": "${titres![1]} - ${descs![1]}",
          "Dinner": "${titres![2]} - ${descs![2]}",
        },
        "Tuesday": {
          "Breakfast": "${titres![3]} - ${descs![3]}",
          "Lunch": "${titres![4]} - ${descs![4]}",
          "Dinner": "${titres![5]} - ${descs![5]}",
        },
        "Wednesday": {
          "Breakfast": "${titres![6]} - ${descs![6]}",
          "Lunch": "${titres![7]} - ${descs![7]}",
          "Dinner": "${titres![8]} - ${descs![8]}",
        },
        "Thursday": {
          "Breakfast": "${titres![9]} - ${descs![9]}",
          "Lunch": "${titres![10]} - ${descs![10]}",
          "Dinner": "${titres![11]} - ${descs![11]}",
        },
        "Friday": {
          "Breakfast": "${titres![12]} - ${descs![12]}",
          "Lunch": "${titres![13]} - ${descs![13]}",
          "Dinner": "${titres![14]} - ${descs![14]}",
        },
        "Saturday": {
          "Breakfast": "${titres![15]} - ${descs![15]}",
          "Lunch": "${titres![16]} - ${descs![16]}",
          "Dinner": "${titres![17]} - ${descs![17]}",
        },
        "Sunday": {
          "Breakfast": "${titres![18]} - ${descs![18]}",
          "Lunch": "${titres![19]} - ${descs![19]}",
          "Dinner": "${titres![20]} - ${descs![20]}",
        },
      };
    }
    return mealDescriptions;
  }

  void _showDescriptionModal(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Meal Description'),
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
