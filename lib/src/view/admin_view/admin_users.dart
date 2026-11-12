import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:trusted_time/trusted_time.dart';

class AdminUsersView extends StatefulWidget {
  const AdminUsersView({super.key});

  @override
  State<AdminUsersView> createState() => _AdminUsersViewState();
}

class _AdminUsersViewState extends State<AdminUsersView> {
  DateTime _now = DateTime.now();
  TrustedTimeEstimate? _estimate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Ensure TrustedTime is initialized before querying
      // (usually initialized in main(), but good to handle safely)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (TrustedTime.isTrusted) {
              _now = TrustedTime.now();
              log("Trusted Time. ${TrustedTime.now().toLocal()}");
            } else {
              // Fallback to estimation if full trust anchor isn't established yet
              _estimate = TrustedTime.nowEstimated();
              // If estimate has a time value, you can extract it depending on package version
            }
          });
          log("Trusted _estimate Time. ${_estimate}.    ${_now}");
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Note: quarterTurns: 4 is a full rotation (0 turns).
            // Change to 1, 2, or 3 if you intended a specific angle.
            RotatedBox(
              quarterTurns: 0,
              child: Column(
                spacing: 40,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Transform(
                      transform: Matrix4.skewY(0.2)..rotateZ(-math.pi / 185.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8581C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Hello Hello!'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Transform(
                      transform: Matrix4.skewY(0.2)..rotateZ(-math.pi / 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8581C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Tesing Go!'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(" - Time: ${_now.toIso8601String()}"),
          ],
        ),
      ),
    );
  }
}
