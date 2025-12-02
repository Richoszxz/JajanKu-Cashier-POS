import 'package:flutter/material.dart';
import 'package:jajanku_pos/routes/app_routes.dart';
import 'package:jajanku_pos/services/authentication_services.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/error_handler_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/services/profile_services.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final profileServices = ProfileServices();
  final _authService = AuthenticationServices();

  Future<void> logout(BuildContext context) async {
    try {
      await _authService.signOut();

      // Arahkan ke login dan hapus semua route sebelumnya
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );
    } catch (e) {
      errorAlert(
        context,
        text: "Failed request sign out !",
        title: "Oops . . .",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "My Profile"),
      drawer: NavigationdrawerWidget(),
      body: FutureBuilder(
        future: profileServices.getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data;

          String fullName = data?['nama_lengkap'] ?? "-";
          String userName = data?['username'] ?? "-";
          String registrationDate = data?['created_at'] ?? "-";
          String phoneNumber = data?['nomor_telepon'] ?? '-';
          String email = data?['email'] ?? '-';
          String roles = data?['role'] ?? '-';

          return Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: AppColor.warnaPrimer,
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 150,
                              color: AppColor.warnaSekunder,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // BASE INFORMATION
                    Container(
                      height: AppSize.tinggi(context) * 0.20,
                      width: AppSize.lebar(context) * 1,
                      margin: EdgeInsets.only(bottom: 13),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.warnaSekunder,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 8),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Base Information",
                            style: AppTextstyle.normalCoklat,
                          ),
                          Container(
                            height: AppSize.tinggi(context) * 0.14,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.warnaPrimer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Full name",
                                      style: AppTextstyle.smallBoldCream,
                                    ),
                                    Text(
                                      "Username",
                                      style: AppTextstyle.smallBoldCream,
                                    ),
                                    Text(
                                      "Registration Date",
                                      style: AppTextstyle.smallBoldCream,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        fullName,
                                        style: AppTextstyle.smallCream,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        userName,
                                        style: AppTextstyle.smallCream,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        registrationDate,
                                        style: AppTextstyle.smallCream,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CONTACT
                    Container(
                      height: AppSize.tinggi(context) * 0.16,
                      width: AppSize.lebar(context) * 1,
                      margin: EdgeInsets.only(bottom: 13),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.warnaSekunder,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 8),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Information",
                            style: AppTextstyle.normalCoklat,
                          ),
                          Container(
                            height: AppSize.tinggi(context) * 0.10,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.warnaPrimer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone Number",
                                      style: AppTextstyle.smallBoldCream,
                                    ),
                                    Text(
                                      "Email",
                                      style: AppTextstyle.smallBoldCream,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      phoneNumber,
                                      style: AppTextstyle.smallCream,
                                    ),
                                    Text(email, style: AppTextstyle.smallCream),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ROLES
                    Container(
                      height: AppSize.tinggi(context) * 0.11,
                      width: AppSize.lebar(context) * 1,
                      margin: EdgeInsets.only(bottom: 13),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.warnaSekunder,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 8),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Roles Information",
                            style: AppTextstyle.normalCoklat,
                          ),
                          Container(
                            height: AppSize.tinggi(context) * 0.05,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.warnaPrimer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Roles",
                                      style: AppTextstyle.smallBoldCream,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(roles, style: AppTextstyle.smallCream),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // EDIT USERS
                        SizedBox(
                          height: AppSize.tinggi(context) * 0.05,
                          width: AppSize.lebar(context) * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              errorAlert(
                                context,
                                text: "Sorry fitur not available",
                                title: "Oops . . .",
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit, color: AppColor.warnaSekunder),
                                SizedBox(width: 10),
                                Text(
                                  "Edit",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColor.warnaPrimer, // Merah tua
                              foregroundColor: AppColor.warnaSekunder,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),

                        // LOGOUT
                        SizedBox(
                          height: AppSize.tinggi(context) * 0.05,
                          width: AppSize.lebar(context) * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              confirmAlert(
                                context,
                                text: "Are you sure you want to log out?",
                                title: "Sign Out ?",
                                onConfirm: () => logout(context),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: AppColor.warnaSekunder,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Log out",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColor.warnaPrimer, // Merah tua
                              foregroundColor: AppColor.warnaSekunder,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
