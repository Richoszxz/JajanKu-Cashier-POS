import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/textformfield_widget.dart';
import 'package:jajanku_pos/models/category_models.dart';
import 'package:jajanku_pos/services/product_services.dart';
import 'package:jajanku_pos/widgets/customdropdown_widget.dart';
import 'package:jajanku_pos/widgets/uploadfile_widgets.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _deskripsiProdukController =
      TextEditingController();
  final TextEditingController _hargaProdukController = TextEditingController();
  final TextEditingController _stokProdukController = TextEditingController();

  List<CategoryModel> kategori = [];
  CategoryModel? kategoriTerpilih;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadKategori();
  }

  Future loadKategori() async {
    final result = await ProductServices().ambilKategori();

    print("Kategori ditemukan: ${result.length}");

    setState(() {
      kategori = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Add Product"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextformfieldWidget(
                  label: "Name Product",
                  hintText: "",
                  controller: _namaProdukController,
                ),
                TextformfieldWidget(
                  label: "Description Product",
                  hintText: "",
                  controller: _deskripsiProdukController,
                ),
                CustomdropdownWidget(
                  label: "Category",
                  items: kategori,
                  value: kategoriTerpilih,
                  onChanged: (CategoryModel? value) {
                    setState(() {
                      kategoriTerpilih = value;
                    });
                  },
                ),

                TextformfieldWidget(
                  label: "Price",
                  hintText: "",
                  controller: _hargaProdukController,
                ),
                TextformfieldWidget(
                  label: "Stok",
                  hintText: "",
                  controller: _stokProdukController,
                ),
                UploadfileWidgets(label: "Upload Image Product")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
