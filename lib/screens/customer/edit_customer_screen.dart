import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/services/customer_services.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/error_handler_widget.dart';
import 'package:jajanku_pos/widgets/textformfield_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';

class EditCustomerScreen extends StatefulWidget {
  final Pelanggan pelanggan;
  const EditCustomerScreen({super.key, required this.pelanggan});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  late TextEditingController namaPelanggan;
  late TextEditingController nomorHandphonePelanggan;
  late TextEditingController emailPelanggan;

  final CustomerServices _customerServices = CustomerServices();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namaPelanggan = TextEditingController(text: widget.pelanggan.namaPelanggan);
    nomorHandphonePelanggan = TextEditingController(
      text: widget.pelanggan.nomoHandphonePelanggan,
    );
    emailPelanggan = TextEditingController(
      text: widget.pelanggan.emailPelanggan,
    );
  }

  /// SnackBar sesuai warna aplikasi
  void showAppSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.warnaPrimer,
        content: Text(
          message,
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

  // 🔥 SIMPAN EDIT CUSTOMER
  Future<void> _editCustomer() async {
    if (_formKey.currentState!.validate()) {
      String name = namaPelanggan.text.trim();
      String email = emailPelanggan.text.trim();
      String phone = nomorHandphonePelanggan.text.trim();

      // --- VALIDATOR SnackBar ---

      if (name.isEmpty) {
        return showAppSnack("Nama customer wajib diisi");
      }

      if (name.length < 3) {
        return showAppSnack("Nama minimal 3 karakter");
      }

      if (email.isNotEmpty) {
        final emailRegex =
            RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$');
        if (!emailRegex.hasMatch(email)) {
          return showAppSnack(
              "Format email tidak valid (contoh: nama@gmail.com)");
        }
      }

      if (phone.isNotEmpty) {
        if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
          return showAppSnack("Nomor telepon hanya boleh angka");
        }
        if (phone.length <= 10) {
          return showAppSnack("Nomor telepon minimal 10 digit");
        }
      }

      try {
        // buat object pelanggan yg sudah diperbarui
        final updatedPelanggan = Pelanggan(
          namaPelanggan: namaPelanggan.text,
          emailPelanggan: emailPelanggan.text,
          nomoHandphonePelanggan: nomorHandphonePelanggan.text,
        );

        await _customerServices.updateCustomer(
          widget.pelanggan.id!,
          updatedPelanggan,
        );
        if (mounted) {
          Navigator.pop(
            context,
            true,
          ); // kirim tanda success agar refresh parent
          setState(() {});
        }
      } catch (e) {
        errorAlert(context, title: "Oops!", text: "Gagal update customer: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Edit Customer", tombolKembali: true),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  TextformfieldWidget(
                    label: "Username",
                    hintText: "",
                    controller: namaPelanggan,
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
                    controller: emailPelanggan,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return null; // optional

                      // format harus benar, sama seperti AddCustomer
                      final emailRegex = RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',
                      );

                      if (!emailRegex.hasMatch(value.trim())) {
                        return "Format email tidak valid (misal: nama@gmail.com)";
                      }

                      return null;
                    },
                  ),
                  TextformfieldWidget(
                    label: "Phone Number",
                    hintText: "",
                    controller: nomorHandphonePelanggan,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return null; // optional

                      final phone = value.trim();

                      if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
                        return "Nomor handphone hanya boleh berisi angka.";
                      }

                      if (phone.length < 10) {
                        return "Nomor telepon minimal 10 digit.";
                      }

                      return null;
                    },
                  ),

                  SizedBox(
                    height: AppSize.tinggi(context) * 0.05,
                    width: AppSize.lebar(context) * 0.4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.warnaPrimer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _editCustomer,
                      child: Text("Save", style: AppTextstyle.appBarTeks),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
