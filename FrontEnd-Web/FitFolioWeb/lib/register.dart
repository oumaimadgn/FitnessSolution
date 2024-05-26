import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'register2.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _ageController = TextEditingController();
    final TextEditingController _weightController = TextEditingController();
    final TextEditingController _heightController = TextEditingController();

    String? _selectedGender;

    bool _validateEmail(String email) {
      final emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      return emailRegex.hasMatch(email);
    }

    bool isStrongPassword(String password) {
      final RegExp passwordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
      );
      return passwordRegex.hasMatch(password);
    }

    bool _validateInputs() {
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final phone = _phoneController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final weight = _weightController.text.trim();
      final height = _heightController.text.trim();
      final age = _ageController.text.trim();

      return firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          phone.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          height.isNotEmpty &&
          weight.isNotEmpty &&
          age.isNotEmpty &&
          _selectedGender != null;
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F3FD),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0x89F3F3FD),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(34),
                              bottomRight: Radius.circular(34),
                            ),
                          ),
                          child: Image.network(
                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2FPXACK4v7n7g5wZeLK3Hv%2Ff064a4b5c14696efcf2a08a0f885d247.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2FPXACK4v7n7g5wZeLK3Hv%2F3c2983ffcd053908542fff26a86d6a458e8df971Logo%201.png?alt=media&token=b77302eb-b1a1-4620-af70-843f57ef733a',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 200,
                        top: 300,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign Up to\nget started',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.black,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'If you already have an account\nyou can ',
                                  ),
                                  TextSpan(
                                    text: 'Login here!',
                                    style: TextStyle(
                                      color: Color(0xFF3694D7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Login()),
                                        );
                                      },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(160, 130, 150, 1),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            children: [
                              const Center(
                                child: Text(
                                  "Welcome",
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: TextField(
                                        controller: _firstNameController,
                                        decoration: InputDecoration(
                                          hintText: "First name",
                                          hintStyle: GoogleFonts.inter(
                                            color: const Color(0xFF4F555A),
                                            fontSize: 15,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFEAF0F7),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: TextField(
                                        controller: _lastNameController,
                                        decoration: InputDecoration(
                                          hintText: "Last name",
                                          hintStyle: GoogleFonts.inter(
                                            color: const Color(0xFF4F555A),
                                            fontSize: 15,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFEAF0F7),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Phone number",
                                  hintStyle: GoogleFonts.inter(
                                    color: const Color(0xFF4F555A),
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFEAF0F7),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.inter(
                                    color: const Color(0xFF4F555A),
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFEAF0F7),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              PasswordTextField(passwordController: _passwordController),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _ageController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "Age",
                                        hintStyle: GoogleFonts.inter(
                                          color: const Color(0xFF4F555A),
                                          fontSize: 15,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFEAF0F7),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedGender,
                                      onChanged: (String? value) {
                                        _selectedGender = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Gender",
                                        hintStyle: GoogleFonts.inter(
                                          color: const Color(0xFF4F555A),
                                          fontSize: 15,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFEAF0F7),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                      ),
                                      items: ['Male', 'Female'].map((
                                          String gender) {
                                        return DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(gender),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _heightController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "Height",
                                        hintStyle: GoogleFonts.inter(
                                          color: const Color(0xFF4F555A),
                                          fontSize: 15,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFEAF0F7),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _weightController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "Weight",
                                        hintStyle: GoogleFonts.inter(
                                          color: const Color(0xFF4F555A),
                                          fontSize: 15,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFEAF0F7),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 60.0),
                              ElevatedButton(
                                onPressed: () {
                                  if (_validateInputs()) {
                                    if (_validateEmail(_emailController.text)) {
                                      if (isStrongPassword(_passwordController.text)) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Register2(
                                              firstNameController: _firstNameController,
                                              lastNameController: _lastNameController,
                                              phoneController: _phoneController,
                                              emailController: _emailController,
                                              passwordController: _passwordController,
                                              ageController: _ageController,
                                              selectedGender: _selectedGender,
                                              heightController: _heightController,
                                              weightController: _weightController,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Password is not strong enough')),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Invalid email format')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('All fields are required')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3694D7),
                                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 4,
                                ),
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
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
            ),
          );
        },
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordTextField({Key? key, required this.passwordController}) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF4F555A),
          fontSize: 15,
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          padding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        filled: true,
        fillColor: const Color(0xFFEAF0F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      obscureText: _obscureText,
    );
  }
}

