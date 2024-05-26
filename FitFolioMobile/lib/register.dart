import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'register2.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      onChanged: (value) {
        RegisterPage1.passwordController.text = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: 'Password',
        hintStyle: GoogleFonts.getFont(
          'Poppins',
          color: const Color(0xFFADA4A5),
          fontSize: 15,
          height: 1.2,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class RegisterPage1 extends StatefulWidget {
  RegisterPage1({Key? key}) : super(key: key);

  static final TextEditingController firstNameController = TextEditingController();
  static final TextEditingController lastNameController = TextEditingController();
  static final TextEditingController phoneNumberController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  @override
  void initState() {
    super.initState();
    RegisterPage1.firstNameController.text = '';
    RegisterPage1.lastNameController.text = '';
    RegisterPage1.phoneNumberController.text = '';
    RegisterPage1.emailController.text = '';
    RegisterPage1.passwordController.text = '';
  }

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

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  void _validateFields(BuildContext context) {
    if (RegisterPage1.firstNameController.text.isEmpty ||
        RegisterPage1.lastNameController.text.isEmpty ||
        RegisterPage1.phoneNumberController.text.isEmpty ||
        RegisterPage1.emailController.text.isEmpty ||
        RegisterPage1.passwordController.text.isEmpty) {
      _showErrorDialog(context, 'Empty Fields', 'Please fill in all fields.');
    }
    else if (!_isValidEmail(RegisterPage1.emailController.text)) {
      _showErrorDialog(context, 'Invalid Email', 'Please enter a valid email address.');
    }
    else if (!_isStrongPassword(RegisterPage1.passwordController.text)) {
      _showErrorDialog(context, 'Weak Password', 'Please choose a stronger password (at least 8 characters).');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage2(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 395,
        height: 830,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: 500,
                  height: 1000,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 147,
                        top: 68,
                        child: Text(
                          'Hey there,',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: Colors.black,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 91,
                        top: 97,
                        child: Text(
                          'Create an Account',
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
                        left: 85,
                        top: 630,
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Already have an account? ',
                                  ),
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: Color(0xFF4A9FDB),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('Tapped on Login');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to RegisterPage3
                                        );                                      },
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 550,
                        child: GestureDetector(
                          onTap: () {
                            _validateFields(context);
                          },
                          child: Container(
                            width: 338,
                            height: 60,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x4C95ADFE),
                                  spreadRadius: 0,
                                  offset: Offset(0, 10),
                                  blurRadius: 22,
                                )
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 338,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(99),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF4A9FDB),
                                          Color(0xFF9DCEFF)
                                        ],
                                        stops: [0.40, 1],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 123,
                                  top: 17,
                                  child: Text(
                                    'Register',
                                    textAlign: TextAlign.center,
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
                        left: 32,
                        top: 186,
                        child: SizedBox(
                          width: 338,
                          height: 48,
                          child: TextField(
                            controller: RegisterPage1.firstNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              hintText: 'First name',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: const Color(0xFFADA4A5),
                                fontSize: 15,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 244,
                        child: SizedBox(
                          width: 338,
                          height: 48,
                          child: TextField(
                            controller: RegisterPage1.lastNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              hintText: 'Last name',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: const Color(0xFFADA4A5),
                                fontSize: 15,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 302,
                        child: SizedBox(
                          width: 338,
                          height: 48,
                          child: TextField(
                            controller: RegisterPage1.phoneNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              hintText: 'Phone number',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: const Color(0xFFADA4A5),
                                fontSize: 15,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 360,
                        child: SizedBox(
                          width: 338,
                          height: 48,
                          child: TextField(
                            controller: RegisterPage1.emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              hintText: 'Email',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: const Color(0xFFADA4A5),
                                fontSize: 15,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 418,
                        child: SizedBox(
                          width: 338,
                          height: 48,
                          child: PasswordTextField(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterPage1(),
    routes: {
      '/register2': (context) => RegisterPage2(),
    },
  ));
}



