import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top:15.0,left: 20.0),
        child: Container(
          width: 36,
          height: 36,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(239, 239, 239, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: onBackPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Color.fromRGBO(221, 246, 250, 1);
                  }
                  return Colors.transparent;
                },
              ),
              elevation: MaterialStateProperty.all<double>(0),
              // No shadow
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.zero,
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child: Transform.rotate(
              angle: 90 * pi / 180,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F4551e0900365bba6afd0d84c7ba16c8f.png',
                width: 12,
                height: 12,
                fit: BoxFit.contain,
                color: Color.fromRGBO(121, 121, 121, 1),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}



class ExpandedActivityDetails extends StatelessWidget {
  final String day;
  final String activity;
  final String activityDetails;


  ExpandedActivityDetails({
    required this.day,
    required this.activity,
    required this.activityDetails,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            GestureDetector(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$day',
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF75B7E7),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$activity',
                                  style: TextStyle(
                                    color: Colors.black, // Make $breakfast black
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                                  '$activityDetails',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
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
    );
  }
}
