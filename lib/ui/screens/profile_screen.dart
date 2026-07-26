import 'package:final_project/data/repositories/scan_repository.dart';
import 'package:final_project/models/scan_result.dart';
import 'package:final_project/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../data/repositories/auth_repository.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  int totalScans = 0;
  int threatsBlocked = 0;
  Future<void> loadStats() async {
    ScanRepository repository = ScanRepository();

    List<ScanResult> scans = await repository.getUserScans(
      AuthRepository.currentUser!.email,
    );

    int dangerCount = 0;

    for (var scan in scans) {
      if (scan.status == "Danger") {
        dangerCount++;
      }
    }

    setState(() {
      totalScans = scans.length;

      threatsBlocked = dangerCount;
    });
  }
  @override
  void initState() {
    super.initState();

    loadStats();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE4D8),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 50),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              "My Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Container(
              width: 120,
              height: 120,

              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),

              child:  Center(
                child: Text(
                  AuthRepository.currentUser?.name[0]??"?",
                  style: TextStyle(
                    fontSize: 55,
                    color: Color(0xFFC69B54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

             Text(
              AuthRepository.currentUser?.name??"?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

             Text(AuthRepository.currentUser?.email??"?", style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,

                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          totalScans.toString(),
                          style: TextStyle(
                            fontSize: 35,
                            color: Color(0xFFC69B54),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Total Scans",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Container(
                    height: 120,

                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          threatsBlocked.toString(),
                          style: TextStyle(
                            fontSize: 35,
                            color: Color(0xFFC69B54),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Threats Blocked",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB23B3B),
                      ),

                      onPressed: () {
                        AuthRepository.currentUser = null;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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
