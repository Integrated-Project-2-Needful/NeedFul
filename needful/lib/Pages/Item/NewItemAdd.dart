import 'dart:io';
import 'package:flutter/material.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/widgets/radioButton.dart';
import 'package:needful/pages/home.dart';
// import 'package:sweet_favors/provider/token_provider.dart';
import 'package:needful/widgets/text_form.dart';
import 'package:needful/widgets/button_at_bottom.dart';
import 'package:needful/widgets/add_image.dart';

class NewItemAdd extends StatefulWidget {
  const NewItemAdd({super.key});

  @override
  State<NewItemAdd> createState() => _NewItemAddState();
}

class _NewItemAddState extends State<NewItemAdd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _linkUrlController = TextEditingController();
  String _selectedValueForRadioButton = '';
  File? _selectedImage;

  // Future<bool> addWishlistItem() async {
  //   // final token = Provider.of<TokenProvider>(context, listen: false).token;
  //   // final userId = Provider.of<TokenProvider>(context, listen: false).userId;
  //   const url = 'http://10.0.2.2:1432/PostAddWishlist';
  //   String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //   try {
  //     var formData = FormData.fromMap({
  //       'itemname': _itemNameController.text ?? '',
  //       // 'quantity': _quantityController.text ?? '',
  //       'Price': _priceController.text ?? '',
  //       'LinkURL': _linkUrlController.text ?? '',
  //       'file': await MultipartFile.fromFile(
  //         _selectedImage!.path,
  //         filename: fileName,
  //       ),
  //     });

  //     final response = await Dio().post(
  //       url,
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': 'application/json', // Adjust content type as needed
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       var map = response.data as Map;

  //       if (map['status'] == 'Successfully registered') {
  //         return true;
  //       }
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  @override
  void dispose() {
    _itemNameController.dispose();
    // _quantityController.dispose();
    _DescriptionController.dispose();
    _linkUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: colorUse.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Add New Item",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(240, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1B4D3F),
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 171, 171, 171),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? 700 : 380,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextForm(
                  filled: true,
                  label: 'Item name',
                  controller: _itemNameController,
                ),
                // TextForm(
                //   label: 'Quantity',
                //   controller: _quantityController,
                // ),
                TextForm(
                  filled: true,
                  label: 'Description',
                  controller: _DescriptionController,
                  maxLine: 5,
                ),
                Radiobutton(title: 'Purpose', labels: const ['Looking to receive','Looking to donate'],
                onChanged: (value) {
                  _selectedValueForRadioButton = value;
                },),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: AddImage(
                    onImageSelected: (image) {
                      setState(() {
                        _selectedImage = image;
                      });
                                        },
                    textfill: 'Add image + ',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: ButtonAtBottom(
                    onPressed: () async {
                      // bool success = await addWishlistItem();
                      bool success = true;
                      if (success) {
                        print('true');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      }
                      //  else {
                      //   print('false not successful');
                      // }
                    },
                    text: 'SUBMIT',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}