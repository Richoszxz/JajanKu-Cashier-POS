import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/routes/app_routes.dart';
import 'package:jajanku_pos/services/supabase_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double opacity = 0; // default transaparan

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1; // mulai animasi fade-in
      });
    });
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(Duration(seconds: 2));
    final session = SupabaseManager.client.auth.currentSession;

    if(session != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.cashierPosScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.getStartedScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.warnaPrimer,
      body: AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: opacity,
        curve: Curves.easeIn,
        child: Center(
          child: Image.asset(
            "assets/images/imagesplashscreen.png",
            width: AppSize.lebar(context) * 0.8,
            height: AppSize.tinggi(context) * 0.8,
          ),
        ),
      ),
    );
  }
}