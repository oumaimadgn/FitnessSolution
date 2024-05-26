import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFFF3F3FD),
        child: Column(
          children: [

            Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -27),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2FL6870zGYW65q3NLlDA7F%2F302b199b7102260926386b2d3adf88e00668fa81image%201.png?alt=media&token=5f4fe613-5e64-48d7-8899-c7063a090060',
                    width: screenWidth,
                    height: screenHeight * 0.87,
                    fit: BoxFit.cover,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -27),
                  child: Positioned.fill(
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.87,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0x26BBCCD7), Color(0x6884C8F8)],
                          stops: [0, 0.94],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.35,
                  width: screenWidth,
                  child: Align(
                      alignment: Alignment.center,
                      child:Transform.translate(
                          offset: Offset(0, -27),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth,
                                child: Text(
                                  'Enhance Your Lifestyle',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.black,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth,
                                height: 40,
                                child: Text(
                                  'With our recommended meal plans',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: const Color(0xFF757799),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500,
                                    height: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ))

                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child:SizedBox(
                width: 600,
                child: Text(
                  'Why is having a healthy meal plan important?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontSize: 37,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
              )
              ,
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(top: 65, bottom: 100),
              child:Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image widget
                    Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2FL6870zGYW65q3NLlDA7F%2Ff38e7d00678b09f6a7fe72de197217e9fc9931c7image%203.png?alt=media&token=08623609-2b3a-47a5-be83-a1fbaac3b9f9',
                      width: screenWidth*0.35,
                      height: 280,
                      fit: BoxFit.none,
                      alignment: const Alignment(-0.429, 0.180),
                      scale: 2.3,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width: screenWidth*0.3,
                        height: 250,
                        child: Text(
                          'Having a healthy meal plan is vital when exercising as it provides the necessary fuel to power through workouts, supports muscle growth and repair, enhances recovery, optimizes performance, manages weight, and promotes overall health. ',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 17,
                            height: 1.8,
                          ),
                        ),
                      ),

                    ),

                  ],
                ),

              ),

            ),
            SizedBox(height: 20),

            Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -27),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/IXpUTqz03udt6sSvHjhzZ00Uktl1%2Fuploads%2Fimages%2F57794080_a117_1fb6_bb18_737aae458ee8_sports_dumbbells_flat_lay_isolated_blue.jpg?alt=media',
                    width: screenWidth,
                    height: screenHeight * 0.87,
                    fit: BoxFit.cover,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -27),
                  child: Positioned.fill(
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.87,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0x26BBCCD7), Color(0x6884C8F8)],
                          stops: [0, 0.7],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.35,
                  width: screenWidth,
                  child: Align(
                      alignment: Alignment.center,
                      child:Transform.translate(
                          offset: Offset(0, -27),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth,
                                child: Text(
                                  'Enhance Your Lifestyle',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.black,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth,
                                height: 40,
                                child: Text(
                                  'With our recommended workout plans',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500,
                                    height: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ))

                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(top: 55),
              child:SizedBox(
                width: 600,
                child: Text(
                  'Why is having a workout plan important?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontSize: 37,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
              )
              ,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 65, bottom: 100),
              child:Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image widget
                    Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/IXpUTqz03udt6sSvHjhzZ00Uktl1%2Fuploads%2Fimages%2F23dfeb80_a102_1fb6_bb18_737aae458ee8_workout2.png?alt=media',
                      width: screenWidth*0.35,
                      height: 280,
                      fit: BoxFit.none,
                      alignment: const Alignment(-0.429, 0.130),
                      scale: 1.991,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width: screenWidth*0.3,
                        height: 260,
                        child: Text(
                          'Workout planners provide structure, organization, and accountability to your fitness routine. They help you set and track goals, maintain consistency, optimize your time, introduce variety, and foster a stronger mind-body connection. In short, they are essential tools for achieving and maintaining fitness goals effectively.',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 17,
                            height: 1.8,
                          ),
                          softWrap: true,
                        ),
                      ),

                    ),

                  ],
                ),

              ),

            ),

            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.6,
                color: Colors.white,
                child: Container(
                  width: screenWidth,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2FL6870zGYW65q3NLlDA7F%2F3c2983ffcd053908542fff26a86d6a458e8df971Logo%201.png?alt=media&token=eae7a62a-fed6-4a34-ab1a-00372d19279f',
                                    width: 242,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 342,
                                    height: 59,
                                    child: Text(
                                      'Lorem ipsum dolor sit amet consectetur adipiscing elit aliquam',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF6E6B8F),
                                        fontSize: 16,
                                        height: 1.6,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15), // Space between the first and second row
                                  // Second Row
                                  Container(
                                    width: 111,
                                    height: 22,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2Fd4a61aab22ccf3c5293408d73bf80206.png',
                                            width: 12,
                                            height: 22,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          left: 40,
                                          top: 2,
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F47f0da94427ff30878c08b6c158d5315.png',
                                            width: 22,
                                            height: 18,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          left: 89,
                                          top: 0,
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F70795973b267483aa1f5c7aff756d9c6.png',
                                            width: 22,
                                            height: 22,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Image widget
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F0fa6e78802cac5bbec5080563431ef7b.png',
                                            width: 17,
                                            height: 15,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        // Text widget
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            'contact@company.com',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                              'DM Sans',
                                              color: const Color(0xFF4F555A),
                                              fontSize: 16,
                                              height: 1.1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2Fa7df39383c5365887346e72b688dac87.png',
                                            width: 18,
                                            height: 18,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        // Text widget
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                                          child: Text(
                                            '(414) 687 - 5892',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                              'DM Sans',
                                              color: const Color(0xFF4F555A),
                                              fontSize: 16,
                                              height: 1.1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    // Third Row
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Image widget
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2F4947209ffc7f3f022c5ffd41c18eb4f6.png',
                                            width: 14,
                                            height: 19,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        // SizedBox with Text widget
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            '794 Marrakesh St\nMarrakesh, 94102',
                                            style: TextStyle(
                                              color: Color(0xFF4F555A),
                                              fontSize: 16,
                                              height: 1.6,
                                              fontFamily: 'Satoshi',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Third column elements
                                  Text(
                                    'About',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF4F555A),
                                      fontSize: 16,
                                      height: 1.1,
                                      fontFamily: 'Satoshi',
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Contact us',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF4F555A),
                                      fontSize: 16,
                                      height: 1.1,
                                      fontFamily: 'Satoshi',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FL6870zGYW65q3NLlDA7F%2Fef49e0e984fdab03a8b4fba84d11a31f.png',
                        width: screenWidth*0.8,
                        height: 41,
                        fit: BoxFit.contain,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SizedBox(
                              width: 216,
                              height: 30,
                              child: Text(
                                'Copyright © 2024 ',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: const Color(0xFF6E6B8F),
                                  fontSize: 15,
                                  height: 1.8,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SizedBox(
                              width: 463,
                              height: 30,
                              child: RichText(
                                textAlign: TextAlign.right,
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Color(0xFF6E6B8F),
                                    fontSize: 15,
                                    height: 1.6,
                                    fontFamily: 'Satoshi',
                                  ),
                                  children: [
                                    TextSpan(text: 'All Rights Reserved | '),
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(
                                        color: Color(0xFF4A3AFF),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
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


            )



          ],
        ),
      ),
    );
  }
}



