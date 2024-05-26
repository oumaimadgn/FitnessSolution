import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'editProfile.dart';
import 'bar_chart.dart';
import 'Terms.dart';
import 'ContactUs.dart';
import 'login.dart';

class Profile extends StatelessWidget {
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

  const Profile({
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
    required this.objectif
  }) : super(key: key);

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
            child: SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Center(
                                  child: Container(
                                width: 330,
                                height: 50,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => editProfile(
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
                                              ),
                                            ),
                                          );

                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF75B7E7),
                                          // Button background color
                                          padding: EdgeInsets.zero,
                                          // No padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                99), // Adjust the border radius as needed
                                          ),
                                        ),
                                        child: Container(
                                          width: 110,
                                          height: 19,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            // Transparent container color
                                            borderRadius: BorderRadius.circular(
                                                99), // Adjust the border radius as needed
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Edit',
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                color: Colors.white,
                                                // Text color
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        nom+" "+ prenom,
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                          color: const Color(0xFF1D1517),
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        objectif,
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                          color: const Color(0xFF7B6F72),
                                          fontSize: 13.5,
                                          height: 1.7,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Center(
                                child: Container(
                              width: screenWidth,
                              height: 115,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        // Left margin for the first container
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 105,
                                            height: 85,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      222, 222, 222, 1),
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 12,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                            taille.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                Text(
                                                  'Height',
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF7B6F72),
                                                    fontSize: 12,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 105,
                                            height: 85,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      222, 222, 222, 1),
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 12,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [

                                            Text(poids.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                Text(
                                                  'Weight',
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF7B6F72),
                                                    fontSize: 12,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        // Right margin for the last container
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 105,
                                            height: 85,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      222, 222, 222, 1),
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 12,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                age.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                Text(
                                                  'Age',
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF7B6F72),
                                                    fontSize: 12,
                                                    height: 1.5,
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
                            )),
                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                            child: Center(
                              child: Container(
                                width: screenWidth,
                                height: 180,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x111D1617),
                                      spreadRadius: 0,
                                      offset: Offset(0, 10),
                                      blurRadius: 40,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 27, top: 19, right: 27),
                                  // Adjust margins as needed
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Other', // Your title
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      // Add some space between the title and buttons
                                      Expanded(
                                        // Wrap the Column with Expanded
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          // Align children to the start (left) of the column
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ContactUs(),
                                                    ),
                                                  );
                                              },
                                              icon: Icon(
                                                Icons.mail,
                                                color: const Color(
                                                    0xFF75B7E7), // Color for the first icon
                                              ),
                                              label: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Contact us',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF7B6F72),
                                                      fontSize: 16,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    // Add left padding of 8
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: const Color(
                                                          0xFF7B6F72),
                                                      size: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                // Set background color to transparent
                                                padding:
                                                    EdgeInsets.only(left: 16),
                                                // No padding
                                                alignment: Alignment.centerLeft,
                                                // Align icon and text to the start
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8), // Smaller border radius
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => TermsConditions(),
                                                    ),
                                                  );
                                              },
                                              icon: Icon(
                                                Icons.rule,
                                                color: const Color(
                                                    0xFF75B7E7), // Color for the first icon
                                              ),
                                              label: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Terms & Conditions',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF7B6F72),
                                                      fontSize: 17,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    // Add left padding of 8
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: const Color(
                                                          0xFF7B6F72),
                                                      size: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                padding:
                                                EdgeInsets.only(left: 16),
                                                alignment: Alignment.centerLeft,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                            child: Center(
                              child: Container(
                                width: screenWidth,
                                height: 90,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x111D1617),
                                      spreadRadius: 0,
                                      offset: Offset(0, 10),
                                      blurRadius: 40,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 27, top: 19, right: 27),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => LoginPage()),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.logout,
                                                color: Colors.red,
                                              ),
                                              label: Row(
                                                children: [
                                                  Text(
                                                    'Log out',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.red,
                                                      fontSize: 16,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                // Set background color to transparent
                                                padding:
                                                EdgeInsets.only(left: 16),
                                                // No padding
                                                alignment: Alignment.centerLeft,
                                                // Align icon and text to the start
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8), // Smaller border radius
                                                ),
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
                          ),
                          SizedBox(height: 100),
                          MyBarChart(),

                        ])))));
  }
}
