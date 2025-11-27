import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/textformfield_widget.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Add Customer"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextformfieldWidget(
                  label: "Customer Name",
                  hintText: "",
                  controller: _nameController,
                ),
                TextformfieldWidget(
                  label: "Email",
                  hintText: "",
                  controller: _emailController,
                ),
                TextformfieldWidget(
                  label: "Phone Number",
                  hintText: "",
                  controller: _phoneNumberController,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.warnaPrimer,
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                  ),
                  child: Text("Save", style: AppTextstyle.appBarTeks),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
