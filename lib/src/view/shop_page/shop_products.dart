// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../features/shopdata/model/shopdata_model.dart';
// import '../../../features/shopdata/shop_provider.dart';

// class ShopProducts extends StatefulWidget {
//   final ResponseShopData shopData;
//   const ShopProducts({super.key, required this.shopData});

//   @override
//   State<ShopProducts> createState() => _ShopProductsState();
// }

// class _ShopProductsState extends State<ShopProducts> {
//   ShopProvider get _shopPvd => Provider.of(context, listen: false);

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _shopPvd.fectchShopProducts(context, widget.shopData);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.shopData.shopName.toString())),
//       body: CustomScrollView(
//         slivers: [
//           SliverList.builder(
//             itemCount: _shopPvd.productList.length,
//             itemBuilder: (context, index) {
//               final product = _shopPvd.productList[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   margin: EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text(product.name),
//                     subtitle: Text(product.categoryId.toString()),
//                     trailing: Text(product.createdAt.toString()),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
