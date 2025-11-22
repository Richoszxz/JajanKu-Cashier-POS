import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/textformfield_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Registration"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextformfieldWidget(
                  label: "Full Name",
                  hintText: "Input your full name . . .",
                  controller: _fullNameController,
                ),
                TextformfieldWidget(
                  label: "Username",
                  hintText: "Input your username . . .",
                  controller: _usernameController,
                ),
                TextformfieldWidget(
                  label: "Email",
                  hintText: "Input your email . . .",
                  controller: _emailController,
                ),
                TextformfieldWidget(
                  label: "Phone Number",
                  hintText: "Input your phone number . . .",
                  controller: _phoneNumberController,
                ),
                TextformfieldWidget(
                  label: "Password",
                  hintText: "Input your password . . .",
                  controller: _passwordController,
                  obscureText: true,
                ),
                TextformfieldWidget(
                  label: "Validation Password",
                  hintText: "Input your password . . .",
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.warnaPrimer,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                  ),
                  child: Text("Register", style: AppTextstyle.appBarTeks),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
