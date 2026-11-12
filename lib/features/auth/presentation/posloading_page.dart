import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/src/providers/admin_provider.dart';

import '../../../core/database/secure_const.dart';
import '../../../core/database/secure_db.dart';
import '../../../core/location/loc_permission.dart';
import '../../../routes/page_router.dart';

class PosLoadingPage extends StatefulWidget {
  const PosLoadingPage({super.key});

  @override
  State<PosLoadingPage> createState() => _PosLoadingPageState();
}

class _PosLoadingPageState extends State<PosLoadingPage> {
  String _currentStep = 'Initializing local database...';
  double _progressValue = 0.2;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // await LocPermission.requestLoc();
    // if (!mounted) return;
    await context.read<AdminProvider>().getUserProfile();
    // Simulate POS startup tasks (e.g., SQLite, Auth, Sync)
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _currentStep = 'Syncing offline transactions...';
      _progressValue = 0.6;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _currentStep = 'Fetching latest catalog & prices...';
      _progressValue = 0.9;
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _currentStep = 'Ready to sell!';
      _progressValue = 1.0;
    });

    // Read saved role
    final roleString = await SecureStorage.secureRead(SecureConst.empRole);

    if (!mounted) return;

    if (roleString.isEmpty) {
      // Something is wrong with login/session
      context.go(PageRouter.authPage);
      return;
    }

    if (!mounted) return;
    // Navigate to Dashboard / POS main screen here
    context.go(PageRouter.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // POS Logo or Icon
              const Icon(
                Icons.point_of_sale,
                size: 80,
                color: Colors.amberAccent,
              ),
              const SizedBox(height: 24),

              // App Title
              const Text(
                'SmartPOS Terminal',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),

              // Progress Bar
              SizedBox(
                width: 280,
                child: LinearProgressIndicator(
                  value: _progressValue,
                  backgroundColor: Colors.blueGrey.shade800,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.amberAccent,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 20),

              // Dynamic Status Text
              Text(
                _currentStep,
                style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade300),
              ),
              const SizedBox(height: 40),

              // Terminal Info (Helpful for retail environments)
              Text(
                'Terminal ID: POS-TERM-001 • v2.4.0',
                style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
