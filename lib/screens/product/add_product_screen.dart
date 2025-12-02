import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/error_handler_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/textformfield_widget.dart';
import 'package:jajanku_pos/models/category_models.dart';
import 'package:jajanku_pos/services/product_services.dart';
import 'package:jajanku_pos/models/product_model.dart';
import 'package:jajanku_pos/widgets/customdropdown_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _deskripsiProdukController =
      TextEditingController();
  final TextEditingController _hargaProdukController = TextEditingController();
  final TextEditingController _stokProdukController = TextEditingController();

  List<CategoryModel> kategori = [];
  CategoryModel? kategoriTerpilih;

  File? _gambarTerpilih;

  @override
  void initState() {
    super.initState();
    loadKategori();
  }

  Future loadKategori() async {
    final result = await ProductServices().ambilKategori();
    if (!mounted) return;
    setState(() => kategori = result);
  }

  // SnackBar khusus agar warnanya sesuai aplikasi
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

  // PAKAI IMAGE PICKER
  Future _pilihGambar() async {
    final XFile? foto = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (foto != null) {
      setState(() {
        _gambarTerpilih = File(foto.path);
      });
    }
  }

  Future<String?> uploadKeSupabase(File file) async {
    try {
      final supabase = Supabase.instance.client;

      final fileName = "produk_${DateTime.now().millisecondsSinceEpoch}.png";

      await supabase.storage
          .from('produk')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(upsert: false),
          );

      return supabase.storage.from('produk').getPublicUrl(fileName);
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  Future simpanProduk() async {
    if (!_formKey.currentState!.validate()) return;

    // 1. Nama
    if (_namaProdukController.text.trim().isEmpty) {
      return showAppSnack("Nama produk tidak boleh kosong");
    }

    // 2. Kategori
    if (kategoriTerpilih == null) {
      return showAppSnack("Kategori harus dipilih");
    }

    // 3. Harga
    if (_hargaProdukController.text.trim().isEmpty) {
      return showAppSnack("Harga produk tidak boleh kosong");
    }
    if (double.tryParse(_hargaProdukController.text.trim()) == null) {
      return showAppSnack("Harga harus berupa angka");
    }

    // 4. Stok
    if (_stokProdukController.text.trim().isEmpty) {
      return showAppSnack("Stok produk tidak boleh kosong");
    }
    if (int.tryParse(_stokProdukController.text.trim()) == null) {
      return showAppSnack("Stok harus berupa angka");
    }

    // Generate kode produk
    String kode = await ProductServices().generateKodeProdukById();

    // Upload gambar jika ada
    String? urlGambar;
    if (_gambarTerpilih != null) {
      urlGambar = await uploadKeSupabase(_gambarTerpilih!);
    }

    final produk = Produk(
      kodeProduk: kode, // ← WAJIB ADA
      namaProduk: _namaProdukController.text,
      hargaProduk: double.parse(_hargaProdukController.text),
      kategoriId: kategoriTerpilih!.id!,
      stokProduk: int.parse(_stokProdukController.text),
      deskripsiProduk: _deskripsiProdukController.text,
      gambarProduk: urlGambar,
    );

    try {
      await ProductServices().tambahProduk(produk);
      successAlert(context, text: "Succedeed add product", title: "Succedeed!");

      // RESET SEMUA FIELD
      _namaProdukController.clear();
      _deskripsiProdukController.clear();
      _hargaProdukController.clear();
      _stokProdukController.clear();
      setState(() {
        kategoriTerpilih = null;
        _gambarTerpilih = null;
      });
    } catch (e) {
      print("$e");
      errorAlert(context, text: "Error add product! $e", title: "Oops . . .");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Add Product"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextformfieldWidget(
                  label: "Name Product",
                  controller: _namaProdukController,
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return "Nama produk tidak boleh kosong";
                    return null;
                  },
                  hintText: '',
                ),
                TextformfieldWidget(
                  label: "Description Product",
                  controller: _deskripsiProdukController,
                  hintText: '',
                ),
                CustomdropdownWidget(
                  label: "Category",
                  items: kategori,
                  value: kategoriTerpilih,
                  onChanged: (value) =>
                      setState(() => kategoriTerpilih = value),
                ),
                TextformfieldWidget(
                  label: "Price",
                  controller: _hargaProdukController,
                  keyboardType: TextInputType.number,
                  hintText: '',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harga produk tidak boleh kosong";

                    if (double.tryParse(value) == null) {
                      return "Harga harus berupa angka";
                    }
                    return null;
                  },
                ),
                TextformfieldWidget(
                  label: "Stok",
                  controller: _stokProdukController,
                  keyboardType: TextInputType.number,
                  hintText: '',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Stok produk tidak boleh kosong";

                    if (int.tryParse(value) == null) {
                      return "Stok harus berupa angka";
                    }
                    return null;
                  },
                ),

                // UPLOAD KONTAINER
                Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.warnaSekunder,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0, 8),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upload image product",
                        style: AppTextstyle.normalCoklat,
                      ),

                      InkWell(
                        onTap: _pilihGambar,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.warnaPrimer,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: _gambarTerpilih == null
                                    ? Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey.shade300,
                                        child: const Icon(Icons.image),
                                      )
                                    : Image.file(
                                        _gambarTerpilih!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Upload Product Image",
                                style: AppTextstyle.normalCream,
                              ),
                              const Spacer(),
                              Icon(Icons.upload, color: AppColor.warnaSekunder),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: simpanProduk,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.warnaPrimer,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
