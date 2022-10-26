import 'package:flutter/material.dart';
import 'createDrawer.dart';
import 'package:buroleave/ui/createDrawer.dart';

class TransactionView extends StatelessWidget {
  static const String routeName = '/transaction';
  static const String screen_title = 'History';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$screen_title')),
      body: const Center(
        child: Text('Leave Management Buro @copy right 2022'),
      ),
      drawer: createDrawer(context),
    );

    // return Container(
    //     child: Scaffold(
    //         appBar: AppBar(
    //           title: const Text('Transaction'),
    //           leading: IconButton(
    //       icon: Icon(Icons.accessible),

    //       onPressed: () => Scaffold.of(context).openDrawer(),
    //     ),
    //           centerTitle: true,
    //         ),
    //     ));
  }
}
