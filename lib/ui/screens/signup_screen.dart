import 'package:final_project/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../../data/repositories/auth_repository.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool agreeTerms = false;
  String errorMessage = "";
  Future<void> signup() async {
    final url = Uri.parse(
      "https://final-project-71fa9-default-rtdb.asia-southeast1.firebasedatabase.app/users.json",
    );

    User newUser = User(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    await http.post(url, body: jsonEncode(newUser.toJson()));

    AuthRepository.currentUser = newUser;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE4D8),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),

            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),

            Text(
              "Create Account",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),

            Text(
              "Join SongKrous to stay safe online",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 30),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Full Name",

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: hidePassword,

              decoration: InputDecoration(
                hintText: "Password",

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: confirmPasswordController,

              obscureText: hideConfirmPassword,

              decoration: InputDecoration(
                hintText: "Confirm Password",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hideConfirmPassword = !hideConfirmPassword;
                    });
                  },
                  icon: Icon(
                    hideConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                  value: agreeTerms,

                  onChanged: (value) {
                    setState(() {
                      agreeTerms = value!;
                    });
                  },
                ),

                Expanded(
                  child: Text(
                    "I agree to the Terms & Privacy Policy",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () async {
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          setState(() {
                            errorMessage = "Please fill all fields";
                          });

                          return;
                        }

                        if (!emailController.text.contains("@") ||
                            !emailController.text.contains(".")) {
                          setState(() {
                            errorMessage = "Invalid Email";
                          });

                          return;
                        }

                        if (passwordController.text.length < 6) {
                          setState(() {
                            errorMessage =
                                "Password must be at least 6 characters";
                          });

                          return;
                        }

                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          setState(() {
                            errorMessage = "Passwords do not match";
                          });

                          return;
                        }

                        if (!agreeTerms) {
                          setState(() {
                            errorMessage =
                                "Please agree to Terms & Privacy Policy";
                          });

                          return;
                        }

                       await signup();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color(0xFFC69B54),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
