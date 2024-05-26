import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'register.dart';

class WelcomeScreen4 extends StatelessWidget {
  const WelcomeScreen4({Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage1()),
        );
      },
      child: Container(
        width: 350,
        height: 812,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color(0xFFFEFEFF),
        ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: Container(
                  width: 400,
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
                        left: 29,
                        top: 469,
                        child: Text(
                          'Eat Well',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF1D1517),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 29,
                        top: 520,
                        child: SizedBox(
                          width: 317,
                          child: Text(
                            "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: const Color(0xFF7B6F72),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 285,
                        top: 712,
                        child: Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: const Color(0xFFF7F8F8),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 306,
                        top: 733,
                        child: SizedBox.square(
                          dimension: 18,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox.square(
                                  dimension: 18,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 6,
                                        top: 4,
                                        child: Transform.rotate(
                                          angle: 90 * pi / 180,
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F03eff90e1d1cbd9dc111b3b706d5b166.png',
                                            width: 5,
                                            height: 11,
                                            fit: BoxFit.contain,
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
                      ),
                      Positioned(
                        left: 0,
                        top: -15,
                        child: Container(
                          width: 600,
                          height: 450,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                child: Image.network(
                                  'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fca98c41465962dce9482c4f870153ec5.png',
                                  width: 400,
                                  height: 450,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                left: 155,
                                top: 87,
                                child: Image.network(
                                  'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F19c1589501af88b641b3fc292a8097d9.png',
                                  width: 73,
                                  height: 114,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                left: 119,
                                top: 198,
                                child: Image.network(
                                  'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F02fcd50cfa9de4341a563d6256c05809.png',
                                  width: 153,
                                  height: 241,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                left: 55,
                                top: 213,
                                child: Image.network(
                                  'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F296d603c20f2292cf8d518a5b8b6c444.png',
                                  width: 93,
                                  height: 204,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                left: 204,
                                top: 218,
                                child: Image.network(
                                  'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F67f062a122d5506ef2c6728a8870275e.png',
                                  width: 159,
                                  height: 156,
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        bottom: 40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage1()),
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: const Color(0xFFF7F8F8),
                              ),
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3694D7), Color(0xFF9DCEFF)],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
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
