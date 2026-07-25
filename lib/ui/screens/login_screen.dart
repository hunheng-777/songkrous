import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

           
            TextField(
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
                onPressed: () {
                  // we add login later
                },
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

            // Sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    //TODO: connent to sign up
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
