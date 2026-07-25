import 'dart:convert';

import 'package:final_project/ui/screens/home_screen.dart';
import 'package:final_project/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = "";
  Future<void> login() async {
    final url = Uri.parse(
      "https://final-project-71fa9-default-rtdb.asia-southeast1.firebasedatabase.app/users.json",
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body) as Map;

    bool found = false;

    for (var user in data.values) {
      if (user["email"] == emailController.text &&
          user["password"] == passwordController.text) {
        found = true;
        break;
      }
    }

    if (found) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        errorMessage = "Wrong email or password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E2D6),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "SongKrous",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Check before you click. Stay safe.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 40),

            const Text(
              "Welcome To SongKrous!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // reset password
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Color(0xFFC69B54)),
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1C1C1C),
                ),
                
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Color(0xFFB23B3B), // red

                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),


            // Sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign Up",
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
