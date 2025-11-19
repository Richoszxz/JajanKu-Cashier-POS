import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Get Product Screen"),
      drawer: const NavigationdrawerWidget(),
      body: const Center(
        child: Text('Get Product Screen Content'),
      ),
    );
  }
}