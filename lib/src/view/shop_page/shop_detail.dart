import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/text_style.dart';
import 'package:rust_flutter/src/providers/shop_provider.dart';

import '../../../features/shopdata/model/shopdata_model.dart';
import '../../../widgets/custom_textfield.dart';

class ShopDetail extends StatefulWidget {
  final ResponseShopData? shopData;

  const ShopDetail({super.key, required this.shopData});

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  ShopProvider get _shopPvd => Provider.of(context, listen: false);

  late final TextEditingController _shopName;
  late final TextEditingController _shopContact;
  late final TextEditingController _shopAddress;
  late final TextEditingController _shopWeblink;

  @override
  void initState() {
    super.initState();

    // Initialize controllers directly with existing data or empty strings
    _shopName = TextEditingController(text: widget.shopData?.shopName ?? "");
    _shopContact = TextEditingController(text: widget.shopData?.contact ?? "");
    _shopAddress = TextEditingController(text: widget.shopData?.address ?? "");
    _shopWeblink = TextEditingController(
      text: widget.shopData?.contactLink ?? "",
    );
  }

  @override
  void dispose() {
    // Always dispose controllers to avoid memory leaks
    _shopName.dispose();
    _shopContact.dispose();
    _shopAddress.dispose();
    _shopWeblink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Detail", style: getAppBarText(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: [
              TextFieldWidget(
                controller: _shopName,
                text: 'Shop Name',
                width: double.infinity,
                hintText: '',
                onTap: () {},
                onTapOutside: (p0) {},
                line: 1,
              ),
              TextFieldWidget(
                controller: _shopContact,
                text: 'Contact',
                width: double.infinity,
                hintText: 'shop ph.',
                onTap: () {},
                onTapOutside: (p0) {},
                line: 1,
              ),
              TextFieldWidget(
                controller: _shopAddress,
                text: 'Address',
                width: double.infinity,
                hintText: 'add shop location',
                onTap: () {},
                onTapOutside: (p0) {},
                line: 1,
              ),
              TextFieldWidget(
                controller: _shopWeblink,
                text: 'Contact-link',
                width: double.infinity,
                hintText: 'TikTok, Facebook link etc...',
                onTap: () {},
                onTapOutside: (p0) {},
                line: 1,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.shopData != null) {
                    final shopData = ResponseShopData(
                      widget.shopData!.shopId,
                      _shopName.text,
                      _shopContact.text,
                      _shopAddress.text,
                      _shopWeblink.text,
                      true,
                    );
                    context.read<ShopProvider>().editShop(context, shopData);
                  } else {
                    await _shopPvd.createShop(
                      _shopName.text,
                      _shopContact.text,
                      _shopAddress.text,
                      _shopWeblink.text,
                    );
                  }
                },
                child: Text(
                  widget.shopData != null ? "Update Shop" : "Create Shop",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
