import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart'; 
import 'package:jajanku_pos/constants/app_size.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/routes/app_routes.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    // Ambil lebar dan tinggi dari class AppSize (asumsi sudah didefinisikan)
    final screenWidth = AppSize.lebar(context);
    final screenHeight = AppSize.tinggi(context);

    // Diameter disesuaikan dengan lebar layar agar kurva terlihat konsisten
    final diameter = screenWidth * 1.5; 

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6C8),
      body: SafeArea( // Ditambahkan untuk memastikan konten tidak terpotong
        child: Stack(
          children: [
            // 1. Circle background (Kurva Atas Merah)
            Positioned(
              // Disesuaikan agar kurva besar di bawah terlihat seperti di gambar
              top: -screenHeight * 0.2,
              left: -screenWidth * 0.25,
              child: Container(
                width: diameter,
                height: diameter,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.warnaPrimer,
                ),
              ),
            ),

            // 2. Logo (Posisi absolut untuk efek tumpang tindih)
            Positioned(
              top: screenHeight * 0.05,
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: Image.asset(
                "assets/images/3dLogo.png",
                // Mengurangi tinggi agar ukuran logo lebih pas
                height: screenHeight * 0.4, 
                fit: BoxFit.contain,
              ),
            ),

            // 3. Kolom Konten Responsif (Text, Button, Footer)
            // Menggunakan Column dan Spacer untuk distribusi vertikal yang responsif
            Column(
              children: [
                // Spacer untuk mendorong konten ke bawah, melewati area logo/kurva
                SizedBox(height: screenHeight * 0.60), 

                // JajanKu POS - Point Of Sales Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "JajanKu POS - Point Of Sales",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.warnaTeks,
                    ),
                  ),
                ),

                const Spacer(flex: 3), // Dorongan ke bawah sebelum tombol

                // Tombol Login (Lebar Penuh dan Responsif)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity, // Ambil lebar maksimum dari Padding
                    height: 70, // Tinggi tombol konsisten
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.warnaPrimer, // Merah tua
                        foregroundColor: AppColor.warnaSekunder,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () {
                        // Navigasi tetap ke login screen
                        Navigator.pushNamed(context, AppRoutes.loginScreen);
                      },
                      child: Text(
                        'Login', // Disesuaikan dengan gambar
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColor.warnaSekunder,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2), // Dorongan ke bawah sebelum footer

                // Footer Text (Nama Perusahaan)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "CV. Richo Berkah Jaya Imup, Tbk.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.warnaNamaPerusahaan,
                    ),
                  ),
                ),

                const Spacer(flex: 1), // Spacer akhir untuk padding bawah
              ],
            ),
          ],
        ),
      ),
    );
  }
}