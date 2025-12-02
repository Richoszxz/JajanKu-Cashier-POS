import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/card_customer_widget.dart';
import 'package:jajanku_pos/widgets/searchbar_widgets.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/services/customer_services.dart';

class GetCustomerScreen extends StatefulWidget {
  const GetCustomerScreen({super.key});

  @override
  State<GetCustomerScreen> createState() => _GetCustomerScreenState();
}

class _GetCustomerScreenState extends State<GetCustomerScreen> {
  final CustomerServices _customerServices = CustomerServices();

  List<Pelanggan> allCustomers = [];
  List<Pelanggan> filteredCustomers = [];

  final TextEditingController _searchController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    try {
      final data = await _customerServices.ambilCustomer();

      // SORTING DARI PALING BARU
      data.sort((a, b) {
        final dateA = a.tanggalRegistrasi ?? DateTime(0);
        final dateB = b.tanggalRegistrasi ?? DateTime(0);
        return dateB.compareTo(dateA);
      });

      setState(() {
        allCustomers = data;
        filteredCustomers = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print("Error loading customers: $e");
    }
  }

  // SEARCH FUNCTION
  void _filterCustomers(String query) {
    final input = query.toLowerCase();

    setState(() {
      filteredCustomers = allCustomers.where((customer) {
        final nama = customer.namaPelanggan.toLowerCase();
        final kode = customer.kodePelanggan.toString().toLowerCase();
        return nama.contains(input) || kode.contains(input);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Customer"),
      drawer: const NavigationdrawerWidget(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // SEARCH BAR
                  SearchbarWidgets(
                    hintText: "Search customer . . .",
                    controller: _searchController,
                    onChanged: _filterCustomers,   // FIX DI SINI
                  ),

                  const SizedBox(height: 12),

                  // LIST CUSTOMER
                  Expanded(
                    child: filteredCustomers.isEmpty
                        ? const Center(child: Text("No matching customers"))
                        : ListView.builder(
                            itemCount: filteredCustomers.length,
                            itemBuilder: (context, index) {
                              return CardCustomerWidget(
                                pelanggan: filteredCustomers[index],
                                onTap: () async {
                                  await loadCustomers();
                                  _filterCustomers(_searchController.text);
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
