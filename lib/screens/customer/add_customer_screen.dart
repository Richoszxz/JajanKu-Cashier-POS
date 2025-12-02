import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/textformfield_widget.dart';
import 'package:jajanku_pos/services/customer_services.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/widgets/error_handler_widget.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final CustomerServices _customerServices = CustomerServices();

  final _formKey = GlobalKey<FormState>();

  // SnackBar khusus dengan warna aplikasi
  void showAppSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.warnaPrimer,
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _simpanCustomer() async {
    if (_formKey.currentState!.validate()) {
      // 1. Nama wajib
      if (_nameController.text.trim().isEmpty) {
        return showAppSnack("Nama customer wajib diisi");
      }

      // 2. Email (optional) → wajib format benar kalau diisi
      String email = _emailController.text.trim();
      if (email.isNotEmpty) {
        final emailRegex = RegExp(
          r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',
        ); // sama seperti Add Product
        if (!emailRegex.hasMatch(email)) {
          return showAppSnack(
            "Format email tidak valid (harus seperti nama@gmail.com)",
          );
        }
      }

      // 3. Phone number (optional)
      String phone = _phoneNumberController.text.trim();
      if (phone.isNotEmpty) {
        if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
          return showAppSnack("Nomor telepon hanya boleh berisi angka");
        }
        if (phone.length <= 10) {
          return showAppSnack("Nomor telepon minimal 10 digit");
        }
      }
      try {
        // generate kode
        String kode = await _customerServices.generateKodePelangganById();

        final pelanggan = Pelanggan(
          kodePelanggan: kode,
          namaPelanggan: _nameController.text,
          emailPelanggan: _emailController.text,
          nomoHandphonePelanggan: _phoneNumberController.text,
        );

        await _customerServices.tambahCustomer(pelanggan);

        successAlert(
          context,
          text: "Customer berhasil ditambahkan!",
          title: "Succeeded!",
        );

        // Reset field setelah sukses
        _nameController.clear();
        _emailController.clear();
        _phoneNumberController.clear();
      } catch (e) {
        print("$e");
        errorAlert(
          context,
          text: "Gagal menambahkan customer! ${e}",
          title: "Oops . . .",
        );
      }
    }
  }

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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama customer wajib diisi";
                    }
                    if (value.trim().length < 3) {
                      return "Nama minimal 3 karakter";
                    }
                    return null;
                  },
                ),
                TextformfieldWidget(
                  label: "Email",
                  hintText: "",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return null; // boleh kosong

                    // Validasi email
                    final emailRegex = RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Format email tidak valid';
                    }

                    return null;
                  },
                ),
                TextformfieldWidget(
                  label: "Phone Number",
                  hintText: "",
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return null; // boleh kosong

                    // Hanya angka
                    final numericRegex = RegExp(r'^[0-9]+$');
                    if (!numericRegex.hasMatch(value)) {
                      return 'Nomor handphone hanya boleh angka.';
                    }

                    if (value.length <= 10) {
                      return 'Nomor telepon minimal 10 karakter.';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _simpanCustomer,
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
