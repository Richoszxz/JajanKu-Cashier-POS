import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String judulHalaman;
  final bool tombolKembali;
  const AppbarWidget({
    super.key,
    required this.judulHalaman,
    this.tombolKembali = false,
  });

  @override
  Widget build(BuildContext context) {
    // final tinggiAppBar = AppSize.tinggi(context) * 0.13;

    return AppBar(
      toolbarHeight: 90,
      backgroundColor: AppColor.warnaPrimer,
      foregroundColor: AppColor.warnaSekunder,
      title: Text(
        judulHalaman,
        style: AppTextstyle.appBarTeks,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      leadingWidth: 72,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 12), // jarak kiri
          child: IconButton(
            icon: Icon(
              tombolKembali ? Icons.arrow_back_ios : Icons.menu,
              size: 30, // ukuran ikon drawer
              color: AppColor.warnaSekunder,
            ),
            onPressed: () {
              if (tombolKembali) {
                Navigator.pop(context);
              } else {
                Scaffold.of(context).openDrawer();
              }
            }, // buka drawer custom
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () {
              // tampilkan notif kalau fitur belum aktif
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Fitur ini belum bisa digunakan 😅',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.black87,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(
              Icons.settings_outlined,
              color: AppColor.warnaSekunder,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  // ini WAJIB supaya AppBar tahu tinggi preferred-nya
  @override
  Size get preferredSize => Size.fromHeight(90);
}
