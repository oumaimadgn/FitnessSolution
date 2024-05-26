import 'package:flutter/material.dart';
import 'exercises.dart';
import 'profileEdit.dart';
import 'dashboardcontent.dart';
import 'mealstest.dart';
import 'login.dart';
import 'AboutUs.dart';

class Dashboard extends StatefulWidget {
  final Map<String, dynamic> processData;

  Dashboard({required this.processData});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Expanded(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2FL6870zGYW65q3NLlDA7F%2F3c2983ffcd053908542fff26a86d6a458e8df971Logo%201.png?alt=media&token=374d0f4d-2b2b-4ac2-b070-d9e3b9cb579b',
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedIndex == 1 ? Color.fromRGBO(44, 142, 176, 1): Colors.transparent,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _selectPage(1); // First link
                          },
                          child: Text(
                            'Dashboard',
                            style: TextStyle(
                              fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                              color: _selectedIndex == 1 ? Color.fromRGBO(44, 142, 176, 1) : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedIndex == 2 ? Color.fromRGBO(44, 142, 176, 1) : Colors.transparent,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _selectPage(2); // Second link
                          },
                          child: Text(
                            'Meals',
                            style: TextStyle(
                              fontWeight: _selectedIndex == 2 ? FontWeight.bold : FontWeight.normal,
                              color: _selectedIndex == 2 ? Color.fromRGBO(44, 142, 176, 1): Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedIndex == 3 ? Color.fromRGBO(44, 142, 176, 1) : Colors.transparent,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _selectPage(3); // Third link
                          },
                          child: Text(
                            'Exercises',
                            style: TextStyle(
                              fontWeight: _selectedIndex == 3 ? FontWeight.bold : FontWeight.normal,
                              color: _selectedIndex == 3 ? Color.fromRGBO(44, 142, 176 , 1) : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedIndex == 4 ? Color.fromRGBO(44, 142, 176, 1) : Colors.transparent,
                      width: 3.0,
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    _selectPage(4); // Fourth link
                  },
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      fontWeight: _selectedIndex == 4 ? FontWeight.bold : FontWeight.normal,
                      color: _selectedIndex == 4 ? Color.fromRGBO(44, 142, 176 , 1) : Colors.grey,
                    ),
                  ),
                ),

              ),
              SizedBox(width: 5,),
              Container(
                child: PopupMenuButton<String>(
                  offset: Offset(0, 30),
                  onSelected: (value) {
                    if (value == 'edit_profile') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            matricule: widget.processData['matricule'],
                            nom: widget.processData['nom'],
                            prenom: widget.processData['prenom'],
                            telephone: widget.processData['telephone'],
                            email: widget.processData['email'],
                            motDePasse: widget.processData['motDePasse'],
                            age: widget.processData['age'],
                            sexe: widget.processData['sexe'],
                            poids: widget.processData['poids'],
                            taille: widget.processData['taille'],
                            objectif: widget.processData['objectif'],
                          ),
                        ),
                      );
                    } else if (value == 'logout') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'edit_profile',
                      child: Text('\t\tEdit Profile\t\t\t\t\t'),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        title: Text(
                          'Logout\t\t\t\t\t',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                  icon: Container(
                    child: Icon(
                      Icons.account_circle,
                      color: _selectedIndex == 0 ? Colors.blueGrey : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _getPage(_selectedIndex),
    );

  }

  Widget _getPage(int index) {
    switch (index) {
      case 1:
        final matricule = widget.processData['matricule'];
        final nom = widget.processData['nom'];
        final prenom = widget.processData['prenom'];
        final taille = widget.processData['taille'];
        final poids = widget.processData['poids'];

        if (matricule != null) {
          return DashboardContent(matricule: matricule, nom: nom, prenom: prenom,taille: taille,poids: poids);
        } else {
          return Center(child: Text('Matricule is null'));
        }
      case 2:
        final matricule = widget.processData['matricule'];
         if (matricule != null) {
          return MealPlannerPage(matricule: matricule);
        } else {
          return Center(child: Text('Matricule is null'));
        }
      case 3:
        final matricule = widget.processData['matricule'];
        if (matricule != null) {
          return ExercisePlannerPage(matricule: matricule);
        } else {
          return Center(child: Text('Matricule is null'));
        }
      case 4:
        return AboutusPage();
      default:
        return Center(
          child: Text('Page not found'),
        );
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


class MealPlannerPage extends StatelessWidget {
  final int matricule;

  MealPlannerPage({required this.matricule});

  @override
  Widget build(BuildContext context) {
    return MealsTracker(matricule: matricule);
  }
}

class DashboardContent extends StatelessWidget {
  final int matricule;
  final String nom;
  final String prenom;
  final double poids;
  final double taille;

  DashboardContent({required this.matricule,required this.nom,required this.prenom,required this.poids,required this.taille});

  @override
  Widget build(BuildContext context) {
    return Dashboard2(matricule: matricule, taille: taille, nom: nom, prenom: prenom,poids: poids,);
  }
}

class ExercisePlannerPage extends StatelessWidget {
  final int matricule;

  ExercisePlannerPage({required this.matricule});

  @override
  Widget build(BuildContext context) {
    return ExerciseTracker(matricule: matricule);
  }
}

class AboutusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Aboutus();
  }
}

