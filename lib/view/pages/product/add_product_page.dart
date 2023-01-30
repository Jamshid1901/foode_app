import 'package:flutter/material.dart';
import 'package:foode_app/controller/product_controller.dart';
import 'package:foode_app/view/component/custom_text_from.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameTextEditController = TextEditingController();
  final TextEditingController descTextEditController = TextEditingController();
  final TextEditingController priceTextEditController = TextEditingController();
  final TextEditingController categoryTextEditController =
      TextEditingController();
  final TextEditingController typeEditController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddProduct"),
      ),
      body: context.watch<ProductController>().isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextFrom(
                    controller: nameTextEditController, label: "name"),
                CustomTextFrom(
                    controller: descTextEditController, label: "desc"),
                CustomTextFrom(
                  controller: priceTextEditController,
                  label: "price",
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField(
                  value:
                      context.watch<ProductController>().listOfCategory.first,
                  items: context
                      .watch<ProductController>()
                      .listOfCategory
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (s) {},
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                CustomTextFrom(
                    controller: categoryTextEditController, label: "category"),
                CustomTextFrom(controller: typeEditController, label: "type"),
                ElevatedButton(onPressed: () {}, child: Text("Save"))
              ],
            ),
    );
  }
}
