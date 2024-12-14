import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store/Services/update_product.dart';
import 'package:store/models/product_model.dart';
import 'package:store/widget/custome_btn.dart';
import 'package:store/widget/custome_text_form_field.dart';

class UpdateProductPage extends StatefulWidget {
  UpdateProductPage({super.key});
  static String id = "UpdateProduct";

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? productName, desc, image, price;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! ProductModel) {
      log("Invalid arguments");
      return Scaffold(
        body: Center(child: Text("Invalid product details")),
      );
    }
    ProductModel product = args;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Edit Product",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                hintText: 'Product Name',
                onChange: (data) {
                  productName = data;
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                hintText: 'Description',
                onChange: (data) {
                  desc = data;
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                inputType: TextInputType.number,
                hintText: 'Price',
                onChange: (data) {
                  price = data;
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                hintText: 'Image',
                onChange: (data) {
                  image = data;
                },
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomBtn(
                btnText: "Update",
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  try {
                    await updateProduct(product);
                    log("Update successful");
                  } catch (e) {
                    log("Error: $e");
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    final double? priceValue =
        double.tryParse(price ?? product.price.toString());
    if (priceValue == null) {
      log("Invalid price");
      return;
    }

    await UpdateProductService().updateProduct(
      title: productName ?? product.title,
      price: priceValue.toString(),
      description: desc ?? product.description,
      image: image ?? product.image,
      category: product.category,
    );
  }
}
