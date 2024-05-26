import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen3.dart'; // Import the WelcomeScreen3 widget

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen3()),
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
              top: 472,
              child: Text(
                'Track Your Goal',
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
              top: 523,
              child: SizedBox(
                width: 317,
                child: Text(
                  "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
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
              right: 25,
              top: 700,
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
            const Positioned(
              left: 340,
              top: 736,
              child: SizedBox.square(
                dimension: 18,
              ),
            ),
            Positioned(
              top: -45,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F31023ce5106522f79a35fd72e1db9d89.png',
                width: 415,
                height: 450,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 126,
              top: 275,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F94c7bcf11a3c8685345f1dd96e17bd1e.png',
                width: 130,
                height: 128,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 80,
              top: 196,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F125fc6a195b01bd301b15612f74eb20f.png',
                width: 66,
                height: 102,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 216,
              top: 174,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F053dab32e7aa08f5524ee216b3ef655b.png',
                width: 93,
                height: 116,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 118,
              top: 174,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fac09e30303abb9dced89313a4bf8d6c0.png',
                width: 116,
                height: 142,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 126,
              top: 75,
              child: Image.network(
                'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fb5088e6e78aadd1c622317e219ae8a0c.png',
                width: 101,
                height: 150,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
