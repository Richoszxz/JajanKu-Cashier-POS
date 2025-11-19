import 'package:flutter/material.dart';
import 'package:jajanku_pos/services/authentication_services.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/error_handler_widget.dart';
import 'package:jajanku_pos/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailAndUsernameController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationServices _authenticationServices = AuthenticationServices();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _authenticationServices.signIn(
        _emailAndUsernameController.text.trim(),
        _passwordController.text.trim(),
      );

      if (response.session != null) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.cashierPosScreen, (route) => false);
        successAlert(context, text: "Login success!", title: "Successed!");
      } else {
        errorAlert(context, text: "Login error! check Email and Password", title: "Error!");
      }
    } on AuthException catch (e) {
      errorAlert(context, text: "Error ${e}", title: "Error");
    } catch (e) {
      errorAlert(context, text: "Terjadi kesalahan", title: "Terjadi kesalahan");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // CIRCLE ATAS
          Positioned(
            top: -200,
            left: -200,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.warnaPrimer,
              ),
            ),
          ),

          // FORM
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 500,
                    decoration: BoxDecoration(
                      color: AppColor.warnaSekunder,
                      borderRadius: BorderRadius.circular(50),
                      border: BoxBorder.all(
                        color: AppColor.warnaPrimer,
                        width: 6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.warnaPrimer.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 40.0,
                              horizontal: 20.0,
                            ),
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppColor.warnaTeks,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsetsGeometry.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Email/Username",
                                  style: AppTextstyle.normalCoklat,
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 10,
                            ),
                            child: TextFormField(
                              controller: _emailAndUsernameController,
                              style: AppTextstyle.normalCream,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.warnaPrimer,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 25,
                                  horizontal: 10,
                                ),
                                hintText: "Input your email/username . . .",
                                hintStyle: AppTextstyle.normalCream,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Email tidak boleh kosong'
                                  : null,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsetsGeometry.only(
                              top: 20,
                              left: 10,
                              bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: AppTextstyle.normalCoklat,
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 10,
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              style: AppTextstyle.normalCream,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.warnaPrimer,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 25,
                                  horizontal: 10,
                                ),
                                hintText: "Input your password . . .",
                                hintStyle: AppTextstyle.normalCream,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Password tidak boleh kosong'
                                  : null,
                            ),
                          ),

                          SizedBox(height: 40),

                          _isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.warnaPrimer,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 23,
                                      horizontal: 70,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: AppTextstyle.normalCream,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // CIRCLE BAWAH
          Stack(
            children: [
              Positioned(
                bottom: -200,
                right: -200,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaPrimer,
                  ),
                ),
              ),
              Positioned(
                bottom: -210,
                right: -210,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaSekunder,
                  ),
                ),
              ),
              Positioned(
                bottom: -220,
                right: -220,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaPrimer,
                  ),
                ),
              ),
              Positioned(
                bottom: -230,
                right: -230,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaSekunder,
                  ),
                ),
              ),
              Positioned(
                bottom: -240,
                right: -240,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaPrimer,
                  ),
                ),
              ),
              Positioned(
                bottom: -250,
                right: -250,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaSekunder,
                  ),
                ),
              ),
              Positioned(
                bottom: -260,
                right: -260,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaPrimer,
                  ),
                ),
              ),
              Positioned(
                bottom: -270,
                right: -270,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaSekunder,
                  ),
                ),
              ),
              Positioned(
                bottom: -280,
                right: -280,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.warnaPrimer,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
