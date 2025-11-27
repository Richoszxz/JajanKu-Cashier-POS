import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/services/supabase_client.dart';
import '../screens/splash_screen.dart';
import 'package:jajanku_pos/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseManager.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jajanku POS (Provider Auth)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.warnaLatar,
        dividerColor:
            Colors.transparent, // Menghilangkan garis divider expansion tile
        expansionTileTheme: ExpansionTileThemeData(
          iconColor: AppColor.warnaTeks, // Warna ikon saat tile diperluas
          collapsedIconColor:
              AppColor.warnaTeks, // Warna ikon saat tile tidak diperluas
        ),
        drawerTheme: DrawerThemeData(
          scrimColor: AppColor.warnaPrimer.withOpacity(0.5),
        ),
      ),
      routes: AppRoutes.routes,
      home: const SplashScreen(),
    );
  }
}
