import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen4.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen4()),
        );
      },
      child: Container(
        width: 375,
        height: 812,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color(0xFFFEFEFF),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 29,
              top: 469,
              child: Text(
                'Get Burn',
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
                    'Let’s keep burning, to achieve your goals, it hurts only temporarily, if you give up now you will be in pain forever',
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
                right: 20,
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen4()),
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
              Positioned(
                left: -13,
                top: -10,
                child: Container(
                  width: 500,
                  height: 406,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -38,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Ffb615fecb8702a7215ed86e97a2a791e.png',
                          width: 700,
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 143,
                        top: 152,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F35c78cdf73a3d1884aef1f2a6ff36dea.png',
                          width: 46,
                          height: 54,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 174,
                        top: 133,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F50221c33786ec7c1ed146ade1e429285.png',
                          width: 60,
                          height: 89,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 183,
                        top: 83,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F26dbcb8921b8b31a88caba30aaf6c6fb.png',
                          width: 42,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 216,
                        top: 136,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F589ee9a3274e9a24dcd9146195821507.png',
                          width: 62,
                          height: 98,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 184,
                        top: 240,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F4727ddf9677cd1cf7155111efb5c6c46.png',
                          width: 147,
                          height: 87,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 62,
                        top: 214,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F75dc5c723ef8903554376b16bfb3c82c.png',
                          width: 167,
                          height: 192,
                          fit: BoxFit.contain,
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
