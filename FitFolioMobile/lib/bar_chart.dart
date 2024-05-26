import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'profile.dart';
import 'mealPlanner.dart';
import 'activityPlanner.dart';
import 'dashboard.dart';
import 'url.dart';

class BarChart {
  static Map<String, dynamic>? processedData;
  static void processData({
    required int matricule,
    required String nom,
    required String prenom,
    required String telephone,
    required String email,
    required String motDePasse,
    required int age,
    required String sexe,
    required double poids,
    required double taille,
    required String objectif,
  }) {
    processedData = {
      'matricule': matricule,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'motDePasse': motDePasse,
      'age': age,
      'sexe': sexe,
      'poids': poids,
      'taille': taille,
      'objectif': objectif,
    };
  }
}

class MyBarChart extends StatefulWidget {
  const MyBarChart({Key? key}) : super(key: key);

  @override
  _MyBarChartState createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  late String nom;
  late String prenom;
  late String telephone;
  late String email;
  late String motDePasse;
  late int age;
  late String sexe;
  late double poids;
  late double taille;
  late String objectif;
  late int matricule;

  void processData({
    required int matricule,
    required String nom,
    required String prenom,
    required String telephone,
    required String email,
    required String motDePasse,
    required int age,
    required String sexe,
    required double poids,
    required double taille,
    required String objectif,
  }) {
    setState(() {
      this.matricule = matricule;
      this.nom = nom;
      this.prenom = prenom;
      this.telephone = telephone;
      this.email = email;
      this.motDePasse = motDePasse;
      this.age = age;
      this.sexe = sexe;
      this.poids = poids;
      this.taille = taille;
      this.objectif = objectif;
    });

    print('Received parameters: $matricule, $nom, $prenom, $telephone, $email, $motDePasse, $age, $sexe, $poids, $taille, $objectif');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      width: 800,
      height: 96,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            spreadRadius: 0,
            offset: Offset(0, 9),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Dashboard(
                          matricule: BarChart.processedData?['matricule'],
                          nom: BarChart.processedData?['nom'],
                          prenom: BarChart.processedData?['prenom'],
                          poids: BarChart.processedData?['poids'],
                          taille: BarChart.processedData?['taille'],
                        )),
              );
            },
            icon: Icon(
              Icons.home_outlined,
              color: const Color(0xFF75B7E7),
              size: 30,
            ),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ActivityPlanner(
                          matricule: BarChart.processedData?['matricule'],
                        )),
              );
            },
            icon: Icon(
              Icons.sports_martial_arts_outlined,
              color: const Color(0xFF75B7E7),
              size: 30,
            ),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MealPlanner(
                          matricule: BarChart.processedData?['matricule'],
                        )),
              );
            },
            icon: Icon(
              Icons.fastfood_outlined,
              color: const Color(0xFF75B7E7),
              size: 30,
            ),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(
                    matricule: BarChart.processedData?['matricule'],
                    nom: BarChart.processedData?['nom'],
                    prenom: BarChart.processedData?['prenom'],
                    telephone: BarChart.processedData?['telephone'],
                    email: BarChart.processedData?['email'],
                    motDePasse: BarChart.processedData?['motDePasse'],
                    age: BarChart.processedData?['age'],
                    sexe: BarChart.processedData?['sexe'],
                    poids: BarChart.processedData?['poids'],
                    taille: BarChart.processedData?['taille'],
                    objectif: BarChart.processedData?['objectif'],
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.person_outline,
              color: const Color(0xFF75B7E7),
              size: 37,
            ),
            padding: EdgeInsets.zero,
          ),
            ],
          ),
      );
  }
}
