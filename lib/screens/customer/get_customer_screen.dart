import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Customer"),
      drawer: const NavigationdrawerWidget(),
      body: FutureBuilder<List<Pelanggan>>(
        future: _customerServices.ambilCustomer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No customers found"));
          }

          final customerList = snapshot.data!;

          return Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Column(
              children: [
                // SEARCH BAR
                SearchbarWidgets(hintText: "Search customer . . ."),
                SizedBox(height: 12),
                // LIST VIEW CUSTOMER
                Expanded(
                  child: ListView.builder(
                    itemCount: customerList.length,
                    itemBuilder: (context, index) {
                      final customer = customerList[index];
                      return CardCustomerWidget(pelanggan: customer);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
