import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard.dart';
import 'bar_chart.dart';

class SuccessRegistration extends StatelessWidget {
  final int matricule;
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final String motDePasse;
  final int age;
  final String sexe;
  final double poids;
  final double taille;
  final String objectif;

  const SuccessRegistration({
    Key? key,
    required this.matricule,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.motDePasse,
    required this.age,
    required this.sexe,
    required this.poids,
    required this.taille,
    required this.objectif,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
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
              left: 10,
              top: 0,
              child: Container(
                width: 375,
                height: 812,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFEFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 79,
                      top: 484,
                      child: SizedBox(
                        width: 216,
                        child: Text(
                          'You are all set now, let’s reach your goals together with us',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF7B6F72),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 138,
                      top: 449,
                      child: Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 40,
                      top: 650,
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
                        child: ElevatedButton(
                          onPressed: () {
                            void handleButtonPress(BuildContext context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(
                                    matricule: matricule,
                                    nom: nom,
                                    prenom: prenom,
                                    poids: poids,
                                    taille: taille,
                                  ),
                                ),
                              );
                              BarChart.processData(
                                matricule: matricule,
                                nom: nom,
                                prenom: prenom,
                                telephone: telephone,
                                email: email,
                                motDePasse: motDePasse,
                                age: age,
                                sexe: sexe,
                                poids: poids,
                                taille: taille,
                                objectif: objectif,
                              );
                            }
                            handleButtonPress(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              'Go to Home',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 49,
                      top: 102,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F1eaa957b347afca3820d4875836f2382.png',
                        width: 278,
                        height: 293,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 208,
                      top: 142,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Ffef197399c1ae5f48263ae9692e3848b.png',
                        width: 42,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 253,
                      top: 385,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F086ed5ce6b1778f7db782042ccd2df82.png',
                        width: 17,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 189,
                      top: 385,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fc9a34fbe8f8fe0bb6fa6d44c5a65c39d.png',
                        width: 16,
                        height: 19,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 192,
                      top: 241,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F2435fac328d928bdbeb558bcf0bea160.png',
                        width: 74,
                        height: 145,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 186,
                      top: 188,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F19abafa4e88a017cd89a2fc44fce3b73.png',
                        width: 35,
                        height: 68,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 207,
                      top: 184,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F9b7ca9c2f4508b9b2252514397caf199.png',
                        width: 47,
                        height: 61,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 210,
                      top: 184,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F335a5f4884a08f4ff7adcbd11b43bdb8.png',
                        width: 22,
                        height: 37,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 218,
                      top: 195,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F9cdb3ebc04407e4ccdc2da8e469c37c3.png',
                        width: 26,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 231,
                      top: 184,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F44efa70c0dd505b5f310266b37bc987e.png',
                        width: 34,
                        height: 108,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 132,
                      top: 115,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fd761cb0d810465b006faab5b53bd9c01.png',
                        width: 38,
                        height: 59,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 82,
                      top: 170,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F12ad49c578811fa6f4ce04ac51925995.png',
                        width: 47,
                        height: 55,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 157,
                      top: 302,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F17d23b7b6e025376f4597d18f7352980.png',
                        width: 34,
                        height: 104,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 103,
                      top: 299,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fe0289c34d38e27ce14964af868259479.png',
                        width: 38,
                        height: 107,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 116,
                      top: 239,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F94aa8e31d59a5b7aa3ab709f2a342ad5.png',
                        width: 67,
                        height: 67,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 123,
                      top: 162,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F30c0dd55da64c9203618b3580fc97d38.png',
                        width: 63,
                        height: 94,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 168,
                      top: 168,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F44ce02c1524af1680fcf1cbf1e456994.png',
                        width: 39,
                        height: 89,
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
