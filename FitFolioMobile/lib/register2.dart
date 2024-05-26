import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register3.dart';


class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({Key? key}) : super(key: key);

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  String? _selectedGender;
  DateTime? _selectedDate;
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 395,
        height: 830,
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
                left: 0,
                top: 0,
                child: Container(
                  width: 395,
                  height: 830,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEFEFF),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        left: 14,
                        top: 80,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2F807ffa8a91a37a822d3a5d1f9ea2a503.png',
                          width: 349,
                          height: 263,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 75,
                        top: 29,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Fff059b37c9493d383de51523397b2e41.png',
                          width: 261,
                          height: 314,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        left: 51,
                        top: 379,
                        child: Text(
                          'Let’s complete your profile',
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
                        left: 72,
                        top: 414,
                        child: Text(
                          'It will help us to know more about you!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: const Color(0xFF7B6F72),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 50,
                        top: 450,
                        child: Form(
                          key: _formKey,
                          child: Container(
                            width: 300,
                            height: 48,
                            padding: const EdgeInsets.only(left: 16, right: 8), // Adjust the padding as needed
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F8F8),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedGender,
                                items: <String>['Female', 'Male']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                                hint: Text(
                                  'Choose Gender',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: _selectedGender != null
                                        ? Colors.black
                                        : const Color(0xFFADA4A5),
                                    fontSize: 15,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 50,
                        top: 500,
                        child: Container(
                          width: 300,
                          height: 48,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F8F8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null && pickedDate != _selectedDate) {
                                setState(() {
                                  _selectedDate = pickedDate;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedDate != null
                                      ? 'Date of Birth: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                      : 'Choose Date of Birth',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: _selectedDate != null
                                        ? Colors.black
                                        : const Color(0xFFADA4A5),
                                    fontSize: 15,
                                    height: 1.2,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey, // Change the color to grey
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 50,
                        top: 550,
                        child: Container(
                          width: 300,
                          height: 48,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F8F8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Your Weight in KG',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: const Color(0xFFADA4A5),
                                fontSize: 15,
                                height: 1.2,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 50,
                        top: 600,
                        child: Container(
                          width: 300,
                          height: 48,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F8F8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextFormField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Your Height in CM',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: const Color(0xFFADA4A5),
                                fontSize: 15,
                                height: 1.2,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 50,
                        top: 700,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_selectedGender == null ||
                                  _selectedDate == null ||
                                  _weightController.text.isEmpty ||
                                  _heightController.text.isEmpty) {
                                _showErrorDialog(
                                  context,
                                  'Error',
                                  'All fields are required. Please fill them in.',
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage3(
                                      selectedGender: _selectedGender,
                                      selectedDate: _selectedDate,
                                      weight: _weightController.text,
                                      height: _heightController.text,
                                    ),
                                  ),
                                );

                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero, backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99),
                            ),
                            elevation: 0,
                          ),
                          child: Ink(
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
                            child: Container(
                              width: 300,
                              height: 60,
                              alignment: Alignment.center,
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
