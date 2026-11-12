import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/database/secure_const.dart';
import 'package:rust_flutter/core/database/secure_db.dart';
import 'package:rust_flutter/core/extension/text_style.dart';
import 'package:rust_flutter/src/providers/admin_provider.dart';

import '../../routes/page_router.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AdminProvider get _adminPvd =>
      Provider.of<AdminProvider>(context, listen: false);

  String empName = '';
  String empMail = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      empName = await SecureStorage.secureRead(SecureConst.empName);
      empMail = await SecureStorage.secureRead(SecureConst.email);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(text: "Profile", color: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 5,
            children: [
              CircleAvatar(
                radius: 40,
                child: Image.asset("assets/icons/profile.png"),
              ),
              Text(
                empName.isEmpty ? _adminPvd.profile?.userUame ?? "" : empName,
                style: TextStyle(
                  color: const Color.fromARGB(153, 199, 7, 7),
                  fontSize: 20,
                ),
              ),
              Text(
                empMail.isEmpty ? _adminPvd.profile?.email ?? "" : empMail,
                style: TextStyle(color: Colors.blue),
              ),

              Text(
                empMail.isEmpty ? _adminPvd.profile?.joinDate ?? "" : empMail,
                style: TextStyle(color: Colors.blue),
              ),
              Text("Trying to be better."),

              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  // 1. Clear secure storage
                  await SecureStorage.secureDelete();
                  globalAuthNotifier.value = true;
                  if (!context.mounted) return;
                  context.go(PageRouter.authPage);
                  // 2. Flip global auth state to false (Forces GoRouter redirect)
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(48, 0, 0, 0),
                    ),
                  ),

                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      Text("Log Out", style: getMediumtext(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     // 1. Clear secure storage
              //     await SecureStorage.secureDelete();
              //     globalAuthNotifier.value = true;
              //     if (!context.mounted) return;
              //     context.go(PageRouter.authPage);
              //     // 2. Flip global auth state to false (Forces GoRouter redirect)
              //   },
              //   child: Text("Log Out"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
