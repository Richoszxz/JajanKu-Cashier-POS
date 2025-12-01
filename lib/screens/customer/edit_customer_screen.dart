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

  // 🔥 SIMPAN EDIT CUSTOMER
  Future<void> _editCustomer() async {
    if (_formKey.currentState!.validate()) {
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

        successAlert(
          context,
          title: "Success",
          text: "Customer berhasil diperbarui!",
        );

        Navigator.pop(context, true); // kirim tanda success agar refresh parent
      } catch (e) {
        errorAlert(
          context,
          title: "Oops!",
          text: "Gagal update customer: $e",
        );
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
                  ),
                  TextformfieldWidget(
                    label: "Phone Number",
                    hintText: "",
                    controller: nomorHandphonePelanggan,
                  ),
                  TextformfieldWidget(
                    label: "Email",
                    hintText: "",
                    controller: emailPelanggan,
                  ),
                  SizedBox(
                    height: AppSize.tinggi(context) * 0.05,
                    width: AppSize.lebar(context) * 0.4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.warnaPrimer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      onPressed: _editCustomer,
                      child: Text(
                        "Save",
                        style: AppTextstyle.appBarTeks,
                      ),
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
