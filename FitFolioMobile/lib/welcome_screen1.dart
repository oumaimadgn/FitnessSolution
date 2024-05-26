import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen2.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 812,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 8,
              top: 0,
              child: Container(
                width: 375,
                height: 812,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFEFF),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 35,
                      top: 221,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2FPXACK4v7n7g5wZeLK3Hv%2F3c2983ffcd053908542fff26a86d6a458e8df971Logo%201.png?alt=media&token=d1543d27-e6fc-4332-acdf-11ad428cee9c',
                        width: 353,
                        height: 315,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 40,
                      top: 712,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen2(),
                            ),
                          );
                        },
                        child: Container(
                          width: 315,
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
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 110,
                                top: 17,
                                child: Text(
                                  'Get Started',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 150,
                      top: 447,
                      child: SizedBox(
                        width: 400,
                        height: 30,
                        child: Text(
                          'Fit for you',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF7B6F72),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
