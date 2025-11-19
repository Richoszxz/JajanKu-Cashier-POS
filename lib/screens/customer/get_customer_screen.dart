import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';

class GetCustomerScreen extends StatefulWidget {
  const GetCustomerScreen({super.key});

  @override
  State<GetCustomerScreen> createState() => _GetCustomerScreenState();
}

class _GetCustomerScreenState extends State<GetCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Customer"),
      drawer: const NavigationdrawerWidget(),
      body: const Center(
        child: Text('Get Customer Screen Content'),
      ),
    );
  }
}